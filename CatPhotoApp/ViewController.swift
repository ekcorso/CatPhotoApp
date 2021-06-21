//
//  ViewController.swift
//  CatPhotoApp
//
//  Created by Emily Corso on 6/15/21.
//

import UIKit

class ViewController: UIViewController {
    var catPic: UIImage? = UIImage()
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.unsplash.com/search/photos/?client_id=i8PFHx5ySE0_QEwoqPtkSu23nvCqlZpRsAvgUhWntrQ&query=kitten&per_page=1"
        fetchImage(with: url)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        do {
            let data = try Data(contentsOf: URL(string: url)!)
            let imageURL = try decoder.decode(ImageInfo.self, from: data)
            let result = imageURL.results[0].urls.regularUrl
            let urlRequest = URLRequest(url: result)
            
            URLSession.shared.dataTask(with: urlRequest) { [self] (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    DispatchQueue.main.async {
                        self.catPic = UIImage(data: data)!
                        imageView.image = catPic
                    }
                } else {
                    print("couldn't unwrap data")
                }
            }.resume()
        } catch {
            print("\(error)")
        }
    }
}

