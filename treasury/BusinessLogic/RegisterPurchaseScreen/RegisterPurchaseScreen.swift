//
//  RegisterPurchaseScreen.swift
//  treasury
//
//  Created by sugarbaron on 28.01.2023.
//

import SwiftUI

// MARK: constructor
extension RegisterPurchase {
    
    struct Screen {
        
        @StateObject private var viewModel: RegisterPurchase.ViewModel
        
        init() {
            Log("[RegisterPurchase.Screen] reconstructing")
            self._viewModel = RegisterPurchase.ViewModel().stateObject
        }
        
    }
    
}

// MARK: layout
extension RegisterPurchase.Screen : View {
    
    var body: some View {
        VStack {
            title
            primarySection
            keyboard
        }
        .background(Color.background)
    }
    
    private var title: some View {
        HStack {
            Spacer()
            Text(.purchase.title).design(.title, .title).padding()
            Spacer()
        }
        .background(Color.uprised)
    }
    
    private var primarySection: some View {
        VStack {
            Spacer()
            availableAmountDisplay
            priceDisplay
            Spacer()
            categoryEditingButton
            commentEditingButton
            Spacer()
        }.padding([.leading, .trailing])
    }
    
    private var availableAmountDisplay: some View {
        VStack {
            todayAmountDetails.padding([.leading, .trailing, .top])
            availableAmount.padding([.leading, .trailing, .bottom])
        }
        .background(Color.uprised.border(Color.lowered, line: 2, corners: 8).blur(radius: 2))
        .border(Color.lowered, line: 1, corners: 8)
    }
    
    private var todayAmountDetails: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(.purchase.forToday).design(.regular).lineLimit(1)
                Text(.purchase.overspent).design(.regular).lineLimit(1)
            }
            VStack(alignment: .leading) {
                Text("100000").design(.regular).lineLimit(1)
                Text("500").design(.regular, .warning1).lineLimit(1)
            }
            Spacer()
        }
    }
    
    private var availableAmount: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text(.purchase.available).design(.regular)
                Text(viewModel.available.string).design(.title, .title)
            }
        }
    }
    
    private var priceDisplay: some View {
        HStack {
            Text(.purchase.price)
                .design(.regular)
                .padding()
            Spacer()
            Text(viewModel.displayed.string)
                .design(.title, .title)
                .padding()
        }
        .background(Color.lowered.border(.black, line: 2, corners: 8).blur(radius: 2))
        .border(.black, line: 1, corners: 8)
    }
    
    private var categoryEditingButton: some View {
        HStack {
            Text(.purchase.category)
                .design(.regular)
                .padding()
            Spacer()
            Text("bar")
                .design(.regular)
                .padding()
        }
        .background(Color.uprised)
        .corners(8)
        .shadow(color: Color.lowered, radius: 4)
    }

    private var commentEditingButton: some View {
        HStack {
            Text(.purchase.comment)
                .design(.regular)
                .padding()
            Spacer()
            Text("craft beer")
                .design(.regular)
                .padding()
        }
        .background(Color.uprised)
        .corners(8)
        .shadow(color: Color.lowered, radius: 4)
    }
    
    private var keyboard: some View {
        DigitalKeyboard.Ui()
            .environmentObject(viewModel.keyboard)
            .frame(maxHeight: 220)
            .background(Color.uprised.shadow(color: Color.lowered, radius: 4))
    }
    
}

struct RegisterPurchaseScreen_Previews : PreviewProvider {
    static var previews: some View { RegisterPurchase.Screen() }
}
