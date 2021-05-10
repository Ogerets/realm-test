//
//  AppDelegate.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let advertsDataService = AdvertsDataService()
    private let housesDataService = HousesDataService()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Launched")

        createHouseWithAdverts()

        return true
    }

    private func createHouseWithAdverts() {
        let houseId = 1
        let annId1 = "test1"
        let annId2 = "test2"
        let advert1 = Advert(annId: annId1, houseId: houseId)
        let advert2 = Advert(annId: annId2, houseId: houseId)

        let house = House(houseId: houseId, adverts: [advert1, advert2])

        housesDataService.createRealmHousesWithAdvertsCreating(housesWithAdverts: [house], completionQueue: .main) {
            print("Houses with Adverts created")
        }
    }

    private func createNewHouse() {
        let house = House(houseId: 2)
        housesDataService.createRealmHouseIfNeeded(usingHouse: house)
        print("New House created")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

