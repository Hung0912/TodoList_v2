//
//  TodoTableViewController.swift
//  TodoList_v2
//
//  Created by HungPB on 6/27/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController{
    
    var sectionTitles : [String] = ["List", "Completed"]
    
    var toDoList = [ToDoItem]()
    var doingList = [ToDoItem]()
    var completedList = [ToDoItem]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        tableView.register(TodoCell.self, forCellReuseIdentifier: cellId)
        setupNavigationBar()

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
    

    
    func createData(){
        toDoList.append(ToDoItem(title: "Do homework"))
        toDoList.append(ToDoItem(title: "Work out"))
        loadTodoListData()
    }
    
    func loadTodoListData(){
        completedList = toDoList.filter {$0.isDone}
        doingList = toDoList.filter {!$0.isDone}
    }
    
    func loadData(){
        //load data here
        self.loadTodoListData()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
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
            cell.delegate = self
            var todoItem: ToDoItem!
            if indexPath.section == 0 {
                //print("Dmmmmmmmm")
                todoItem = doingList[indexPath.row]
            }
            if indexPath.section == 1 {
                todoItem = completedList[indexPath.row]
            }
            cell.updateUICell(item: todoItem)
            return cell
        }
        return UITableViewCell()

        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let detailScreen = sb.instantiateViewController(withIdentifier: "DetailScreen") as! ItemDetailVC
        let detailScreen = ItemDetailVC()
        if indexPath.section == 0 {
            detailScreen.item = doingList[indexPath.row]
        }else{
            detailScreen.item = completedList[indexPath.row]
        }
        
        self.navigationController?.pushViewController(detailScreen, animated: true)
        
        detailScreen.delegate = self
    }
    
    
    @objc func addTapped(){
        let addScreen = AddItemVC()
        self.navigationController?.pushViewController(addScreen, animated: true)
        addScreen.delegate = self
    }
    
    func showArray(){
        print("---------List:")
        for item in toDoList{
         
            print("\(item.title)")
        }
        print("---------Doing list:")
        for item in doingList{
            
            print("\(item.title)")
        }
        print("---------Completed list:")
        for item in completedList{
            
            print("\(item.title)")
        }
    }
    
    
}

extension TodoTableViewController: ToDoCellTableViewCellDelegate, ItemDetailVCDelegate, AddItemVCDelegate{
    
    func didAdd(item: ToDoItem) {
        self.toDoList.append(item)
        self.loadData()
        //self.showArray()
    }
    
    func didSave(item: ToDoItem) {
        self.loadData()
        //self.showArray()
    }
    
    func didComplete(item: ToDoItem) {
        item.isDone = true
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        item.endDate = "\(day)/\(month)"
        
        self.loadData()
        //self.showArray()

    }
    
}

