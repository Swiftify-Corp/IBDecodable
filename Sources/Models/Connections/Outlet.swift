//
//  Outlet.swift
//  IBDecodable
//
//  Created by phimage on 05/04/2018.
//

import SWXMLHash

public struct Outlet: IBDecodable, ConnectionProtocol {
    public var id: String
    public var destination: String
    public var property: String

    static func decode(_ xml: XMLIndexerType) throws -> Outlet {
        let container = xml.container(keys: CodingKeys.self)
        return Outlet(
            id:            try container.attribute(of: .id),
            destination:   try container.attribute(of: .destination),
            property:      try container.attribute(of: .property))
    }
}
