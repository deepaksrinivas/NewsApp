import UIKit

open class Sources: NSObject { 

	open var id: String? 
	open var name: String? 
	open var desc: String? 
	open var url: String? 
	open var category: String? 
	open var language: String? 
	open var country: String? 
	open var urlsToLogos: UrlsToLogos? 
	open var sortBysAvailable: [String]? 
}
extension Sources { 
	open static func getModel(dictionary: NSDictionary) -> Sources { 
		let modelObject = Sources() 
		modelObject.id = dictionary["id"] as? String 
		modelObject.name = dictionary["name"] as? String 
		modelObject.desc = dictionary["description"] as? String 
		modelObject.url = dictionary["url"] as? String 
		modelObject.category = dictionary["category"] as? String 
		modelObject.language = dictionary["language"] as? String 
		modelObject.country = dictionary["country"] as? String 
		if let dict = dictionary["urlsToLogos"] as? NSDictionary { 
			modelObject.urlsToLogos = UrlsToLogos.getModel(dictionary: dict) 
		} 
		if let objArray = dictionary["sortBysAvailable"] as? NSArray { 
			var dataObjects = [String]() 
			for obj in objArray { 
				 let dataObj = obj as? String ?? "" 
				 dataObjects.append(dataObj)
			} 
			modelObject.sortBysAvailable = dataObjects 
		} 
		return modelObject 
	} 
} 

