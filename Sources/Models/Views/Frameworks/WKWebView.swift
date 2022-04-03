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
            wkWebViewConfiguration:                    container.elementIfPresent(of: .wkWebViewConfiguration)
        )
    }
}

public struct WKWebViewConfiguration: IBDecodable, IBKeyable {
    public var key: String?
    public var allowsInlineMediaPlayback: Bool?
    public var applicationNameForUserAgent: String?
    public var selectionGranularity: String?
    public var audiovisualMediaTypes: AudiovisualMediaTypes?
    public var wkPreferences: WKPreferences?

    static func decode(_ xml: XMLIndexerType) throws -> WKWebViewConfiguration {
        let container = xml.container(keys: CodingKeys.self)
        return WKWebViewConfiguration(
            key:                            container.attributeIfPresent(of: .key),
            allowsInlineMediaPlayback:      container.attributeIfPresent(of: .allowsInlineMediaPlayback),
            applicationNameForUserAgent:    container.attributeIfPresent(of: .applicationNameForUserAgent),
            selectionGranularity:           container.attributeIfPresent(of: .selectionGranularity),
            audiovisualMediaTypes:          container.elementIfPresent(of: .audiovisualMediaTypes)
        )
    }
}

public struct AudiovisualMediaTypes: IBDecodable, IBKeyable {
    public var key: String?
    public var audio: Bool?
    public var video: Bool?

    static func decode(_ xml: XMLIndexerType) throws -> AudiovisualMediaTypes {
        let container = xml.container(keys: CodingKeys.self)
        return AudiovisualMediaTypes(
            key:        container.attributeIfPresent(of: .key),
            audio:      container.attributeIfPresent(of: .audio),
            video:      container.attributeIfPresent(of: .video)
        )
    }
}

public struct WKPreferences: IBDecodable, IBKeyable {
    var key: String?
    var javaScriptCanOpenWindowsAutomatically: Bool?
    var minimumFontSize: Float?
    
    static func decode(_ xml: XMLIndexerType) throws -> WKPreferences {
        let container = xml.container(keys: CodingKeys.self)
        return WKPreferences(
            key:                                        container.attributeIfPresent(of: .key),
            javaScriptCanOpenWindowsAutomatically:      container.attributeIfPresent(of: .audio),
            minimumFontSize:                            container.attributeIfPresent(of: .video)
        )
    }
}
