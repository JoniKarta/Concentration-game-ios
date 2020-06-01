//
//  Converter.swift
//  Concentration-Game
//
//  Created by user165579 on 5/31/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import Foundation

class ConverterService {
    
    func playerListToJson(playerList: [Player]) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(playerList)
        let jsonString: String = String(data: data, encoding: .utf8)!
        return jsonString
    }
    
    func jsonToPlayerList(jsonPlayerList: String) -> [Player]? {
        let decoder = JSONDecoder()
        if jsonPlayerList == "" {
            return [Player]()
        }else{
            let data: [Player]
            let convertedData: Data = jsonPlayerList.data(using: .utf8)!
            data = try! decoder.decode([Player].self,from: convertedData)
            return data
        }
    }
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        return formatter.string(from: date)
        
    }
}

