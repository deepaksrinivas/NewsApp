import UIKit

open class UrlsToLogos: NSObject { 

	open var small: String? 
	open var medium: String? 
	open var large: String? 
}
extension UrlsToLogos { 
	open static func getModel(dictionary: NSDictionary) -> UrlsToLogos { 
		let modelObject = UrlsToLogos() 
		modelObject.small = dictionary["small"] as? String 
		modelObject.medium = dictionary["medium"] as? String 
		modelObject.large = dictionary["large"] as? String 
		return modelObject 
	} 
} 

