//
//  ProductViewController.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import UIKit

class ProductViewController: UIViewController {
    // MARK: Variables
    let viewModel = ProductViewModel()
    // MARK: Outlets
    @IBOutlet var productView: ProductView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init the static view
        initView()
        // init view model
        initVM()
    }
    func initView() {
        self.navigationItem.title = "Golden Scent"
        productView.rowsTableView.rowHeight = UITableView.automaticDimension
    }

    func initVM() {
        // Native binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.productView.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productView.rowsTableView.alpha = 0.0
                        self.productView.errorView.alpha = 1.0
                        self.productView.errorLabel.text = self.viewModel.alertMessage
                    })
                case .loading:
                    self.productView.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productView.rowsTableView.alpha = 0.0
                        self.productView.errorView.alpha = 0.0
                    })
                case .populated:
                    self.productView.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productView.rowsTableView.alpha = 1.0
                        self.productView.errorView.alpha = 0.0
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productView.rowsTableView.reloadData()
            }
        }
        viewModel.fetchRows()

    }
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 328
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RowTableViewCell",
                                                       for: indexPath) as? RowTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.rowCellViewModel = cellVM
        return cell
    }
}

extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.userSelectTask(at: indexPath)
        if viewModel.isAllowSegue {
//            self.performSegue(withIdentifier: "taskDetailsSegue", sender: self)
        } else {
        }
    }
}
