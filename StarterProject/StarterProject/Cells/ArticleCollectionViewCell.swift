//
//  ArticleCollectionViewCell.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 6/25/17.
//
//

import UIKit
import APIModule

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescLabel: UILabel!
    @IBOutlet weak var articleholderView: UIView!
    
    var newsArticle: Articles? {
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
        imageView.image = nil
        articleDateLabel.text = nil
        articleTitleLabel.text = nil
        articleDescLabel.text = nil
    }
    
    fileprivate func setupView() {
        if let article = newsArticle {
            if let _ = article.urlToImage {
                setImage()
            }
            articleDateLabel.text = article.publishedAt
            articleTitleLabel.text = article.title
            articleDescLabel.text = article.desc
        }
        
        articleholderView.layer.shadowRadius = 5.0
        articleholderView.layer.shadowOpacity = 5.0
    }
    
    func setImage() {
        if let image = ImageCacheManager.shared.getImageCache(forUrl: newsArticle!.urlToImage!) {
            imageView?.image = image
            return
        } else {
            let iconUrl = newsArticle!.urlToImage!
            ImageDowloader().getImage(forUrl: iconUrl, completion: { (image) in
                if image != nil {
                    ImageCacheManager.shared.addCache(image: image!, forUrl: self.newsArticle!.urlToImage!)
                    self.imageView?.image = image
                }
            })
        }
    }
    
    func performSelectionAnimations() {
        UIView.animate(withDuration: 0.25) { 
            self.articleholderView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    func performDeSelectionAnimations() {
        UIView.animate(withDuration: 0.25) {
            self.articleholderView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
