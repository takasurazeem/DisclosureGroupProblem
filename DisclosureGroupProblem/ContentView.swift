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
                        Grid {
                            ForEach(c.content) { content in
                                DisclosureGroup {
                                    Text(content.expanded.text)
                                    Color.green
                                        .frame(height: 400)
                                } label: {
                                    
                                    GridRow {
                                        Text(content.collapsed.text)
                                        Text(content.collapsed.prop1)
                                        Text(content.collapsed.prop2)
                                        Text(content.collapsed.prop3)
                                    }
                                }
                                .disclosureGroupStyle(MyDisclosureStyle())
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
        let content: [Content] = (1...3).map { _ in
            Content()
        }
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
        let prop1 = "Prop \((0...100).randomElement()!)"
        let prop2 = "Prop \((0...100).randomElement()!)"
        let prop3 = "Prop \((0...100).randomElement()!)"
        let text = "Coll \((0...100).randomElement()!)"
    }
}


struct MyDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .firstTextBaseline) {
                    configuration.label
                    Spacer()
                    Text(configuration.isExpanded ? "hide" : "show")
                        .foregroundColor(.accentColor)
                        .font(.caption.lowercaseSmallCaps())
                    //                        .animation(nil, value: configuration.isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}
