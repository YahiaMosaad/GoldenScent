//
//  TextCollectionViewCell.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 06/03/2021.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    var cellViewModel: CollectionViewCellViewModel? {
        didSet {
            self.textLabel.sizeToFit()
            self.textLabel.text = cellViewModel?.text
            self.textLabel.textAlignment = cellViewModel?.textAlighment ?? .center
            self.textLabel.font = UIFont(name: cellViewModel?.textFontName ?? "",
                                         size: cellViewModel?.textFontSize ?? 20.0)
            self.contentView.backgroundColor = UIColor(hex: cellViewModel?.backGroundColor ?? "")
        }
    }
}
