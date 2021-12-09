//
//  Primitive.swift
//  IBDecodable
//
//  Created by phimage on 11/05/2018.
//

import SWXMLHash

// MARK: - Bool

public struct IBBool: IBDecodable, IBKeyable {

    public var key: String?
    public var value: Bool

    static func decode(_ xml: XMLIndexerType) throws -> IBBool {
        let container = xml.container(keys: CodingKeys.self)
        return IBBool(
            key:   container.attributeIfPresent(of: .key),
            value: container.attributeIfPresent(of: .value) ?? false
        )
    }

}

// MARK: - Real

public struct IBReal: IBDecodable, IBKeyable {

    public var key: String?
    public var value: Float?

    static func decode(_ xml: XMLIndexerType) throws -> IBReal {
        let container = xml.container(keys: CodingKeys.self)
        return IBReal(
            key:   container.attributeIfPresent(of: .key),
            value: container.attributeIfPresent(of: .value)
        )
    }

}

// MARK: - Integer

public struct IBInteger: IBDecodable, IBKeyable {

    public var key: String?
    public var value: Int?

    static func decode(_ xml: XMLIndexerType) throws -> IBInteger {
        let container = xml.container(keys: CodingKeys.self)
        return IBInteger(
            key:   container.attributeIfPresent(of: .key),
            value: container.attributeIfPresent(of: .value)
        )
    }

}
// MARK: - Nil

public struct IBNil: IBDecodable, IBKeyable {

    public var key: String?
    public var name: String?

    static func decode(_ xml: XMLIndexerType) throws -> IBNil {
        let container = xml.container(keys: CodingKeys.self)
        return IBNil(
            key:   container.attributeIfPresent(of: .key),
            name:  container.attributeIfPresent(of: .name)
        )
    }

}

// MARK: - URL

public struct IBURL: IBDecodable, IBKeyable {

    public var key: String?
    public var string: String?

    static func decode(_ xml: XMLIndexerType) throws -> IBURL {
        let container = xml.container(keys: CodingKeys.self)
        return IBURL(
            key:    container.attributeIfPresent(of: .key),
            string: container.attributeIfPresent(of: .string)
        )
    }

}

// MARK: - String

public struct IBString: IBDecodable, IBKeyable {

    public var key: String?
    public var base64UTF8: String?

    static func decode(_ xml: XMLIndexerType) throws -> IBString {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .base64UTF8: return "base64-UTF8"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }

        return IBString(
            key:        container.attributeIfPresent(of: .key),
            base64UTF8: container.attributeIfPresent(of: .base64UTF8)
        )
    }

}

// MARK: - Date

public struct IBDate: IBDecodable, IBKeyable {

    public var key: String?
    public var timeIntervalSinceReferenceDate: String

    static func decode(_ xml: XMLIndexerType) throws -> IBDate {
        let container = xml.container(keys: CodingKeys.self)
        return IBDate(
            key:                            container.attributeIfPresent(of: .key),
            timeIntervalSinceReferenceDate: try container.attribute(of: .timeIntervalSinceReferenceDate)
        )
    }

}

// MARK: - Locale

public struct IBLocale: IBDecodable {
    
    public var key: String?
    public var localeIdentifier: String?
    
    static func decode(_ xml: XMLIndexerType) throws -> IBLocale {
        let container = xml.container(keys: CodingKeys.self)
        return IBLocale(
            key:                            container.attributeIfPresent(of: .key),
            localeIdentifier:               container.attributeIfPresent(of: .localeIdentifier)
        )
    }
}

// MARK: - Array

public struct IBArray: IBDecodable, IBKeyable {

    public var key: String?

    static func decode(_ xml: XMLIndexerType) throws -> IBArray {
        let container = xml.container(keys: CodingKeys.self)
        return IBArray(
            key: container.attributeIfPresent(of: .key)
        )
    }

}

// MARK: - Data

public struct IBData: IBDecodable, IBKeyable {

    public var key: String?

    static func decode(_ xml: XMLIndexerType) throws -> IBData {
        let container = xml.container(keys: CodingKeys.self)
        return IBData(
            key: container.attributeIfPresent(of: .key)
        )
    }

}

// MARK: - TimeZone

public struct IBTimeZone: IBDecodable, IBKeyable {

    public var key: String?
    public var name: String?

    static func decode(_ xml: XMLIndexerType) throws -> IBTimeZone {
        let container = xml.container(keys: CodingKeys.self)
        return IBTimeZone(
            key: container.attributeIfPresent(of: .key),
            name: container.attributeIfPresent(of: .name)
        )
    }

}
