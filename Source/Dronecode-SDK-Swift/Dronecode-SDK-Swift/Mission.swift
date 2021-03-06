import Foundation
import gRPC
import RxSwift

public struct MissionItem : Equatable {
    public let latitudeDeg: Double
    public let longitudeDeg: Double
    public let relativeAltitudeM: Float
    public let speedMPS: Float
    public let isFlyThrough: Bool
    public let gimbalPitchDeg: Float
    public let gimbalYawDeg: Float
    public let cameraAction: CameraAction

/**
The struct represents a waypoint item. A mission consist of an array of waypoint items.
     
- Parameters:
     - latitudeDeg: latitude of the waypoint
     - longitudeDeg: longtitude of the waypoint
     - relativeAltitudeM: altitude relative to the takeoff altitude
     - speedMPS: speed in meters per second
     - isFlyThrough: if enabled, the aircraft will fly through the waypoint and stop at waypoint
     - gimbalPitchDeg: gimbal pitch. Valid range [-90.0, 0.0]
     - gimbalYawDeg: gimbal yaw relative to the aircraft yaw. Valid range [0.0, 360.0]
     - cameraAction: camera action type
*/
    public init(latitudeDeg: Double, longitudeDeg: Double, relativeAltitudeM: Float, speedMPS: Float, isFlyThrough: Bool, gimbalPitchDeg: Float, gimbalYawDeg: Float, cameraAction: CameraAction) {
        self.latitudeDeg = latitudeDeg
        self.longitudeDeg = longitudeDeg
        self.relativeAltitudeM = relativeAltitudeM
        self.speedMPS = speedMPS
        self.isFlyThrough = isFlyThrough
        self.gimbalPitchDeg = gimbalPitchDeg
        self.gimbalYawDeg = gimbalYawDeg
        self.cameraAction = cameraAction
    }

    public static func == (lhs: MissionItem, rhs: MissionItem) -> Bool {
        return lhs.latitudeDeg == rhs.latitudeDeg
            && lhs.longitudeDeg == rhs.longitudeDeg
            && lhs.relativeAltitudeM == rhs.relativeAltitudeM
            && lhs.speedMPS == rhs.speedMPS
            && lhs.isFlyThrough == rhs.isFlyThrough
            && lhs.gimbalPitchDeg == rhs.gimbalPitchDeg
            && lhs.gimbalYawDeg == rhs.gimbalYawDeg
            && lhs.cameraAction == rhs.cameraAction
    }
}

public struct MissionProgress : Equatable {
    public let currentItemIndex: Int
    public let missionCount: Int
    
    public init(currentItemIndex: Int32, missionCount: Int32) {
        self.currentItemIndex = Int(currentItemIndex)
        self.missionCount = Int(missionCount)
    }
    
    public static func == (lhs: MissionProgress, rhs: MissionProgress) -> Bool {
        return lhs.currentItemIndex == rhs.currentItemIndex
            && lhs.missionCount == rhs.missionCount
    }
}

public enum CameraAction {
    case none
    case takePhoto
    case startPhotoInterval
    case stopPhotoInterval
    case startVideo
    case stopVideo
    
    internal var rpcCameraAction: Dronecore_Rpc_Mission_MissionItem.CameraAction {
        switch (self) {
        case .none:
            return Dronecore_Rpc_Mission_MissionItem.CameraAction.none
        case .takePhoto:
            return Dronecore_Rpc_Mission_MissionItem.CameraAction.takePhoto
        case .startPhotoInterval:
            return Dronecore_Rpc_Mission_MissionItem.CameraAction.startPhotoInterval
        case .stopPhotoInterval:
            return Dronecore_Rpc_Mission_MissionItem.CameraAction.stopPhotoInterval
        case .startVideo:
            return Dronecore_Rpc_Mission_MissionItem.CameraAction.startVideo
        case .stopVideo:
            return Dronecore_Rpc_Mission_MissionItem.CameraAction.stopVideo
        }
    }
}

public class Mission {
    private let service: Dronecore_Rpc_Mission_MissionServiceService
    private let scheduler: SchedulerType
    
    public lazy var missionProgressObservable: Observable<MissionProgress> = createMissionProgressObservable()

    public convenience init(address: String, port: Int) {
        let service = Dronecore_Rpc_Mission_MissionServiceServiceClient(address: "\(address):\(port)", secure: false)
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        
        self.init(service: service, scheduler: scheduler)
    }

    init(service: Dronecore_Rpc_Mission_MissionServiceService, scheduler: SchedulerType) {
        self.service = service
        self.scheduler = scheduler
    }

    public func uploadMission(missionItems: [MissionItem]) -> Completable {
        return Completable.create { completable in
            var uploadMissionRequest = Dronecore_Rpc_Mission_UploadMissionRequest()

            for missionItem in missionItems {
                var rpcMissionItem = Dronecore_Rpc_Mission_MissionItem()
                rpcMissionItem.latitudeDeg = missionItem.latitudeDeg
                rpcMissionItem.longitudeDeg = missionItem.longitudeDeg
                rpcMissionItem.relativeAltitudeM = missionItem.relativeAltitudeM
                rpcMissionItem.speedMS = missionItem.speedMPS
                rpcMissionItem.isFlyThrough = missionItem.isFlyThrough
                rpcMissionItem.gimbalPitchDeg = missionItem.gimbalPitchDeg
                rpcMissionItem.gimbalYawDeg = missionItem.gimbalYawDeg
                rpcMissionItem.cameraAction = missionItem.cameraAction.rpcCameraAction

                uploadMissionRequest.mission.missionItem.append(rpcMissionItem)
            }

            do {
                let uploadMissionResponse = try self.service.uploadmission(uploadMissionRequest)
                if (uploadMissionResponse.missionResult.result == Dronecore_Rpc_Mission_MissionResult.Result.success) {
                    completable(.completed)
                } else {
                    completable(.error("Cannot upload mission: \(uploadMissionResponse.missionResult.result)"))
                }
            } catch {
                completable(.error(error))
            }

            return Disposables.create {}
        }
    }

    public func startMission() -> Completable {
        return Completable.create { completable in
            let startMissionRequest = Dronecore_Rpc_Mission_StartMissionRequest()

            do {
                let startMissionResponse = try self.service.startmission(startMissionRequest)
                if (startMissionResponse.missionResult.result == Dronecore_Rpc_Mission_MissionResult.Result.success) {
                    completable(.completed)
                } else {
                    completable(.error("Cannot start mission: \(startMissionResponse.missionResult.result)"))
                }
            } catch {
                completable(.error(error))
            }

            return Disposables.create {}
        }
    }
    
    public func pauseMission() -> Completable {
        return Completable.create { completable in
            let pauseMissionRequest = Dronecore_Rpc_Mission_PauseMissionRequest()
            
            do {
                let pauseMissionResponse = try self.service.pausemission(pauseMissionRequest)
                if (pauseMissionResponse.missionResult.result == Dronecore_Rpc_Mission_MissionResult.Result.success) {
                    completable(.completed)
                } else {
                    completable(.error("Cannot pause mission: \(pauseMissionResponse.missionResult.result)"))
                }
            } catch {
                completable(.error(error))
            }
            
            return Disposables.create {}
        }
    }
    
    public func isMissionFinished() -> Single<Bool> {
        return Single<Bool>.create { single in
            let isMissionFinishedRequest = Dronecore_Rpc_Mission_IsMissionFinishedRequest()
            do {
                let isMissionFinishedResponse = try self.service.ismissionfinished(isMissionFinishedRequest)
                single(.success(isMissionFinishedResponse.isFinished))
                return Disposables.create {}
            } catch {
                single(.error(error))
                return Disposables.create {}
            }
        }
    }
    
    private func createMissionProgressObservable() -> Observable<MissionProgress> {
        return Observable.create { observer in
            let missionProgressRequest = Dronecore_Rpc_Mission_SubscribeMissionProgressRequest()
            
            do {
                print("Enter MissionProgressObservable")
                let call = try self.service.subscribemissionprogress(missionProgressRequest, completion: nil)
                print("Create a Call MissionProgressObservable")
                while let response = try? call.receive() {
                    print("Response MissionProgressObservable")
                    let missionProgres = MissionProgress(currentItemIndex: response.currentItemIndex , missionCount: response.missionCount)
                    print("MissionProgres in MissionProgressObservable : \(missionProgres.currentItemIndex)/ \(missionProgres.missionCount)")
                    observer.onNext(missionProgres)
                    print("After OnNext MissionProgressObservable")
                }
            } catch {
                print("Failed to subscribe to discovery stream. MissionProgressObservable")
                observer.onError("Failed to subscribe to discovery stream")
            }
            print("Disposables.create() MissionProgressObservable")
            return Disposables.create()
        }.subscribeOn(self.scheduler)
    }
}
