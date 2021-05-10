//
//  HousesDataService.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

class HousesDataService {
    private lazy var realmStorage = RealmStorage()

    func getRealmHouse(forHouseId houseId: HouseId) -> RealmHouse? {
        return realmStorage.fetch(ofType: RealmHouse.self, forPrimaryKey: houseId)
    }

    func createRealmHouseIfNeeded(usingHouse house: House) {
        guard getRealmHouse(forHouseId: house.houseId) == nil else { return }
        addRealmHouse(usingHouse: house)
    }
    private func addRealmHouse(usingHouse house: House) {
        let realmHouse = RealmHouse(houseId: house.houseId)
        try? realmStorage.apply {
            realmStorage.add(object: realmHouse)
        }
    }
}
