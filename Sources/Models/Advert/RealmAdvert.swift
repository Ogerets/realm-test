//
//  RealmAdvert.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import RealmSwift

/**
 Class that describes advert that can be saved to Realm.
 */
internal class RealmAdvert: Object, AdvertProtocol {

    @objc dynamic var annId: AnnId = ""

    @objc dynamic var realmHouse: RealmHouse?

    override class func primaryKey() -> String { "annId" }

    convenience init(annId: AnnId,
                     realmHouse: RealmHouse? = nil) {
        self.init()
        self.annId = annId
        self.realmHouse = realmHouse
    }
}
