//
//  MainResponse.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation

struct MainResponse: Codable {

    let totalCount: Int
        let incompleteResults: Bool
        let items: [Items]

        private enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case incompleteResults = "incomplete_results"
            case items = "items"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            totalCount = try values.decode(Int.self, forKey: .totalCount)
            incompleteResults = try values.decode(Bool.self, forKey: .incompleteResults)
            items = try values.decode([Items].self, forKey: .items)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(totalCount, forKey: .totalCount)
            try container.encode(incompleteResults, forKey: .incompleteResults)
            try container.encode(items, forKey: .items)
        }

    }
