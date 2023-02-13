//
//  MovieView.swift
//  iMovie
//
//  Created by PC on 2023/02/13.
//

import SwiftUI

// HTTP 통신할 때는 Target - 프로젝트 이름 클릭 후
// info 탭에서 App Transport Security Settings 하위의 Allow Arbitrary Loads를 Yes로 바꿔야한다
// 이유 : 애플이 HTTP의 보안이 약해서 막고 있기 떄문에 바꿔줘야 한다

// Codable : Encodable & Decodable 나눠진다
// Encodable : 구조체를 문자열로 만들어주는 역할
// Decodable : 문자열을 구조체로 만들어주는 역할
// Json파일도 보기편하게 되어 있지만 사실은 문자열로 받아온다
// 받아온 문자열을 보기 편하게 파싱 "" { 만나면 "키" : value로 보기 쉽게 변환 함"" 역할을 해주는게 Encodable이다

struct Movie: Codable, Hashable {
    let title: String
    let image: String
}


struct MovieResponse: Codable {
    let data: [Movie]
}


struct MovieView: View {
    @State var Movies: [Movie] = []
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack(alignment: .center){
            NavigationStack{
                ScrollView(.vertical){
                    LazyVGrid(columns: columns) {
                        ForEach(Movies, id: \.self){ item in
                            AsyncImage(url: URL(string: "http://mynf.codershigh.com:8080"+item.image)) { image in
                                image.resizable()
                                    .frame(width:150, height: 200)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                .navigationTitle("영화")
                .onAppear(perform:fetchMovieList)
            }
        }
    }
    
    func fetchMovieList() {
        print("fetchMovieList")
        // 1. URL
        let urlStr = "http://mynf.codershigh.com:8080/api/movies"
        let url = URL(string: urlStr)!
        
        // 2. Request
        let request = URLRequest(url: url)
        
        // 3. Session, Task
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let ret = try JSONDecoder().decode(MovieResponse.self, from: data!)
                for item in ret.data {
                    Movies.append(item)
                }
            }
            catch {
                print("Error", error)
            }
        }.resume()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
