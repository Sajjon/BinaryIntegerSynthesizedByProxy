//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-05.
//

import Foundation

public struct Integer<Magnitude>: BinaryIntegerSynthesizedByProxy where
    Magnitude: BinaryInteger,
    Magnitude.Magnitude == Magnitude {

    public let proxy: Proxy
    public init(proxy: Proxy) {
        self.proxy = proxy
    }

}

public extension Integer {
    typealias IntegerLiteralType = Magnitude.IntegerLiteralType
}
