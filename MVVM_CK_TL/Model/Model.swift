//
//  Model.swift
//  MVVM_CK_TL
//
//  Created by Malak  on 24/05/1444 AH.
//

// model struct that represents an item. This struct should contain all of the data needed to represent an item, such as its name, purchase date, and expiry date. You should also define any computed properties, such as warranty period and days left, within this struct.
import CloudKit
import Foundation
import SwiftUI

// Model
struct Item: Identifiable {
    let id = UUID()
    let warImg : String
    let itemImg : String //should be Image
 
    let name: String
    var purchaseDate: Date
    var expiryDate: Date
    var warrantyPeriod: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: purchaseDate, to: expiryDate).day ?? 0
    }
    var daysLeft: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: Date(), to: expiryDate).day ?? 0
    }
    var currentProgress: Double {
        return Double(daysLeft) / Double(warrantyPeriod)
    }
}
