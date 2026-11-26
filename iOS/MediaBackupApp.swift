import SwiftUI
import Photos
import UniformTypeIdentifiers
import CryptoKit

@main
struct MediaBackupApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var importing = false
    @State private var busy = false
    @State private var photos = "Sin consultar"
    @State private var result = "Selecciona una carpeta del SSD."

    var body: some View {
        NavigationStack {
            Form {
                Section("Fototeca") {
                    Button("Consultar acceso de lectura") {
                        Task {
                            let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
                            switch status {
                            case .authorized, .limited:
                                let count = PHAsset.fetchAssets(with: nil).count
                                photos = "\(count) elementos visibles. " +
                                    (status == .limited ? "Acceso limitado." : "Acceso completo.")
                            default: photos = "Acceso no disponible."
                            }
                        }
                    }
                    Text(photos)
                }
                Section("SSD — prueba de solo lectura") {
                    Button("Seleccionar carpeta y verificar un archivo") { importing = true }
                        .disabled(busy)
                    if busy { ProgressView() }
                    Text(result).textSelection(.enabled)
                }
                Section {
                    Text("Prueba de concepto: no copia ni elimina originales. No certifica el respaldo completo.")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Media Backup")
            .fileImporter(isPresented: $importing, allowedContentTypes: [.folder]) { selection in
                switch selection {
                case .failure(let error): result = error.localizedDescription
                case .success(let url):
                    busy = true
                    Task {
                        result = await Task.detached { Self.inspect(url) }.value
                        busy = false
                    }
                }
            }
        }
    }

    nonisolated private static func inspect(_ url: URL) -> String {
        guard url.startAccessingSecurityScopedResource() else {
            return "No se pudo obtener acceso a la carpeta."
        }
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            let keys: Set<URLResourceKey> = [.isRegularFileKey, .isSymbolicLinkKey]
            let entries = try FileManager.default.contentsOfDirectory(at: url,
                includingPropertiesForKeys: Array(keys), options: [.skipsHiddenFiles])
            var files: [URL] = []
            for entry in entries {
                let values = try entry.resourceValues(forKeys: keys)
                if values.isRegularFile == true && values.isSymbolicLink != true { files.append(entry) }
            }
            guard let first = files.sorted(by: { $0.lastPathComponent < $1.lastPathComponent }).first else {
                return "No hay archivos regulares visibles en este nivel."
            }
            let handle = try FileHandle(forReadingFrom: first)
            defer { try? handle.close() }
            var hash = SHA256()
            var size: UInt64 = 0
            while let data = try handle.read(upToCount: 1024 * 1024), !data.isEmpty {
                hash.update(data: data)
                size += UInt64(data.count)
            }
            let digest = hash.finalize().map { String(format: "%02x", $0) }.joined()
            return "Archivos directos: \(files.count)\nMuestra: \(first.lastPathComponent)\nBytes: \(size)\nSHA-256: \(digest)"
        } catch {
            return "Error de lectura: \(error.localizedDescription)"
        }
    }
}
