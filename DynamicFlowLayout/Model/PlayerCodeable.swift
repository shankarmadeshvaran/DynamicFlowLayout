//
//  PlayerCodeable.swift
//  DynamicFlowLayout
//
//  Created by Shankar on 18/01/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation

struct PlayerCodeable: Codable {
    var name: String?
    var descriptions: String?
    var imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case descriptions = "description"
        case imageUrl = "imageUrl"
    }

    
    func encode(to encoder: Encoder) throws {

    }
}
struct PlayersC: Codable {
    var player: [PlayerCodeable]
    
    enum CodingKeys: String, CodingKey {
        case player = "players"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        player = try values.decode([PlayerCodeable].self, forKey: .player)

    }


}
