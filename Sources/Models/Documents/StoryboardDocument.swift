//
//  StoryboardDocument.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

// MARK: - StoryboardDocument

public struct StoryboardDocument: IBDecodable, InterfaceBuilderDocument {

    public var type: String
    public var version: String
    public var toolsVersion: String
    public var targetRuntime: TargetRuntime
    public var propertyAccessControl: String?
    public var useAutolayout: Bool?
    public var useTraitCollections: Bool?
    public var useSafeAreas: Bool?
    public var colorMatched: Bool?
    public var initialViewController: String?
    public var launchScreen: Bool
    public var device: Device?
    public var scenes: [Scene]?
    public var resources: [AnyResource]?
    public var classes: [IBClass]?
    public var dependencies: [AnyDependency]?
    public var systemVersion: String?
    public var variant: String?

    enum ScenesCodingKeys: CodingKey { case scene }

    static func decode(_ xml: XMLIndexerType) throws -> StoryboardDocument {
        let container = xml.container(keys: CodingKeys.self)
        let scenesContainer = container.nestedContainerIfPresent(of: .scenes, keys: ScenesCodingKeys.self)
        return StoryboardDocument(
            type:                  try container.attribute(of: .type),
            version:               try container.attribute(of: .version),
            toolsVersion:          try container.attribute(of: .toolsVersion),
            targetRuntime:         try container.attribute(of: .targetRuntime),
            propertyAccessControl: container.attributeIfPresent(of: .propertyAccessControl),
            useAutolayout:         container.attributeIfPresent(of: .useAutolayout),
            useTraitCollections:   container.attributeIfPresent(of: .useTraitCollections),
            useSafeAreas:          container.attributeIfPresent(of: .useSafeAreas),
            colorMatched:          container.attributeIfPresent(of: .colorMatched),
            initialViewController: container.attributeIfPresent(of: .initialViewController),
            launchScreen:          container.attributeIfPresent(of: .launchScreen) ?? false,
            device:                container.elementIfPresent(of: .device),
            scenes:                scenesContainer?.elementsIfPresent(of: .scene),
            resources:             container.childrenIfPresent(of: .resources),
            classes:               container.childrenIfPresent(of: .classes),
            dependencies:          container.childrenIfPresent(of: .dependencies),
            systemVersion:         container.attributeIfPresent(of: .systemVersion),
            variant:               container.attributeIfPresent(of: .variant)
        )
    }

    public var ibType: IBType {
        return .storyboard
    }

}
