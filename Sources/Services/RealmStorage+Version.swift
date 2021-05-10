//
//  RealmStorage+Version.swift
//  realm-test
//
//  Created by Yevhen Pyvovarov on 10.05.2021.
//

import Foundation

extension RealmStorage {

    /**
     Current Realm version.
     */
    static let currentVersion: Version = .v1

    /**
     All Realm versions with descriptions from the first one.
     */
    enum Version: UInt64 {
        /**
         Standart.
         */
        case v0 = 0
        case v1 = 1

        var numeral: UInt64 {
            return rawValue
        }

        init?(numeral: UInt64) {
            guard let version = Version(rawValue: numeral) else { return nil }
            self = version
        }

        func next() -> Version? {
            Version(numeral: numeral + 1)
        }

        func previous() -> Version? {
            Version(numeral: numeral - 1)
        }

        static func <(lhs: Version, rhs: Version) -> Bool {
            lhs.numeral < rhs.numeral
        }
        static func <=(lhs: Version, rhs: Version) -> Bool {
            lhs.numeral <= rhs.numeral
        }

        static func >(lhs: Version, rhs: Version) -> Bool {
            lhs.numeral > rhs.numeral
        }
        static func >=(lhs: Version, rhs: Version) -> Bool {
            lhs.numeral >= rhs.numeral
        }
    }
}
