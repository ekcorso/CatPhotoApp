//
//  ViewController.swift
//  CatPhotoApp
//
//  Created by Emily Corso on 6/15/21.
//

import UIKit

class ViewController: UIViewController {
    var catPic: ImageInfo?
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.unsplash.com/search/photos/?client_id=i8PFHx5ySE0_QEwoqPtkSu23nvCqlZpRsAvgUhWntrQ&query=kitten&per_page=1"
        fetchImage(with: url)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    func fetchImage(with url: String) {
        let decoder = JSONDecoder()
        
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                if let imageResult = try? decoder.decode(ImageInfo.self, from: data) {
                    catPic = imageResult
                }
            }
        }
    }
}

