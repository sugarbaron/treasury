//
//  EditPlanningPeriodScreen.swift
//  treasury
//
//  Created by sugarbaron on 05.08.2021.
//

import SwiftUI

extension EditPlanningPeriod {
    
    struct Screen: View {
        
        @SwiftUI.Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>
        
        @ObservedObject private var viewModel: ViewModel = .init()
        
        var body: some View {
            HStack { Layout.xSpace; VStack {
                Layout.ySpace
                title
                Layout.yTitleSpace
                fields
                Layout.yInfinite
                buttons
                Layout.ySpace
            }; Layout.xSpace }.background(Colors.background)
        }
        
        private var title: some View {
            Text("edit period").titleStyle
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        
        private var fields: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("period start:").labelStyle
                    Layout.ySpace
                    Layout.ySpace
                    Layout.ySpace
                    Text("period end:").labelStyle
                }
                Layout.xSpace
                Layout.xSpace
                VStack {
                    DatePicker("", selection: $viewModel.periodStart, displayedComponents: [.date]).adjust()
                    Layout.ySpace
                    Layout.ySpace
                    DatePicker("", selection: $viewModel.periodEnd, displayedComponents: [.date]).adjust()
                }
                Spacer()
            }
        }
        
        private var buttons: some View {
            HStack {
                YesButton().onTapGesture {
                    viewModel.editPeriod()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer().frame(maxWidth: .infinity)
                NoButton().onTapGesture { presentationMode.wrappedValue.dismiss() }
            }
        }
        
    }
    
}

private extension DatePicker {
    
    func adjust() -> some View {
        datePickerStyle(CompactDatePickerStyle())
            .frame(width:90, alignment: .center)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 15))
            .background(Colors.biege)
            .accentColor(Colors.black)
            .cornerRadius(5)
    }
    
}

struct EditPlanningPeriodScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        EditPlanningPeriod.Screen()
    }
    
}
