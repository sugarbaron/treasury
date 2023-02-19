//
//  RegisterPurchaseTextAssets.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

extension RegisterPurchase { final class TextAssets { } }

extension RegisterPurchase.TextAssets {
    var title: Resources.Text.Asset { .init("purchase.title") }
    var available: Resources.Text.Asset { .init("purchase.available") }
    var category: Resources.Text.Asset { .init("purchase.category") }
    var comment: Resources.Text.Asset { .init("purchase.comment") }
    var price: Resources.Text.Asset { .init("purchase.price") }
}
