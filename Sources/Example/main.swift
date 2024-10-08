import Keystone
import SwiftSCAD

EnvironmentReader { e in
    let m = KeystoneSlot.Metrics(environment: e)
    Box(m.baseSize + [10, 12, 0])
        .aligned(at: .centerXY)
        .subtracting {
            KeystoneSlot()
                .translated(y: -2)
        }
}
.withTolerance(0.3)
.save(to: "keystone-example")
