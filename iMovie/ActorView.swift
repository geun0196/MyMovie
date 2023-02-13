//
//  ActorView.swift
//  iMovie
//
//  Created by PC on 2023/02/13.
//

import SwiftUI

struct Actor: Codable, Hashable {
    let name: String
    let image: String
}


struct ActorResponse: Codable {
    let data: [Actor]
}

struct ActorView: View {
    @State private var Actors: [Actor] = []
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack{
            NavigationStack{
                ScrollView(.vertical){
                    LazyVGrid(columns: columns) {
                        ForEach(Actors, id: \.self){ item in
                            AsyncImage(url: URL(string: "http://mynf.codershigh.com:8080"+item.image)) { image in
                                image.resizable()
                                    .frame(width:150, height: 200)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                .navigationTitle("배우")
                .onAppear(perform:fetchActorList)
            }
        }
    }
    
    func fetchActorList() {
        print("fetchMovieList")
        // 1. URL
        let urlStr = "http://mynf.codershigh.com:8080/api/actors"
        let url = URL(string: urlStr)!
        
        // 2. Request
        let request = URLRequest(url: url)
        
        // 3. Session, Task
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let ret = try JSONDecoder().decode(ActorResponse.self, from: data!)
                for item in ret.data {
                    Actors.append(item)
                }
            }
            catch {
                print("Error", error)
            }
        }.resume()
    }
}

struct ActorView_Previews: PreviewProvider {
    static var previews: some View {
        ActorView()
    }
}
