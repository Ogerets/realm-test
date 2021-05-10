//
//  HousesDataService.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

class HousesDataService {

    private lazy var realmStorage = RealmStorage()

    // MARK: Functions

    func getRealmHouse(withId houseId: Int) -> RealmHouse? {
        return realmStorage.fetch(ofType: RealmHouse.self, forPrimaryKey: houseId)
    }

    func createRealmHouseIfNeeded(withId houseId: Int) {
        guard getRealmHouse(withId: houseId) == nil else { return }
        addRealmHouse(withId: houseId)
    }
    private func addRealmHouse(withId houseId: Int) {
        let realmHouse = RealmHouse(houseId: houseId)
        try? realmStorage.apply {
            realmStorage.add(object: realmHouse)
        }
    }
}
