//
//  File.swift
//  
//
//  Created by Ibrahim Hassan on 03/05/22.
//

public protocol IBTextElement {
    var text: String? { get }
    var string: StringContainer? { get }
    var mutableString: StringContainer? { get }
}

// Adding this since TextField does not have a mutableString element
public extension IBTextElement {
    var mutableString: StringContainer? {
        return nil
    }
}
