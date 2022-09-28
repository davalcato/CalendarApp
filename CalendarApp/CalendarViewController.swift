//
//  ViewController.swift
//  CalendarApp
//
//  Created by Daval Cato on 9/22/22.
//

import UIKit
import CalendarKit
import EventKit

class CalendarViewController: DayViewController {
    // create the event store
    private let eventStore = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // add title
        title = "Calendar"
        // function reques
        requestAccessToCalendar()
    }
    // function for access
    func requestAccessToCalendar() {
        eventStore.requestAccess(
            to: .event) { success, error in
            
        }
    }
}

