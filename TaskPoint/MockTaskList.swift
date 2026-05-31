//
//  MockTaskList.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 31.05.26.
//

class MockTaskList {
    let iconName: String
    let title: String
    let description: String
    let date: String
    let time: String
    let location: String
    let priority: String
    let notes: String
    let isCompleted: Bool
    
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
