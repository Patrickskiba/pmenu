//
//  ContentView.swift
//  pmenu
//
//  Created by Patrick on 11/19/19.
//  Copyright © 2019 Patrick. All rights reserved.
//

import SwiftUI
import Fuse

struct Result: Identifiable {
    var id = UUID()
    var name: String
}


struct ContentView: View {
    let fuse = Fuse()

    var stdin: [String]
    @State private var results: [Fuse.SearchResult] = []
    @State private var list: [Result] = []
    
    @State private var selected: UUID = UUID()
    @State private var selectedIdx: Int = 0

    var body: some View {
        return VStack(alignment: .leading) {
            FilteringTextView(placeholderString: "command", changeHandler: { (change) in
                self.selectedIdx = 0
                if ( change == "" ) {
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: { () in
                        let arrLength = self.stdin.count > 10 ? 10 : self.stdin.count - 1
                        self.list = Array(0...arrLength).map({ ( line ) in
                            Result(name: self.stdin[line])
                        })
                        self.selected = self.list[self.selectedIdx].id
                    })
                } else {
                    self.results = self.fuse.search(change, in: self.stdin)
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: { () in
                        if (self.results.count == 0) {
                            self.list = [Result(name: "none")]
                           
                        } else {
                            let _list = self.results.map({ ( item ) in
                                Result(name: self.stdin[item.index])
                            })
                            if (_list.count > 10) {
                                self.list = Array(_list.prefix(upTo: 10))
                            }
                            self.list = _list
                        }
                        self.selected = self.list[self.selectedIdx].id
                    })
                }
            }, endedEditing: {() in
                FileHandle.standardOutput.write(self.list[self.selectedIdx].name.data(using: .utf8)!)
                exit(0)
            }, eventTriggered: {(event) in
                if ( event == "next" && self.selectedIdx < self.list.count - 1) {
                    self.selectedIdx += 1
                    self.selected = self.list[self.selectedIdx].id
                }
                
                if ( event == "prev" && self.selectedIdx > 0) {
                    self.selectedIdx -= 1
                    self.selected = self.list[self.selectedIdx].id
                }
            }).onAppear(perform: {() in
                let arrLength = self.stdin.count > 10 ? 10 : self.stdin.count - 1
                self.list = Array(0...arrLength).map({ ( line ) in
                    Result(name: self.stdin[line])
                })
                
                self.selected = self.list[self.selectedIdx].id
            }).frame(height: 20)
            
            List {
                ForEach(list) { (text) in
                    if ( self.selected == text.id ) {
                        VStack() {
                            Text(text.name)
                        }.background(Color.blue)
                    } else {
                        VStack() {
                            Text(text.name)
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stdin: ["test"])
    }
}
