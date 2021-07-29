//
//  Placeholder.swift
//  IBDecodable
//
//  Created by phimage on 08/04/2018.
//

import SWXMLHash

public struct Placeholder: IBDecodable, IBIdentifiable, IBCustomClassable, IBUserLabelable {

    public var id: String
    public var placeholderIdentifier: String
    public var userLabel: String?
    public var colorLabel: String?
    public var sceneMemberID: String?
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userComments: AttributedString?
    public var connections: [AnyConnection]?

    enum ExternalCodingKeys: CodingKey { case attributedString }
    enum AttributedStringCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> Placeholder {
        let container = xml.container(keys: CodingKeys.self)
        let attributedStringContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .attributedString, keys: AttributedStringCodingKeys.self)
        return Placeholder(
            id:                    try container.attribute(of: .id),
            placeholderIdentifier: try container.attribute(of: .placeholderIdentifier),
            userLabel:             container.attributeIfPresent(of: .userLabel),
            colorLabel:            container.attributeIfPresent(of: .colorLabel),
            sceneMemberID:         container.attributeIfPresent(of: .sceneMemberID),
            customClass:           container.attributeIfPresent(of: .customClass),
            customModule:          container.attributeIfPresent(of: .customModule),
            customModuleProvider:  container.attributeIfPresent(of: .customModuleProvider),
            userComments:          attributedStringContainer?.withAttributeElement(.key, "userComments"),
            connections:           container.childrenIfPresent(of: .connections)
        )
    }

}
