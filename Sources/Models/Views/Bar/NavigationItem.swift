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
    
    // `titleView` item https://take.ms/vpUDF
    public var button: Button?
    public var pageControl: PageControl?
    public var progressView: ProgressView?
    public var segmentedControl: SegmentedControl?
    public var slider: Slider?
    public var stepper: Stepper?
    public var `switch`: Switch?
    public var textField: TextField?
    public var view: AnyView?
    
    public func getTitleView() -> ViewProtocol? {
        if let button = button {
            return button
        }
        
        if let pageControl = pageControl {
            return pageControl
        }
        
        if let progressView = progressView {
            return progressView
        }
        
        if let segmentedControl = segmentedControl {
            return segmentedControl
        }
        
        if let slider = slider {
            return slider
        }
        
        if let stepper = stepper {
            return stepper
        }
        
        if let `switch` = `switch` {
            return `switch`
        }
        
        if let textField = textField {
            return textField
        }
        
        if let view = view {
            return view.nested
        }
        
        return nil
    }
    
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
            largeTitleDisplayMode:  container.attributeIfPresent(of: .largeTitleDisplayMode),
            button:                 container.elementIfPresent(of: .button),
            pageControl:            container.elementIfPresent(of: .pageControl),
            progressView:           container.elementIfPresent(of: .progressView),
            segmentedControl:       container.elementIfPresent(of: .segmentedControl),
            slider:                 container.elementIfPresent(of: .slider),
            stepper:                container.elementIfPresent(of: .stepper),
            switch:                 container.elementIfPresent(of: .switch),
            textField:              container.elementIfPresent(of: .textField),
            view:                   container.elementIfPresent(of: .view)
        )
    }
}
