import XCTest
@testable import BackupCore

final class ComparisonTests: XCTestCase {
    private let a = Fingerprint(byteCount: 10, sha256: String(repeating: "a", count: 64))
    private let b = Fingerprint(byteCount: 10, sha256: String(repeating: "b", count: 64))

    func testIdentical() { XCTAssertEqual(Comparison.compare(source: a, destination: a), .verified) }
    func testSameSizeDifferentHash() { XCTAssertEqual(Comparison.compare(source: a, destination: b), .different) }
    func testMissing() { XCTAssertEqual(Comparison.compare(source: a, destination: nil), .missing) }
    func testUnavailable() { XCTAssertEqual(Comparison.compare(source: nil, destination: a), .unverified) }
    func testInvalidHash() {
        let invalid = Fingerprint(byteCount: 10, sha256: "invalid")
        XCTAssertEqual(Comparison.compare(source: invalid, destination: invalid), .unverified)
    }
}
