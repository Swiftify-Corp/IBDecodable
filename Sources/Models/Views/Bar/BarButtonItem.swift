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
    public var imageReferences: [ImageReference]?
    public var image: String?
    public var landscapeImage: String?

    static func decode(_ xml: XMLIndexerType) throws -> BarButtonItem {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .imageReferences: return "imageReference"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        return BarButtonItem(
            id:             try container.attribute(of: .id),
            key:                container.attributeIfPresent(of: .key),
            style:              container.attributeIfPresent(of: .style),
            systemItem:         container.attributeIfPresent(of: .systemItem),
            title:              container.attributeIfPresent(of: .title),
            imageReferences:    container.elementsIfPresent(of: .imageReferences),
            image:              container.attributeIfPresent(of: .image),
            landscapeImage:     container.attributeIfPresent(of: .landscapeImage)
        )
    }
}
