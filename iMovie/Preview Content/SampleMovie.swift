//
//  SampleMovie.swift
//  iMovie
//
//  Created by PC on 2023/02/01.
//

import SwiftUI

struct SampleMovie: View {
    
    @State var movies: [Movie] = []
    
    var body: some View {
        VStack{
            List{
                ForEach(movies, id: \.self) { item in
                    HStack{
                        AsyncImage(url: URL(string: "http://mynf.codershigh.com:8080"+item.image)){ image
                            in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100)
                            
                        } placeholder: {
                            ProgressView()
                        }
                
                        Text(item.title)
                    }
                }
            }
            Button{
                // 서버에다가 요청하는 함수
                fetchMovieList()
            } label: {
                Text("Get Movie")
            }
        }
        .padding()
    }
    
    func fetchMovieList(){
        // MARK: 1.URL
        let urlStr = "http://mynf.codershigh.com:8080/api/movies"
        let url = URL(string: urlStr)!
        
        // MARK: 2. Request
        let request = URLRequest(url: url)
        
        // MARK: 3. Session, DataTask
        URLSession.shared.dataTask(with: request) { data, response, error
            in
            do{
                let ret = try JSONDecoder().decode(MovieResponse.self, from: data!)
    
                for item in ret.data{
                    print(item.title)
                    print(item.image)
                    movies.append(item)
                }
            }
            catch {
                print("Error")
            }
        }.resume()
        
    }
}

struct SampleMovie_Previews: PreviewProvider {
    static var previews: some View {
        SampleMovie()
    }
}
