//
//  ItemDetailVC.swift
//  TodoList_v2
//
//  Created by HungPB on 6/27/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

protocol ItemDetailVCDelegate : class{
    func didSave(item : ToDoItem)
}
class ItemDetailVC: UIViewController {
    
    var item: ToDoItem!
    
    weak var delegate: ItemDetailVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Item Detail"
        self.setupLayout()
        
        view.backgroundColor = .white
        saveBtn.addTarget(self, action: #selector(self.savePressed), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.updateUI()
    }
    
    var titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    var titleTextField : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.lightGray
        tf.font = UIFont.systemFont(ofSize: 13)
        
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    var contentLbl: UILabel = {
        let label = UILabel()
        label.text = "Content"
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    var contentTextField : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .lightGray
        tf.font = UIFont.systemFont(ofSize: 13)
        tf.textAlignment = .left
        tf.contentVerticalAlignment = .top
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    var saveBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("Save", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    func layoutTitle(){
        view.addSubview(titleLbl)
        view.addSubview(titleTextField)
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            titleTextField.heightAnchor.constraint(equalToConstant: 35),
            titleTextField.widthAnchor.constraint(equalToConstant: 344)
            ])
        
    }
    
    func layoutContent(){
        view.addSubview(contentLbl)
        view.addSubview(contentTextField)
        
        contentLbl.translatesAutoresizingMaskIntoConstraints = false
        contentTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLbl.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            
            contentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentTextField.topAnchor.constraint(equalTo: contentLbl.bottomAnchor, constant: 5),
            contentTextField.heightAnchor.constraint(equalToConstant: 165),
            contentTextField.widthAnchor.constraint(equalToConstant: 344)
            ])
    }
    
    func layoutSaveButton(){
        view.addSubview(saveBtn)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveBtn.heightAnchor.constraint(equalToConstant: 50),
            saveBtn.widthAnchor.constraint(equalToConstant: 282),
            saveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            ])
    }
    
    func setupLayout(){
        layoutTitle()
        layoutContent()
        layoutSaveButton()
        
    }
    
    func updateUI(){
        self.titleTextField.text = self.item.title
        self.contentTextField.text = self.item.content
    }
    
    
    @objc func savePressed(){
        print("Saved")
        guard let titlt = self.titleTextField.text else { return}
        self.item.title = titlt
        self.item.content = self.contentTextField.text
        self.delegate?.didSave(item: self.item)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
}

