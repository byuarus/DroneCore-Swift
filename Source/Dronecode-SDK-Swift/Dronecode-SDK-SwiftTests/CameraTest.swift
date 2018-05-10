import Foundation
import RxBlocking
import RxSwift
import RxTest
import XCTest
@testable import Dronecode_SDK_Swift

class CameraTest: XCTestCase {
    let scheduler = MainScheduler.instance
    let cameraResultsArray: [Dronecore_Rpc_Camera_CameraResult.Result] = [.unknown, .error, .busy, .timeout, .inProgress, .denied, .wrongArgument, .UNRECOGNIZED(0)]
    
    func testTakePhoto() {
        assertSuccess(result: takePhotoWithFakeResult(result: Dronecore_Rpc_Camera_CameraResult.Result.success))
    }
    
    func takePhotoWithFakeResult(result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_TakePhotoResponse()
        
        response.cameraResult.result = result
        fakeService.takephotoResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.takePhoto().toBlocking().materialize()
    }
    
    func testTakePhotoFail() {
        cameraResultsArray.forEach { result in
            assertFailure(result: takePhotoWithFakeResult(result: result))
        }
    }
    
    func testStartPhotoInteval() {
        assertSuccess(result: startPhotoIntervalWithFakeResult(result: Dronecore_Rpc_Camera_CameraResult.Result.success))
    }
    
    func startPhotoIntervalWithFakeResult(result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_StartPhotoIntervalResponse()
        
        response.cameraResult.result = result
        fakeService.startphotointervalResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.startPhotoInteval(interval: 5).toBlocking().materialize()
    }
    
    func testStartPhotoIntervalFail() {
        cameraResultsArray.forEach { result in
            assertFailure(result: startPhotoIntervalWithFakeResult(result: result))
        }
    }
    
    func testStopPhotoInterval() {
        assertSuccess(result: stopPhotoIntervalWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result.success))
    }
    
    func stopPhotoIntervalWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_StopPhotoIntervalResponse()
        
        response.cameraResult.result = result
        fakeService.stopphotointervalResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.stopPhotoInterval().toBlocking().materialize()
    }
    
    func testStopPhotoIntervalFail() {
        cameraResultsArray.forEach { result in
            assertFailure(result: stopPhotoIntervalWithFakeResponse(result: result))
        }
    }
    
    func testStartVideo() {
        assertSuccess(result: startVideoWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result.success))
    }
    
    func startVideoWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_StartVideoResponse()
        
        response.cameraResult.result = result
        fakeService.startvideoResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.startVideo().toBlocking().materialize()
    }
    
    func testStartVideoFail() {
        cameraResultsArray.forEach { result in
            assertFailure(result: startVideoWithFakeResponse(result:result))
        }
    }
    
    func testStopVideo() {
        assertSuccess(result: stopPhotoIntervalWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result.success))
    }
    
    func stopVideoWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_StopVideoResponse() // Should fail?
        
        response.cameraResult.result = result
        fakeService.stopvideoResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.stopVideo().toBlocking().materialize()
    }
    
    func testStopVideoFail() {
        cameraResultsArray.forEach { result in
            assertFailure(result: stopPhotoIntervalWithFakeResponse(result: result))
        }
    }
    
    func testStartVideoStreaming() {
        assertSuccess(result: startVideoWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result.success))
    }
    
    func startVideoStreamingWithFakeResult(result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_StartVideoStreamingResponse()
        
        response.cameraResult.result = result
        fakeService.startvideostreamingResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.startVideoStreaming().toBlocking().materialize()
    }
    
    func testStartVideoStreamingFail() {
        cameraResultsArray.forEach { result in
            assertFailure(result: startVideoStreamingWithFakeResult(result: result))
        }
    }
    
    func testStopVideoStreaming() {
        assertSuccess(result: stopPhotoIntervalWithFakeResponse(result: Dronecore_Rpc_Camera_CameraResult.Result.success))
    }
    
    func stopVideoStreamingWithFakeResult(result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_StopVideoStreamingResponse()
        
        response.cameraResult.result = result
        fakeService.stopvideostreamingResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.stopVideoStreaming().toBlocking().materialize()
    }
    
    func testStopVideoStreamingFail() {
        cameraResultsArray.forEach { result in
            assertFailure(result: stopVideoStreamingWithFakeResult(result: result))
        }
    }
    
    func testSetMode() {
        let cameraModeArray: [CameraMode] = [.unknown, .photo, .video]
        
        cameraModeArray.forEach { mode in
            assertSuccess(result: setModeWithFakeResponse(mode: mode, result: Dronecore_Rpc_Camera_CameraResult.Result.success))
        }
    }
    
    func setModeWithFakeResponse(mode: CameraMode, result: Dronecore_Rpc_Camera_CameraResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Camera_CameraServiceServiceTestStub()
        var response = Dronecore_Rpc_Camera_SetModeResponse()
        
        response.cameraResult.result = result
        fakeService.setmodeResponses.append(response)
        
        let client = Camera(service: fakeService, scheduler: scheduler)
        
        return client.setMode(mode: mode).toBlocking().materialize()
    }
    
    func testSetModeFail() {
        let cameraModeArray: [CameraMode] = [.unknown, .photo, .video]
        
        cameraResultsArray.forEach { result in
            cameraModeArray.forEach { mode in
                assertFailure(result: setModeWithFakeResponse(mode: mode, result: result))
            }
        }
    }
    
    // MARK: - Utils
    func assertSuccess(result: MaterializedSequenceResult<Never>) {
        switch result {
        case .completed:
            break
        case .failed:
            XCTFail("Expecting success, got failure")
        }
    }
    
    func assertFailure(result: MaterializedSequenceResult<Never>) {
        switch result {
        case .completed:
            XCTFail("Expecting failure, got success")
        case .failed:
            break
        }
    }
}
