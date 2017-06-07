//
//  ViewController.swift
//  ViewModel
//
//  Created by Jin Kato on 6/7/17.
//  Copyright © 2017 Jin Kato. All rights reserved.
//

import UIKit

//https://talk.objc.io/episodes/S01E47-view-models-at-kickstarter
// --------------------------------------------------------------------------------- Model


struct State {
    var statusLabelText: String?
}


// --------------------------------------------------------------------------------- ViewModel


class ViewModel {
    var state: State = State(statusLabelText: nil) {
        didSet {
            callback(state)
        }
    }
    private var count:Int = 0
    var callback: ((State) -> Void)
    
    //MARK: Life Cycle
    
    init(callback: @escaping (State) -> Void) {
        self.callback = callback
        self.callback(state)
    }
    
    //MARK: Helper
    
    func buttonPressed(){
        count = count + 1
        state.statusLabelText = "\(count)"
    }
}


// --------------------------------------------------------------------------------- ViewController


class ViewController: UIViewController {

    var viewModel: ViewModel!
    
    let blueButton:UIButton = {
        let button = UIButton()
        button.setTitle("Click", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    let statusLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel { [unowned self] state in
            self.statusLabel.text = state.statusLabelText
        }
        layoutBlueButton()
        layoutStatusLabel()
    }
    
    //MARK: Helper

    func buttonPressed(){
        viewModel.buttonPressed()
    }
    fileprivate func layoutStatusLabel(){
        view.addSubview(statusLabel)
        statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        statusLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    fileprivate func layoutBlueButton(){
        view.addSubview(blueButton)
        blueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        blueButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        blueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

