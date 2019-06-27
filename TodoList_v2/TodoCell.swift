//
//  ToDoCellTableViewCell.swift
//  ToDoList
//
//  Created by Bảo  Hưng on 6/25/19.
//  Copyright © 2019 Bảo  Hưng. All rights reserved.
//

import UIKit

protocol ToDoCellTableViewCellDelegate : class{
    func didComplete(cell: TodoCell)
}

class TodoCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    var checkBox: UIButton = {
        let btn = UIButton()
        
        btn.isEnabled = true
        btn.setImage(UIImage(named: "uncheck_icon"), for: .normal)
        btn.setImage(UIImage(named: "checked_icon"), for: .selected)

        return btn
        }()
    
    var endDateLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .red
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.isHidden = true
        return lbl
    }()
    
    var item : ToDoItem!
    
    weak var delegate:ToDoCellTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layoutCell()
        
        checkBox.addTarget(self, action: #selector(checkedBox), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutCell(){
        addSubview(dateLbl)
        addSubview(todoTitleLbl)
        addSubview(checkBox)
        addSubview(endDateLbl)
        
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        todoTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        endDateLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            dateLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateLbl.heightAnchor.constraint(equalToConstant: 11),
            dateLbl.widthAnchor.constraint(equalToConstant: 36),
            
            todoTitleLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            todoTitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            todoTitleLbl.heightAnchor.constraint(equalToConstant: 13),
            todoTitleLbl.widthAnchor.constraint(equalToConstant: 200),
            
            checkBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            checkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkBox.heightAnchor.constraint(equalToConstant: 32),
            checkBox.widthAnchor.constraint(equalToConstant: 32),
            
            endDateLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            endDateLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            endDateLbl.heightAnchor.constraint(equalToConstant: 13),
            endDateLbl.widthAnchor.constraint(equalToConstant: 35),
            ])
        
    }
    
    
    @objc func checkedBox(_ sender: UIButton) {
        delegate?.didComplete(cell: self)
    }

    func updateUICell(){
        self.dateLbl.text = self.item.startDate
        self.todoTitleLbl.text = self.item.title
        if self.item.isDone{
            self.checkBox.isSelected = true
        }else{
            self.checkBox.isSelected = false
        }
        
        guard let endDate = self.item.endDate else {
            return
        }
        self.endDateLbl.isHidden = false
        self.endDateLbl.text = endDate
        self.checkBox.isHidden = true
    }
    
}
