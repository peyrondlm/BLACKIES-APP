//
//  MomoModel.swift
//  NegroidesMomosProject
//
//  Created by Pedro Lopez Zamora on 13/06/25.
//

import Foundation

struct MomoModel: Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var image: String
    var level: LevelModel
    var autor: AuthorModel
}
