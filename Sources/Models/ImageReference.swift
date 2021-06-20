//
//  ImageReference.swift
//  
//
//  Created by Ibrahim Hassan on 20/06/21.
//

// <imageReference key="background" image="square.and.arrow.up" catalog="system" symbolScale="large" renderingMode="template"/>

public struct ImageReference: IBDecodable, IBKeyable {
    public let key: String?
    public let image: String?
    public let catalog: String?
    public let symbolScale: String?
    public let renderingMode: String?

    static func decode(_ xml: XMLIndexerType) throws -> ImageReference {
        let container = xml.container(keys: CodingKeys.self)
        return ImageReference(
            key: container.attributeIfPresent(of: .key),
            image: container.attributeIfPresent(of: .image),
            catalog: container.attributeIfPresent(of: .catalog),
            symbolScale: container.attributeIfPresent(of: .symbolScale),
            renderingMode: container.attributeIfPresent(of: .renderingMode)
        )
    }
}
