//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public typealias AnyInteger<Value: BinaryInteger> = BoundInteger<NoBound<Value>> where Value.Magnitude == Value
