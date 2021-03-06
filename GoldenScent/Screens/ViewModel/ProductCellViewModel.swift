//
//  ProductCellViewModel.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import Foundation
import UIKit

class ProductCellViewModel {
    var rowVMs: [CollectionViewCellViewModel] = []
    var row: Row!
    var slidersArray = [Slide]()
    init(row: Row) {
        self.row = row
        // Initialize rowsVMs
        row.columns.forEach({
            rowVMs.append(CollectionViewCellViewModel.init(column: $0))
        })
    }
    var numberOfRows: Int {
        self.rowVMs.count
    }
    var leftMargine: CGFloat {
        self.row.rowMarginLeft?.numbers.CGFloatValue() ?? 0.0
    }
    var rightMargine: CGFloat {
        self.row.rowMarginRight?.numbers.CGFloatValue() ?? 0.0
    }
    var bottomMargine: CGFloat {
        self.row.rowMarginBottom?.numbers.CGFloatValue() ?? 0.0
    }
    func columnViewModel(at indexPath: IndexPath) -> CollectionViewCellViewModel {
        slidersArray = self.rowVMs[indexPath.row].slider ?? []
        return self.rowVMs[indexPath.row]
    }
}
