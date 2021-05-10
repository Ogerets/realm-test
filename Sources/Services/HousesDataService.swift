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

    func getRealmHouse(forHouseId houseId: HouseId) -> RealmHouse? {
        return realmStorage.fetch(ofType: RealmHouse.self, forPrimaryKey: houseId)
    }

    func createRealmHouseIfNeeded(withId houseId: HouseId) {
        guard getRealmHouse(forHouseId: houseId) == nil else { return }
        addRealmHouse(withId: houseId)
    }
    private func addRealmHouse(withId houseId: HouseId) {
        let realmHouse = RealmHouse(houseId: houseId)
        try? realmStorage.apply {
            realmStorage.add(object: realmHouse)
        }
    }
}
