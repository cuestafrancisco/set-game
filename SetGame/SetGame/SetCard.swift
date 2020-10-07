//
//  SetCard.swift
//  SetGame
//
//  Created by Francisco Cuesta on 9/25/20.
//  Copyright © 2020 Francisco Cuesta. All rights reserved.
//

import Foundation
import UIKit  // PROVIDES ATTRIBUTES LIKE NSAttributesString

class SetCard : Equatable
{
    
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
    return lhs.color == rhs.color &&
     lhs.count == rhs.count &&
     lhs.shade == rhs.shade &&
     lhs.shape == rhs.shape}
    //card attributes
    

    var count   :Int
    var shape   :Shapes
    var shade   :Shades
    var color   :Colors
    var isSelected      = false
    var isMatched       = false   //part of a set
    var isMisMatched    = false     //not part of a set
   

    //function contents returns a string
    func contents() -> String{
        
        
        var shape: String
        switch self.shape{
        case .triangle: shape = "▲"
        case .circle:   shape = "●"
        case .square:   shape = "◾️"
        }
        
        var content = ""  //empty string
       for _ in 1...self.count{
        content += shape
        }
        return content
        // returns 1, 2 or 3 shapes (triangle, circle or square)
    }
    //return NSA
    func attributedContents() -> NSAttributedString {
             let strokeColor: UIColor
             switch self.color {
             case .green: strokeColor = UIColor.green
             case .red: strokeColor = UIColor.red
             case .purple: strokeColor = UIColor.purple
             }
             
             var foregroundColor = strokeColor
             switch self.shade{
             case .outlined  : foregroundColor = foregroundColor.withAlphaComponent(0.0)
             case .striped   : foregroundColor = foregroundColor.withAlphaComponent(0.3)
             case .filled    : foregroundColor = foregroundColor.withAlphaComponent(1.0)
             }
             //dictionary of attributes
             let attributes: [ NSAttributedString.Key: Any ] = [
                 .foregroundColor    : foregroundColor,
                 .strokeColor        :  strokeColor,
                 .strokeWidth        : -5.0 ]
        
            return NSAttributedString(string: self.contents(), attributes: attributes)
        
         }

    
    enum Shapes: String    {
        case triangle
        case circle
        case square
        static let all = [Shapes.triangle, .circle, .square]
    }
    enum Shades
    {
        case outlined
        case striped
        case filled
        static var all = [Shades.outlined, .striped, .filled]
    }
    enum Colors
    {
        case green
        case red
        case purple
        static var all = [ Colors.green, .red, .purple]
    }
    
    
    //variables initialization
       init (shape: Shapes, shade:Shades, color:Colors, count: Int){
              self.shade = shade
              self.shape = shape
              self.color = color
              self.count = count
        
    }
    
    
    public static func renderCard( cardToRender card: SetCard, onButton: UIButton, selectButton: Bool, isSet: Bool) {
  
         if selectButton {
             if isSet {
                 onButton.select(borderColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
             } else {
                 onButton.select()
             }
         } else {
             onButton.deselect()
         }
     }
    
}
    
extension UIButton {

    func IsSelected() -> Bool {
        return self.layer.borderWidth == 4.0
    }
    
    func select(borderColor: UIColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)) {
        self.layer.borderWidth = 4.0
        self.layer.borderColor = borderColor.cgColor
        self.layer.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    
    func deselect() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
 
}
