//
//  DragAndDrop.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 14/04/23.
//

import SwiftUI

struct Character: Identifiable, Hashable, Equatable {
    var id = UUID().uuidString
    var value: String
    var padding: CGFloat = 10
    var textSize: CGFloat = .zero
    var fontSize: CGFloat = 19
    var isShowing: Bool = false
}

var characters_: [Character] = [
    Character(value: "Lorem"),
    Character(value: "Ipsum"),
    Character(value: "is"),
    Character(value: "simply"),
    Character(value: "dummy"),
    Character(value: "text"),
    Character(value: "of"),
    Character(value: "the"),
    Character(value: "design"),
]

struct DragAndDrop: View {
    // Mark: Properties
    @State var progress: CGFloat = 0
    @State var characters: [Character] = characters_
    
    // Mark: Custom Grid Arrays
    // For Drag Part
    @State var shuffledRows: [[Character]] = []
    // For Drop Part
    @State var rows: [[Character]] = []
    
    var body: some View {
        VStack(spacing: 15) {
            NavBar()
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Form this sentences")
                    .font(.title2.bold())
                
                Image(systemName: "globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, 100)
            }
            .padding(.top, 30)
            
            // Mark: Drag Drop Area
            DropArea()
                .padding(.vertical, 30)
            DragArea()
        }
        .padding()
        .onAppear {
            if rows.isEmpty {
                // First creating shuffled one
                // Then normal one
                characters = characters.shuffled()
                shuffledRows = generateGrid()
                characters = characters_
                rows = generateGrid()
            }
        }
    }
    
    // Mark: Drop Area
    @ViewBuilder
    func DropArea() -> some View {
        VStack(spacing: 12) {
            ForEach($rows, id: \.self) { $row in
                HStack(spacing: 10) {
                    ForEach($row) { $item in
                        Text(item.value)
                            .font(.system(size: item.fontSize))
                            .padding(.vertical, 5)
                            .padding(.horizontal, item.padding)
                            .opacity(item.isShowing ? 1 : 0)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous).fill(item.isShowing ? .clear : .gray.opacity(0.25))
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .stroke(.gray)
                                    .opacity(item.isShowing ? 1: 0)
                                
                            }
                        // Mark: Adding Drop Operation
                            .onDrop(of: [.url], isTargeted: .constant(false)) { providers in
                                
                                if let first = providers.first {
                                    let _ = first.loadObject(ofClass: URL.self) {
                                        value, error in
                                        
                                        guard let url = value else {return}
                                        if item.id == "\(url)" {
                                            withAnimation {
                                                item.isShowing = true
                                                updateShuffledArray(character: item)
                                            }
                                        }
                                    }
                                }
                                
                                return false
                            }
                    }
                }
                
                if rows.last != row {
                    Divider()
                }
            }
        }
    }
    
    @ViewBuilder
    func DragArea() -> some View {
        VStack(spacing: 12) {
            ForEach(shuffledRows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row) { item in
                        Text(item.value)
                            .font(.system(size: item.fontSize))
                            .padding(.vertical, 5)
                            .padding(.horizontal, item.padding)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous).stroke(.gray)
                            }
                        // Mark: Adding Drag Operation
                            .onDrag {
                                // Returning ID to find which item is Moving
                                return .init(contentsOf: URL(string: item.id))!
                            }
                            .opacity(item.isShowing ? 0 : 1)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous).fill(item.isShowing ? .gray.opacity(0.25) : .clear)
                            }
                    }
                }
                
                if shuffledRows.last != row {
                    Divider()
                }
            }
        }
    }
    
    // Mark: Custom Nav Bar
    @ViewBuilder
    func NavBar() -> some View {
        HStack(spacing: 18) {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.gray.opacity(0.25))
                    
                    Capsule()
                        .fill(.green)
                        .frame(width: proxy.size.width * progress)
                }
            }
            .frame(height: 20)
            
            Button {
                
            } label: {
                Image(systemName: "suit.heart.fill")
                    .font(.title3)
                    .foregroundColor(.red)
            }
        }
    }
    
    // Mark: Generating Custom Grid Columns
    func generateGrid() -> [[Character]] {
        for item in characters.enumerated() {
            let textSize = textSize(character: item.element)
            
            characters[item.offset].textSize = textSize
        }
        
        var gridArray: [[Character]] = []
        var tempArray: [Character] = []
        
        var currentWidth: CGFloat = 0
        let totalScreenWidth: CGFloat = UIScreen.main.bounds.width - 30
        
        for character in characters {
            currentWidth += character.textSize
            
            if currentWidth < totalScreenWidth {
                tempArray.append(character)
            } else {
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = character.textSize
                tempArray.append(character)
            }
        }
        
        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        
        return gridArray
    }
    
    // Mark: Identifying Text Size
    func textSize(character: Character) -> CGFloat {
        let font = UIFont.systemFont(ofSize: character.fontSize)
        let attributes = [NSAttributedString.Key.font : font]
        let size = (character.value as NSString).size(withAttributes: attributes)
        
        // Horizontal Padding
        return size.width * (character.padding * 2) + 15
    }
    
    // Mark: Updating Shuffled Array
    func updateShuffledArray(character: Character) {
        for index in shuffledRows.indices {
            for subIndex in shuffledRows[index].indices {
                if shuffledRows[index][subIndex].id == character.id {
                    shuffledRows[index][subIndex].isShowing = true
                }
            }
        }
    }
}

struct DragAndDrop_Previews: PreviewProvider {
    static var previews: some View {
        DragAndDrop()
    }
}
