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
    // new events for date
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        // fetch events with date range
        let startDate = date
        var oneDayComponents = DateComponents()
        // the span of the dates
        oneDayComponents.day = 1
        // create end date
        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        
        // fetch all the events from the beginning of startDate to end of date
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        
        // fetch from eventstore
        let eventKitEvents = eventStore.events(matching: predicate)
        
        // The `eventKitEvents` has a type of `[EKEvent]`, we need to convert them to CalendarKit Events
        let calendarKitEvents = eventKitEvents.map { eKEvent -> Event in
            // separate events
            let ckEvent = Event() // Creating a new CalendarKit.Event
//            ckEvent.startDate = eKEvent.startDate
//            ckEvent.endDate = eKEvent.endDate
            ckEvent.isAllDay = eKEvent.isAllDay
            ckEvent.text = eKEvent.description
            // pass the color
            if let eventColor = eKEvent.calendar.cgColor {
                ckEvent.color = UIColor(cgColor: eventColor)
            }
            return ckEvent
        }
        return calendarKitEvents
    }
}

