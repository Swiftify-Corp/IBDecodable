//
//  BarButtonItem.swift
//  
//
//  Created by Ibrahim Hassan on 10/08/21.
//

public struct BarButtonItem: IBDecodable {
    public var id: String
    public var key: String?
    public var style: String?
    public var systemItem: String?
    public var title: String?
    public var imageReference: ImageReference?
    public var image: String?
    public var landscapeImage: String?
    public var tintColor: Color?
    
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> BarButtonItem {
        let container = xml.container(keys: CodingKeys.self)

        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return BarButtonItem(
            id:             try container.attribute(of: .id),
            key:                container.attributeIfPresent(of: .key),
            style:              container.attributeIfPresent(of: .style),
            systemItem:         container.attributeIfPresent(of: .systemItem),
            title:              container.attributeIfPresent(of: .title),
            imageReference:     container.elementIfPresent(of: .imageReference),
            image:              container.attributeIfPresent(of: .image),
            landscapeImage:     container.attributeIfPresent(of: .landscapeImage),
            tintColor:          colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue)
        )
    }
}
