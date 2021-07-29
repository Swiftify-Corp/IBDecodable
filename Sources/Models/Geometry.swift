//
//  Geometry.swift
//  IBDecodable
//
//  Created by phimage on 10/05/2018.
//

import SWXMLHash

// MARK: - Rect

public struct Rect: IBDecodable, IBKeyable {

    public var x: Float
    public var y: Float
    public var width: Float
    public var height: Float
    public var key: String?

    static func decode(_ xml: XMLIndexerType) throws -> Rect {
        let container = xml.container(keys: CodingKeys.self)
        return Rect(
            x:      try container.attribute(of: .x),
            y:      try container.attribute(of: .y),
            width:  try container.attribute(of: .width),
            height: try container.attribute(of: .height),
            key:    container.attributeIfPresent(of: .key)
        )
    }

}

// MARK: - Point

public struct Point: IBDecodable, IBKeyable {

    public var x: Float
    public var y: Float
    public var key: String?

    static func decode(_ xml: XMLIndexerType) throws -> Point {
        let container = xml.container(keys: CodingKeys.self)
        return Point(
            x:      try container.attribute(of: .x),
            y:      try container.attribute(of: .y),
            key:    container.attributeIfPresent(of: .key)
        )
    }

}

// MARK: - Size

public struct Size: IBDecodable, IBKeyable {

    public var width: Float
    public var height: Float
    public var key: String?

    static func decode(_ xml: XMLIndexerType) throws -> Size {
        let container = xml.container(keys: CodingKeys.self)
        return Size(
            width:  try container.attribute(of: .width),
            height: try container.attribute(of: .height),
            key:    container.attributeIfPresent(of: .key)
        )
    }

}

// MARK: - Inset

public struct Inset: IBDecodable, IBKeyable {

    public var key: String?
    public var minX: Float?
    public var minY: Float?
    public var maxX: Float?
    public var maxY: Float?

    static func decode(_ xml: XMLIndexerType) throws -> Inset {
        let container = xml.container(keys: CodingKeys.self)
        return Inset(
            key:  container.attributeIfPresent(of: .key),
            minX: container.attributeIfPresent(of: .minX),
            minY: container.attributeIfPresent(of: .minY),
            maxX: container.attributeIfPresent(of: .maxX),
            maxY: container.attributeIfPresent(of: .maxY)
        )
    }

}

// MARK: - EdgeInset

public struct EdgeInset: IBDecodable, IBKeyable {

    public var key: String?
    public var left: Float?
    public var right: Float?
    public var bottom: Float?
    public var top: Float?

    static func decode(_ xml: XMLIndexerType) throws -> EdgeInset {
        let container = xml.container(keys: CodingKeys.self)
        return EdgeInset(
            key:    container.attributeIfPresent(of: .key),
            left:   container.attributeIfPresent(of: .left),
            right:  container.attributeIfPresent(of: .right),
            bottom: container.attributeIfPresent(of: .bottom),
            top:    container.attributeIfPresent(of: .top)
        )
    }

}

// MARK: - DirectionalEdgeInsets

public struct DirectionalEdgeInsets: IBDecodable, IBKeyable {

    public var key: String?
    public var leading: Float?
    public var bottom: Float?
    public var trailing: Float?
    public var top: Float?

    static func decode(_ xml: XMLIndexerType) throws -> DirectionalEdgeInsets {
        let container = xml.container(keys: CodingKeys.self)
        return DirectionalEdgeInsets(
            key:      container.attributeIfPresent(of: .key),
            leading:  container.attributeIfPresent(of: .leading),
            bottom:   container.attributeIfPresent(of: .bottom),
            trailing: container.attributeIfPresent(of: .trailing),
            top:      container.attributeIfPresent(of: .top)
        )
    }

}

// MARK: - Frame

public struct Frame: IBDecodable, IBKeyable {

    public var width: Float
    public var height: Float
    public var minX: Float
    public var minY: Float
    public var maxX: Float
    public var maxY: Float
    public var key: String?

    static func decode(_ xml: XMLIndexerType) throws -> Frame {
        let container = xml.container(keys: CodingKeys.self)
        return Frame(
            width:  try container.attribute(of: .width),
            height: try container.attribute(of: .height),
            minX:   try container.attribute(of: .minX),
            minY:   try container.attribute(of: .minY),
            maxX:   try container.attribute(of: .maxX),
            maxY:   try container.attribute(of: .maxY),
            key:    container.attributeIfPresent(of: .key)
        )
    }

}
