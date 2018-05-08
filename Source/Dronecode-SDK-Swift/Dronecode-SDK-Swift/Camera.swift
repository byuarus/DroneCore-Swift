import Foundation
import gRPC
import RxSwift


public enum CameraMode {
    case unknown
    case photo
    case video
    case unrecognized(Int)
    
    internal var rpcCameraMode: Dronecore_Rpc_Camera_CameraMode {
        switch self {
        case .photo:
            return .photo
        case .video:
            return .video
        case .unknown:
            return .unknown
        case .unrecognized(let value):
            return .UNRECOGNIZED(value)
        }
    }
    
    internal static func createFromRPC(_ rpcCameraMode: Dronecore_Rpc_Camera_CameraMode) -> CameraMode {
        switch rpcCameraMode {
        case .photo:
            return .photo
        case .video:
            return .video
        case .unknown:
            return .unknown
        case .UNRECOGNIZED(let value):
            return .unrecognized(value)
        }
    }
}

public class Camera {
    let service: Dronecore_Rpc_Camera_CameraServiceService
    let scheduler: SchedulerType

    public convenience init(address: String, port: Int) {
        let service = Dronecore_Rpc_Camera_CameraServiceServiceClient(address: "\(address):\(port)", secure: false)
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        
        self.init(service: service, scheduler: scheduler)
    }
    
    init(service: Dronecore_Rpc_Camera_CameraServiceService, scheduler: SchedulerType) {
        self.service = service
        self.scheduler = scheduler
    }
    
    public func setMode(mode: CameraMode) -> Completable {
        return Completable.create { completable in
            
            var setCameraModeRequest = Dronecore_Rpc_Camera_SetModeRequest()
            setCameraModeRequest.cameraMode = mode.rpcCameraMode

            do {
                let setCameraModeResponse = try self.service.setmode(setCameraModeRequest)
                if setCameraModeResponse.cameraResult.result == Dronecore_Rpc_Camera_CameraResult.Result.success {
                    completable(.completed)
                } else {
                    completable(.error("Cannot set camera mode: \(setCameraModeResponse.cameraResult.result)"))
                }
            } catch {
                completable(.error(error))
            }
            
            return Disposables.create {}
        }
    }
    
    public func takePhoto() -> Completable {
        return Completable.create { completable in
            let takePhotoRequest = Dronecore_Rpc_Camera_TakePhotoRequest()
            
            do {
                let takePhotoResponse = try self.service.takephoto(takePhotoRequest)
                if takePhotoResponse.cameraResult.result == Dronecore_Rpc_Camera_CameraResult.Result.success {
                    completable(.completed)
                } else {
                    completable(.error("Cannot take photo: \(takePhotoResponse.cameraResult.result)"))
                }
            } catch {
                completable(.error(error))
            }
            return Disposables.create {}
        }
    }
    
    public func startPhotoInteval(interval: Float) -> Completable {
        return Completable.create { completable in
            var startPhotoIntervalRequest = Dronecore_Rpc_Camera_StartPhotoIntervalRequest()
            startPhotoIntervalRequest.intervalS = interval
            
            do {
                let startPhotoIntevalResponse = try self.service.startphotointerval(startPhotoIntervalRequest)
                if startPhotoIntevalResponse.cameraResult.result == Dronecore_Rpc_Camera_CameraResult.Result.success {
                    completable(.completed)
                } else {
                    completable(.error("Cannot start photo interval: \(startPhotoIntevalResponse.cameraResult.result)"))
                }
            } catch {
                completable(.error(error))
            }
            
            return Disposables.create {}
        }
    }
    
    public func stopPhotoInterval() -> Completable {
        return Completable.create { completable in
            let stopPhotoIntervalRequest = Dronecore_Rpc_Camera_StopPhotoIntervalRequest()
            
            do {
                let stopPhotoIntervalResponse = try self.service.stopphotointerval(stopPhotoIntervalRequest)
                if stopPhotoIntervalResponse.cameraResult.result == Dronecore_Rpc_Camera_CameraResult.Result.success {
                    completable(.completed)
                } else {
                    completable(.error("Cannot stop photo interval: \(stopPhotoIntervalResponse.cameraResult.result)"))
                }
            } catch {
                completable(.error(error))
            }
            
            return Disposables.create {}
        }
    }
    
    public lazy var cameraModeObservable: Observable<CameraMode> = {
        return createCameraModeObservable()
    }()
    
    private func createCameraModeObservable() -> Observable<CameraMode> {
        return Observable.create { observer in
            let cameraModeRequest = Dronecore_Rpc_Camera_SubscribeModeRequest()
            
            do {
                let call = try self.service.subscribemode(cameraModeRequest, completion: nil)
                while let response = try? call.receive() {
                    let cameraMode = CameraMode.createFromRPC(response.cameraMode)
                    observer.onNext(cameraMode)
                }
            } catch {
                observer.onError("Failed to subscribe to camera mode stream")
            }
            return Disposables.create()
        }
    }
}
