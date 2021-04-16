//
//  HomeViewController.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 11/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController {
    
    // MARK: IBOutlet
    
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
        let input = HomeViewModel.Input(trigger: rx.viewDidAppear)
        let _ = viewModel.transform(input: input)
    }

}
