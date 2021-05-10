//
//  RealmHouse.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import RealmSwift

internal final class RealmHouse: Object, HouseProtocol {

    @objc dynamic var houseId: HouseId = 0

    let realmAdverts = List<RealmAdvert>()

    override class func primaryKey() -> String { "houseId" }

    convenience init(houseId: HouseId,
                     realmAdverts: [RealmAdvert] = []) {
        self.init()
        self.houseId = houseId
        self.realmAdverts.append(objectsIn: realmAdverts)
    }
}
