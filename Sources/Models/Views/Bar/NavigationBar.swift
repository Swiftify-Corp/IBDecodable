//
//  NavigationBar.swift
//  IBDecodable
//
//  Created by phimage on 02/04/2018.
//

import SWXMLHash

public struct NavigationBar: IBDecodable, ViewProtocol, IBIdentifiable {
    public var id: String
    public var elementClass: String = "UINavigationBar"

    public var key: String?
    public var autoresizingMask: AutoresizingMask?
    public var clipsSubviews: Bool?
    public var constraints: [Constraint]?
    public var contentMode: String?
    public var barStyle: String?
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?
    public var items: [NavigationItem]?
    public var isMisplaced: Bool?
    public var isAmbiguous: Bool?
    public var verifyAmbiguity: VerifyAmbiguity?
    public var opaque: Bool?
    public var rect: Rect?
    public var subviews: [AnyView]?
    public var translatesAutoresizingMaskIntoConstraints: Bool?
    public var userInteractionEnabled: Bool?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var variations: [Variation]?
    public var backgroundColor: Color?
    public var barTintColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?
    
    public var imageReferences: [ImageReference]?
    public var shadowImage: String?
    public var backIndicatorTransitionMaskImage: String?
    public var backIndicatorImage: String?
    public var largeTitles: Bool?
    public var isTranslucent: Bool? // true if not present
    public var textAttributes: [TextAttributes]?
    public var tag: String?

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }
    enum NavigationItemsCodingKeys: CodingKey { case navigationItem }
    

    static func decode(_ xml: XMLIndexerType) throws -> NavigationBar {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .imageReferences: return "imageReference"
                case .isTranslucent: return "translucent"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }

        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let navigationItemsContainer = container.nestedContainerIfPresent(of: .items, keys: NavigationItemsCodingKeys.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return NavigationBar(
            id:                                        try container.attribute(of: .id),
            elementClass:                              "UINavigationBar",
            key:                                       container.attributeIfPresent(of: .key),
            autoresizingMask:                          container.elementIfPresent(of: .autoresizingMask),
            clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
            constraints:                               constraintsContainer?.elementsIfPresent(of: .constraint),
            contentMode:                               container.attributeIfPresent(of: .contentMode),
            barStyle:                                  container.attributeIfPresent(of: .barStyle),
            customClass:                               container.attributeIfPresent(of: .customClass),
            customModule:                              container.attributeIfPresent(of: .customModule),
            customModuleProvider:                      container.attributeIfPresent(of: .customModuleProvider),
            userLabel:                                 container.attributeIfPresent(of: .userLabel),
            colorLabel:                                container.attributeIfPresent(of: .colorLabel),
            items:                                     navigationItemsContainer?.elementsIfPresent(of: .navigationItem),
            isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
            isAmbiguous:                               container.attributeIfPresent(of: .isAmbiguous),
            verifyAmbiguity:                           container.attributeIfPresent(of: .verifyAmbiguity),
            opaque:                                    container.attributeIfPresent(of: .opaque),
            rect:                                      container.elementIfPresent(of: .rect),
            subviews:                                  container.childrenIfPresent(of: .subviews),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
            userDefinedRuntimeAttributes:              container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                               container.childrenIfPresent(of: .connections),
            variations:                                variationContainer.elementsIfPresent(of: .variation),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            barTintColor:                              colorsContainer?.withAttributeElement(.key, CodingKeys.barTintColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha),
            imageReferences:                           container.elementsIfPresent(of: .imageReferences),
            shadowImage:                               container.attributeIfPresent(of: .shadowImage),
            backIndicatorTransitionMaskImage:          container.attributeIfPresent(of: .backIndicatorTransitionMaskImage),
            backIndicatorImage:                        container.attributeIfPresent(of: .backIndicatorImage),
            largeTitles:                               container.attributeIfPresent(of: .largeTitles),
            isTranslucent:                             container.attributeIfPresent(of: .isTranslucent),
            textAttributes:                            container.elementsIfPresent(of: .textAttributes),
            tag:                                       container.attributeIfPresent(of: .tag)
        )
    }
}
