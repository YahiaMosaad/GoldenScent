//
//  SliderTableViewCell.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import UIKit
import SDWebImage

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var slider : Slide?
    
    var cellViewModel : CollectionViewCellViewModel? {
        didSet {
            if slider?.type == "text" {
                self.textLabel.text = self.slider?.src
            } else if slider?.type == "image" {
                self.image.sd_setImage(with: URL(string: self.slider?.src ?? ""), completed: nil)
            }
            self.contentView.setNeedsLayout()
        }
    }

}
