//
//  MapView.swift
//  IBDecodable
//
//  Created by phimage on 01/04/2018.
//

import SWXMLHash

public struct MapView: IBDecodable, ViewProtocol, IBIdentifiable {
    public var id: String
    public var elementClass: String = "MKMapView"

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
    public var mapType: String?
    public var multipleTouchEnabled: Bool?
    public var showsTraffic: Bool?
    public var scrollEnabled: Bool?
    public var appearanceType: String?
    public var verticalHuggingPriority: Int?
    public var showsCompass: Bool?
    public var showsPointsOfInterest: Bool?
    public var restorationIdentifier: String?
    public var showsUserLocation: Bool?
    public var showsScale: Bool?
    public var showsBuildings: Bool?
    public var pitchEnabled: Bool?
    public var rotateEnabled: Bool?
    public var zoomEnabled: Bool?
    public var verticalCompressionResistancePriority: String?
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?
    public var tag: String?

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> MapView {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return MapView(
            id:                                        try container.attribute(of: .id),
            elementClass:                              "MKMapView",
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
            mapType:                                   container.attributeIfPresent(of: .mapType),
            multipleTouchEnabled:                      container.attributeIfPresent(of: .multipleTouchEnabled),
            showsTraffic:                              container.attributeIfPresent(of: .showsTraffic),
            scrollEnabled:                             container.attributeIfPresent(of: .scrollEnabled),
            appearanceType:                            container.attributeIfPresent(of: .appearanceType),
            verticalHuggingPriority:                   container.attributeIfPresent(of: .verticalHuggingPriority),
            showsCompass:                              container.attributeIfPresent(of: .showsCompass),
            showsPointsOfInterest:                     container.attributeIfPresent(of: .showsPointsOfInterest),
            restorationIdentifier:                     container.attributeIfPresent(of: .restorationIdentifier),
            showsUserLocation:                         container.attributeIfPresent(of: .showsUserLocation),
            showsScale:                                container.attributeIfPresent(of: .showsScale),
            showsBuildings:                            container.attributeIfPresent(of: .showsBuildings),
            pitchEnabled:                              container.attributeIfPresent(of: .pitchEnabled),
            rotateEnabled:                             container.attributeIfPresent(of: .rotateEnabled),
            zoomEnabled:                               container.attributeIfPresent(of: .zoomEnabled),
            verticalCompressionResistancePriority:     container.attributeIfPresent(of: .verticalCompressionResistancePriority),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha),
            tag:                                       container.attributeIfPresent(of: .tag)
        )
    }
}
