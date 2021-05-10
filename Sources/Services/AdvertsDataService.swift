//
//  AdvertsDataService.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

class AdvertsDataService {
    private lazy var realmStorage = RealmStorage()

    func getRealmAdvert(forAnnId annId: AnnId) -> RealmAdvert? {
        return realmStorage.fetch(ofType: RealmAdvert.self, forPrimaryKey: annId)
    }

    func createRealmAdvertIfNeeded(usingAdvert advert: Advert, realmHouse: RealmHouse) {
        guard getRealmAdvert(forAnnId: advert.annId) == nil else { return }
        addRealmAdvert(usingAdvert: advert, realmHouse: realmHouse)
    }
    private func addRealmAdvert(usingAdvert advert: Advert, realmHouse: RealmHouse) {
        let realmAdvert = RealmAdvert(annId: advert.annId, realmHouse: realmHouse)
        try? realmStorage.apply {
            realmStorage.add(object: realmAdvert)
        }
    }
}
