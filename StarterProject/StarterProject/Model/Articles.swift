import UIKit

open class Articles: NSObject { 

	open var author: String? 
	open var title: String? 
	open var desc: String? 
	open var url: String? 
	open var urlToImage: String? 
	open var publishedAt: String? 
}
extension Articles { 
	open static func getModel(dictionary: NSDictionary) -> Articles { 
		let modelObject = Articles() 
		modelObject.author = dictionary["author"] as? String 
		modelObject.title = dictionary["title"] as? String 
		modelObject.desc = dictionary["description"] as? String 
		modelObject.url = dictionary["url"] as? String 
		modelObject.urlToImage = dictionary["urlToImage"] as? String 
		modelObject.publishedAt = dictionary["publishedAt"] as? String 
		return modelObject 
	} 
} 

