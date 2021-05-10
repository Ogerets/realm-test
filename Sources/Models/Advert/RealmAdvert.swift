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
    @objc dynamic var isAvailable: Bool = true

    @objc dynamic var isViewed: Bool = false
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var isSentToBirdPro: Bool = false
    @objc dynamic var isNotification: Bool = false

    @objc dynamic var realmHouse: RealmHouse?

    override class func primaryKey() -> String { "annId" }

    convenience init(annId: AnnId,
                     isAvailable: Bool = true,
                     isViewed: Bool = false,
                     isFavorite: Bool = false,
                     isNotification: Bool = false,
                     realmHouse: RealmHouse? = nil) {
        self.init()

        self.annId = annId
        self.isAvailable = isAvailable

        self.isViewed = isViewed
        self.isFavorite = isFavorite
        self.isNotification = isNotification

        self.realmHouse = realmHouse
    }
}
