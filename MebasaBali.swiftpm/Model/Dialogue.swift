//
//  Dialogue.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 14/04/23.
//

import SwiftUI



struct DialogueSentence: Identifiable, Hashable, Equatable, Decodable {
    var id: String = UUID().uuidString
    var soundKey: String
    var text: String
    var meaning: String
    var explanation: String
    var isAnswered = false
    var isBot = true
}

func getDialogue(_ topic:String) -> [DialogueSentence] {
    switch(topic) {
        case "1":
            return loadJson("berhitung")
        case "2":
            return loadJson("berkenalan")
        case "3":
            return loadJson("menunjuk")
        default:
            return loadJson("berhitung")
    }
}
