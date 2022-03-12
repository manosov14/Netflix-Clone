//
//  Tv.swift
//  Netflix Clone
//
//  Created by Михаил on 08.03.2022.
//

import Foundation

//{
//"backdrop_path" = "/eF3pfdinIPjXz3IXqezlGMFmkPL.jpg";
//"first_air_date" = "2022-03-04";
//"genre_ids" =             (
//80,
//9648,
//18
//);
//id = 99002;
//"media_type" = tv;
//name = "Pieces of Her";
//"origin_country" =             (
//US
//);
//"original_language" = en;
//"original_name" = "Pieces of Her";
//overview = "An act of violence rocks a sleepy Georgia town as well as the bond between a mother and her daughter.";
//popularity = "125.189";
//"poster_path" = "/yPTlbfrDv9asnHlCCd3XzM5noF1.jpg";
//"vote_average" = "7.6";
//"vote_count" = 11;
//}

struct TrendingTvResponse: Codable {
    let results: [Tv]
    
}

struct Tv: Codable {
    
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    
}
