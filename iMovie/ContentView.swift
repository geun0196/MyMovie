//
//  ContentView.swift
//  iMovie
//
//  Created by PC on 2023/02/01.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = "영화 목록 보기"
    var body: some View{
        TabView(selection: $selection){
            MovieView()
                .tag("영화 목록 보기")
                .tabItem {
                    Text("영화")
                    Image(systemName: "display")
                }
            ActorView()
                .tag("배우 목록 보기")
                .tabItem {
                    Text("배우")
                    Image(systemName: "person.2")
                }
        }.font(.headline)
    }
}

/**
 {
 "message": "success","paging": {"total": 28,"skip": 0,"limit": 10
 },"data": [{"genre": ["드라마","로맨스","스릴러","액션"],"_id": "631f93832d06ff4e337e64b9","title": "오징어 게임","image": "/poster/1663013763153.jpeg"}]}
 */


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
