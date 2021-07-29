//
//  ViewController.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

public struct ViewController: IBDecodable, ViewControllerProtocol {

    public var elementClass: String = "UIViewController"
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
    public var definesPresentationContext: Bool?
    public var providesPresentationContextTransitionStyle: Bool?
    public var modalTransitionStyle: ModalTransitionStyle
    public var modalPresentationStyle: ModalPresentationStyle

    enum LayoutGuidesCodingKeys: CodingKey { case viewControllerLayoutGuide }

    static func decode(_ xml: XMLIndexerType) throws -> ViewController {
        let container = xml.container(keys: CodingKeys.self)
        let layoutGuidesContainer = container.nestedContainerIfPresent(of: .layoutGuides, keys: LayoutGuidesCodingKeys.self)
        return ViewController(
            id:                                         try container.attribute(of: .id),
            customClass:                                container.attributeIfPresent(of: .customClass),
            customModule:                               container.attributeIfPresent(of: .customModule),
            customModuleProvider:                       container.attributeIfPresent(of: .customModuleProvider),
            userLabel:                                  container.attributeIfPresent(of: .userLabel),
            colorLabel:                                 container.attributeIfPresent(of: .colorLabel),
            storyboardIdentifier:                       container.attributeIfPresent(of: .storyboardIdentifier),
            sceneMemberID:                              container.attributeIfPresent(of: .sceneMemberID),
            layoutGuides:                               layoutGuidesContainer?.elementsIfPresent(of: .viewControllerLayoutGuide),
            userDefinedRuntimeAttributes:               container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                                container.childrenIfPresent(of: .connections),
            keyCommands:                                container.childrenIfPresent(of: .keyCommands),
            tabBarItem:                                 container.elementIfPresent(of: .tabBarItem),
            view:                                       container.elementIfPresent(of: .view),
            size:                                       container.elementsIfPresent(of: .size),
            definesPresentationContext:                 container.attributeIfPresent(of: .definesPresentationContext),
            providesPresentationContextTransitionStyle: container.attributeIfPresent(of: .providesPresentationContextTransitionStyle),
            modalTransitionStyle:                       container.attributeIfPresent(of: .modalTransitionStyle) ?? .coverVertical,
            modalPresentationStyle:                       container.attributeIfPresent(of: .modalPresentationStyle) ?? .automatic
        )
    }
}
