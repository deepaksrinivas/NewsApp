//
//  HTTPLayer.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 5/19/17.
//
//

import UIKit

let errorDomain = "com.tlnetworking.error"

enum ErrorCodes: Int {
    case InvalidUrl = 1000
    case InvalidRequestBody = 1001
    case UnknownError = 1002
}

class HTTPLayer: NSObject {
    
    typealias ResponseHandler = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    
    
    func httpGet(urlString: String, headers: [String: String]?, handler: @escaping ResponseHandler) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: errorDomain, code: ErrorCodes.InvalidUrl.rawValue, userInfo: [NSLocalizedDescriptionKey : "Invalid url: \(urlString)"]) as Error
            handler(nil, nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET";
        if let requestHeaders = headers {
            for eachHeader in requestHeaders {
                request.setValue(eachHeader.value, forHTTPHeaderField: eachHeader.key)
            }
        }
        dispatchHTTP(request: request, handler: handler)
    }
    
    func httpPost(urlString: String, headers: [String: String]?, bodyParams: [String: AnyObject]?, handler: @escaping ResponseHandler) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: errorDomain, code: ErrorCodes.InvalidUrl.rawValue, userInfo: [NSLocalizedDescriptionKey : "Invalid url: \(urlString)"]) as Error
            handler(nil, nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let requestHeaders = headers {
            for eachHeader in requestHeaders {
                request.setValue(eachHeader.value, forHTTPHeaderField: eachHeader.key)
            }
        }
        
        if let requestBodyParams = bodyParams {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: requestBodyParams, options: [])
                request.httpBody = bodyData
            } catch {
                let error = NSError(domain: errorDomain, code: ErrorCodes.InvalidRequestBody.rawValue, userInfo: [NSLocalizedDescriptionKey : "Invalid request body: \(requestBodyParams)"]) as Error
                handler(nil, nil, error)
                return
            }
        }
        
        dispatchHTTP(request: request, handler: handler)
    }
    
    func httpPut(urlString: String, headers: [String: String]?, bodyParams: [String: AnyObject]?, handler: @escaping ResponseHandler) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: errorDomain, code: ErrorCodes.InvalidUrl.rawValue, userInfo: [NSLocalizedDescriptionKey : "Invalid url: \(urlString)"]) as Error
            handler(nil, nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let requestHeaders = headers {
            for eachHeader in requestHeaders {
                request.setValue(eachHeader.value, forHTTPHeaderField: eachHeader.key)
            }
        }
        
        if let requestBodyParams = bodyParams {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: requestBodyParams, options: [])
                request.httpBody = bodyData
            } catch {
                let error = NSError(domain: errorDomain, code: ErrorCodes.InvalidRequestBody.rawValue, userInfo: [NSLocalizedDescriptionKey : "Invalid request body: \(requestBodyParams)"]) as Error
                handler(nil, nil, error)
                return
            }
        }
        
        dispatchHTTP(request: request, handler: handler)
    }
    
    func httpDelete(urlString: String, headers: [String: String]?, bodyParams: [String: AnyObject]?, handler: @escaping ResponseHandler) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: errorDomain, code: ErrorCodes.InvalidUrl.rawValue, userInfo: [NSLocalizedDescriptionKey : "Invalid url: \(urlString)"]) as Error
            handler(nil, nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let requestHeaders = headers {
            for eachHeader in requestHeaders {
                request.setValue(eachHeader.value, forHTTPHeaderField: eachHeader.key)
            }
        }
        
        if let requestBodyParams = bodyParams {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: requestBodyParams, options: [])
                request.httpBody = bodyData
            } catch {
                let error = NSError(domain: errorDomain, code: ErrorCodes.InvalidRequestBody.rawValue, userInfo: [NSLocalizedDescriptionKey : "Invalid request body: \(requestBodyParams)"]) as Error
                handler(nil, nil, error)
                return
            }
        }
        
        dispatchHTTP(request: request, handler: handler)
    }
    
    fileprivate func dispatchHTTP(request: URLRequest, handler: @escaping ResponseHandler) {
//        let session = URLSession(configuration: .default)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, urlResponse, error) in
            session.finishTasksAndInvalidate()
            DispatchQueue.main.async {
                if responseData != nil {
                    let responseStr = NSString(data: responseData!, encoding: String.Encoding.utf8.rawValue)
                    print("\n \(responseStr) \n")
                }
                handler(responseData, urlResponse, error)
            }
        }
        task.resume()
    }
}
