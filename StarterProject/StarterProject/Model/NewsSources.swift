import UIKit

open class NewsSources: NSObject { 

	open var status: String? 
	open var sources: [Sources]? 
}
extension NewsSources { 
	open static func getModel(dictionary: NSDictionary) -> NewsSources { 
		let modelObject = NewsSources() 
		modelObject.status = dictionary["status"] as? String 
		if let objArray = dictionary["sources"] as? NSArray { 
			var dataObjects = [Sources]() 
			for obj in objArray { 
				 let dataObj = Sources.getModel(dictionary: obj as! NSDictionary)
				 dataObjects.append(dataObj)
			} 
			modelObject.sources = dataObjects 
		} 
		return modelObject 
	} 
} 

