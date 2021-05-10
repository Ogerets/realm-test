//
//  HousesDataService.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

class HousesDataService {

    private lazy var realmStorage = RealmStorage()
    private lazy var advertsDataService = AdvertsDataService()

    static let processingDispatchQueue = DispatchQueue(label: String(describing: HousesDataService.self),
                                                       qos: .userInitiated)

    // MARK: Functions

    func refresh() {
       realmStorage.refresh()
    }

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

    func createRealmHousesWithAdvertsCreating(housesWithAdverts: [House],
                                              completionQueue: DispatchQueue,
                                              completion: (() -> Void)? = nil) {
        let dispatchGroup = DispatchGroup()

        for houseWithAdverts in housesWithAdverts {
            dispatchGroup.enter()
            createRealmHouseIfNeeded(usingHouse: houseWithAdverts)
            addNewAdvertsCreatingIfNeeded(forHouseWithAdverts: houseWithAdverts,
                                          completionQueue: completionQueue,
                                          completion: { _ in dispatchGroup.leave() })
        }

        dispatchGroup.notify(queue: completionQueue) { [weak self] in
            guard let self = self else { return }
            self.refresh()
            completion?()
        }
    }

    func addNewAdvertsCreatingIfNeeded(forHouseWithAdverts houseWithAdverts: House,
                                       completionQueue: DispatchQueue,
                                       completion: ((Bool) -> Void)? = nil) {
        HousesDataService.processingDispatchQueue.async {
            autoreleasepool { [weak self] in
                guard let self = self else { return }

                guard
                    let realmHouse = self.getRealmHouse(forHouseId: houseWithAdverts.houseId),
                    var updatedAdverts = houseWithAdverts.adverts
                else {
                    completionQueue.async { completion?(false) }
                    return
                }

                if let otherAdverts = houseWithAdverts.otherAdverts {
                    updatedAdverts += otherAdverts
                }

                for advert in updatedAdverts {
                    self.advertsDataService.createRealmAdvertIfNeeded(usingAdvert: advert, realmHouse: realmHouse)
                    self.advertsDataService.applyChangesIfPossible(toRealmAdvertWithAnnId: advert.annId) { (realmAdvert) in
                        if !realmHouse.realmAdverts.contains(realmAdvert) {
                            realmHouse.realmAdverts.append(realmAdvert)
                        }
                        if realmAdvert.realmHouse == nil {
                            realmAdvert.realmHouse = realmHouse
                        }
                    }
                }

                completionQueue.async { completion?(true) }
            }
        }
    }
}
