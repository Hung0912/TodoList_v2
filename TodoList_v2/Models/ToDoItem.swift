//
//  ToDoItem.swift
//  TodoList_v2
//
//  Created by HungPB on 6/27/19.
//  Copyright © 2019 HungPB. All rights reserved.
//
import Foundation

class ToDoItem {
    var title: String
    var startDate: String
    var endDate: String?
    var content: String = "No content"
    var isDone: Bool = false
    
    init(title: String) {
        self.title = title

        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        self.startDate = "\(day)/\(month)"
    }
}
