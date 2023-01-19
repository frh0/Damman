
import CloudKit
import Foundation
import SwiftUI
// ViewModel
class TimeLineViewModel: ObservableObject {
    //LINA
    @Published var Category = ["Devices", "Jewelry", "Furniture"]
    @Published  var selectedColor = "Red" // <1>
    
    @Published  var itemname: String = ""
    @Published var isExchange: Bool = true
    
    
    @Published var StartDate: Date = Date.now
    @Published var EndDate: Date = Date.now
    
    var dataFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    

  //  @Published var items: [Item] = []
    
    @Published var items: [Item] = [Item(warImg: "mac", itemImg: "mac", name: "MacBook", purchaseDate: Date(), expiryDate: Date().addingTimeInterval(86400*3)),Item(warImg: "mac",itemImg: "TV", name: "TV", purchaseDate: Date(), expiryDate: Date().addingTimeInterval(86400*14)),Item(warImg: "mac",itemImg: "iphone", name: "iPhone11", purchaseDate: Date(), expiryDate: Date().addingTimeInterval(86400*21)) ,Item(warImg: "mac",itemImg: "AirpodsPro2", name: "AirpodsPro2", purchaseDate: Date(), expiryDate: Date().addingTimeInterval(86400*35))]

    func justDoIt() {
        print("Button was tapped")
    }
    
//    func fetchProfiles(){
//        let predicate = NSPredicate(value: true)
//        //2
//        //let predicate2 = NSPredicate(format: "firstName == %@", "Sara")
//
//        //Record Type depends on what you have named it
//        let query = CKQuery(recordType:"Learner", predicate: predicate)
//
//
//        let operation = CKQueryOperation(query: query)
//        operation.recordMatchedBlock = { recordId, result in
//            DispatchQueue.main.async {
//                switch result{
//                case .success(let record):
//                    let Item = Item(record: record)
//                    self.items.append(Item)
//                case .failure(let error):
//                    print("\(error.localizedDescription)")
//                }
//            }
//        }
//
//        CKContainer.default().publicCloudDatabase.add(operation)
//    }
    
}
