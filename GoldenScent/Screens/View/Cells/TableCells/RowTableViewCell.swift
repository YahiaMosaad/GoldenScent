//
//  TextTableViewCell.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import UIKit

enum collectionCellType {
    case text
    case image
    case slider
}
class RowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectioViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rowMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var rowMarginRight: NSLayoutConstraint!
    @IBOutlet weak var rowMarginBottom: NSLayoutConstraint!

    // MARK:- Variables
    var collectionItems: [CollectionViewCellViewModel]?
    var collectionViewCellsCount: Int = 0
    var isSlider: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    var rowCellViewModel : ProductCellViewModel? {
        didSet {
            collectionItems = rowCellViewModel?.rowVMs

            self.rowMarginLeft.constant = rowCellViewModel?.leftMargine ?? 0.0
            self.rowMarginRight.constant = rowCellViewModel?.rightMargine ?? 0.0
            self.rowMarginBottom.constant =  rowCellViewModel?.bottomMargine ?? 0.0
            let columnType = rowCellViewModel?.rowVMs.first?.cellType
            switch columnType {
            case .slider:
                collectioViewHeight.constant = 230
                isSlider = true
                collectionViewCellsCount = rowCellViewModel?.rowVMs.first?.column.slides?.count ?? 0
            case .image:
                collectioViewHeight.constant = 230
                isSlider = false
                collectionViewCellsCount = collectionItems?.count ?? 0
                
            case .text:
                collectioViewHeight.constant = 30
                isSlider = false
                collectionViewCellsCount = collectionItems?.count ?? 0
            default:
               
                break
            }
            collectionView.layoutIfNeeded()
            self.collectionView.reloadData()
        }
    }
    
}

extension RowTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionViewCellsCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let column: CollectionViewCellViewModel?
        
        if isSlider{
            let index = IndexPath(row: 0, section: 1)

            column = rowCellViewModel?.columnViewModel(at: index)
        }
        else {
            column = rowCellViewModel?.columnViewModel(at: indexPath)
        }
        switch  column?.cellType{
        case .text:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCollectionViewCell", for: indexPath) as? TextCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellViewModel = column
            cell.layoutIfNeeded()

            return cell
        case .image:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellViewModel = column
            cell.layoutIfNeeded()

            return cell
        case .slider:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as? SliderCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.slider = column?.slider?[indexPath.row]
            cell.cellViewModel = column
            cell.layoutIfNeeded()

            return cell
        case .none:
            return UICollectionViewCell()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let column: CollectionViewCellViewModel?

        if isSlider{
            let index = IndexPath(row: 0, section: 1)
            
            column = rowCellViewModel?.columnViewModel(at: index)
        }
        else {
            column = rowCellViewModel?.columnViewModel(at: indexPath)
        }
        switch  column?.cellType{
        case .text:
            let text = column?.text ?? ""
            let margines = 10.0
            let width = self.estimatedFrame(text: text, font: UIFont.systemFont(ofSize: column?.textFontSize ?? 0.0)).width
            return CGSize(width: Double(width) + margines, height: 30.0)
        case .image:
            return CGSize(width: 200, height: 300.0)

        case .slider:
            return CGSize(width: 200, height: 300.0)

        case .none:
            return CGSize(width: 200, height: 300.0)
     
        }

    }

    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 0, height: 60) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }

    //Add spaces at the beginning and the end of the collection view
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
   }

}

 
