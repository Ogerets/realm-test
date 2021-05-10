//
//  RealmStorage.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import RealmSwift

/**
 The class that has different functions to perform operations on realm objects
 */
internal class RealmStorage {

    // MARK: - Variables

    private var realm: Realm {
        var realm: Realm

        do {
            realm = try Realm(configuration: realmConfiguration)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }

        return realm
    }

    private lazy var realmConfiguration: Realm.Configuration = {
        Realm.Configuration(schemaVersion: RealmStorage.currentVersion.numeral)
    }()

    // MARK: - Functions

    func apply(changes: (() -> Void)) throws {
        do {
            try realm.write(changes)
        } catch let error {
            throw error
        }
    }

    func add<Type: Object>(object: Type) {
        realm.add(object, update: .modified)
    }
    func delete<Type: Object>(object: Type) {
        realm.delete(object)
    }

    func refresh() {
        realm.refresh()
    }

    func fetch<Type: Object>(ofType type: Type.Type) -> Results<Type> {
        return realm.objects(type)
    }
    func fetch<Type: Object>(ofType type: Type.Type, forPrimaryKey key: Any) -> Type? {
        return realm.object(ofType: type, forPrimaryKey: key)
    }
}
