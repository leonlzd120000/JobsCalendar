//
//  ViewController.swift
//  JobsCalendar
//
//  Created by leon on 2018/11/15.
//  Copyright © 2018年 leon. All rights reserved.
//

import UIKit
import FSCalendar

class NavViewController: UIViewController,FSCalendarDataSource,FSCalendarDelegate {

    var day: String = ""
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate weak var calendar: FSCalendar!
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var scrollDirection: FSCalendarScrollDirection = .vertical
    var selectedDate: Data?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black
        self.view = view
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.white
        self.view.addSubview(calendar)
        self.calendar = calendar
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did selected date \(self.formatter.string(from: date))")
        
        let str = self.formatter.string(from: date)
        
        day = String(str.suffix(2))
        
        print(day)
        
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return self.gregorian.isDateInToday(date) ? "今天" : nil
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2019/12/31")!
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    

}

