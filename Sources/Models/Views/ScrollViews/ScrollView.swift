//
//  ScrollView.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

public struct ScrollView: IBDecodable, ViewProtocol, IBIdentifiable {
    public var id: String
    public var elementClass: String = "UIScrollView"

    public var key: String?
    public var autoresizingMask: AutoresizingMask?
    public var clipsSubviews: Bool?
    public var constraints: [Constraint]?
    public var contentMode: String?
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?
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
    public var isPagingEnabled: Bool?
    public var bouncesZoom: Bool?
    public var bounces: Bool?
    public var alwaysBounceVertical: Bool?
    public var alwaysBounceHorizontal: Bool?
    public var keyboardDismissMode: String?
    public var showsVerticalScrollIndicator: Bool? // default true
    public var showsHorizontalScrollIndicator: Bool? // default true
    public var maximumZoomScale: Float?
    public var minimumZoomScale: Float?
    public var isDirectionalLockEnabled: Bool?
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?
    public var indicatorStyle: String?
    public var delaysContentTouches: Bool?
    public var canCancelContentTouches: Bool?
    public var inset: Inset?
    public var contentInsetAdjustmentBehavior: String?
    public var directionalEdgeInsets: DirectionalEdgeInsets?
    public var edgeInsets: EdgeInset?
    

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> ScrollView {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .isPagingEnabled: return "pagingEnabled"
                case .isDirectionalLockEnabled: return "directionalLockEnabled"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return ScrollView(
            id:                                        try container.attribute(of: .id),
            elementClass:                              "UIScrollView",
            key:                                       container.attributeIfPresent(of: .key),
            autoresizingMask:                          container.elementIfPresent(of: .autoresizingMask),
            clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
            constraints:                               constraintsContainer?.elementsIfPresent(of: .constraint),
            contentMode:                               container.attributeIfPresent(of: .contentMode),
            customClass:                               container.attributeIfPresent(of: .customClass),
            customModule:                              container.attributeIfPresent(of: .customModule),
            customModuleProvider:                      container.attributeIfPresent(of: .customModuleProvider),
            userLabel:                                 container.attributeIfPresent(of: .userLabel),
            colorLabel:                                container.attributeIfPresent(of: .colorLabel),
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
            isPagingEnabled:                           container.attributeIfPresent(of: .isPagingEnabled),
            bouncesZoom:                               container.attributeIfPresent(of: .bouncesZoom),
            bounces:                                   container.attributeIfPresent(of: .bounces),
            alwaysBounceVertical:                      container.attributeIfPresent(of: .alwaysBounceVertical),
            alwaysBounceHorizontal:                    container.attributeIfPresent(of: .alwaysBounceHorizontal),
            keyboardDismissMode:                       container.attributeIfPresent(of: .keyboardDismissMode),
            showsVerticalScrollIndicator:              container.attributeIfPresent(of: .showsVerticalScrollIndicator),
            showsHorizontalScrollIndicator:            container.attributeIfPresent(of: .showsHorizontalScrollIndicator),
            maximumZoomScale:                          container.attributeIfPresent(of: .maximumZoomScale),
            minimumZoomScale:                          container.attributeIfPresent(of: .minimumZoomScale),
            isDirectionalLockEnabled:                  container.attributeIfPresent(of: .isDirectionalLockEnabled),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha),
            indicatorStyle:                            container.attributeIfPresent(of: .indicatorStyle),
            delaysContentTouches:                      container.attributeIfPresent(of: .delaysContentTouches),
            canCancelContentTouches:                   container.attributeIfPresent(of: .canCancelContentTouches),
            inset:                                     container.elementIfPresent(of: .inset),
            contentInsetAdjustmentBehavior:            container.attributeIfPresent(of: .contentInsetAdjustmentBehavior),
            directionalEdgeInsets:                     container.elementIfPresent(of: .directionalEdgeInsets),
            edgeInsets:                                container.elementIfPresent(of: .edgeInsets)
        )
    }
}
