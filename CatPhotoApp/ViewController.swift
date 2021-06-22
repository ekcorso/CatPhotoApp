//
//  ViewController.swift
//  CatPhotoApp
//
//  Created by Emily Corso on 6/15/21.
//

import UIKit

class ViewController: UIViewController {
    var catPics: [UIImage] = [UIImage]()
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=i8PFHx5ySE0_QEwoqPtkSu23nvCqlZpRsAvgUhWntrQ&query=kitten&per_page=30")!
        fetchImages(with: url)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(getNewPic))
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    func fetchImages(with url: URL) {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let imageURL = try decoder.decode(ImageInfo.self, from: data)
            let resultsArray = imageURL.results
            
            for result in resultsArray {
                let url = result.urls.regularUrl
                let urlRequest = URLRequest(url: url)
                
                URLSession.shared.dataTask(with: urlRequest) { [self] (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        DispatchQueue.main.async {
                            let catPic = UIImage(data: data)!
                            catPics.append(catPic)
                            imageView.image = catPics[0]
                        }
                    } else {
                        print("couldn't unwrap data")
                    }
                }.resume()
            }
        } catch {
            print("\(error)")
        }
    }
    
    @objc func getNewPic() {
        var catPicsIterator = catPics.makeIterator()
        let nextCat = catPicsIterator.next()
        DispatchQueue.main.async { [self]
            self.imageView.image = nextCat!
            print("async")
        }
        print("tried to refresh")
    }
}
