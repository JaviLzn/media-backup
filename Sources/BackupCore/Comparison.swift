public enum Comparison: Equatable, Sendable {
    case verified, different, missing, unverified

    public static func compare(source: Fingerprint?, destination: Fingerprint?) -> Self {
        guard let source, source.isValid else { return .unverified }
        guard let destination else { return .missing }
        guard destination.isValid else { return .unverified }
        return source.byteCount == destination.byteCount &&
            source.sha256.lowercased() == destination.sha256.lowercased()
            ? .verified : .different
    }
}

public struct Fingerprint: Equatable, Sendable {
    public let byteCount: UInt64
    public let sha256: String

    public init(byteCount: UInt64, sha256: String) {
        self.byteCount = byteCount
        self.sha256 = sha256
    }

    public var isValid: Bool {
        sha256.utf8.count == 64 && sha256.utf8.allSatisfy {
            (48...57).contains($0) || (65...70).contains($0) || (97...102).contains($0)
        }
    }
}
