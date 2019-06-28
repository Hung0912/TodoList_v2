//
//  AddItemVC.swift
//  TodoList_v2
//
//  Created by HungPB on 6/27/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

protocol AddItemVCDelegate : class {
    func didAdd(item : ToDoItem)
}

class AddItemVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        self.title = "Add Item"
        addBtn.addTarget(self, action: #selector(self.addPressed), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    weak var delegate : AddItemVCDelegate?
    
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
    
    var addBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("Add", for: .normal)
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
    
    func layoutAddButton(){
        view.addSubview(addBtn)
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBtn.heightAnchor.constraint(equalToConstant: 50),
            addBtn.widthAnchor.constraint(equalToConstant: 282),
            addBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            ])
    }
    
    func setupLayout(){
        view.backgroundColor = .white
        layoutTitle()
        layoutContent()
        layoutAddButton()
    }
    
    @objc func addPressed(){
        guard let title = self.titleTextField.text else {
            return
        }
        if title != ""{
            print("Added")
            let addItem = ToDoItem(title: title)
            if self.contentTextView.text != ""{
                addItem.content  = self.contentTextView.text
            }
            self.delegate?.didAdd(item: addItem)
        }else{
            print("Non title")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
}

