//
//  ItemDetailVC.swift
//  TodoList_v2
//
//  Created by HungPB on 6/27/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

protocol ItemDetailVCDelegate : class{
    func didSave()
}
class ItemDetailVC: UIViewController {
    
    var item: ToDoItem!
    
    weak var delegate: ItemDetailVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Item Detail"
        self.setupLayout()
        self.updateUI()
        view.backgroundColor = .white
        saveBtn.addTarget(self, action: #selector(self.savePressed), for: .touchUpInside)
        // Do any additional setup after loading the view.
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
        tf.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tf.font = UIFont.systemFont(ofSize: 13)
        tf.autocorrectionType = .no
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
    
    var contentTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tv.font = UIFont.systemFont(ofSize: 13)
        tv.textAlignment = .left
        return tv
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
        view.addSubview(contentTextView)
        
        contentLbl.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLbl.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            
            contentTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentTextView.topAnchor.constraint(equalTo: contentLbl.bottomAnchor, constant: 5),
            contentTextView.heightAnchor.constraint(equalToConstant: 165),
            contentTextView.widthAnchor.constraint(equalToConstant: 344)
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
        if self.item.isDone{
            self.contentTextView.isEditable = false
            self.titleTextField.isEnabled = false
            saveBtn.isHidden = true
        }
    }
    
    func updateUI(){
        self.titleTextField.text = self.item.title
        if self.item.content != "No content"{
             self.contentTextView.text = self.item.content
        }
    }
    
    
    @objc func savePressed(){
        print("Saved")
        guard let title = self.titleTextField.text else { return}
        self.item.title = title
        self.item.content = self.contentTextView.text
        self.delegate?.didSave()
        
        navigationController?.popToRootViewController(animated: true)
    }
    
}

