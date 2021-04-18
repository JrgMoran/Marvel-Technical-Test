//
//  AlertView.swift
//  Marvel-Technical-Test
//

import UIKit

class AlertView: ViewController {

    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet private weak var rightButton: UIButton!
    
    var leftAction: (() -> Void)? = nil
    var rightAction: (() -> Void)? = nil
    private var actionSelect: (() -> Void)? {
        didSet {
            close()
        }
    }
    
    var skin: AlertViewSkin? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView(){
        closeButton.setImage(R.images.close, for: .normal)
        guard let skin = skin else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        
        titleLabel.text(skin.title, withSkin: LabelSkin.mainTitle)
        titleLabel.numberOfLines = 2
        
        bodyLabel.text(skin.body, withSkin: LabelSkin.body)
        bodyLabel.numberOfLines = 0
        
        imageView.image = skin.image
        
        if let buttonSkin = skin.rightButton?.skin {
            rightButton.text(skin.rightButton?.text, withSkin: buttonSkin)
        } else {
            rightButton.setTitle(nil, for: .normal)
        }
        self.rightAction = skin.rightButton?.action
        
        if let buttonSkin = skin.leftButton?.skin {
            self.leftButton.text(skin.leftButton?.text, withSkin: buttonSkin)
        } else {
            leftButton.setTitle(nil, for: .normal)
        }
        self.leftAction = skin.leftButton?.action
        
        hideUnnecessaryViews()
    }
    
    private func hideUnnecessaryViews (){
        bodyLabel.isHidden = bodyLabel.text == nil
        imageView.isHidden = imageView.image == nil
        leftView.isHidden = isHiddenThis(button: leftButton)
        rightView.isHidden = isHiddenThis(button: rightButton)
    }
    
    @IBAction private func leftTap(_ sender: Any) {
        actionSelect = leftAction
    }
    
    @IBAction private func rightTap(_ sender: Any) {
        actionSelect = rightAction
    }
    
    @IBAction private func closeTap(_ sender: Any) {
        close()
    }
    
    func close(){
        self.dismiss(animated: true) {
            if let actionSelect = self.actionSelect {
                actionSelect()
            }
        }
    }
    
    func isHiddenThis(button: UIButton) -> Bool {
        var isHidden = true
        if let text = button.title(for: .normal)?.trimmingCharacters(in: .whitespaces){
            isHidden = text.isEmpty
        }
        return isHidden
    }

}
