import AppKit

// Mirror the vector mark on a rounded tile at native app-icon resolution.
let size = 1024
let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: size, pixelsHigh: size,
  bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
  colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
func color(_ hex: UInt32) -> NSColor {
  NSColor(calibratedRed: CGFloat((hex >> 16) & 255) / 255,
    green: CGFloat((hex >> 8) & 255) / 255, blue: CGFloat(hex & 255) / 255, alpha: 1)
}
func ellipse(_ x: CGFloat, _ y: CGFloat, _ rx: CGFloat, _ ry: CGFloat, _ hex: UInt32) {
  color(hex).setFill()
  NSBezierPath(ovalIn: NSRect(x: x-rx, y: y-ry, width: rx*2, height: ry*2)).fill()
}
func polygon(_ points: [(CGFloat, CGFloat)], _ hex: UInt32) {
  let path = NSBezierPath()
  for (index, point) in points.enumerated() {
    let position = NSPoint(x: point.0, y: point.1)
    if index == 0 { path.move(to: position) } else { path.line(to: position) }
  }
  path.close()
  color(hex).setFill()
  path.fill()
}
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
color(0xF1E9D8).setFill()
NSBezierPath(roundedRect: NSRect(x: 30, y: 30, width: 964, height: 964), xRadius: 220, yRadius: 220).fill()
let transform = AffineTransform(translationByX: 128, byY: 896)
var coordinates = transform
coordinates.scale(x: 12, y: -12)
(coordinates as NSAffineTransform).concat()
ellipse(34, 34, 23, 26, 0x8E592D)
ellipse(29, 29, 23, 26, 0xEDB84F)
ellipse(29, 29, 18, 21, 0xCB8D31)
ellipse(29, 29, 16, 19, 0x294969)
ellipse(29, 29, 14, 17, 0x9CB8C9)
NSGraphicsContext.saveGraphicsState()
NSBezierPath(ovalIn: NSRect(x: 15, y: 12, width: 28, height: 34)).addClip()
let wave = NSBezierPath()
wave.move(to: NSPoint(x: 12, y: 31))
wave.curve(to: NSPoint(x: 29, y: 31), controlPoint1: NSPoint(x: 17.33, y: 25.67), controlPoint2: NSPoint(x: 23, y: 25.67))
wave.curve(to: NSPoint(x: 46, y: 31), controlPoint1: NSPoint(x: 35, y: 36.33), controlPoint2: NSPoint(x: 40.67, y: 36.33))
wave.line(to: NSPoint(x: 46, y: 51))
wave.line(to: NSPoint(x: 12, y: 51))
wave.close()
color(0x345873).setFill()
wave.fill()
polygon([(19, 14), (24, 12), (19, 27), (14, 29)], 0xF1E9D8)
NSGraphicsContext.restoreGraphicsState()
for point in [(29.0, 7.0), (29.0, 51.0), (9.0, 29.0), (49.0, 29.0)] {
  ellipse(point.0, point.1, 1.7, 1.7, 0x8E592D)
}
polygon([(3, 21), (10, 21), (10, 37), (3, 37)], 0xCB8D31)
polygon([(3, 21), (10, 21), (10, 24), (3, 24)], 0xF1CE79)
NSGraphicsContext.restoreGraphicsState()
let destination = CommandLine.arguments.dropFirst().first ?? "assets/logo.png"
guard let data = bitmap.representation(using: .png, properties: [:]) else {
  fatalError("Could not encode app icon")
}
try data.write(to: URL(fileURLWithPath: destination))
