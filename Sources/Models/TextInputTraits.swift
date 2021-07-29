//
//  File.swift
//  
//
//  Created by Ibrahim Hassan on 31/01/21.
//

public struct TextInputTraits: IBDecodable, IBKeyable {
    public var key: String?
    public var autocorrectionType: Bool?
    public var spellCheckingType: Bool?
    public var keyboardType: String?
    public var keyboardAppearance: String?
    public var returnKeyType: String?
    public var enablesReturnKeyAutomatically: Bool?
    public var smartDashesType: Bool?
    public var smartInsertDeleteType: Bool?
    public var smartQuotesType: Bool?
    public var textContentType: String?
    public var autocapitalizationType: String?
    public var secureTextEntry: Bool?

    static func decode(_ xml: XMLIndexerType) throws -> TextInputTraits {
        let container = xml.container(keys: CodingKeys.self)
        return TextInputTraits(
            key: container.attributeIfPresent(of: .key),
            autocorrectionType: container.attributeIfPresent(of: .autocorrectionType),
            spellCheckingType: container.attributeIfPresent(of: .spellCheckingType),
            keyboardType: container.attributeIfPresent(of: .keyboardType),
            keyboardAppearance: container.attributeIfPresent(of: .keyboardAppearance),
            returnKeyType: container.attributeIfPresent(of: .returnKeyType),
            enablesReturnKeyAutomatically: container.attributeIfPresent(of: .enablesReturnKeyAutomatically),
            smartDashesType: container.attributeIfPresent(of: .smartDashesType),
            smartInsertDeleteType: container.attributeIfPresent(of: .smartInsertDeleteType),
            smartQuotesType: container.attributeIfPresent(of: .smartDashesType),
            textContentType: container.attributeIfPresent(of: .textContentType),
            autocapitalizationType: container.attributeIfPresent(of: .autocapitalizationType),
            secureTextEntry: container.attributeIfPresent(of: .secureTextEntry)
        )
    }
}
