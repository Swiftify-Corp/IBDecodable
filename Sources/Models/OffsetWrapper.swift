//
//  OffsetWrapper.swift
//  
//
//  Created by Ibrahim Hassan on 07/08/21.
//

// <offsetWrapper key="textShadowOffset" horizontal="40" vertical="0.0"/>

public struct OffsetWrapper: IBDecodable, IBKeyable {
    public var key: String?
    public var horizontal: Float
    public var vertical: Float

    static func decode(_ xml: XMLIndexerType) throws -> OffsetWrapper {
        let container = xml.container(keys: CodingKeys.self)
        return OffsetWrapper(
            key: container.attributeIfPresent(of: .key),
            horizontal: container.attribute(of: .horizontal),
            vertical: container.attribute(of: .vertical)
        )
    }
}
