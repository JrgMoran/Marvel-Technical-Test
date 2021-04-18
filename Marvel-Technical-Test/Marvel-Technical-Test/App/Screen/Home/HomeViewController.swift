//
//  HomeViewController.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 11/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController, UITableViewDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: CharacterCell.identifier, bundle: nil), forCellReuseIdentifier: CharacterCell.identifier)
            tableView.rx.setDelegate(self).disposed(by: disposeBag)
        }
    }
    
    // MARK: Injections
    var viewModel: HomeViewModel!
    
    // MARK: Attributes

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    // MARK: Configure View
    private func configureView(){
        
    }
    
    // MARK: Binding
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = HomeViewModel.Input(trigger: rx.viewWillAppear,
                                        indexTap: tableView.rx.itemSelected.map({ $0.row }).asObservable(),
                                        indexWillView: tableView.rx.willDisplayCell.map({$0.indexPath.row}))
        let output = viewModel.transform(input: input)
        
        output.characters.bind(to: tableView.rx.items(cellIdentifier: CharacterCell.identifier,
                                                      cellType: CharacterCell.self)){ (row,item,cell) in
                    cell.configure(with: item)
        }.disposed(by: disposeBag)
        
        output.isHiddenTableView.bind(to: tableView.rx.isHidden).disposed(by: disposeBag)
    }

}
