//
//  PlanningPeriodsInspector.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//

import Foundation
import Swinject

final class PlanningPeriodsInspector {
    
    private let queue: OperationQueue
    private let storage: CentralStorage
    private var lastInspection: Date?
    
    init?() {
        guard let storage: CentralStorage = try? Di.inject(CentralStorage?.self)
        else { Log(error: "[PlanningPeriodsInspector] unable to construct"); return nil }
        
        self.queue = OperationQueue.newSerial()
        self.storage = storage
    }
    
    func start() { queue.addCancellable { [weak self] isCancelled in
        let inspectionPeriod: TimeInterval = 60
        while(isCancelled() == false) {
            guard let this = self else { Log(error: "[PlanningPeriodsInspector] suddenly deallocated"); return }
            this.inspect()
            Thread.sleep(forTimeInterval: inspectionPeriod)
        }
    } }
    
    func stop() { queue.cancelAllOperations() }
    
    private func inspect() {
        guard let currentPeriod: PlanningPeriod = storage.loadCurrentPeriod()
        else { createPlanningPeriod(startDate: Date.now); return }
        
        let day: TimeInterval = 24 * 60 * 60
        if Date.now.timeIntervalSince(currentPeriod.end) > day {
            //if try! Date.parse("2021-09-03 19:00:01").timeIntervalSince(currentPeriod.end) > 0 {
            createPlanningPeriod(startDate: currentPeriod.end.addingTimeInterval(day)); return
        }
    }
    
    private func createPlanningPeriod(startDate: Date) {
        let newPeriod: Date.Range = (startDate, getNextMonthDate(from: startDate))
        Log(info: "[PlanningPeriodsInspector] period:[\(newPeriod.from.format()) - \(newPeriod.to.format())]") /* fixme */
        storage.saveNew(period: newPeriod)
        
    }
    
    private func getNextMonthDate(from: Date) -> Date {
        let almostNextMonthDate: Date = from.addingTimeInterval(30 * 24 * 60 * 60)
        
        let calendar: Calendar = Calendar(identifier: .iso8601)
        var components: DateComponents = calendar.dateComponents([.year, .month, .day], from: from)
        
        guard let month: Int = components.month,
              let day: Int = components.day
          else { return almostNextMonthDate }
        let nextMonth: Int = month + 1; components.month = nextMonth
        let previousDay: Int = day - 1; components.day = previousDay
        
        var nextMonthDate: Date? = calendar.date(from: components)
        while (nextMonthDate == nil) {
            guard let day: Int = components.day else { return almostNextMonthDate }
            components.day = day - 1
            nextMonthDate = calendar.date(from: components)
        }
        return nextMonthDate ?? almostNextMonthDate
    }
    
}

extension PlanningPeriodsInspector {
    
    final class Assembly : Swinject.Assembly {
        
        func assemble(container: Container) {
            container.register(PlanningPeriodsInspector?.self) { _ in PlanningPeriodsInspector() }.singleton()
        }
        
    }
    
}
