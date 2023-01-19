
import Foundation
import SwiftUI
import AVKit
import VisionKit
import CoreML
import CloudKit



struct TimeLineView: View {
    @ObservedObject var viewModel: TimeLineViewModel
    var vm = AppViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 3, height: 1000)
                        .border(Color.blue)
                        .cornerRadius(5)
                        .padding(.leading, 6.0)
                        .shadow(
                            color: Color.gray.opacity(0.6),
                            radius: 8,
                            x: 8,
                            y: 8
                        )
                    VStack {
                        ForEach(viewModel.items) { i in //viewModel.items:(var viewModel> class TimeLineViewModel> var array items>struct Item in Model)
                            ZStack {
                                    CardView(item: i)//(var item in cardview)
                            }
                        }
                    }
                }.padding()
                    .navigationTitle("TimeLine")
            }
            .padding()
            .navigationTitle("Account")
            .foregroundColor(.black)
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(
                trailing:
                    NavigationLink(
                        destination:
//                            TextScanner()
                        scanner()
                                .environmentObject(vm)//(var vm> class AppViewModel)
                                .task {
                                    await vm.requestDataScannerAccessStatus()   }//(var vm> class AppViewModel> func request..)
                        ,
                        label: {
                            Image(systemName: "plus.circle")
                        })
            )
        }
    }
    struct CardView: View {
        @State var showSheet : Bool = false
        @State var item: Item //(struct Item in Model)
        var body: some View {
            HStack {
                Circle()
                    .fill(Color(red: 0.03137254901960784, green: 0.7607843137254902, blue: 0.5450980392156862))
                    .frame(width: 15)
                Spacer().frame(width: 15)
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 276, height: 89)
                        .cornerRadius(5)
                        .shadow(
                            color: Color.gray.opacity(0.7),
                            radius: 8,
                            x: 5,
                            y: 8)
                    
                    HStack{
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 75, height: 75)
                                .cornerRadius(5)
                            Image(item.itemImg)//(var item> struct Item in Model> constant itemImg)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:75,height: 75, alignment: .center )
                                .cornerRadius(4)
                        }
                        Spacer().frame(width: 20)
                        VStack(alignment: .leading, spacing: 5){
                            HStack{
                                Text(item.name)
                                    .font(.title)
                            }
                           Text(String(item.daysLeft) + " days left")
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 161, height: 9)
                                    .cornerRadius(5)
                                Rectangle()
                                    .fill(Color(red: 0.03137254901960784, green: 0.7607843137254902, blue: 0.5450980392156862))
                                
                                    .frame(width: 150 * item.currentProgress, height: 9)
                                    .cornerRadius(5)
                            }
                            
                        }
                        
                    }
                }
            }.onTapGesture {
                self.showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                DetailsSheet(showSheet: $showSheet, item: item)//item in the DetailsSheet:> item in CardView)
            }
        }
    }
}

struct DetailsSheet : View{
    @State private var showingAlert = false
    @State private var isEditing = false
    @State private var text = ""
    @Binding var showSheet : Bool

    @State var item: Item
    
    var dataFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    
    var body: some View{
        
        NavigationView {
            VStack{
                Form {
                    Image(item.warImg)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(alignment: .center)
                        .padding(1)
                        .cornerRadius(10)
                    
                    Section() {
                        TextField(item.name,
                                  text: $text)
                        .disabled(!isEditing).padding(1).font(.title2)
                        DatePicker("Purchase date", selection: $item.purchaseDate,displayedComponents: [.date])
                            .disabled(!isEditing)
                            .accentColor(Color.blue)
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding(1)
                            .font(.title2)
                        DatePicker("Expiry date", selection: $item.expiryDate, displayedComponents: [.date])
                            .disabled(!isEditing)
                            .accentColor(Color.blue)
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding(1)
                        .font(.title2)}
                    Section() {
                        
                        let dateDiff = Calendar.current.dateComponents([.day],  from: item.purchaseDate, to: item.expiryDate)
                        HStack(spacing : 130){
                            Text("Warranty period").font(.title2)
                            Text((dateDiff.day?.description ?? "No Month Found"))
                        }.padding(5)
                    }
                   
                }
            }
            .navigationBarItems(trailing: Button(isEditing ? "Save" : "Edit") {
                self.isEditing.toggle()
            })
            
            .toolbar {
                if (isEditing){
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: {})
                    }
                }
                
                if (isEditing){ ToolbarItem(placement: .bottomBar) {
                    Button("Delete", action: {showingAlert = true}).foregroundColor(.red).alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Remove \"Samsong TV\" ?"),
                            message: Text("Are you sure you want to delete this item?"),
                            primaryButton: .destructive(Text("Delete")) {
                                print("Deleting...")
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                }}
            
        }
    }
}


struct TimeLine_Previews: PreviewProvider {
    @ObservedObject var viewModel: TimeLineViewModel
    static var previews: some View {
        
        TimeLineView(viewModel: .init())
        
    }
}

