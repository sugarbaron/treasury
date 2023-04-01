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
            HStack { Spacer(); primarySection; Spacer() }
            keyboard
        }
        .background(.background)
    }
    
    private var title: some View {
        HStack {
            Spacer()
            Text(.purchase.title).design(size: .title, color: .title).padding()
            Spacer()
        }
        .background(Color.uprised, ignoresSafeAreaEdges: .top)
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
        }
    }
    
    private var availableAmountDisplay: some View {
        VStack {
            todayAmountDetails.padding([.leading, .trailing, .top])
            availableAmount.padding([.leading, .trailing, .bottom])
        }
        .background(Color.uprised.design(.border(.lowered, line: 2)).blur(radius: 2))
        .design(.border(.lowered))
    }
    
    private var todayAmountDetails: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing) {
                Text(.purchase.forToday).design(size: .regular)
                Text(.purchase.overspent).design(size: .regular)
            }
            VStack(alignment: .leading) {
                Text("100000").design(size: .regular)
                Text("500").design(size: .regular, color: .warning1)
            }
            Spacer()
            planBudgetButton
        }
    }
    
    private var availableAmount: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text(.purchase.available).design(size: .regular)
                Text(viewModel.available.string).design(size: .title, color: .title)
            }
        }
    }
    
    private var planBudgetButton: some View {
        Image(systemName: "gearshape")
            .design(size: .title)
            .padding(7)
            .background(.background)
            .design(.corners)
            .shadow(color: .black, radius: 2)
            .button(effect: .scale(0.9)) { }
    }
    
    private var priceDisplay: some View {
        HStack {
            Text(.purchase.price)
                .design(size: .regular)
                .padding()
            Spacer()
            Text(viewModel.displayed.string)
                .design(size: .title, color: .title)
                .padding()
        }
        .background(Color.lowered.design(.border(.black, line: 2)).blur(radius: 2))
        .design(.border(.black))
    }
    
    private var categoryEditingButton: some View {
        HStack {
            Text(.purchase.category)
                .design(size: .regular)
                .padding()
            Spacer()
            Text("bar")
                .design(size: .regular)
                .padding()
        }
        .background(.uprised)
        .design(.corners)
        .design(.shadow)
        .button { }
    }

    private var commentEditingButton: some View {
        HStack {
            Text(.purchase.comment)
                .design(size: .regular)
                .padding()
            Spacer()
            Text("craft beer")
                .design(size: .regular)
                .padding()
        }
        .background(.uprised)
        .design(.corners)
        .design(.shadow)
        .button { }
    }
    
    private var keyboard: some View {
        DigitalKeyboard.Ui()
            .environmentObject(viewModel.keyboard)
            .frame(maxHeight: 220)
            .background(Color.uprised.design(.shadow).ignoresSafeArea(edges: .bottom))
            
            
    }
    
}

struct RegisterPurchaseScreen_Previews : PreviewProvider {
    static var previews: some View { RegisterPurchase.Screen() }
}
