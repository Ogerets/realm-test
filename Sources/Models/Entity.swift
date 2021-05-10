//
//  Entity.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import RealmSwift

internal final class Entity: Object {

    @objc dynamic var entityId: Int = 0

    override class func primaryKey() -> String { "entityId" }

    convenience init(entityId: Int) {
        self.init()
        self.entityId = entityId
    }
}
