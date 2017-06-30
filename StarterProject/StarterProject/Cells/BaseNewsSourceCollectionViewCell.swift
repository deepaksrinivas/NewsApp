//
//  BaseCollectionViewCell.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 6/24/17.
//
//

import UIKit
import APIModule

let iconTemplateUrl = "https://icons.better-idea.org/icon?url=%@/news&size=70..120..200"

class BaseNewsSourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var sourceNameLabel: UILabel?
    @IBOutlet weak var sourceDescLabel: UILabel?
    
    var newsSource: Sources? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bgImageView?.image = nil
        imageView?.image = nil
        sourceNameLabel?.text = nil
        sourceDescLabel?.text = nil
    }
    
    func setupView() {
        if let source = newsSource {
            setImage()
            sourceNameLabel?.text = source.name
            sourceDescLabel?.text = source.desc
        }
    }
    
    func setImage() {
        if let image = ImageCacheManager.shared.getImageCache(forUrl: newsSource!.url!) {
            self.imageView?.image = image
            return
        }
        
//        if let image = ImageCacheManager.shared.getImageCache(forUrl: newsSource!.name!) {
//            self.imageView?.image = image
//        } else {
//            let placeholderImage = PlaceholderView.getPlaceholder(forName: self.newsSource!.name!)
//            self.imageView?.image = placeholderImage
//            self.imageView?.layer.masksToBounds = true
//            ImageCacheManager.shared.addCache(image: placeholderImage!, forUrl: self.newsSource!.name!)
//            
//            let iconUrl = String(format: iconTemplateUrl, newsSource!.url!)
//            ImageDowloader().getImage(forUrl: iconUrl, completion: { (image) in
//                if image != nil {
//                    ImageCacheManager.shared.addCache(image: image!, forUrl: self.newsSource!.url!)
//                    self.imageView?.image = image
//                }
//            })
//        }
        
        let placeholderImage = PlaceholderView.getPlaceholder(forName: self.newsSource!.name!)
        self.imageView?.image = placeholderImage
        self.imageView?.layer.masksToBounds = true
        ImageCacheManager.shared.addCache(image: placeholderImage!, forUrl: self.newsSource!.url!)
        
        if let image = ImageCacheManager.shared.getImageCache(forUrl: newsSource!.url!) {
            imageView?.image = image
            self.bgImageView?.image = image
        } else {
            let iconUrl = String(format: iconTemplateUrl, newsSource!.url!)
            ImageDowloader().getImage(forUrl: iconUrl, completion: { (image) in
                if image != nil {
                    ImageCacheManager.shared.addCache(image: image!, forUrl: self.newsSource!.url!)
                    self.imageView?.image = image
                    self.bgImageView?.image = image
                }
            })
        }
    }
}
