//
//  EntitiesDataService.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

class EntitiesDataService {

    // MARK: Variables

    private lazy var realmStorage = RealmStorage()

    // MARK: Functions

    func createEntityIfNeeded(withId entityId: Int) {
        guard getEntity(withId: entityId) == nil else { return }
        addRealmHouse(withId: entityId)
    }

    private func getEntity(withId entityId: Int) -> Entity? {
        return realmStorage.fetch(ofType: Entity.self, forPrimaryKey: entityId)
    }

    private func addRealmHouse(withId entityId: Int) {
        let realmHouse = Entity(entityId: entityId)
        try? realmStorage.apply {
            realmStorage.add(object: realmHouse)
        }
    }
}
