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
            availableAmountSection
            display
            Spacer()
            detailSection
            Spacer()
        }.padding([.leading, .trailing])
    }
    
    private var detailSection: some View {
        VStack {
            categorySection
            commentSection
        }
    }
    
    private var availableAmountSection: some View {
        section(.purchase.available, viewModel.available.string, .purchase.available)
    }
    
    private var display: some View {
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
    
    private var categorySection: some View {
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

    private var commentSection: some View {
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
    
    private func section(_ title: Resources.Text.Asset, _ content: String, _ icon: Resources.Image.Asset) -> some View {
        VStack {
            HStack {
                Spacer()
                Text(title)
                    .regular()
                    .foreground(.foreground)
                    .padding([.trailing])
            }
            HStack {
                Spacer()
                Text(content)
                    .title()
                    .foreground(.foreground)
                    .padding(.trailing)
            }
        }
    }
    
}

struct RegisterPurchaseScreen_Previews : PreviewProvider {
    static var previews: some View { RegisterPurchase.Screen() }
}
