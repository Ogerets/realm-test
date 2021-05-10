//
//  AdvertsDataService.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

class AdvertsDataService {
    private lazy var realmStorage = RealmStorage()

    func applyChangesIfPossible(toRealmAdvertWithAnnId annId: AnnId, changes: (RealmAdvert) -> Void) {
        guard let realmAdvert = getRealmAdvert(forAnnId: annId) else { return }
        try? realmStorage.apply { changes(realmAdvert) }
    }

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
