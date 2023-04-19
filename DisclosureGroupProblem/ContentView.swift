//
//  ContentView.swift
//  DisclosureGroupProblem
//
//  Created by Takasur Azeem on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    let data: ProblemSet = .example
    var body: some View {
        VStack {
            List {
                ForEach(data.content) { c in
                    Section {
                        ForEach(c.content) { content in
                            DisclosureGroup {
                                Text(content.expanded.text)
                            } label: {
                                Text(content.collapsed.text)
                            }
                        }
                    } header: {
                        Text(c.headerTitle)
                    }

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ProblemSet {
    let content: [ListData]
    
    static var example: ProblemSet {
        var list = [ListData]()
        for i in 1...10 {
            list.append(
                ListData(headerTitle: "Section \(i)")
            )
        }
        return .init(content: list)
    }
    
    struct ListData: Identifiable {
        var id = UUID()
        let headerTitle: String
        let content: [Content] = Array(repeating: Content(), count: 3)
    }
    
    struct Content: Identifiable {
        var id = UUID()
        let collapsed = Collapsed()
        let expanded = Expanded()
    }
    
    struct Expanded: Identifiable {
        var id = UUID()
        let text = "Expanded"
    }
    
    struct Collapsed: Identifiable {
        var id = UUID()
        let text = "Collapsed"
    }
}
