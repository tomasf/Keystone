import SwiftSCAD

/// A keystone module slot.
///
/// `KeystoneSlot` is designed to hold a standard keystone module, providing
/// space for both the flexible latch and the fixed anchor, as well as an
/// insertion slope to facilitate easy installation.
///
/// This model is ideal for use in custom 3D models where keystone jacks need
/// to be integrated, such as patch panels, wall plates, or surface mount boxes.
///
/// Subtract a keystone slot shape from your main model. Positive Z points
/// towards the face of the module.
///
/// - Note: The `Metrics` nested struct provides dimensions that can be used in
///   other models, allowing users to align their designs with the dimensions
///   of a standard keystone module.
///
public struct KeystoneSlot: Shape3D {
    public struct Metrics {
        public let baseSize: Vector3D
        public let insertionSlopeSize = 2.0

        public let latchSpaceSize: Vector3D
        public let latchDistanceFromFront = 8.4
        public let latchBodySize = 3.3

        public let anchorSpaceSizeY = 1.8
        public let anchorSpaceSizeZ = 3.0

        public init(environment: EnvironmentValues) {
            let tolerance = environment.tolerance
            baseSize = [14.5 + tolerance, 16.1 + tolerance, 9.8]
            latchSpaceSize = [baseSize.x, 5.2, 3.0]
        }
    }

    let latchSpaceDepthExtension: Double
    @Environment(\.keystoneSlotMetrics) var metrics

    /// Creates a new `KeystoneSlot` instance with a specified extension for the latch space depth.
    ///
    /// - Parameter latchSpaceDepthExtension: Additional size added to the space made for the latch.
    ///   This is typically used to expose the latch space, allowing users to easily delatch the keystone module.
    ///   Defaults to `100.0`.
    public init(latchSpaceDepthExtension: Double = 100.0) {
        self.latchSpaceDepthExtension = latchSpaceDepthExtension
    }

    public var body: any Geometry3D {
        Box(metrics.baseSize + .init(z: 0.02))
            .aligned(at: .centerXY)
            .translated(z: -0.01)
            .adding {
                // Add slope-shaped space that is needed for rotating while inserting the module
                Box([metrics.baseSize.x, metrics.insertionSlopeSize + 1, 1])
                    .aligned(at: .centerX)
                    .translated(y: metrics.baseSize.y / 2 - 1, z: metrics.baseSize.z - metrics.latchDistanceFromFront + metrics.latchSpaceSize.z - 1)
            }
            .convexHull()

        // Latch, the flexible tab that snaps into the latch space
        Box(metrics.latchSpaceSize + [0, 2 + latchSpaceDepthExtension, 0])
            .aligned(at: .centerX)
            .translated(y: metrics.baseSize.y / 2 - 1, z: metrics.baseSize.z - metrics.latchDistanceFromFront)

        // Additional space for the body of the latch
        Box([metrics.baseSize.x, metrics.latchBodySize + 1, metrics.baseSize.z - metrics.latchDistanceFromFront + 1])
            .aligned(at: .centerX)
            .translated(y: metrics.baseSize.y / 2 - 1, z: -1)

        // Anchor, a fixed tab opposite the latch that holds the module in place
        Box([metrics.baseSize.x, metrics.anchorSpaceSizeY + 1, metrics.anchorSpaceSizeZ])
            .aligned(at: .centerX)
            .translated(y: -metrics.baseSize.y / 2 - metrics.anchorSpaceSizeY, z: metrics.baseSize.z - metrics.latchDistanceFromFront)
    }
}

public extension EnvironmentValues {
    var keystoneSlotMetrics: KeystoneSlot.Metrics {
        .init(environment: self)
    }
}
