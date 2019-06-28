//
//  TodoTableViewController.swift
//  TodoList_v2
//
//  Created by HungPB on 6/27/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController{
    
    var doingList = [ToDoItem]()
    var completedList = [ToDoItem]()

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        tableView.register(TodoCell.self, forCellReuseIdentifier: cellId)
        setupNavigationBar()
    }


    func createData(){
        doingList.append(ToDoItem(title: "Do homework"))
        doingList.append(ToDoItem(title: "Work out"))
    }
    
    func setupNavigationBar(){
        self.title = "Todo List"
        let button  = UIButton(type: .custom)
        if let image = UIImage(named:"plus_icon") {
            button.setImage(image, for: .normal)
        }
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }
    
    func showArray(){
        print("---------Doing list:")
        for item in doingList{
            print("\(item.title)")
        }
        print("---------Completed list:")
        for item in completedList{
            print("\(item.title)")
        }
    }
    
    @objc func addTapped(){
        let addScreen = AddItemVC()
        self.navigationController?.pushViewController(addScreen, animated: true)
        addScreen.delegate = self
    }
    
}

//Datasource
extension TodoTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return doingList.count
        }
        if section == 1 {
            return completedList.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? TodoCell{
            if indexPath.section == 0 {
                cell.item = doingList[indexPath.row]
            }
            if indexPath.section == 1 {
                cell.item = completedList[indexPath.row]
            }
            cell.updateUICell()
            return cell
        }
        return UITableViewCell()
        
        
    }
    
}

//Delegate
extension TodoTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen = ItemDetailVC()
        if indexPath.section == 0 {
            detailScreen.item = doingList[indexPath.row]
        }else{
            detailScreen.item = completedList[indexPath.row]
            detailScreen.item.isDone = true
        }
        self.navigationController?.pushViewController(detailScreen, animated: true)
        detailScreen.delegate = self
    }
    
    // Header of section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        let headerIcon = UIImageView(image: UIImage(named: "list_icon"))
        headerIcon.frame = CGRect(x: 5, y: 5, width: 32, height: 32)
        headerIcon.contentMode = .scaleAspectFit
        
        let headerTitle = UILabel(frame: CGRect(x: 42, y: 5, width: 100, height: 35))
        headerTitle.font = UIFont.systemFont(ofSize: 15)
        headerTitle.textAlignment = .left
        
        
        if section == 0 {
            headerTitle.text = "List"
        }else if section == 1 {
            headerTitle.text = "Completed"
        }
        headerView.addSubview(headerIcon)
        headerView.addSubview(headerTitle)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
}

extension TodoTableViewController{
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (action, view, nil) in
            print("Deleted")
            if indexPath.section == 0{
                self.doingList.remove(at: indexPath.row)
            }else{
                self.completedList.remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
        let complete = UIContextualAction(style: .normal, title: "complete") { (action, view, nil) in
            print("Completed")
            self.completedList.append(self.doingList[indexPath.row])
            self.doingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        complete.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        var swipeAction = UISwipeActionsConfiguration()
        if indexPath.section == 0{
            swipeAction = UISwipeActionsConfiguration(actions: [delete,complete])
            swipeAction.performsFirstActionWithFullSwipe = false
        }
        
        if indexPath.section == 1 {
            swipeAction = UISwipeActionsConfiguration(actions: [delete])
            swipeAction.performsFirstActionWithFullSwipe = false
        }
        return swipeAction
    }
}


extension TodoTableViewController: ItemDetailVCDelegate{
    func didSave() {
        self.tableView.reloadData()
        //self.showArray()
    }
}

extension TodoTableViewController: AddItemVCDelegate{
    func didAdd(item: ToDoItem) {
        self.doingList.append(item)
        self.tableView.reloadData()
        //self.showArray()
    }
}


