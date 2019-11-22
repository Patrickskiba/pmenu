//
//  ContentView.swift
//  pmenu
//
//  Created by Patrick on 11/19/19.
//  Copyright © 2019 Patrick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var stdin: String?
    @State private var query: String = ""
    @State private var isFirstResponder: Bool = false

    
    var body: some View {
        VStack {
            FilteringTextView(placeholderString: "command", changeHandler: { (change) in
                print(change)
            })
            List((stdin ?? "").split { $0.isNewline }, id: \.self) { line in
                    Text(line)
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stdin: "test")
    }
}
