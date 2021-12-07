//
//  File.swift
//  
//
//  Created by Ibrahim Hassan on 07/12/21.
//

public struct ContentOffset: IBDecodable, IBKeyable {
    public var key: String?
    public var width: String?
    public var height: String?
    
    static func decode(_ xml: XMLIndexerType) throws -> ContentOffset {
        let container = xml.container(keys: CodingKeys.self)
        return ContentOffset(
            key: container.attributeIfPresent(of: .key),
            width: try container.attribute(of: .width),
            height: try container.attribute(of: .height)
        )
    }
}

