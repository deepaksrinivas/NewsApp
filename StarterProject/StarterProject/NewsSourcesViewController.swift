//
//  ViewController.swift
//  StarterProject
//
//  Created by Administrator on 23/03/17.
//
//

import UIKit
import APIModule

struct AppConfig {
    static let API_KEY = "4d7daa0436c9407d8b23fd8335aeff45"
}

class NewsSourcesViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var allSourcesWithoutSearch: [Sources] = [Sources]()
    fileprivate var allSources: [Sources] = [Sources]()
    
    fileprivate var isScrollingTop: Bool = false
    fileprivate var previousContentOffset: CGFloat = 0
    
//    let listIcon = ListIconView.getView() //ListIconView.icon
//    let gridIcon = GridIconView.getView()//GridIconView.icon
//    let hugeIcon = HugeIconView.getView()//HugeIconView.icon    
    
    let listIcon = ListIconView.icon
    let gridIcon = GridIconView.icon
    let hugeIcon = HugeIconView.icon
    
    var listBarButton: UIBarButtonItem!
    var gridBarButton: UIBarButtonItem!
    var hugeBarButton: UIBarButtonItem!
    
    struct CellIdentifiers {
        static let NewsSourceCellListItem = "NewsSourceCellListItem"
        static let NewsSourceCellGridItem = "NewsSourceCellGridItem"
        static let NewsSourceCellHugeItem = "NewsSourceCellHugeItem"
    }
    
    var cellIdentifier = CellIdentifiers.NewsSourceCellListItem
    
    struct SegueIdentifiers {
        static let ShowArticles = "ShowArticles"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let listCellNib = UINib(nibName: "NewsSourceCellListItem", bundle: nil)
        collection.register(listCellNib, forCellWithReuseIdentifier: "NewsSourceCellListItem")
        
        let gridCellNib = UINib(nibName: "NewsSourceCellGridItem", bundle: nil)
        collection.register(gridCellNib, forCellWithReuseIdentifier: "NewsSourceCellGridItem")
        
        let hugeCellNib = UINib(nibName: "NewsSourceCellHugeItem", bundle: nil)
        collection.register(hugeCellNib, forCellWithReuseIdentifier: "NewsSourceCellHugeItem")
        
        setupNavigationBar()
        decisionTapped(sender: listBarButton)
        loadNewsSources()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
//        listBarButton = UIBarButtonItem(image: listIcon, style: .plain, target: self, action: #selector(decisionTapped(sender:)))
//        gridBarButton = UIBarButtonItem(image: gridIcon, style: .plain, target: self, action: #selector(decisionTapped(sender:)))
//        hugeBarButton = UIBarButtonItem(image: hugeIcon, style: .plain, target: self, action: #selector(decisionTapped(sender:)))
        
        listBarButton = UIBarButtonItem(customView: ListIconView.getView())
        listBarButton.target = self
        listBarButton.action = #selector(decisionTapped(sender:))
        
        gridBarButton = UIBarButtonItem(customView: GridIconView.getView())
        gridBarButton.target = self
        gridBarButton.action = #selector(decisionTapped(sender:))
        
        hugeBarButton = UIBarButtonItem(customView: HugeIconView.getView())
        hugeBarButton.target = self
        hugeBarButton.action = #selector(decisionTapped(sender:))
        
        navigationItem.rightBarButtonItem = gridBarButton
    }
    
    func decisionTapped(sender: UIBarButtonItem) {
        collection.collectionViewLayout.invalidateLayout()
        switch sender {
            case listBarButton:
                cellIdentifier = CellIdentifiers.NewsSourceCellListItem
                collection.collectionViewLayout = CollectionFlowLayout(type: .list)
                navigationItem.rightBarButtonItem = gridBarButton
                break
            case gridBarButton:
                cellIdentifier = CellIdentifiers.NewsSourceCellGridItem
                collection.collectionViewLayout = CollectionFlowLayout(type: .grid)
                navigationItem.rightBarButtonItem = hugeBarButton
                break
            case hugeBarButton:
                cellIdentifier = CellIdentifiers.NewsSourceCellHugeItem
                collection.collectionViewLayout = CollectionFlowLayout(type: .huge)
                navigationItem.rightBarButtonItem = listBarButton
                break
            default: break
        }
        collection.reloadItems(at: collection.indexPathsForVisibleItems)
    }
    
    func loadNewsSources() {
        activityIndicatorView.startAnimating()
        HTTPManager.shared.getNewsSources(language: "en", apiKey: AppConfig.API_KEY) { (newsSources, error) in
            self.activityIndicatorView.stopAnimating()
            if error == nil && newsSources != nil {
                if let sources = newsSources!.sources {
                    self.allSources = sources
                    self.allSourcesWithoutSearch = sources
                    self.collection.reloadData()
                }
            } else {
                self.showAlert(title: "\(error!._code)", message: error!.localizedDescription)
            }
        }
    }
}

extension NewsSourcesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = getCell(forIndexPath: indexPath)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        var cell = collectionView.cellForItem(at: indexPath)
//        cell = nil
//    }
    
    fileprivate func getCell(forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        switch cellIdentifier {
            case CellIdentifiers.NewsSourceCellListItem:
                let listCell = collection.dequeueReusableCell(withReuseIdentifier: "NewsSourceCellListItem", for: indexPath) as! NewsSourceCellListItem
                listCell.newsSource = allSources[indexPath.row]
                cell = listCell
                break
            case CellIdentifiers.NewsSourceCellGridItem:
                let gridCell = collection.dequeueReusableCell(withReuseIdentifier: "NewsSourceCellGridItem", for: indexPath) as! NewsSourceCellGridItem
                gridCell.newsSource = allSources[indexPath.row]
                cell = gridCell
                break
            case CellIdentifiers.NewsSourceCellHugeItem:
                let hugeCell = collection.dequeueReusableCell(withReuseIdentifier: "NewsSourceCellHugeItem", for: indexPath) as! NewsSourceCellHugeItem
                hugeCell.newsSource = allSources[indexPath.row]
                cell = hugeCell
                break
            default:
                cell = UICollectionViewCell()
                break
        }
        return cell
    }
}

extension NewsSourcesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if !isScrollingTop {
//            let originalFrame = cell.frame
//            cell.frame = CGRect.zero
//            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 5, initialSpringVelocity: 8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//                cell.frame = originalFrame
//            }) { (finished) in
//                cell.frame = originalFrame
//            }
//        }
        
//        let originalFrame = cell.frame
//        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
//        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }) { (finished) in
//            cell.frame = originalFrame
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let source = allSources[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let articlesVc = storyboard.instantiateViewController(withIdentifier: "NewsArticlesViewController") as! NewsArticlesViewController
        articlesVc.newsSource = source
        self.navigationController?.pushViewController(articlesVc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        isScrollingTop = (scrollOffset < previousContentOffset) ? true : false
        previousContentOffset = scrollOffset
    }
}

extension NewsSourcesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterResults(searchText: searchText)
    }
    
    func filterResults(searchText: String) {
        if searchText == "" {
            allSources = allSourcesWithoutSearch
        } else {
            allSources = allSourcesWithoutSearch.filter({ (source) -> Bool in
                return source.name!.lowercased().contains(searchText.lowercased())
            })
        }
        collection.reloadData()
    }
}

extension UIViewController {
    func showAlert(title: String?, message: String?, actionTitle: String = "OK") {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertVc.addAction(okAction)
        present(alertVc, animated: true, completion: nil)
    }
}

