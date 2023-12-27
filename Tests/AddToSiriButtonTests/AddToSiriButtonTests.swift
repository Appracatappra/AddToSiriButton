import XCTest
@testable import AddToSiriButton

final class AddToSiriButtonTests: XCTestCase {
    func testButton() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let button = SiriButtonView()
        XCTAssertNotNil(button)
    }
}
