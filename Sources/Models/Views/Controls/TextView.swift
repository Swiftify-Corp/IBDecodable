//
//  TextView.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

public struct TextView: IBDecodable, ControlProtocol, IBIdentifiable, IBTextElement {
    public var id: String
    public var elementClass: String = "UITextView"

    public var key: String?
    public var autoresizingMask: AutoresizingMask?
    public var bounces: Bool?
    public var bouncesZoom: Bool?
    public var clipsSubviews: Bool?
    public var constraints: [Constraint]?
    public var contentMode: String?
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?
    public var fontDescription: FontDescription?
    public var isMisplaced: Bool?
    public var isAmbiguous: Bool?
    public var verifyAmbiguity: VerifyAmbiguity?
    public var opaque: Bool?
    public var rect: Rect?
    public var scrollEnabled: Bool?
    public var showsHorizontalScrollIndicator: Bool?
    public var showsVerticalScrollIndicator: Bool?
    public var subviews: [AnyView]?
    public var string: StringContainer?
    public var mutableString: StringContainer?
    public var text: String?
    public var textAlignment: String?
    public var textColor: Color?
    public var translatesAutoresizingMaskIntoConstraints: Bool?
    public var userInteractionEnabled: Bool?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var variations: [Variation]?
    public var editable: Bool?
    public var backgroundColor: Color?
    public var tintColor: Color?

    public var isEnabled: Bool?
    public var isHighlighted: Bool?
    public var isSelected: Bool?
    public var contentHorizontalAlignment: String?
    public var contentVerticalAlignment: String?
    
    public var hidden: Bool?
    public var alpha: Float?
    public var textInputTraits: TextInputTraits?
    public var dataDetectorType: DataDetectorType?
    
    public var alwaysBounceVertical: Bool?
    public var alwaysBounceHorizontal: Bool?
    public var indicatorStyle: String?
    public var selectable: Bool?
    public var spellCheckingType: Bool?
    public var tag: String?
    
    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color, string }
    enum ColorsCodingKeys: CodingKey { case key }
    enum StringsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> TextView {
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
        let externalContainer = xml.container(keys: ExternalCodingKeys.self)
        let colorsContainer = externalContainer
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)
        let stringsContainer = externalContainer
            .nestedContainerIfPresent(of: .string, keys: StringsCodingKeys.self)

        var text: String? = container.attributeIfPresent(of: .text)
        if text == nil {
            let multiLineText: StringElement? = stringsContainer?.withAttributeElement(.key, CodingKeys.text.stringValue)
            text = multiLineText?.elementValue
        }
        
        return TextView(
            id: try container.attribute(of: .id),
            elementClass: "UITextView",
            key: container.attributeIfPresent(of: .key),
            autoresizingMask: container.elementIfPresent(of: .autoresizingMask),
            bounces: container.attributeIfPresent(of: .bounces),
            bouncesZoom: container.attributeIfPresent(of: .bouncesZoom),
            clipsSubviews: container.attributeIfPresent(of: .clipsSubviews),
            constraints: constraintsContainer?.elementsIfPresent(of: .constraint),
            contentMode: container.attributeIfPresent(of: .contentMode),
            customClass: container.attributeIfPresent(of: .customClass),
            customModule: container.attributeIfPresent(of: .customModule),
            customModuleProvider: container.attributeIfPresent(of: .customModuleProvider),
            userLabel: container.attributeIfPresent(of: .userLabel),
            colorLabel: container.attributeIfPresent(of: .colorLabel),
            fontDescription: container.elementIfPresent(of: .fontDescription),
            isMisplaced: container.attributeIfPresent(of: .isMisplaced),
            isAmbiguous: container.attributeIfPresent(of: .isAmbiguous),
            verifyAmbiguity: container.attributeIfPresent(of: .verifyAmbiguity),
            opaque: container.attributeIfPresent(of: .opaque),
            rect: container.elementIfPresent(of: .rect),
            scrollEnabled: container.attributeIfPresent(of: .scrollEnabled),
            showsHorizontalScrollIndicator: container.attributeIfPresent(of: .showsHorizontalScrollIndicator),
            showsVerticalScrollIndicator: container.attributeIfPresent(of: .showsVerticalScrollIndicator),
            subviews: container.childrenIfPresent(of: .subviews),
            string: container.elementIfPresent(of: .string),
            mutableString: container.elementIfPresent(of: .mutableString),
            text: container.attributeIfPresent(of: .text),
            textAlignment: container.attributeIfPresent(of: .textAlignment),
            textColor: colorsContainer?.withAttributeElement(.key, CodingKeys.textColor.stringValue),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled: container.attributeIfPresent(of: .userInteractionEnabled),
            userDefinedRuntimeAttributes: container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections: container.childrenIfPresent(of: .connections),
            variations: variationContainer.elementsIfPresent(of: .variation),
            editable: container.attributeIfPresent(of: .editable),
            backgroundColor: colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor: colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            isEnabled: container.attributeIfPresent(of: .isEnabled),
            isHighlighted: container.attributeIfPresent(of: .isHighlighted),
            isSelected: container.attributeIfPresent(of: .isSelected),
            contentHorizontalAlignment: container.attributeIfPresent(of: .contentHorizontalAlignment),
            contentVerticalAlignment: container.attributeIfPresent(of: .contentVerticalAlignment),
            hidden: container.attributeIfPresent(of: .hidden),
            alpha: container.attributeIfPresent(of: .alpha),
            textInputTraits: container.elementIfPresent(of: .textInputTraits),
            dataDetectorType: container.elementIfPresent(of: .dataDetectorType),
            alwaysBounceVertical: container.attributeIfPresent(of: .alwaysBounceVertical),
            alwaysBounceHorizontal: container.attributeIfPresent(of: .alwaysBounceHorizontal),
            indicatorStyle: container.attributeIfPresent(of: .indicatorStyle),
            selectable: container.attributeIfPresent(of: .selectable),
            spellCheckingType: container.attributeIfPresent(of: .spellCheckingType),
            tag: container.attributeIfPresent(of: .tag)
        )
    }
}
