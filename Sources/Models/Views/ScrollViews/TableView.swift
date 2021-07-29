//
//  TableView.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

// MARK: - TableView

public struct TableView: IBDecodable, ViewProtocol, IBIdentifiable {

    public var id: String
    public var elementClass: String = "UITableView"

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
    public var dataMode: DataMode?
    public var estimatedRowHeight: Float?
    public var isMisplaced: Bool?
    public var isAmbiguous: Bool?
    public var verifyAmbiguity: VerifyAmbiguity?
    public var opaque: Bool?
    public var rect: Rect?
    public var rowHeight: Float?
    public var sectionFooterHeight: Float?
    public var sectionHeaderHeight: Float?
    public var separatorStyle: String?
    public var style: String?
    private let _subviews: [AnyView]?
    public var subviews: [AnyView]? {
        return (_subviews ?? []) + (headersFooters ?? [])
    }
    public var translatesAutoresizingMaskIntoConstraints: Bool?
    public var userInteractionEnabled: Bool?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var variations: [Variation]?
    public var sections: [TableViewSection]?
    public var prototypeCells: [TableViewCell]?
    public var isPagingEnabled: Bool?
    public var bouncesZoom: Bool?
    public var bounces: Bool?
    public var alwaysBounceVertical: Bool?
    public var keyboardDismissMode: String?
    public var showsVerticalScrollIndicator: Bool?
    public var showsHorizontalScrollIndicator: Bool?
    public var maximumZoomScale: Float?
    public var minimumZoomScale: Float?
    public var isDirectionalLockEnabled: Bool?
    public var headersFooters: [AnyView]?
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?

    public enum DataMode: XMLAttributeDecodable, KeyDecodable, Equatable {
        case `static`, prototypes

        public func encode(to encoder: Encoder) throws { fatalError() }

        static func decode(_ attribute: XMLAttribute) throws -> TableView.DataMode {
            switch attribute.text {
            case "static":     return .static
            case "prototypes": return .prototypes
            default:
                throw IBError.unsupportedTableViewDataMode(attribute.text)
            }
        }

        public static func == (left: DataMode, right: DataMode) -> Bool {
            switch (left, right) {
            case (.`static`, .`static`):
                return true
            case (.prototypes, .prototypes):
                return true
            default:
                return false
            }
        }
    }

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> TableView {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case .prototypeCells: return "prototypes"
                case .isPagingEnabled: return "pagingEnabled"
                case .isDirectionalLockEnabled: return "directionalLockEnabled"
                case ._subviews: return "subviews"
                case .headersFooters: return "view"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return TableView(
            id:                                        try container.attribute(of: .id),
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
            dataMode:                                  container.attributeIfPresent(of: .dataMode),
            estimatedRowHeight:                        container.attributeIfPresent(of: .estimatedRowHeight),
            isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
            isAmbiguous:                               container.attributeIfPresent(of: .isAmbiguous),
            verifyAmbiguity:                           container.attributeIfPresent(of: .verifyAmbiguity),
            opaque:                                    container.attributeIfPresent(of: .opaque),
            rect:                                      container.elementIfPresent(of: .rect),
            rowHeight:                                 container.attributeIfPresent(of: .rowHeight),
            sectionFooterHeight:                       container.attributeIfPresent(of: .sectionFooterHeight),
            sectionHeaderHeight:                       container.attributeIfPresent(of: .sectionHeaderHeight),
            separatorStyle:                            container.attributeIfPresent(of: .separatorStyle),
            style:                                     container.attributeIfPresent(of: .style),
            _subviews:                                 container.childrenIfPresent(of: ._subviews),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
            userDefinedRuntimeAttributes:              container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                               container.childrenIfPresent(of: .connections),
            variations:                                variationContainer.elementsIfPresent(of: .variation),
            sections:                                  container.childrenIfPresent(of: .sections),
            prototypeCells:                            container.childrenIfPresent(of: .prototypeCells),
            isPagingEnabled:                           container.attributeIfPresent(of: .isPagingEnabled),
            bouncesZoom:                               container.attributeIfPresent(of: .bouncesZoom),
            bounces:                                   container.attributeIfPresent(of: .bounces),
            alwaysBounceVertical:                      container.attributeIfPresent(of: .alwaysBounceVertical),
            keyboardDismissMode:                       container.attributeIfPresent(of: .keyboardDismissMode),
            showsVerticalScrollIndicator:              container.attributeIfPresent(of: .showsVerticalScrollIndicator),
            showsHorizontalScrollIndicator:            container.attributeIfPresent(of: .showsHorizontalScrollIndicator),
            maximumZoomScale:                          container.attributeIfPresent(of: .maximumZoomScale),
            minimumZoomScale:                          container.attributeIfPresent(of: .minimumZoomScale),
            isDirectionalLockEnabled:                  container.attributeIfPresent(of: .isDirectionalLockEnabled),
            headersFooters:                            container.elementsIfPresent(of: .headersFooters),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha)
        )
    }
}

// MARK: - TableViewSection

public struct TableViewSection: IBDecodable {

    public var id: String
    public var headerTitle: String?
    public var footerTitle: String?
    public var colorLabel: String?
    public var cells: [TableViewCell]?
    public var userComments: AttributedString?

    enum ExternalCodingKeys: CodingKey { case attributedString }
    enum AttributedStringCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> TableViewSection {
        assert(xml.elementName == "tableViewSection")
        let container = xml.container(keys: CodingKeys.self)
        let attributedStringContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .attributedString, keys: AttributedStringCodingKeys.self)
        return TableViewSection(
            id:           try container.attribute(of: .id),
            headerTitle:  container.attributeIfPresent(of: .headerTitle),
            footerTitle:  container.attributeIfPresent(of: .footerTitle),
            colorLabel:   container.attributeIfPresent(of: .colorLabel),
            cells:        container.childrenIfPresent(of: .cells),
            userComments: attributedStringContainer?.withAttributeElement(.key, "userComments")
        )
    }
}
// MARK: - TableViewCell

public struct TableViewCell: IBDecodable, ViewProtocol, IBIdentifiable, IBReusable {

    public var id: String
    public var elementClass: String = "UITableViewCell"

    public var key: String?
    public var autoresizingMask: AutoresizingMask?
    public var clipsSubviews: Bool?
    public var constraints: [Constraint]?
    public var contentView: TableViewContentView
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
    private let _subviews: [AnyView]?
    public var subviews: [AnyView]? {
        return (_subviews ?? []) + [AnyView(contentView)]
    }
    public var translatesAutoresizingMaskIntoConstraints: Bool?
    public var userInteractionEnabled: Bool?
    public var userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public var connections: [AnyConnection]?
    public var variations: [Variation]?
    public var reuseIdentifier: String?
    public var backgroundColor: Color?
    public var tintColor: Color?
    public var hidden: Bool?
    public var alpha: Float?

    public var children: [IBElement] {
        // do not let default implementation which lead to duplicate element contentView
        var children: [IBElement] = [contentView] + (rect.map { [$0] } ?? [])
        if let elements = constraints {
            children += elements as [IBElement]
        }
        if let elements = _subviews {
            children += elements as [IBElement]
        }
        if let elements = userDefinedRuntimeAttributes {
            children += elements as [IBElement]
        }
        if let elements = connections {
            children += elements as [IBElement]
        }
        return children
    }

    public struct TableViewContentView: IBDecodable, ViewProtocol, IBIdentifiable {
        public var id: String
        public var elementClass: String = "UITableViewContentView"

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
        public var backgroundColor: Color?
        public var tintColor: Color?
        public var hidden: Bool?
        public var alpha: Float?

        static func decode(_ xml: XMLIndexerType) throws -> TableViewCell.TableViewContentView {
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

            return TableViewContentView(
                id:                                        try container.attribute(of: .id),
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
                backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
                tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
                hidden:                                    container.attributeIfPresent(of: .hidden),
                alpha:                                     container.attributeIfPresent(of: .alpha)
            )
        }
    }

    enum ConstraintsCodingKeys: CodingKey { case constraint }
    enum VariationCodingKey: CodingKey { case variation }
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> TableViewCell {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                case .isAmbiguous: return "ambiguous"
                case ._subviews: return "subview"
                case .contentView: return "tableViewCellContentView"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        let constraintsContainer = container.nestedContainerIfPresent(of: .constraints, keys: ConstraintsCodingKeys.self)
        let variationContainer = xml.container(keys: VariationCodingKey.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return TableViewCell(
            id:                                        try container.attribute(of: .id),
            key:                                       container.attributeIfPresent(of: .key),
            autoresizingMask:                          container.elementIfPresent(of: .autoresizingMask),
            clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
            constraints:                               constraintsContainer?.elementsIfPresent(of: .constraint),
            contentView:                               try container.element(of: .contentView),
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
            _subviews:                                 container.childrenIfPresent(of: ._subviews),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
            userDefinedRuntimeAttributes:              container.childrenIfPresent(of: .userDefinedRuntimeAttributes),
            connections:                               container.childrenIfPresent(of: .connections),
            variations:                                variationContainer.elementsIfPresent(of: .variation),
            reuseIdentifier:                           container.attributeIfPresent(of: .reuseIdentifier),
            backgroundColor:                           colorsContainer?.withAttributeElement(.key, CodingKeys.backgroundColor.stringValue),
            tintColor:                                 colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            hidden:                                    container.attributeIfPresent(of: .hidden),
            alpha:                                     container.attributeIfPresent(of: .alpha)
        )
    }
}
