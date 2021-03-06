//
//  TableViewController.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

public struct TableViewController: IBDecodable, ViewControllerProtocol {

    public var elementClass: String = "UITableViewController"
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
    public var tableView: TableView?
    public var rootView: ViewProtocol? { return tableView }
    public var clearsSelectionOnViewWillAppear: Bool?
    public var size: [Size]?
    public var navigationItem: NavigationItem?
    public let hidesBottomBarWhenPushed: Bool?

    enum LayoutGuidesCodingKeys: CodingKey { case viewControllerLayoutGuide }

    static func decode(_ xml: XMLIndexerType) throws -> TableViewController {
        let container = xml.container(keys: CodingKeys.self)
        let layoutGuidesContainer = container.nestedContainerIfPresent(of: .layoutGuides, keys: LayoutGuidesCodingKeys.self)
        return TableViewController(
            elementClass:                    "UITableViewController",
            id:                              try container.attribute(of: .id),
            customClass:                     container.attributeIfPresent(of: .customClass),
            customModule:                    container.attributeIfPresent(of: .customModule),
            customModuleProvider:            container.attributeIfPresent(of: .customModuleProvider),
            userLabel:                       container.attributeIfPresent(of: .userLabel),
            colorLabel:                      container.attributeIfPresent(of: .colorLabel),
            storyboardIdentifier:            container.attributeIfPresent(of: .storyboardIdentifier),
            sceneMemberID:                   container.attributeIfPresent(of: .sceneMemberID),
            layoutGuides:                    layoutGuidesContainer?.elementsIfPresent(of: .viewControllerLayoutGuide),
            userDefinedRuntimeAttributes:    container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                     container.childrenIfPresent(of: .connections),
            keyCommands:                     container.childrenIfPresent(of: .keyCommands),
            tabBarItem:                      container.elementIfPresent(of: .tabBarItem),
            tableView:                       container.elementIfPresent(of: .tableView),
            clearsSelectionOnViewWillAppear: container.attributeIfPresent(of: .clearsSelectionOnViewWillAppear) ?? true,
            size:                            container.elementsIfPresent(of: .size),
            navigationItem:                  container.elementIfPresent(of: .navigationItem),
            hidesBottomBarWhenPushed:     container.attributeIfPresent(of: .hidesBottomBarWhenPushed)
        )
    }
}
