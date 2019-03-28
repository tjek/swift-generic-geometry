import Foundation
import GenericGeometry

let maybeSize: Size<Int?> = Size(width: nil, height: 15)
// w: nil, h: Optional(15)

let concreteSize: Size<Int> = maybeSize.unwrapped(or: Size(999))
// w: 999, h: 15

let stringSize: Size<String> = concreteSize.map(String.init)
// w: "999", h: "15"

let scaledSize = concreteSize.multipling(by: Size<Int>(width: 10, height: 100))
// w: 9990, h: 1500
