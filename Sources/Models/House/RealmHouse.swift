//
//  RealmHouse.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import RealmSwift

internal final class RealmHouse: Object {

    @objc dynamic var houseId: HouseId = 0

    override class func primaryKey() -> String { "houseId" }

    convenience init(houseId: HouseId) {
        self.init()
        self.houseId = houseId
    }
}
