import AppKit

// The native icon mirrors assets/logo.svg, rendered at app-icon resolution.
let size = 1024
let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: size, pixelsHigh: size,
  bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
  colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
NSColor(calibratedRed: 0.96, green: 0.93, blue: 0.98, alpha: 1).setFill()
NSBezierPath(roundedRect: NSRect(x: 30, y: 30, width: 964, height: 964), xRadius: 220, yRadius: 220).fill()
let accent = NSColor(calibratedRed: 0.47, green: 0.33, blue: 0.61, alpha: 1)
accent.setStroke()
for radius in [330.0, 215.0] {
  let circle = NSBezierPath(ovalIn: NSRect(x: 512-radius, y: 512-radius, width: radius*2, height: radius*2))
  circle.lineWidth = 45
  circle.stroke()
}
let wave = NSBezierPath()
wave.move(to: NSPoint(x: 305, y: 485))
wave.curve(to: NSPoint(x: 720, y: 485), controlPoint1: NSPoint(x: 440, y: 625), controlPoint2: NSPoint(x: 590, y: 345))
wave.lineWidth = 42
wave.lineCapStyle = .round
wave.stroke()
accent.setFill()
for point in [(512.0, 790.0), (512.0, 234.0), (234.0, 512.0), (790.0, 512.0)] {
  NSBezierPath(ovalIn: NSRect(x: point.0-17, y: point.1-17, width: 34, height: 34)).fill()
}
NSGraphicsContext.restoreGraphicsState()
let destination = CommandLine.arguments.dropFirst().first ?? "assets/logo.png"
guard let data = bitmap.representation(using: .png, properties: [:]) else {
  fatalError("Could not encode app icon")
}
try data.write(to: URL(fileURLWithPath: destination))
