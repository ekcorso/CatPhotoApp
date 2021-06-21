//
//  ImageInfo.swift
//  CatPhotoApp
//
//  Created by Emily Corso on 6/15/21.
//

import Foundation

struct ImageInfo: Codable {
    let results: [Results]
}

struct Results: Codable {
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    var regularUrl: URL {
        return URL(string: regular)!
    }
}
