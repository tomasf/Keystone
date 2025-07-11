import Keystone
import Cadova

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

await Model("keystone-example") {
    Example()
} environment: {
    $0.tolerance = 0.3
}
