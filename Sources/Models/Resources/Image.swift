//
//  Image.swift
//  IBDecodable
//
//  Created by phimage on 01/04/2018.
//

import SWXMLHash

public struct Image: IBDecodable, ResourceProtocol {
    public var name: String
    public var width: String
    public var height: String
    public var catalog: String?
    public var mutableData: MutableData?

    static func decode(_ xml: XMLIndexerType) throws -> Image {
        let container = xml.container(keys: CodingKeys.self)
        return Image(
            name:          try container.attribute(of: .name),
            width:         try container.attribute(of: .width),
            height:        try container.attribute(of: .height),
            catalog:       container.attributeIfPresent(of: .catalog),
            mutableData:   container.elementIfPresent(of: .mutableData))
    }
}

public struct MutableData: IBDecodable {
    public var key: String
    public var content: String?

    static func decode(_ xml: XMLIndexerType) throws -> MutableData {
        let container = xml.container(keys: CodingKeys.self)
        return MutableData(
            key:      try container.attribute(of: .key),
            content:  xml.elementText)
    }
}
