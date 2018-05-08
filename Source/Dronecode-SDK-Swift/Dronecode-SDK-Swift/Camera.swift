//
//  Camera.swift
//  Dronecode-SDK-Swift
//
//  Created by Douglas on 5/7/18.
//  Copyright © 2018 Dronecode. All rights reserved.
//

import Foundation
import gRPC
import RxSwift

public class Camera {
    let service = Dronecore_Rpc_Camera_CameraServiceService
    
    public convenience init(address: String, port: Int) {
        let service = Dronecore_Rpc_Camera_CameraServiceServiceClient(address: "\(address):\(port)", secure: false)
        self.init(service:service)
    }
    
    init(service: Dronecore_Rpc_Camera_CameraServiceService) {
        self.service = service
    }
    
    public func takePhoto() -> Completable {
        return Completable.create { completable in
            let takePhotoRequest = Dronecore_Rpc_Camera_TakePhotoRequest()
            
            do {
                let takePhotoResponse = try self.service.takephoto(takePhotoRequest)
                if takePhotoResponse.cameraResult.result == Dronecore_Rpc_Camera_CameraResult.Result.success {
                    completable(.completed)
                    return Disposable.create {}
                } else {
                    completable(.error(error))
                    return Disposable.create {}
                }
            } catch {
                completable(.error(error))
                return Disposable.create {}
            }
        }
    }
    
    public func startPhotoInteval(interval: Floar) -> Completable {
        return Completable.create { completable in
            let startPhotoIntervalRequest = Dronecore_Rpc_Camera_StartPhotoIntervalRequest()
            startPhotoIntervalRequest.intervalS = interval
            
            do {
                let _ = try self.service.startphotointerval(startPhotoIntervalRequest)
                completable(.completed)
            } catch {
                completable(.error(error))
            }
            
            return Disposable.create {}
        }
    }
    
    public func stopPhotoInterval() -> Completable {
        return Completable.create { completable in
            let stopPhotoIntervalRequest = Dronecore_Rpc_Camera_StopPhotoIntervalRequest()
            
            do {
                let stopPhotoIntervalResponse = try self.service.stopphotointerval(stopPhotoIntervalRequest)
                if stopPhotoIntervalResponse.cameraResult.result == Dronecore_Rpc_Camera_CameraResult.Result.success {
                    completable(.completed)
                    return Disposable.create {}
                }
            } catch {
                
            }
        }
    }
}
