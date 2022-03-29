//
//  YouTubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Михаил on 29.03.2022.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
