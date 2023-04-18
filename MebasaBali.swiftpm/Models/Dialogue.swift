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
            return loadJson("counting")
        case "2":
            return loadJson("introduction")
        case "3":
            return loadJson("pointing")
        default:
            return loadJson("counting")
    }
}
