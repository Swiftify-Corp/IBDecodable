//
//  Button.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

public struct Button: IBDecodable, ControlProtocol, IBIdentifiable {
    public var id: String
    public var elementClass: String = "UIButton"
    
    public var key: String?
    public var autoresizingMask: AutoresizingMask?
    public var buttonType: String?
    public var clipsSubviews: Bool?
    public var constraints: [Constraint]?
    public var contentMode: String?
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?
    public var fixedFrame: Bool?
    public var fontDescription: FontDescription?
    public var lineBreakMode: String?
    public var isMisplaced: Bool?
    public var isAmbiguous: Bool?
    public var verifyAmbiguity: VerifyAmbiguity?
    public var opaque: Bool?
    public var rect: Rect?
    public var subviews: [AnyView]?
    public var state: [State]?
    public var translatesAutoresizingMaskIntoConstraints: Bool?
    public var userInteractionEnabled: Bool?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var variations: [Variation]?
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?
    
    public var isEnabled: Bool?
    public var isHighlighted: Bool?
    public var isSelected: Bool?
    public var contentHorizontalAlignment: String?
    public var contentVerticalAlignment: String? = nil
    public var tag: String?
    public var buttonConfiguration: ButtonConfiguration?

    public struct State: IBDecodable, IBKeyable {
        public let key: String?
        public let title: String?
        public let color: Color?
        public let titleColor: Color?
        public let titleShadowColor: Color?
        public let image: String?
        public let catalog: String?
        public let attributedString: AttributedString?
        public let backgroundImage: String?
        
        static func decode(_ xml: XMLIndexerType) throws -> Button.State {
            let container = xml.container(keys: CodingKeys.self)
            let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
                .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)
            return State.init(
                key: try container.attribute(of: .key),
                title: container.attributeIfPresent(of: .title),
                color: container.elementIfPresent(of: .color),
                titleColor: colorsContainer?.withAttributeElement(.key, CodingKeys.titleColor.stringValue),
                titleShadowColor: colorsContainer?.withAttributeElement(.key, CodingKeys.titleShadowColor.stringValue),
                image: container.attributeIfPresent(of: .image),
                catalog: container.attributeIfPresent(of: .catalog),
                attributedString: container.elementIfPresent(of: .attributedString),
                backgroundImage: container.attributeIfPresent(of: .backgroundImage)
            )
        }
    }
    
    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }
    
    static func decode(_ xml: XMLIndexerType) throws -> Button {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .isEnabled: return "enabled"
                case .isHighlighted: return "highlighted"
                case .isSelected: return "selected"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)
        
        return Button(
            id:                                        try container.attribute(of: .id),
            elementClass:                              "UIButton",
            key:                                       container.attributeIfPresent(of: .key),
            autoresizingMask:                          container.elementIfPresent(of: .autoresizingMask),
            buttonType:                                container.attributeIfPresent(of: .buttonType),
            clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
            constraints:                               constraintsContainer?.elementsIfPresent(of: .constraint),
            contentMode:                               container.attributeIfPresent(of: .contentMode),
            customClass:                               container.attributeIfPresent(of: .customClass),
            customModule:                              container.attributeIfPresent(of: .customModule),
            customModuleProvider:                      container.attributeIfPresent(of: .customModuleProvider),
            userLabel:                                 container.attributeIfPresent(of: .userLabel),
            colorLabel:                                container.attributeIfPresent(of: .colorLabel),
            fixedFrame:                                container.attributeIfPresent(of: .fixedFrame),
            fontDescription:                           container.elementIfPresent(of: .fontDescription),
            lineBreakMode:                             container.attributeIfPresent(of: .lineBreakMode),
            isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
            isAmbiguous:                               container.attributeIfPresent(of: .isAmbiguous),
            verifyAmbiguity:                           container.attributeIfPresent(of: .verifyAmbiguity),
            opaque:                                    container.attributeIfPresent(of: .opaque),
            rect:                                      container.elementIfPresent(of: .rect),
            subviews:                                  container.childrenIfPresent(of: .subviews),
            state:                                     container.elementsIfPresent(of: .state),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
            userDefinedRuntimeAttributes:              container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                               container.childrenIfPresent(of: .connections),
            variations:                                variationContainer.elementsIfPresent(of: .variation),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha),
            isEnabled:                                 container.attributeIfPresent(of: .isEnabled),
            isHighlighted:                             container.attributeIfPresent(of: .isHighlighted),
            isSelected:                                container.attributeIfPresent(of: .isSelected),
            contentHorizontalAlignment:                container.attributeIfPresent(of: .contentHorizontalAlignment),
            contentVerticalAlignment:                  container.attributeIfPresent(of: .contentVerticalAlignment),
            tag:                                       container.attributeIfPresent(of: .tag),
            buttonConfiguration:                       container.elementIfPresent(of: .buttonConfiguration)
        )
    }
}
