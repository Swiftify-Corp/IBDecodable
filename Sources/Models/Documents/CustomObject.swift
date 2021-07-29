//
//  CustomObject.swift
//  IBDecodable
//
//  Created by phimage on 09/05/2018.
//

import SWXMLHash

public struct CustomObject: IBDecodable, IBIdentifiable, IBCustomClassable {

    public var id: String
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?

    static func decode(_ xml: XMLIndexerType) throws -> CustomObject {
        let container = xml.container(keys: CodingKeys.self)
        return CustomObject(
            id:                    try container.attribute(of: .id),
            customClass:           container.attributeIfPresent(of: .customClass),
            customModule:          container.attributeIfPresent(of: .customModule),
            customModuleProvider:  container.attributeIfPresent(of: .customModuleProvider),
            userLabel:             container.attributeIfPresent(of: .userLabel),
            colorLabel:            container.attributeIfPresent(of: .colorLabel)
        )
    }

}
