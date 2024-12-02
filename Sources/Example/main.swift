import Keystone
import SwiftSCAD

struct Example: Shape3D {
    @Environment(\.keystoneSlotMetrics) var metrics

    var body: any Geometry3D {
        Box(metrics.baseSize + [10, 12, 0])
            .aligned(at: .centerXY)
            .subtracting {
                KeystoneSlot()
                    .translated(y: -2)
            }
    }
}

save(environment: .defaultEnvironment.withTolerance(0.3)) {
    Example()
        .named("keystone-example")
}
