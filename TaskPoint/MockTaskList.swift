//
//  MockTaskList.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 31.05.26.
//

class MockTaskList {
    var iconName: String
    var title: String
    var description: String
    var date: String
    var time: String
    var location: String
    var priority: String
    var notes: String
    var isCompleted: Bool
    
    init(iconName: String, title: String, description: String, date: String, time: String, location: String, priority: String, notes: String, isCompleted: Bool) {
        self.iconName = iconName
        self.title = title
        self.description = description
        self.date = date
        self.time = time
        self.location = location
        self.priority = priority
        self.notes = notes
        self.isCompleted = isCompleted
    }
}
