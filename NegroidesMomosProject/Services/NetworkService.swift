//
//  NetworkService.swift
//  NegroidesMomosProject
//
//  Created by Pedro Lopez Zamora on 17/06/25.
//

import Foundation

struct NetworkService {
    static func fetchMomos() async throws -> [MomoModel] {
        let url = URL(string: "https://vapor.negroides.world/momos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([MomoModel].self, from: data)
    }

    static func fetchLevels() async throws -> [LevelModel] {
        let url = URL(string: "https://vapor.negroides.world/levels")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([LevelModel].self, from: data)
    }
}
