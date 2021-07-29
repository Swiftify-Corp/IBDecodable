//
//  OutletCollection.swift
//  IBDecodable
//
//  Created by SaitoYuta on 2018/04/20.
//

import SWXMLHash

public struct OutletCollection: IBDecodable, ConnectionProtocol {
    public var id: String
    public var destination: String
    public var property: String
    public var collectionClass: String?
    public var appends: Bool?

    static func decode(_ xml: XMLIndexerType) throws -> OutletCollection {
        let container = xml.container(keys: CodingKeys.self)
        return OutletCollection(
            id:              try container.attribute(of: .id),
            destination:     try container.attribute(of: .destination),
            property:        try container.attribute(of: .property),
            collectionClass: container.attributeIfPresent(of: .collectionClass),
            appends:         container.attributeIfPresent(of: .appends)
        )
    }
}
