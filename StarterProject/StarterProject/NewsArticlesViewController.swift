//
//  NewsArticlesViewController.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 6/16/17.
//
//

import UIKit
import APIModule
import SafariServices

class NewsArticlesViewController: UIViewController {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collection: UICollectionView!
    
    fileprivate var allArticles: [Articles] = [Articles]()
    
    var newsSource: Sources?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cellNib = UINib(nibName: "ArticleCollectionViewCell", bundle: nil)
        collection.register(cellNib, forCellWithReuseIdentifier: "ArticleCollectionViewCell")
        collection.collectionViewLayout = ArticleCollectionFlowLayout()
        
        if newsSource != nil {
            self.title = newsSource!.name
            loadNewsArticles(newsSource: newsSource!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNewsArticles(newsSource: Sources) {
        activityIndicatorView.startAnimating()
        HTTPManager.shared.getNewsArticles(source: newsSource.id!, apiKey: AppConfig.API_KEY) { (newsArticles, error) in
            self.activityIndicatorView.stopAnimating()
            if error == nil && newsArticles != nil {
                if let articles = newsArticles!.articles {
                    self.allArticles = articles
                    self.collection.reloadData()
                }
            } else {
                self.showAlert(title: "\(error!._code)", message: error!.localizedDescription)
            }
        }
    }
}

extension NewsArticlesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as! ArticleCollectionViewCell
        cell.newsArticle = allArticles[indexPath.row]
        return cell
    }
}

extension NewsArticlesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = allArticles[indexPath.row]
        let safariServiceVc = SFSafariViewController(url: URL(string: article.url!)!, entersReaderIfAvailable: true)
        present(safariServiceVc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ArticleCollectionViewCell
        cell?.performSelectionAnimations()
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ArticleCollectionViewCell
        cell?.performDeSelectionAnimations()
    }
}
