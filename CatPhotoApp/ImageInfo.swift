//
//  ImageInfo.swift
//  CatPhotoApp
//
//  Created by Emily Corso on 6/15/21.
//

import Foundation

struct ImageInfo: Codable {
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    var regularString: URL {
        return URL(string: regular)!
    }
}
