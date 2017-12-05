import FBSnapshotTestCase
import KIF

@testable import BoilerplateWars

class BaseUITestCase: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        if let isRecording = ProcessInfo.processInfo.environment["IS_RECORDING_SCREENSHOTS"], isRecording == "true" {
            self.recordMode = true
        }
    }

    func verify(_ view: UIView, tolerance: CGFloat = 0.0) {
        tester().waitForAnimationsToFinish()
        FBSnapshotVerifyView(view, tolerance: tolerance)
    }
}

extension XCTestCase {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
