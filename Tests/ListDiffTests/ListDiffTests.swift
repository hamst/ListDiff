import Foundation
import XCTest
@testable import ListDiff

extension Int : Diffable {
    var diffIdentifier: AnyHashable {
        return String(self)
    }
}

class ListDiffTests : XCTestCase {
    func test_whenDiffingEmptyArrays_thatResultHasNoChanges() {
        let o = Array<Int>()
        let n = Array<Int>()
        let result = List.Diffing(oldArray: o, newArray: n)
        XCTAssertFalse(result.hasChanges)
    }
    
    func test_whenDiffingFromEmptyArray_thatResultHasChanges() {
        let o = Array<Int>()
        let n = Array<Int>(arrayLiteral: 1)
        let result = List.Diffing(oldArray: o, newArray: n)
        XCTAssertTrue(result.hasChanges)
        XCTAssertEqual(result.inserts, IndexSet(integer: 0))
        XCTAssertEqual(result.changeCount, 1)
    }

    func test_whenDiffingToEmptyArray_thatResultHasChanges() {
        let o = Array<Int>(arrayLiteral: 1)
        let n = Array<Int>()
        let result = List.Diffing(oldArray: o, newArray: n)
        XCTAssertTrue(result.hasChanges)
        XCTAssertEqual(result.deletes, IndexSet(integer: 0))
        XCTAssertEqual(result.changeCount, 1)
    }

    func test_whenSwappingObjects_thatResultHasMoves() {
        let o = Array<Int>(arrayLiteral: 1, 2)
        let n = Array<Int>(arrayLiteral: 2, 1)
        let result = List.Diffing(oldArray: o, newArray: n)
        XCTAssertTrue(result.hasChanges)
        XCTAssertEqual(result.moves, [List.MoveIndex(from: 1, to: 0), List.MoveIndex(from: 0, to: 1)])
        XCTAssertEqual(result.changeCount, 2)
    }

    static var allTests : [(String, (ListDiffTests) -> () throws -> Void)] {
        return [
            ("test_whenDiffingEmptyArrays_thatResultHasNoChanges", test_whenDiffingEmptyArrays_thatResultHasNoChanges),
            ("test_whenDiffingFromEmptyArray_thatResultHasChanges", test_whenDiffingFromEmptyArray_thatResultHasChanges),
            ("test_whenDiffingToEmptyArray_thatResultHasChanges", test_whenDiffingToEmptyArray_thatResultHasChanges),
        ]
    }
}
