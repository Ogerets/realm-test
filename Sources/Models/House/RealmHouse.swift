//
//  RealmHouse.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import RealmSwift

internal final class RealmHouse: Object, HouseProtocol {

    @objc dynamic var houseId: HouseId = 0

    @objc dynamic var viewsCount: Int = 0

    @objc dynamic var isSubscriptionEnabled: Bool = false

    let realmAdverts = List<RealmAdvert>()

    override class func primaryKey() -> String { "houseId" }

    convenience init(houseId: HouseId,
                     viewsCount: Int = 0,
                     isSubscriptionEnabled: Bool = false,
                     realmAdverts: [RealmAdvert] = []) {
        self.init()
        self.houseId = houseId
        self.viewsCount = viewsCount
        self.isSubscriptionEnabled = isSubscriptionEnabled
        self.realmAdverts.append(objectsIn: realmAdverts)
    }
}
