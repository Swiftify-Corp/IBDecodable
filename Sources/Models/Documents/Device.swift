//
//  Device.swift
//  IBDecodable
//
//  Created by phimage on 08/04/2018.
//

import SWXMLHash

public struct Device: IBDecodable, IBIdentifiable {

    public var id: String
    public var orientation: String?
    public var appearance: String?
    public var adaptation: Adaptation?

    static func decode(_ xml: XMLIndexerType) throws -> Device {
        let container = xml.container(keys: CodingKeys.self)
        return Device(
            id:          try container.attribute(of: .id),
            orientation: container.attributeIfPresent(of: .orientation),
            appearance:  container.attributeIfPresent(of: .appearance),
            adaptation:  container.elementIfPresent(of: .adaptation)
        )
    }

    public struct Adaptation: IBDecodable, IBIdentifiable {

        public var id: String

        static func decode(_ xml: XMLIndexerType) throws -> Adaptation {
            let container = xml.container(keys: CodingKeys.self)
            return Adaptation(
                id:  try container.attribute(of: .id)
            )
        }
    }

}
