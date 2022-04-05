//
//  DataDetectorType.swift
//  
//
//  Created by Ibrahim Hassan on 16/06/21.
//

public struct DataDetectorType: IBDecodable, IBKeyable {
    public var key: String?
    public var phoneNumber: Bool?
    public var link: Bool?
    public var address: Bool?
    public var calendarEvent: Bool?
    public var shipmentTrackingNumber: Bool?
    public var flightNumber: Bool?
    public var lookupSuggestion: Bool?
    public var trackingNumber: Bool?

    static func decode(_ xml: XMLIndexerType) throws -> DataDetectorType {
        let container = xml.container(keys: CodingKeys.self)
        return DataDetectorType(
            key: container.attributeIfPresent(of: .key),
            phoneNumber: container.attributeIfPresent(of: .phoneNumber),
            link: container.attributeIfPresent(of: .link),
            address: container.attributeIfPresent(of: .address),
            calendarEvent: container.attributeIfPresent(of: .calendarEvent),
            shipmentTrackingNumber: container.attributeIfPresent(of: .shipmentTrackingNumber),
            flightNumber: container.attributeIfPresent(of: .flightNumber),
            lookupSuggestion: container.attributeIfPresent(of: .lookupSuggestion),
            trackingNumber: container.attributeIfPresent(of: .trackingNumber)
        )
    }
}
