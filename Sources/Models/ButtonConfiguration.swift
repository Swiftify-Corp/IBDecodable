//
//  File.swift
//  
//
//  Created by Ibrahim Hassan on 09/04/22.
//

public struct ButtonConfiguration: IBDecodable, IBKeyable {
    public let key: String?
    public let style: String?
    public let title: String?
    public let string: StringContainer?
    public let imageReference: ImageReference?
    public let fontDescription: FontDescription?
    
    static func decode(_ xml: XMLIndexerType) throws -> ButtonConfiguration {
        let container = xml.container(keys: CodingKeys.self)
        return ButtonConfiguration(
            key:    container.attributeIfPresent(of: .key),
            style:  container.attributeIfPresent(of: .style),
            title: container.attributeIfPresent(of: .title),
            string: container.elementIfPresent(of: .string),
            imageReference: container.elementIfPresent(of: .imageReference),
            fontDescription: container.elementIfPresent(of: .fontDescription)
        )
    }
}
