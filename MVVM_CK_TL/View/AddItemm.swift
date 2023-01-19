//
//  AddItemm.swift
//  MVVM_CK_TL
//
//  Created by Malak  on 24/05/1444 AH.
//

import Foundation
import SwiftUI
import AVKit
import VisionKit
import CoreML

struct AddItemm: View {
    // private var Category = ["Devices", "Jewelry", "Furniture"]
    @ObservedObject var viewModel: TimeLineViewModel
    //    @State private var selectedColor = "Red" // <1>
    //
    //    @State private var itemname: String = ""
    //    @State var isExchange: Bool = true
    //
    //
    //    @State var StartDate: Date = Date.now
    //    @State var EndDate: Date = Date.now
    //
    //    var dataFormatter: DateFormatter{
    //        let formatter = DateFormatter()
    //        formatter.dateStyle = .long
    //        return formatter
    //    }
    //
    var body: some View {
            
            NavigationView {
                VStack(spacing: 16) {
                    
                    
                   Form {
                        
                        HStack {
                            Text("Item name").font(.title2)
                            Spacer()
                            TextField("Ex: iPhone 13",  text: $viewModel.itemname).font(.title2)
                            
                        }
                        
                        
                        HStack {
                            NavigationLink(destination:ContentView()){
                                Text("Item image").font(.title2)
                                
                            }
                            
                        }
                        
                        
                        HStack {
                            
                            NavigationLink(destination:ContentView()){
                                Text("Warranty").font(.title2)
                                
                            }
                            
                            
                        }
                        
                        
                        HStack {
                            
                            
                            
                            Picker("Category", selection: $viewModel.selectedColor, content: {
                                ForEach(viewModel.Category, id: \.self, content: { color in
                                    Text(color)
                                })
                            }).font(.title2)
                            
                        }
                        
                        
                        DatePicker("Purchase date", selection: $viewModel.StartDate,displayedComponents: [.date])
                            .accentColor(Color.blue)
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding(1)
                            .font(.title2)
                        DatePicker("Expiry date", selection: $viewModel.EndDate, displayedComponents: [.date])
                            .accentColor(Color.blue)
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding(1)
                            .font(.title2)
                        
                       let dateDiff = Calendar.current.dateComponents([.day],  from: viewModel.StartDate, to: viewModel.EndDate)
                       HStack(spacing : 130){
                           Text("Warranty period").font(.title2)
                           Text((dateDiff.day?.description ?? "No Month Found"))
                       }.padding(5)
                        
                        Toggle(isOn: $viewModel.isExchange) {
                            Text("Notify me before the expire date").font(.title2)
                            
                        }
    //
    //                    HStack{
    //                        Spacer()
    //                        Button("Add"){
    //                            vm.newAccount(name: name)
    //                        }
    //                            .font(.system(size: 20, weight: .bold,design: .default))
    //                            .foregroundColor(.white)
    //                            .frame(width: 200,height: 50)
    //                            .background(Color.blue)
    //                            .cornerRadius(8)
    //                            .padding(.top,16)
    //                            .padding(.bottom,10)
    //                        Spacer()
    //
    //                    }
                        
                        
                        
                        
                        
                        
                    }.navigationTitle("New Item")
                    Button("Add"){
                       // vm.newAccount(name: name)
                    }
                        .font(.system(size: 20, weight: .bold,design: .default))
                        .foregroundColor(.white)
                        .frame(width: 200,height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.top,16)
                        .padding(.bottom,10)
                }
                
            }.navigationBarBackButtonHidden()
            
            
       }
}



struct AddItemm_Previews: PreviewProvider {
    static var previews: some View {
        AddItemm(viewModel: TimeLineViewModel())
        
    }
}

