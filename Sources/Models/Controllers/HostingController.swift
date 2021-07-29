//
//  HostingController.swift
//  IBDecodable
//
//  Created by Eric Marchand on 11/07/2019.
//

import Foundation

public struct HostingController: IBDecodable, ViewControllerProtocol {

    public var elementClass: String = "UIHostingController"
    public var id: String
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?
    public var storyboardIdentifier: String?
    public var sceneMemberID: String?
    public var layoutGuides: [ViewControllerLayoutGuide]?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var keyCommands: [KeyCommand]?
    public var tabBarItem: TabBar.TabBarItem?
    public var view: View?
    public var rootView: ViewProtocol? { return view }
    public var size: [Size]?
    public var framework: String { return "SwiftUI" }

    enum LayoutGuidesCodingKeys: CodingKey { case viewControllerLayoutGuide }

    static func decode(_ xml: XMLIndexerType) throws -> HostingController {
        let container = xml.container(keys: CodingKeys.self)
        let layoutGuidesContainer = container.nestedContainerIfPresent(of: .layoutGuides, keys: LayoutGuidesCodingKeys.self)
        return HostingController(
            id:                   try container.attribute(of: .id),
            customClass:          container.attributeIfPresent(of: .customClass),
            customModule:         container.attributeIfPresent(of: .customModule),
            customModuleProvider: container.attributeIfPresent(of: .customModuleProvider),
            userLabel:            container.attributeIfPresent(of: .userLabel),
            colorLabel:           container.attributeIfPresent(of: .colorLabel),
            storyboardIdentifier: container.attributeIfPresent(of: .storyboardIdentifier),
            sceneMemberID:        container.attributeIfPresent(of: .sceneMemberID),
            layoutGuides:         layoutGuidesContainer?.elementsIfPresent(of: .viewControllerLayoutGuide),
            userDefinedRuntimeAttributes: container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:          container.childrenIfPresent(of: .connections),
            keyCommands:          container.childrenIfPresent(of: .keyCommands),
            tabBarItem:           container.elementIfPresent(of: .tabBarItem),
            view:                 container.elementIfPresent(of: .view),
            size:                 container.elementsIfPresent(of: .size)
        )
    }
}
