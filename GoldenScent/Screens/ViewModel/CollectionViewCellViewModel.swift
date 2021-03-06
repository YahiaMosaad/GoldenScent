//
//  CollectionViewCellViewModel.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import Foundation
import UIKit

class CollectionViewCellViewModel {

   var column: Column!

   init(column: Column) {
     self.column = column
   }

   var text: String? {
      return self.column.content
   }
    var backGroundColor: String? {
        return self.column.background?.color
    }
    var textFontName : String? {
        return self.column.font
    }
    var textAlighment : NSTextAlignment? {
        if self.column.textAlign == "left" {
            return .left
        } else if self.column.textAlign == "right" {
            return .right
        } else if self.column.textAlign == "center" {
            return .center
        } else {
            return .center
        }
    }
    var textFontColor: String? {
        return self.column.fontColor
    }
    var textFontSize: CGFloat? {
        return self.column.fontSize?.CGFloatValue()
    }
    var imageURL: String? {
       return self.column.src
    }
    var slider: [Slide]? {
        return self.column.slides
     }
    
    var cellType: collectionCellType {
        if self.column.type == "text" {
            return .text
        }
        else if column.type == "image" {
            return .image
        }
        else if column.type == "custom-slider" {
            return .slider
        }
        else {
            return .text
        }
    }
}
