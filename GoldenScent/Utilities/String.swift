//
//  String.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 06/03/2021.
//

import Foundation
import UIKit

extension String {
    var numbers: String {
        return filter { "0"..."9" ~= $0 }
    }
    func CGFloatValue() -> CGFloat? {
      guard let doubleValue = Double(self) else {
        return nil
      }

      return CGFloat(doubleValue)
    }
}
