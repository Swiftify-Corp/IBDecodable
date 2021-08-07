//
//  TextAttributes.swift
//  
//
//  Created by Ibrahim Hassan on 06/08/21.
//

/*
 <textAttributes key="titleTextAttributes">
     <fontDescription key="fontDescription" style="UICTFontTextStyleTitle0"/>
     <color key="textColor" red="0.69570005189999995" green="0.0" blue="0.0" alpha="1" colorSpace="calibratedRGB"/>
     <color key="textShadowColor" red="0.69570005189999995" green="1" blue="0.0" alpha="1" colorSpace="calibratedRGB"/>
     <offsetWrapper key="textShadowOffset" horizontal="40" vertical="0.0"/>
 </textAttributes>
 */

public struct TextAttributes: IBDecodable, IBKeyable {
    public var key: String?
    public var textColor: Color?
    public var textShadowColor: Color?
    public var fontDescription: FontDescription?
    public var offsetWrapper: OffsetWrapper?
    
    enum ExternalCodingKeys: CodingKey { case color }
    enum ColorsCodingKeys: CodingKey { case key }

    static func decode(_ xml: XMLIndexerType) throws -> TextAttributes {
        let container = xml.container(keys: CodingKeys.self)
        let colorsContainer = xml.container(keys: ExternalCodingKeys.self)
            .nestedContainerIfPresent(of: .color, keys: ColorsCodingKeys.self)
        
        return TextAttributes(
            key: container.attributeIfPresent(of: .key),
            textColor: colorsContainer?.withAttributeElement(.key, CodingKeys.textColor.stringValue),
            textShadowColor: colorsContainer?.withAttributeElement(.key, CodingKeys.textShadowColor.stringValue),
            fontDescription: container.elementIfPresent(of: .fontDescription),
            offsetWrapper: container.elementIfPresent(of: .offsetWrapper)
        )
    }
}
