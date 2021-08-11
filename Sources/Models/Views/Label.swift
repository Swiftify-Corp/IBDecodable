//
//  Label.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

public struct Label: IBDecodable, ViewProtocol, IBIdentifiable {
    public var id: String
    public var elementClass: String = "UILabel"

    public var adjustsFontSizeToFit: Bool?
    public var key: String?
    public var autoresizingMask: AutoresizingMask?
    public var baselineAdjustment: String?
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
    public var horizontalHuggingPriority: Int?
    public var lineBreakMode: String?
    public var isMisplaced: Bool?
    public var isAmbiguous: Bool?
    public var verifyAmbiguity: VerifyAmbiguity?
    public var opaque: Bool?
    public var rect: Rect?
    public var subviews: [AnyView]?
    public var string: StringContainer?
    public var mutableString: StringContainer?
    public var text: String?
    public var textAlignment: String?
    public var textColor: Color?
    public var attributedText: AttributedString?
    public var translatesAutoresizingMaskIntoConstraints: Bool?
    public var userInteractionEnabled: Bool?
    public var verticalHuggingPriority: Int?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var variations: [Variation]?
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?
    
    
    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> Label {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .attributedText: return "attributedString"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return Label(
            id: try container.attribute(of: .id),
            elementClass: "UILabel",
            adjustsFontSizeToFit: container.attributeIfPresent(of: .adjustsFontSizeToFit),
            key: container.attributeIfPresent(of: .key),
            autoresizingMask: container.elementIfPresent(of: .autoresizingMask),
            baselineAdjustment: container.attributeIfPresent(of: .baselineAdjustment),
            clipsSubviews: container.attributeIfPresent(of: .clipsSubviews),
            constraints: constraintsContainer?.elementsIfPresent(of: .constraint),
            contentMode: container.attributeIfPresent(of: .contentMode),
            customClass: container.attributeIfPresent(of: .customClass),
            customModule: container.attributeIfPresent(of: .customModule),
            customModuleProvider: container.attributeIfPresent(of: .customModuleProvider),
            userLabel: container.attributeIfPresent(of: .userLabel),
            colorLabel: container.attributeIfPresent(of: .colorLabel),
            fixedFrame: container.attributeIfPresent(of: .fixedFrame),
            fontDescription: container.elementIfPresent(of: .fontDescription),
            horizontalHuggingPriority: container.attributeIfPresent(of: .horizontalHuggingPriority),
            lineBreakMode: container.attributeIfPresent(of: .lineBreakMode),
            isMisplaced: container.attributeIfPresent(of: .isMisplaced),
            isAmbiguous: container.attributeIfPresent(of: .isAmbiguous),
            verifyAmbiguity: container.attributeIfPresent(of: .verifyAmbiguity),
            opaque: container.attributeIfPresent(of: .opaque),
            rect: container.elementIfPresent(of: .rect),
            subviews: container.childrenIfPresent(of: .subviews),
            string: container.elementIfPresent(of: .string),
            mutableString: container.elementIfPresent(of: .mutableString),
            text: container.attributeIfPresent(of: .text),
            textAlignment: container.attributeIfPresent(of: .textAlignment),
            textColor: colorsContainer?.withAttributeElement(.key, CodingKeys.textColor.stringValue),
            attributedText: container.elementIfPresent(of: .attributedText),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled: container.attributeIfPresent(of: .userInteractionEnabled),
            verticalHuggingPriority: container.attributeIfPresent(of: .verticalHuggingPriority),
            userDefinedRuntimeAttributes: container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections: container.childrenIfPresent(of: .connections),
            variations: variationContainer.elementsIfPresent(of: .variation),
            backgroundColor: colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor: colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden: container.attributeIfPresent(of: .hidden),
            alpha: container.attributeIfPresent(of: .alpha)
        )
    }
}

// MARK: - FontDescription

public enum FontDescription: IBDecodable {
    public typealias SystemFont = (key: String?, type: String, weight: String?, pointSize: Float)
    public typealias CustomFont = (key: String?, name: String, family: String, pointSize: Float)
    public typealias TextStyle = (key: String?, style: String)
    case system(SystemFont)
    case custom(CustomFont)
    case textStyle(TextStyle)

    public var pointSize: Float? {
        switch self {
        case .system(let systemFont):
            return systemFont.pointSize
        case .custom(let customFont):
            return customFont.pointSize
        case .textStyle:
            return nil
        }
    }

    enum CodingKeys: CodingKey {
        case key, type, weight, pointSize, name, family, style
    }

    public func encode(to encoder: Encoder) throws { fatalError() }

    static func decode(_ xml: XMLIndexerType) throws -> FontDescription {
        let container = xml.container(keys: CodingKeys.self)
        let key: String? = container.attributeIfPresent(of: .key)
        if let type: String = container.attributeIfPresent(of: .type) {
            return try .system((key: key,
                                type: type,
                                weight: container.attributeIfPresent(of: .weight),
                                pointSize: container.attribute(of: .pointSize)
            ))
        } else if let name: String = container.attributeIfPresent(of: .name),
            let family: String = container.attributeIfPresent(of: .family) {
            return try .custom((key: key,
                                name: name,
                                family: family,
                                pointSize: container.attribute(of: .pointSize)
            ))
        } else if let style: String = container.attributeIfPresent(of: .style) {
            return .textStyle((key: key,
                               style: style
            ))
        } else {
            throw IBError.unsupportedFontDescription
        }
    }
}

extension FontDescription: AttributeProtocol {
    public var key: String? {
        switch self {
        case .system(let systemFont):
            return systemFont.key
        case .custom(let customFont):
            return customFont.key
        case .textStyle(let textStyle):
            return textStyle.key
        }
    }
}
