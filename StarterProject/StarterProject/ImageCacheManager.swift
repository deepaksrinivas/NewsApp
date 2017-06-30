//
//  ImageCacheManager.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 6/23/17.
//
//

import UIKit

class ImageCacheManager: NSObject {
    
    static let shared = ImageCacheManager()
    
    private override init() {
        super.init()
    }
    
    private var imageCaches = [String: UIImage]()
    
    func getImageCache(forUrl url: String) -> UIImage? {
        guard let image = imageCaches[url] else {
            return nil
        }
        return image
    }
    
    func addCache(image: UIImage, forUrl url: String) {
        imageCaches[url] = image
    }
    
    func clearImageCache() {
        imageCaches.removeAll()
    }
    
    @discardableResult func removeCache(forUrl url: String) -> Bool {
        if let index = imageCaches.index(forKey: url) {
            imageCaches.remove(at: index)
            return true
        }
        return false
    }
}

class ImageDowloader {
    func getImage(forUrl urlString: String, completion: @escaping(_ image: UIImage?) -> Void) {
        let queue = DispatchQueue(label: "com.news.imageCache")
        queue.async {
            if let url = URL(string: urlString) {
                do {
                    let imageData = try Data(contentsOf: url)
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }
}
