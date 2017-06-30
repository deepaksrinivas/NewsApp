//
//  HTTPManager.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 5/19/17.
//
//

import UIKit
//4d7daa0436c9407d8b23fd8335aeff45
public class HTTPManager: NSObject {
    
    static public let shared = HTTPManager()
    
    private override init() {
        super.init()
    }
    
    public func getNewsSources(language: String, apiKey: String, completion: @escaping(_ newsSources: NewsSources?, _ errorData: Error?) -> Void) {
        let httpLayer = HTTPLayer()
        httpLayer.httpGet(urlString: "https://newsapi.org/v1/sources?language=en&apiKey=\(apiKey)", headers: nil) { (data, response, error) in
            if error == nil && data != nil {
                let parseData = self.getJson(data: data!)
                if let errorData = parseData.error {
                    completion(nil, errorData)
                }
                if let dictionary = parseData.dictionary {
                    let newsSources = NewsSources.getModel(dictionary: dictionary)
                    completion(newsSources, nil)
                }
            } else {
                let error = NSError(domain: errorDomain, code: ErrorCodes.UnknownError.rawValue, userInfo: [NSLocalizedDescriptionKey: "Unknown Error to handle"])
                completion(nil, error as Error)
            }
        }
    }
    
    public func getNewsArticles(source: String, apiKey: String, completion: @escaping(_ newsArticles: NewsArticles?, _ errorData: Error?) -> Void) {
        let httpLayer = HTTPLayer()
        httpLayer.httpGet(urlString: "https://newsapi.org/v1/articles?source=\(source)&apiKey=\(apiKey)", headers: nil) { (data, response, error) in
            if error == nil && data != nil {
                let parseData = self.getJson(data: data!)
                if let errorData = parseData.error {
                    completion(nil, errorData)
                }
                if let dictionary = parseData.dictionary {
                    let newsArticles = NewsArticles.getModel(dictionary: dictionary)
                    completion(newsArticles, nil)
                }
            } else {
                let error = NSError(domain: errorDomain, code: ErrorCodes.UnknownError.rawValue, userInfo: [NSLocalizedDescriptionKey: "Unknown Error to handle"])
                completion(nil, error as Error)
            }
        }
    }
    
    func getJson(data: Data) -> (dictionary: NSDictionary?, error: Error?) {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            return (dictionary: jsonDictionary, error: nil)
        } catch let error as NSError {
            debugPrint("\n Json error = \(error.localizedDescription) \n")
            debugPrint("\n Json failure error = \(error.localizedFailureReason ?? "Unable to find reason") \n")
            return (dictionary: nil, error: error as Error)
        }
    }
}
