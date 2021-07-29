//
//  KeyCommand.swift
//  IBDecodable
//
//  Created by phimage on 09/05/2018.
//

import SWXMLHash

public struct KeyCommand: IBDecodable {

    public var input: String?
    public var modifierFlags: String?
    public var actionName: String?
    public var discoverabilityTitle: String?

    static func decode(_ xml: XMLIndexerType) throws -> KeyCommand {
        let container = xml.container(keys: CodingKeys.self)
        return KeyCommand(
            input:                container.attributeIfPresent(of: .input),
            modifierFlags:        container.attributeIfPresent(of: .modifierFlags),
            actionName:           container.attributeIfPresent(of: .actionName),
            discoverabilityTitle: container.attributeIfPresent(of: .discoverabilityTitle)
        )
    }

}
