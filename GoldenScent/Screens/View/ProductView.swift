//
//  ProductView.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import UIKit

class ProductView: UIView {

    @IBOutlet weak var rowsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!


    // MARK:- Public Methods
    func setup(){
        setUpInitialState()
    }
    func setUpInitialState(){
        rowsTableView.isHidden = true
    }
    func showNoDataFound(){
        rowsTableView.isHidden = true
        errorView.isHidden = false
        errorLabel.isHidden = false
    }

}
