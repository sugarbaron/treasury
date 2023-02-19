//
//  RegisterPurchaseImageAssets.swift
//  treasury
//
//  Created by sugarbaron on 18.02.2023.
//

extension RegisterPurchase { final class ImageAssets { } }

extension RegisterPurchase.ImageAssets {
    var available: Resources.Image.Asset { .init("purchase.available") }
    var category: Resources.Image.Asset { .init("purchase.category") }
    var comment: Resources.Image.Asset { .init("purchase.comment") }
    var price: Resources.Image.Asset { .init("purchase.price") }
}
