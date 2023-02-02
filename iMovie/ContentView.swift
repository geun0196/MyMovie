//
//  ContentView.swift
//  iMovie
//
//  Created by PC on 2023/02/01.
//

import SwiftUI

// HTTP 통신할 때는 Target - 프로젝트 이름 클릭 후
// info 탭에서 App Transport Security Settings 하위의 Allow Arbitrary Loads를 Yes로 바꿔야한다
// 이유 : 애플이 HTTP의 보안이 약해서 막고 있기 떄문에 바꿔줘야 한다

struct ContentView: View {
    var body: some View {
        SampleMovie()
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
