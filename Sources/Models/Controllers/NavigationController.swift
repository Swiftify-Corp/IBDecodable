//
//  NavigationController.swift
//  IBDecodable
//
//  Created by phimage on 02/04/2018.
//

import SWXMLHash

public struct NavigationController: IBDecodable, ViewControllerProtocol {

    public var elementClass: String = "UINavigationController"
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
    public var tabBarItem: TabBarItem?
    public var navigationBar: NavigationBar?
    public var rootView: ViewProtocol? { return navigationBar }
    public var size: [Size]?
    public var navigationItem: NavigationItem? { return nil }
    public let hidesBottomBarWhenPushed: Bool?

    enum LayoutGuidesCodingKeys: CodingKey { case viewControllerLayoutGuide }

    static func decode(_ xml: XMLIndexerType) throws -> NavigationController {
        let container = xml.container(keys: CodingKeys.self)
        let layoutGuidesContainer = container.nestedContainerIfPresent(of: .layoutGuides, keys: LayoutGuidesCodingKeys.self)
        return NavigationController(
            elementClass:                 "UINavigationController",
            id:                           try container.attribute(of: .id),
            customClass:                  container.attributeIfPresent(of: .customClass),
            customModule:                 container.attributeIfPresent(of: .customModule),
            customModuleProvider:         container.attributeIfPresent(of: .customModuleProvider),
            userLabel:                    container.attributeIfPresent(of: .userLabel),
            colorLabel:                   container.attributeIfPresent(of: .colorLabel),
            storyboardIdentifier:         container.attributeIfPresent(of: .storyboardIdentifier),
            sceneMemberID:                container.attributeIfPresent(of: .sceneMemberID),
            layoutGuides:                 layoutGuidesContainer?.elementsIfPresent(of: .viewControllerLayoutGuide),
            userDefinedRuntimeAttributes: container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                  container.childrenIfPresent(of: .connections),
            keyCommands:                  container.childrenIfPresent(of: .keyCommands),
            tabBarItem:                   container.elementIfPresent(of: .tabBarItem),
            navigationBar:                container.elementIfPresent(of: .navigationBar),
            size:                         container.elementsIfPresent(of: .size),
            hidesBottomBarWhenPushed:     container.attributeIfPresent(of: .hidesBottomBarWhenPushed)
        )
    }
}
