//
//  ProductViewModel.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import Foundation
enum RowTableViewCellType {
    case normal(cellViewModel: ProductViewModel)
    case error(message: String)
    case empty
}

class ProductViewModel {
    let json: JSONManager
    private var rowssArray: [Row] = [Row]()
    private var cellViewModels: [ProductCellViewModel] = [ProductCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    // callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var errorMessage: String? {
        didSet {
            self.showErrorView?()
        }
    }
    var selectedRow: Row?
    var isAllowSegue: Bool = false
    // Native binding
    var reloadTableViewClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var showErrorView: (() -> Void)?
    init( json: JSONManager = JSONManager()) {
        self.json = json
    }
    func fetchRows() {
        state = .loading
        json.fetcRowsDataFrom(fileName: "GoldenScent") { (rowsModel) in
            self.state = .populated
            self.processFetchedTasks(rows: rowsModel.rows)
        } failure: { (error) in
            self.state = .error
            switch error {
            case .unexpectedError:
                self.alertMessage = error.localizedDescription
            case .parsingError:
                self.alertMessage = error.localizedDescription
            case .noDataFound:
                self.alertMessage = error.localizedDescription
            case .fileNotFound:
                self.alertMessage = error.localizedDescription
            }
        }
    }
    func getCellViewModel( at indexPath: IndexPath ) -> ProductCellViewModel {
        return cellViewModels[indexPath.row]
    }
    private func processFetchedTasks( rows: [Row] ) {
        self.rowssArray = rows // Cache
        var vms = [ProductCellViewModel]()
        rows.forEach({
            vms.append(ProductCellViewModel(row: $0))
        })
        self.cellViewModels = vms
    }
}
