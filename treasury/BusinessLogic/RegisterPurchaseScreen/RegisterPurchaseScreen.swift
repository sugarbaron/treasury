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
            Spacer()
            DigitalKeyboard.Ui(viewModel.keyboard)
                .frame(w: .flexible(max: 500), h: .flexible(max: 300))
                .background(Color.uprised.rounded(8).ignoresSafeArea(edges: .bottom))
        }
        .background(Color.background)
    }
    
}

struct RegisterPurchaseScreen_Previews : PreviewProvider {
    static var previews: some View { RegisterPurchase.Screen() }
}
