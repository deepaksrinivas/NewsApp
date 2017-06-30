import UIKit

open class NewsArticles: NSObject { 

	open var status: String? 
	open var source: String? 
	open var sortBy: String? 
	open var articles: [Articles]? 
}
extension NewsArticles { 
	open static func getModel(dictionary: NSDictionary) -> NewsArticles { 
		let modelObject = NewsArticles() 
		modelObject.status = dictionary["status"] as? String 
		modelObject.source = dictionary["source"] as? String 
		modelObject.sortBy = dictionary["sortBy"] as? String 
		if let objArray = dictionary["articles"] as? NSArray { 
			var dataObjects = [Articles]() 
			for obj in objArray { 
				 let dataObj = Articles.getModel(dictionary: obj as! NSDictionary)
				 dataObjects.append(dataObj)
			} 
			modelObject.articles = dataObjects 
		} 
		return modelObject 
	} 
} 

