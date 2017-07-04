//
//  PlaceholderView.swift
//  StarterProject
//
//  Created by Srinivas, Deepak - Deepak on 6/23/17.
//
//

import UIKit

enum Colors {
    case newsRed
    case newsGreen
    case newsBlue
    case newsPurple
    case newsBlueViolet
    
    var rawValue: UIColor {
        switch self {
        case .newsRed:
            return UIColor(colorLiteralRed: 178/255, green: 34/255, blue: 34/255, alpha: 1.0)
        case .newsGreen:
            return UIColor(colorLiteralRed: 0, green: 114/255, blue: 0, alpha: 1.0)
        case .newsBlue:
            return UIColor(colorLiteralRed: 0, green: 0, blue: 139/255, alpha: 1.0)
        case .newsPurple:
            return UIColor(colorLiteralRed: 147/255, green: 112/255, blue: 219/255, alpha: 1.0)
        case .newsBlueViolet:
            return UIColor(colorLiteralRed: 138/255, green: 43/255, blue: 226/255, alpha: 1.0)
        }
    }
    
    static let allColors: [Colors] = [.newsRed, .newsGreen, .newsBlue, .newsPurple, .newsBlueViolet]
}

class PlaceholderView: UIView {
    
    @IBOutlet fileprivate weak var iconLabel: UILabel!
    
    static func getPlaceholder(forName name: String) -> UIImage? {
        let nib = UINib(nibName: "PlaceholderView", bundle: nil)
        let placeholderView = nib.instantiate(withOwner: self, options: nil).first as! PlaceholderView
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        placeholderView.frame = rect
        var finalName = ""
        let stringParts = name.trimmingCharacters(in: CharacterSet.whitespaces).components(separatedBy: CharacterSet.whitespaces)
        for str in stringParts {
            let notAllowedCharacters = CharacterSet.alphanumerics.inverted
            let firstCharacter = String(describing: str.characters.first!).uppercased()
            if firstCharacter.rangeOfCharacter(from: notAllowedCharacters) == nil {
                finalName += firstCharacter
            }
        }
        finalName = finalName.trimmingCharacters(in: CharacterSet.whitespaces)
        finalName = finalName.characters.count > 0 ? finalName : "?"
        placeholderView.iconLabel.text = finalName
        let allColorsCount = Colors.allColors.count
//        let randomIndex = Int(arc4random()) % allColorsCount
        let randomIndex = Int(arc4random_uniform(UInt32(allColorsCount)))
        placeholderView.backgroundColor = Colors.allColors[randomIndex].rawValue
        placeholderView.layer.cornerRadius = 50
        placeholderView.clipsToBounds = true
        
        //Generate image
        UIGraphicsBeginImageContextWithOptions(rect.size, !placeholderView.isOpaque, UIScreen.main.scale)
        placeholderView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
