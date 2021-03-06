import XCTest
import RxBlocking
import RxSwift
import RxTest
@testable import Dronecode_SDK_Swift

class ActionTest: XCTestCase {
    
    let ARBITRARY_ALTITUDE: Float = 123.5
    let ARBITRARY_SPEED: Float = 321.5
    
    // MARK: - ARM
    func testArmSucceedsOnSuccess() {
        assertSuccess(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.success))
    }
    
    func testArmFailsOnFailure() {
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.busy))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDenied))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedNotLanded))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedLandedStateUnknown))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.connectionError))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noSystem))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noVtolTransitionSupport))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.timeout))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.unknown))
        assertFailure(result: armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.vtolTransitionSupportUnknown))
    }
    
    func armWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_ArmResponse()
        response.actionResult.result = result
        fakeService.armResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.arm().toBlocking().materialize()
    }

    // MARK: - DISARM
    func testDisarmSucceedsOnSuccess() {
        assertSuccess(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.success))
    }
    
    func testDisarmFailsOnFailure() {
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.busy))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDenied))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedNotLanded))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedLandedStateUnknown))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.connectionError))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noSystem))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noVtolTransitionSupport))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.timeout))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.unknown))
        assertFailure(result: disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.vtolTransitionSupportUnknown))
    }
    
    func disarmWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_DisarmResponse()
        response.actionResult.result = result
        fakeService.disarmResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.disarm().toBlocking().materialize()
    }
    
    // MARK: - KILL
    func testKillSucceedsOnSuccess() {
        assertSuccess(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.success))
    }
    
    func testKillFailsOnFailure() {
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.busy))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDenied))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedNotLanded))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedLandedStateUnknown))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.connectionError))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noSystem))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noVtolTransitionSupport))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.timeout))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.unknown))
        assertFailure(result: killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.vtolTransitionSupportUnknown))
    }
    
    func killWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_KillResponse()
        response.actionResult.result = result
        fakeService.killResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.kill().toBlocking().materialize()
    }
    
    // MARK: - RETURN TO LAUNCH
    func testReturnToLaunchSucceedsOnSuccess() {
        assertSuccess(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.success))
    }
    
    func testReturnToLaunchFailsOnFailure() {
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.busy))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDenied))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedNotLanded))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedLandedStateUnknown))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.connectionError))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noSystem))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noVtolTransitionSupport))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.timeout))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.unknown))
        assertFailure(result: returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.vtolTransitionSupportUnknown))
    }
    
    func returnToLaunchWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_ReturnToLaunchResponse()
        response.actionResult.result = result
        fakeService.returntolaunchResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.returnToLaunch().toBlocking().materialize()
    }
    
    // MARK: - TRANSITION TO FIXED WINGS
    func testTransitionToFixedWingsSucceedsOnSuccess() {
        assertSuccess(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.success))
    }
    
    func testTransitionToFixedWingsFailsOnFailure() {
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.busy))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDenied))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedNotLanded))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedLandedStateUnknown))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.connectionError))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noSystem))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noVtolTransitionSupport))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.timeout))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.unknown))
        assertFailure(result: transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.vtolTransitionSupportUnknown))
    }
    
    func transitionToFixedWingsWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_TransitionToFixedWingResponse()
        response.actionResult.result = result
        fakeService.transitiontofixedwingResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.transitionToFixedWing().toBlocking().materialize()
    }
    
    // MARK: - TRANSITION TO MULTICOPTER
    func testTransitionToMulticopterSucceedsOnSuccess() {
        assertSuccess(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.success))
    }
    
    func testTransitionToMulticopterFailsOnFailure() {
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.busy))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDenied))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedNotLanded))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.commandDeniedLandedStateUnknown))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.connectionError))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noSystem))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.noVtolTransitionSupport))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.timeout))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.unknown))
        assertFailure(result: transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result.vtolTransitionSupportUnknown))
    }
    
    func transitionToMulticopterWithFakeResult(result: Dronecore_Rpc_Action_ActionResult.Result) -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_TransitionToMulticopterResponse()
        response.actionResult.result = result
        fakeService.transitiontomulticopterResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.transitionToMulticopter().toBlocking().materialize()
    }
    
    // MARK: - GET TAKEOFF ALTITUDE
    func testGetTakeoffAltitudeSucceedsOnSuccess() {
        let expectedAltitude: Float = ARBITRARY_ALTITUDE
        
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_GetTakeoffAltitudeResponse()
        response.altitudeM = expectedAltitude
        fakeService.gettakeoffaltitudeResponses.append(response)
        let client = Action(service: fakeService)
        
        _ = client.getTakeoffAltitude().subscribe { event in
            switch event {
            case .success(let altitude):
                XCTAssert(altitude == expectedAltitude)
                break
            case .error(let error):
                XCTFail("Expecting success, got failure: getTakeoffAltitude() \(error) ")
            }
        }
    }
    
    // MARK: - SET TAKEOFF ALTITUDE
    func testSetTakeoffAltitudeSucceedsOnSuccess() {
        assertSuccess(result: setTakeoffAltitudeWithFakeResult())
    }
    
    func setTakeoffAltitudeWithFakeResult() -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        let response = Dronecore_Rpc_Action_SetTakeoffAltitudeResponse()
        fakeService.settakeoffaltitudeResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.setTakeoffAltitude(altitude: 20.0).toBlocking().materialize()
    }
    
    // MARK: - GET MAXIMUM SPEED
    func testGetMaximumSpeedSucceedsOnSuccess() {
        let expectedSpeed = ARBITRARY_SPEED
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        var response = Dronecore_Rpc_Action_GetMaximumSpeedResponse()
        response.speedMS = expectedSpeed
        fakeService.getmaximumspeedResponses.append(response)
        let client = Action(service: fakeService)
        
        _ = client.getMaximumSpeed().subscribe { event in
            switch event {
            case .success(let speed):
                XCTAssert(speed == expectedSpeed)
                break
            case .error(let error):
                XCTFail("Expecting success, got failure: getMaximumSpeed() \(error) ")
            }
        }
    }
    
    // MARK: - SET MAXIMUM SPEED
    func testSetMaximumSpeedSucceedsOnSuccess() {
        assertSuccess(result: setMaximumSpeedWithFakeResult())
    }
    
    func setMaximumSpeedWithFakeResult() -> MaterializedSequenceResult<Never> {
        let fakeService = Dronecore_Rpc_Action_ActionServiceServiceTestStub()
        let response = Dronecore_Rpc_Action_SetMaximumSpeedResponse()
        fakeService.setmaximumspeedResponses.append(response)
        let client = Action(service: fakeService)
        
        return client.setMaximumSpeed(speed: 20.0).toBlocking().materialize()
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
