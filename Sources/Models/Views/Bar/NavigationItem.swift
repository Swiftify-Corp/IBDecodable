//
//  NavigationItem.swift
//  
//
//  Created by Ibrahim Hassan on 10/08/21.
//

public struct NavigationItem: IBDecodable, IBIdentifiable, IBKeyable, IBCustomClassable, IBUserLabelable {

    public var id: String
    public var key: String?
    public var style: String?
    public var systemItem: String?
    public var title: String?
    public var customClass: String?
    public var customModule: String?
    public var customModuleProvider: String?
    public var userLabel: String?
    public var colorLabel: String?
    public var barButtonItems: [BarButtonItem]?
    public var largeTitleDisplayMode: String?
    
    static func decode(_ xml: XMLIndexerType) throws -> NavigationItem {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .barButtonItems: return "barButtonItem"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        
        return NavigationItem(
            id:                 try container.attribute(of: .id),
            key:                    container.attributeIfPresent(of: .key),
            style:                  container.attributeIfPresent(of: .style),
            systemItem:             container.attributeIfPresent(of: .systemItem),
            title:                  container.attributeIfPresent(of: .title),
            customClass:            container.attributeIfPresent(of: .customClass),
            customModule:           container.attributeIfPresent(of: .customModule),
            customModuleProvider:   container.attributeIfPresent(of: .customModuleProvider),
            userLabel:              container.attributeIfPresent(of: .userLabel),
            colorLabel:             container.attributeIfPresent(of: .colorLabel),
            barButtonItems:         container.elementsIfPresent(of: .barButtonItems),
            largeTitleDisplayMode:  container.attributeIfPresent(of: .largeTitleDisplayMode)
        )
    }
}
