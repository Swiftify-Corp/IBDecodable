//
//  DataDetectorType.swift
//  
//
//  Created by Ibrahim Hassan on 16/06/21.
//

public struct DataDetectorType: IBDecodable, IBKeyable {
    public let key: String?
    public let phoneNumber: Bool?
    public let link: Bool?
    public let address: Bool?
    public let calendarEvent: Bool?
    public let shipmentTrackingNumber: Bool?
    public let flightNumber: Bool?

    static func decode(_ xml: XMLIndexerType) throws -> DataDetectorType {
        let container = xml.container(keys: CodingKeys.self)
        return DataDetectorType(
            key: container.attributeIfPresent(of: .key),
            phoneNumber: container.attributeIfPresent(of: .phoneNumber),
            link: container.attributeIfPresent(of: .link),
            address: container.attributeIfPresent(of: .address),
            calendarEvent: container.attributeIfPresent(of: .calendarEvent),
            shipmentTrackingNumber: container.attributeIfPresent(of: .shipmentTrackingNumber),
            flightNumber: container.attributeIfPresent(of: .flightNumber)
        )
    }
}
