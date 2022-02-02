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
    public var tabBarItem: TabBarItem?
    public var view: View?
    
    /*
     Interface Builder sets the XML element name as
     1) <tableViewController> </tableViewController>
     2) <collectionViewController> </collectionViewController>
     3) <navigationController> </navigationController>
     
     but the element name can be overridden to viewController and the project runs fine
     https://gist.github.com/Ibrahimhass/a130fac7d8861bc42ce61dcf5cc44682
     */
    
    public var tableView: TableView?
    public var collectionView: CollectionView?
    public var navigationBar: NavigationBar?
    public var videoView: AnyView?
    public var glkView: GLKView?
    
    public var rootView: ViewProtocol? {
        var rootView: ViewProtocol?
        
        if let tableView = tableView {
            rootView = tableView
        }
        
        if let collectionView = collectionView {
            rootView = collectionView
        }
        
        if let navigationBar = navigationBar {
            rootView = navigationBar
        }
        
        if let videoView = videoView {
            rootView = videoView.view
        }
        
        if let glkView = glkView {
            rootView = glkView
        }
        
        if let view = view {
            rootView = view
        }
        
        return rootView
    }
    
    public var size: [Size]?
    public var definesPresentationContext: Bool?
    public var providesPresentationContextTransitionStyle: Bool?
    public var modalTransitionStyle: ModalTransitionStyle
    public var modalPresentationStyle: ModalPresentationStyle
    public var navigationItem: NavigationItem?

    enum LayoutGuidesCodingKeys: CodingKey { case viewControllerLayoutGuide }

    static func decode(_ xml: XMLIndexerType) throws -> ViewController {
        let container = xml.container(keys: CodingKeys.self)
        let layoutGuidesContainer = container.nestedContainerIfPresent(of: .layoutGuides, keys: LayoutGuidesCodingKeys.self)
        return ViewController(
            elementClass:                               "UIViewController",
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
            tableView:                                  container.elementIfPresent(of: .tableView),
            collectionView:                             container.elementIfPresent(of: .collectionView),
            navigationBar:                              container.elementIfPresent(of: .navigationBar),
            videoView:                                  xml.childrenElements.first.flatMap(decodeValue),
            glkView:                                    container.elementIfPresent(of: .glkView),
            size:                                       container.elementsIfPresent(of: .size),
            definesPresentationContext:                 container.attributeIfPresent(of: .definesPresentationContext),
            providesPresentationContextTransitionStyle: container.attributeIfPresent(of: .providesPresentationContextTransitionStyle),
            modalTransitionStyle:                       container.attributeIfPresent(of: .modalTransitionStyle) ?? .coverVertical,
            modalPresentationStyle:                     container.attributeIfPresent(of: .modalPresentationStyle) ?? .automatic,
            navigationItem:                             container.elementIfPresent(of: .navigationItem)
        )
    }
}
