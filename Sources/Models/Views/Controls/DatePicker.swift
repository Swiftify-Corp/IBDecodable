//
//  DatePicker.swift
//  IBDecodable
//
//  Created by phimage on 01/04/2018.
//

import SWXMLHash

public struct DatePicker: IBDecodable, ControlProtocol, IBIdentifiable {
    public var id: String
    public var elementClass: String = "UIDatePicker"

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
    public var viewLayoutGuide: LayoutGuide?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var variations: [Variation]?
    
    public var datePickerMode: String?
    public var minuteInterval: Int? // Integer??
    public var date: IBDate?
    public var backgroundColor: Color?
    public var tintColor: Color?
    
    public var isEnabled: Bool?
    public var isHighlighted: Bool?
    public var isSelected: Bool?
    public var contentHorizontalAlignment: String?
    public var contentVerticalAlignment: String?
    
    public var hidden: Bool?
    public var alpha: Float?

    public var style: String?
    public var useCurrentDate: Bool?
    public var countdownDuration: Int?
    public var minimumDate: IBDate?
    public var maximumDate: IBDate?
    public var locale: IBLocale?

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color, date, locale }
    enum ColorsCodingKeys: CodingKey { case key }
    enum DateCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> DatePicker {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .isEnabled: return "enabled"
                case .isHighlighted: return "highlighted"
                case .isSelected: return "selected"
                case .countdownDuration: return "countDownDuration"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)
        let dateContainer = xml.container(keys: ExternalCodingKeys.self)
                .nestedContainerIfPresent(of: .date, keys: DateCodingKeys.self)

        return DatePicker(
            id:                                        try container.attribute(of: .id),
            elementClass:                              "UIDatePicker",
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
            viewLayoutGuide:                           container.elementIfPresent(of: .viewLayoutGuide),
            userDefinedRuntimeAttributes:              container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                               container.childrenIfPresent(of: .connections),
            variations:                                variationContainer.elementsIfPresent(of: .variation),
            datePickerMode:                            container.attributeIfPresent(of: .datePickerMode),
            minuteInterval:                            container.attributeIfPresent(of: .minuteInterval),
            date:                                      dateContainer?.withAttributeElement(.key, CodingKeys.date.stringValue),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            isEnabled:                                 container.attributeIfPresent(of: .isEnabled),
            isHighlighted:                             container.attributeIfPresent(of: .isHighlighted),
            isSelected:                                container.attributeIfPresent(of: .isSelected),
            contentHorizontalAlignment:                container.attributeIfPresent(of: .contentHorizontalAlignment),
            contentVerticalAlignment:                  container.attributeIfPresent(of: .contentVerticalAlignment),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha),
            style:                                     container.attributeIfPresent(of: .style),
            useCurrentDate:                            container.attributeIfPresent(of: .useCurrentDate),
            countdownDuration:                         container.attributeIfPresent(of: .countdownDuration),
            minimumDate:                               dateContainer?.withAttributeElement(.key, CodingKeys.minimumDate.stringValue),
            maximumDate:                               dateContainer?.withAttributeElement(.key, CodingKeys.maximumDate.stringValue),
            locale:                                    container.elementIfPresent(of: .locale)
        )
    }
    
    public func getDatePickerMode() -> String? {
        return datePickerMode == "countDownTimer" ? "countdownTimer" :  datePickerMode
    }
}
