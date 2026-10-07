import Foundation
import Testing
@testable import MonitorCore

struct IntegrationTests {
  @Test func honorsSharedVMAndKeyOverrides() throws {
    let home = FileManager.default.temporaryDirectory.appending(path: UUID().uuidString)
    defer { try? FileManager.default.removeItem(at: home) }
    let config = home.appending(path: ".config/slipway")
    try FileManager.default.createDirectory(at: config, withIntermediateDirectories: true)
    try "VM=custom-vm\nTART=/opt/flox/bin/tart\nKEY='/tmp/custom key'\nTEST_USER=builder\n".write(
      to: config.appending(path: "config"), atomically: true, encoding: .utf8)
    let target = VMTarget.load(home: home)
    #expect(target.vmName == "custom-vm")
    #expect(target.tartExecutable == "/opt/flox/bin/tart")
    #expect(target.key.path == "/tmp/custom key")
    #expect(target.user == "builder")
    let arguments = VM.sshArguments(target, address: "192.0.2.1")
    #expect(arguments.contains("ControlPath=/tmp/slipway-ssh-%C"))
    #expect(arguments.contains("/tmp/custom key"))
  }
}
