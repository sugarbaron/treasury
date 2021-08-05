//
//  EditPlanningPeriodScreen.swift
//  treasury
//
//  Created by sugarbaron on 05.08.2021.
//

import SwiftUI

extension EditPlanningPeriod {
    
    struct Screen: View {
        
        @ObservedObject private var viewModel: ViewModel = .init()
        
        var body: some View {
            DatePicker(selection: $viewModel.periodStart) {  }
        }
        
    }
    
}

struct EditPlanningPeriodScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        EditPlanningPeriod.Screen()
    }
    
}
