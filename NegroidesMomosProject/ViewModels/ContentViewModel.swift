//
//  ContentViewModel.swift
//  NegroidesMomosProject
//
//  Created by Pedro Lopez Zamora on 17/06/25.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published var levels: [LevelModel] = []
    @Published var momos: [MomoModel] = []
    @Published var currentLevelIndex: Int = 0
    @Published var selectedMomo: MomoModel? = nil

    var currentLevel: LevelModel? {
        guard levels.indices.contains(currentLevelIndex) else { return nil }
        return levels[currentLevelIndex]
    }

    func loadData() async {
        async let levelsResult = NetworkService.fetchLevels()
        async let momosResult = NetworkService.fetchMomos()

        do {
            levels = try await levelsResult
            momos = try await momosResult
        } catch {
            print("Error al cargar datos: \(error)")
        }
    }

    func momosForCurrentLevel() -> [MomoModel] {
        guard let level = currentLevel else { return [] }
        return momos.filter { $0.level.id == level.id }
    }

    func goToPreviousLevel() {
        if currentLevelIndex > 0 {
            currentLevelIndex -= 1
        }
    }

    func goToNextLevel() {
        if currentLevelIndex < levels.count - 1 {
            currentLevelIndex += 1
        }
    }
}
