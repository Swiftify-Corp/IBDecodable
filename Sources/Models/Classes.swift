//
//  Classes.swift
//  IBDecodable
//
//  Created by phimage on 12/05/2018.
//

import SWXMLHash

// MARK: - IBClass

public struct IBClass: IBDecodable {

    public var className: String?
    public var superclassName: String?
    public var source: Source?
    public var relationships: [Relationship]?

    static func decode(_ xml: XMLIndexerType) throws -> IBClass {
        let container = xml.container(keys: CodingKeys.self)
        return IBClass(
            className:      container.attributeIfPresent(of: .className),
            superclassName: container.attributeIfPresent(of: .superclassName),
            source:         container.elementIfPresent(of: .source),
            relationships:  container.childrenIfPresent(of: .relationships)
        )
    }

}

// MARK: - Source

public struct Source: IBDecodable, IBKeyable {

    public var key: String?
    public var type: String?
    public var relativePath: String?

    static func decode(_ xml: XMLIndexerType) throws -> Source {
        let container = xml.container(keys: CodingKeys.self)
        return Source(
            key:          container.attributeIfPresent(of: .key),
            type:         container.attributeIfPresent(of: .type),
            relativePath: container.attributeIfPresent(of: .relativePath)
        )
    }

}

// MARK: - Relationship

public struct Relationship: IBDecodable {

    public var kind: String?
    public var name: String?

    static func decode(_ xml: XMLIndexerType) throws -> Relationship {
        let container = xml.container(keys: CodingKeys.self)
        return Relationship(
            kind: container.attributeIfPresent(of: .kind),
            name: container.attributeIfPresent(of: .name)
        )
    }

}
