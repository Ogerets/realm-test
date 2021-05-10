//
//  Advert.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

public protocol AdvertProtocol: Hashable {
    var annId: AnnId { get }
}

public extension AdvertProtocol {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.annId == rhs.annId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(annId)
    }
}

public struct Advert: AdvertProtocol {
    public var annId: AnnId
    public var houseId: HouseId?

    public init(annId: AnnId, houseId: HouseId? = nil) {
        self.annId = annId
        self.houseId = houseId
    }
}
