//
//  ColumnCollectionViewCell.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
 
    var cellViewModel : CollectionViewCellViewModel? {
        didSet {
            self.image.sd_setImage(with: URL(string: cellViewModel?.imageURL ?? ""), completed: nil)
        }
    }
}
