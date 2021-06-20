//
//  CatAPI.swift
//  CatPhotoApp
//
//  Created by Emily Corso on 6/16/21.
//

import Foundation

class CatAPI {
    func fetchImage(url: URL) {
        let decoder = JSONDecoder()

        if let data = try? Data(contentsOf: url), let imageResult = try? decoder.decode(ImageInfo.self, from: data) {
            //do something with this output
        }
    }
}
