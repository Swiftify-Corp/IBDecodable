//
//  File.swift
//  
//
//  Created by Ibrahim Hassan on 07/12/21.
//

public struct Segment: IBDecodable {
    public var title: String
    public var imageReference: ImageReference?
    public var width: String?
    public var contentOffset: ContentOffset?
    
    static func decode(_ xml: XMLIndexerType) throws -> Segment {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                    case .contentOffset: return "size"
                    default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }
        
        return try Segment(
            title: container.attribute(of: .title),
            imageReference: container.elementIfPresent(of: .imageReference),
            width: container.attributeIfPresent(of: .width),
            contentOffset: container.elementIfPresent(of: .contentOffset)
        )
    }
}
