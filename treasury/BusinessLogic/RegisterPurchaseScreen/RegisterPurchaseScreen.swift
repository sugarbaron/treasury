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
            Text(.purchase.title)
            .title()
            .foreground(.foreground)
            .padding()
            Spacer()
        }
        .background(Color.uprised)
    }
    
    private var primarySection: some View {
        VStack {
            Spacer()
            availableAmountDisplay
            priceDisplay
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
        .background(Color.uprised.border(Color.lowered, width: 2, rounded: 8).blur(radius: 2))
        .border(Color.lowered, width: 1, rounded: 8)
    }
    
    private var todayAmountDetails: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(.purchase.forToday).regular().foreground(.foreground).lineLimit(1)
                Text(.purchase.saved).regular().foreground(.foreground).lineLimit(1)
            }
            VStack(alignment: .leading) {
                Text("100000").regular().foreground(.foreground).lineLimit(1).layoutPriority(1)
                Text("500").regular().foreground(.success1).lineLimit(1).layoutPriority(1)
            }
            Spacer()
        }
    }
    
    private var availableAmount: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text(.purchase.available).regular().foreground(.foreground)
                Text(viewModel.available.string).title().foreground(.foreground)
            }
        }
    }
    
    private var priceDisplay: some View {
        HStack {
            Text(.purchase.price)
                .regular()
                .foreground(.disabled)
                .padding()
            Spacer()
            Text(viewModel.displayed.string)
                .title()
                .foreground(.foreground)
                .padding()
        }
        .background(Color.lowered.border(.black, width: 2, rounded: 8).blur(radius: 2))
        .border(.black, width: 1, rounded: 8)
    }
    
    private var categoryEditingButton: some View {
        HStack {
            Text(.purchase.category)
                .regular()
                .foreground(.disabled)
                .padding()
            Spacer()
            Text("bar")
                .regular()
                .foreground(.disabled)
                .padding()
        }
        .background(Color.uprised)
        .rounded(8)
        .shadow(color: Color.lowered, radius: 4)
    }

    private var commentEditingButton: some View {
        HStack {
            Text(.purchase.comment)
                .regular()
                .foreground(.disabled)
                .padding()
            Spacer()
            Text("craft beer")
                .regular()
                .foreground(.disabled)
                .padding()
        }
        .background(Color.uprised)
        .rounded(8)
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
