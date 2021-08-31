//
//  File.swift
//  
//
//  Created by Ibrahim Hassan on 31/08/21.
//

import SWXMLHash

public struct TabBarItem: IBDecodable, IBKeyable, IBCustomClassable, IBUserLabelable {

    public var id: String
    public var key: String?
    public var style: String?
    public var systemItem: String?
    public var title: String?
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?

    static func decode(_ xml: XMLIndexerType) throws -> TabBarItem {
        let container = xml.container(keys: CodingKeys.self)
        return TabBarItem(
            id:         try container.attribute(of: .id),
            key:        container.attributeIfPresent(of: .key),
            style:      container.attributeIfPresent(of: .style),
            systemItem: container.attributeIfPresent(of: .systemItem),
            title:      container.attributeIfPresent(of: .title),
            customClass:          container.attributeIfPresent(of: .customClass),
            customModule:         container.attributeIfPresent(of: .customModule),
            customModuleProvider: container.attributeIfPresent(of: .customModuleProvider),
            userLabel:            container.attributeIfPresent(of: .userLabel),
            colorLabel:           container.attributeIfPresent(of: .colorLabel)
        )
    }
}
