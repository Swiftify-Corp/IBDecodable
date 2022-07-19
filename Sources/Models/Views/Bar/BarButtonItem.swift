//
//  BarButtonItem.swift
//  
//
//  Created by Ibrahim Hassan on 10/08/21.
//

public struct BarButtonItem: IBDecodable {
    public var id: String
    public var key: String?
    public var style: String?
    public var systemItem: String?
    public var title: String?
    public var imageReference: ImageReference?
    public var image: String?
    public var landscapeImage: String?
    public var tintColor: Color?
    
    // `customView` for leftBarButtonItem and rightBarButtonItem https://take.ms/EfeZA
    public var button: Button?
    public var pageControl: PageControl?
    public var progressView: ProgressView?
    public var segmentedControl: SegmentedControl?
    public var slider: Slider?
    public var stepper: Stepper?
    public var `switch`: Switch?
    public var textField: TextField?
    public var view: View?
    
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> BarButtonItem {
        let container = xml.container(keys: CodingKeys.self)

        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)

        return BarButtonItem(
            id:             try container.attribute(of: .id),
            key:                container.attributeIfPresent(of: .key),
            style:              container.attributeIfPresent(of: .style),
            systemItem:         container.attributeIfPresent(of: .systemItem),
            title:              container.attributeIfPresent(of: .title),
            imageReference:     container.elementIfPresent(of: .imageReference),
            image:              container.attributeIfPresent(of: .image),
            landscapeImage:     container.attributeIfPresent(of: .landscapeImage),
            tintColor:          colorsContainer?.withAttributeElement(.key, CodingKeys.tintColor.stringValue),
            button:             container.elementIfPresent(of: .button),
            pageControl:        container.elementIfPresent(of: .pageControl),
            progressView:       container.elementIfPresent(of: .progressView),
            segmentedControl:   container.elementIfPresent(of: .segmentedControl),
            slider:             container.elementIfPresent(of: .slider),
            stepper:            container.elementIfPresent(of: .stepper),
            switch:             container.elementIfPresent(of: .switch),
            textField:          container.elementIfPresent(of: .textField),
            view:               container.elementIfPresent(of: .view)
        )
    }
}
