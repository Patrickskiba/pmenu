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

    var body: some View {
        return VStack(alignment: .leading) {
            FilteringTextView(placeholderString: "command", changeHandler: { (change) in
                if ( change == "" ) {
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: { () in
                        self.list = Array(0...self.stdin.count - 1).map({ ( line ) in
                            Result(name: self.stdin[line])
                        })
                    })
                } else {
                    self.results = self.fuse.search(change, in: self.stdin)
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: { () in
                        self.list = self.results.map({ item in
                            return item.index
                        }).map({ ( line ) in
                            Result(name: self.stdin[line])
                        })
                    })
                }
            }, endedEditing: {() in
                FileHandle.standardOutput.write(self.list[0].name.data(using: .utf8)!)
            }).onAppear(perform: {() in
                self.list = Array(0...self.stdin.count - 1).map({ ( line ) in
                    Result(name: self.stdin[line])
                })
            })
                .frame(height: 20)
            
            List {
                ForEach(list) { text in
                    Text(text.name)
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
