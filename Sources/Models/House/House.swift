//
//  House.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

public protocol HouseProtocol: Hashable {
    var houseId: HouseId { get }
}

public extension HouseProtocol {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.houseId == rhs.houseId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(houseId)
    }
}

public struct House: HouseProtocol {
    public var houseId: HouseId
    public var adverts: [Advert]?
    public var otherAdverts: [Advert]?

    public init(houseId: HouseId,
                adverts: [Advert]? = nil,
                otherAdverts: [Advert]? = nil) {
        self.houseId = houseId
        self.adverts = adverts
        self.otherAdverts = otherAdverts
    }
}
