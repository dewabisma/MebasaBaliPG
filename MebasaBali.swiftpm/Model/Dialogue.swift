//
//  Dialogue.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 14/04/23.
//

import SwiftUI

struct DialogueSentence: Identifiable, Hashable, Equatable {
    var id: String = UUID().uuidString
    var soundKey: String
    var text: String
    var meaning: String
    var isAnswered = false
    var isBot = true
}

var dialogues_ = [
    DialogueSentence(soundKey: "om swastiastu-bot", text: "Om Swastiastu", meaning: "Hello"),
    DialogueSentence(soundKey: "om swastiastu-user", text: "Om Swastiastu", meaning: "Hello", isBot: false),
    DialogueSentence(soundKey: "sampun-bot", text: "Sampun", meaning: "Already/Have Done"),
    DialogueSentence(soundKey: "sampun-user", text: "Sampun", meaning: "Already/Have Done", isBot: false),
    DialogueSentence(soundKey: "suksma-bot", text: "Suksma", meaning: "Thank you"),
    DialogueSentence(soundKey: "suksma-user", text: "Suksma", meaning: "Thank you", isBot: false),
    DialogueSentence(soundKey: "nggih-bot", text: "Nggih", meaning: "Yes"),
    DialogueSentence(soundKey: "nggih-user", text: "Nggih", meaning: "Yes", isBot: false)
]

var botDialogues_ = [
    DialogueSentence(soundKey: "b-sentences", text: "becik", meaning: "good or well"),
    DialogueSentence(soundKey: "b-sentences", text: "Om Swastiastu", meaning: "Polite Greeting, literally means may you be blessed by the Lord"),
]

var userDialogues_ = [
    DialogueSentence(soundKey: "a-phrases", text: "Punapi gatra?", meaning: "How are you?", isBot: false),
    DialogueSentence(soundKey: "a-sentences", text: "Om Swastiastu", meaning: "Polite Greeting, literally means may you be blessed by the Lord", isBot: false),
    DialogueSentence(soundKey: "a-sentences", text: "Sampun", meaning: "Polite Greeting, literally means may you be blessed by the Lord", isBot: false)
]
