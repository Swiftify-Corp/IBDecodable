//
//  WKWebView.swift
//  IBDecodable
//
//  Created by phimage on 01/04/2018.
//

import SWXMLHash

public struct WKWebView: IBDecodable, ViewProtocol, IBIdentifiable {
    public var id: String
    public var elementClass: String = "WKWebView"

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
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?
    public var tag: String?
    public var wkWebViewConfiguration: WKWebViewConfiguration?
    public var allowsLinkPreview: Bool? // default value is true
    public var customUserAgent: String?
    public var allowsBackForwardNavigationGestures: Bool?

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> WKWebView {
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

        return WKWebView(
            id:                                        try container.attribute(of: .id),
            elementClass:                              "WKWebView",
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
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha),
            tag:                                       container.attributeIfPresent(of: .tag),
            wkWebViewConfiguration:                    container.elementIfPresent(of: .wkWebViewConfiguration),
            allowsLinkPreview:                         container.attributeIfPresent(of: .allowsLinkPreview),
            customUserAgent:                           container.attributeIfPresent(of: .customUserAgent),
            allowsBackForwardNavigationGestures:       container.attributeIfPresent(of: .allowsBackForwardNavigationGestures)
        )
    }
}

public struct WKWebViewConfiguration: IBDecodable, IBKeyable {
    public var key: String?
    public var allowsInlineMediaPlayback: Bool?
    public var suppressesIncrementalRendering: Bool? // default value is false
    public var allowsPictureInPictureMediaPlayback: Bool?
    public var allowsAirPlayForMediaPlayback: Bool?
    public var applicationNameForUserAgent: String?
    public var selectionGranularity: String?
    public var audiovisualMediaTypes: AudiovisualMediaTypes?
    public var wkPreferences: WKPreferences?
    public var dataDetectorTypes: DataDetectorType?

    static func decode(_ xml: XMLIndexerType) throws -> WKWebViewConfiguration {
        let container = xml.container(keys: CodingKeys.self)
        return WKWebViewConfiguration(
            key:                                  container.attributeIfPresent(of: .key),
            allowsInlineMediaPlayback:            container.attributeIfPresent(of: .allowsInlineMediaPlayback),
            suppressesIncrementalRendering:       container.attributeIfPresent(of: .suppressesIncrementalRendering),
            allowsPictureInPictureMediaPlayback:  container.attributeIfPresent(of: .allowsPictureInPictureMediaPlayback),
            allowsAirPlayForMediaPlayback:        container.attributeIfPresent(of: .allowsAirPlayForMediaPlayback),
            applicationNameForUserAgent:          container.attributeIfPresent(of: .applicationNameForUserAgent),
            selectionGranularity:                 container.attributeIfPresent(of: .selectionGranularity),
            audiovisualMediaTypes:                container.elementIfPresent(of: .audiovisualMediaTypes),
            wkPreferences:                        container.elementIfPresent(of: .wkPreferences),
            dataDetectorTypes:                    container.elementIfPresent(of: .dataDetectorTypes)
        )
    }
}

public struct AudiovisualMediaTypes: IBDecodable, IBKeyable {
    public var key: String?
    public var audio: Bool?
    public var video: Bool?
    public var none: Bool?

    static func decode(_ xml: XMLIndexerType) throws -> AudiovisualMediaTypes {
        let container = xml.container(keys: CodingKeys.self)
        return AudiovisualMediaTypes(
            key:        container.attributeIfPresent(of: .key),
            audio:      container.attributeIfPresent(of: .audio),
            video:      container.attributeIfPresent(of: .video),
            none:       container.attributeIfPresent(of: .none)
        )
    }
}

public struct WKPreferences: IBDecodable, IBKeyable {
    public var key: String?
    public var javaScriptEnabled: Bool?
    public var javaScriptCanOpenWindowsAutomatically: Bool?
    public var minimumFontSize: Float?
    
    static func decode(_ xml: XMLIndexerType) throws -> WKPreferences {
        let container = xml.container(keys: CodingKeys.self)
        return WKPreferences(
            key:                                        container.attributeIfPresent(of: .key),
            javaScriptEnabled:                          container.attributeIfPresent(of: .javaScriptEnabled),
            javaScriptCanOpenWindowsAutomatically:      container.attributeIfPresent(of: .javaScriptCanOpenWindowsAutomatically),
            minimumFontSize:                            container.attributeIfPresent(of: .minimumFontSize)
        )
    }
}
