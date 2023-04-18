//
//  Topic.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 16/04/23.
//

import SwiftUI

struct Topic: Identifiable, Hashable, Decodable  {
    var id: String = UUID().uuidString
    var title:String
    var description:String
    var explanation:String
    var image:String
}
