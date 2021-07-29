//
//  Exit.swift
//  IBDecodable
//
//  Created by phimage on 09/05/2018.
//

import SWXMLHash

public struct Exit: IBDecodable, IBIdentifiable, IBUserLabelable {

    public var id: String
    public var userLabel: String?
    public var colorLabel: String?
    public var sceneMemberID: String?

    static func decode(_ xml: XMLIndexerType) throws -> Exit {
        let container = xml.container(keys: CodingKeys.self)
        return Exit(
            id:            try container.attribute(of: .id),
            userLabel:     container.attributeIfPresent(of: .userLabel),
            colorLabel:    container.attributeIfPresent(of: .colorLabel),
            sceneMemberID: container.attributeIfPresent(of: .sceneMemberID)
        )
    }

}
