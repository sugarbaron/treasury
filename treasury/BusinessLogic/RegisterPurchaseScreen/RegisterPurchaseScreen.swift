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
        
    }
    
}
// MARK: layout
extension RegisterPurchase.Screen : View {
    
    var body: some View {
        VStack {
            VStack {
                Color.background
                keyboard.frame(w: .flexible(max: 500), h: .flexible(max: 300))
            }
            .edgesIgnoringSafeArea([.top, .leading, .trailing])
            .background(Color.background.rounded(0))
        }
        .background(Color.uprised)
    }
    
}

private extension RegisterPurchase.Screen {
    
    var keyboard: some View {
        DigitalKeyboard()
    }
    
    
    
}

struct RegisterPurchaseScreen_Previews : PreviewProvider {
    static var previews: some View { RegisterPurchase.Screen() }
}
