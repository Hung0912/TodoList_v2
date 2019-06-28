//
//  ToDoCellTableViewCell.swift
//  ToDoList
//
//  Created by Bảo  Hưng on 6/25/19.
//  Copyright © 2019 Bảo  Hưng. All rights reserved.
//

import UIKit


class TodoCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUICell()
        print("1")
    }
    
    var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.sizeToFit()
        lbl.font = UIFont.systemFont(ofSize: 11)
        return lbl
    }()
    
    var todoTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.sizeToFit()
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    var contentLabel: UILabel = {
        let lbl = UILabel()
        lbl.sizeToFit()
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.numberOfLines = 0
//        lbl.isEditable = false
//        lbl.isScrollEnabled = false
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.isUserInteractionEnabled = false
        return lbl
    }()
    
    var item : ToDoItem!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutCell(){
        addSubview(dateLbl)
        addSubview(todoTitleLbl)
        addSubview(contentLabel)
        
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        todoTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            dateLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            dateLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            dateLbl.heightAnchor.constraint(equalToConstant: 11),
            dateLbl.widthAnchor.constraint(equalToConstant: 36),
            
            todoTitleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            todoTitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            todoTitleLbl.heightAnchor.constraint(equalToConstant: 13),
            todoTitleLbl.widthAnchor.constraint(equalToConstant: 200),
            
            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  10),
            contentLabel.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: 5),
            contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            ])
        
    }
    
    func updateUICell(){
        self.dateLbl.text = self.item.startDate
        self.todoTitleLbl.text = self.item.title
        self.contentLabel.text = self.item.content
    }
}
