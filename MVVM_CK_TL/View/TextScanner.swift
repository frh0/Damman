//
//  ContentView.swift
//  BarcodeTextScanner
//
//  Created by Alfian Losari on 6/25/22.
//
import SwiftUI
import VisionKit
import CoreML

struct TextScanner: View {
    @State private var modelInput = ""
    @State private var modelOutput = ""
    @State private var alertShow = false
    //Added
    //@ObservedObject var viewModel: TimeLineViewModel
    @EnvironmentObject var vm: AppViewModel
    
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        //("", .none),//this was for All text tybe :)
        //("URL", .URL),
       // ("Phone", .telephoneNumber),
       // ("Email", .emailAddress),
       // ("Address", .fullStreetAddress)
        
    ]
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .scannerAvailable:
            mainView
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerNotAvailable:
            Text("Your device doesn't have support for scanning barcode with this app")
        case .cameraAccessNotGranted:
            Text("Please provide access to the camera in settings")
        case .notDetermined: //our case 
            Text("Requesting camera access")
        }
    }
    
    func classify() {
            do {
                let model = try MyTextClassifier_4(configuration: .init())
                let prediction = try model.prediction(text: modelInput)
                modelOutput = prediction.label
            } catch {
                modelOutput = "Something went wrong"
            }
        alertShow = true
      }
     var mainView: some View {
        DataScannerView(
            recognizedItems: $vm.recognizedItems,
            recognizedDataType: vm.recognizedDataType,
            recognizesMultipleItems: vm.recognizesMultipleItems)
        .background { Color.gray.opacity(0.3) }
        .ignoresSafeArea()
        .id(vm.dataScannerViewId)
        .sheet(isPresented: .constant(true)) {
            bottomContainerView
                .background(.ultraThinMaterial)
                .presentationDetents([.medium, .fraction(0.25)])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .onAppear {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                        return
                    }
                    controller.view.backgroundColor = .clear
                }
        }
        .onChange(of: vm.scanType) { _ in vm.recognizedItems = [] }
        .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
        .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = []}
    }
    
     var headerView: some View {
        VStack {
            Text("Scan Warranty")
                .font(.title)
                .padding(.top, 30)
            Text("Position your warranty in the frame to scan it")
            
            Spacer()
            
//            HStack {
//                Picker("Scan Type", selection: $vm.scanType) {
//                    Text("Barcode").tag(ScanType.barcode)
//                    Text("Text").tag(ScanType.text)
//                }.pickerStyle(.segmented)
//
//                Toggle("Scan multiple", isOn: $vm.recognizesMultipleItems)
//            }.padding(.top)
            
         
//
            
            VStack{
                
                NavigationLink(
                    destination:AddItemm(viewModel: TimeLineViewModel()))
                {
                    Text("Enter Warranty Deteails Manually")
                                        .foregroundColor(Color.blue)
                                    //    .multilineTextAlignment(.center)
                    
                                    
                }
                TextEditor(text: $modelInput)
                //هنا جالس ياخذ الشيء الي يتعمل له تصنيف الى اقسام
                //    .frame(width: 200, height: 150, alignment: .center)
                
                // المربع الي ياخذ البينات
                    .border(Color.black)
                Spacer()
                Button(action: classify) {
              //      Text("Classify")
                }
                Spacer()
                VStack {
                    
                }.alert(isPresented: $alertShow, content: {
                Alert(title: Text("Prediction"), message: Text(modelOutput), dismissButton: .default(Text("OK")))
                })
            }
            
            
            if vm.scanType == .text {
                Picker("Text content type", selection: $vm.textContentType) {
                    ForEach(textContentTypes, id: \.self.textContentType) { option in
                        Text(option.title).tag(option.textContentType)
                    }
                }.pickerStyle(.segmented)
            }
            
            Text(vm.headerText).padding(.top)
        }.padding(.horizontal)
    }
    
     var bottomContainerView: some View {
         NavigationView {
             VStack {
                 Text("here")
                 headerView
                 ScrollView {
                     LazyVStack(alignment: .leading, spacing: 16) {
                         ForEach(vm.recognizedItems) { item in
                             switch item {
                             case .barcode(let barcode):
                                 Text(barcode.payloadStringValue ?? "Unknown barcode")
                                 
                             case .text(let text):
                                 
                                // Text(text.transcript+"🇧🇸")
                                 Text("")
                                // break
                             @unknown default:
                                 Text("Unknown")
                             }
                         }
                     }
                     .padding()
                 }
             }

         }
    }
}

