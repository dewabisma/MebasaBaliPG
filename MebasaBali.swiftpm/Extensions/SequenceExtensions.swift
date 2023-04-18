//
//  SwiftUIView.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 18/04/23.
//

import SwiftUI

extension Sequence where Element == DialogueSentence {
    func uniqueDialogues() -> [DialogueSentence] {
        var buffer: [DialogueSentence] = []
        
        for elem in self {
            let isExist = buffer.first { dialogue in
                dialogue.text == elem.text
            }
            
            if isExist != nil {
                continue
            }
            
            buffer.append(elem)
        }
        return buffer
    }
}
