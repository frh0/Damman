//
//  MVVM_CK_TLApp.swift
//  MVVM_CK_TL
//
//  Created by Malak  on 24/05/1444 AH.
//

import SwiftUI

@main
struct MVVM_CK_TLApp: App {
    @StateObject var item = TimeLineViewModel()
    @StateObject var vm = AppViewModel() // ماريه
    var body: some Scene {
        WindowGroup {
            // to add on boarding 
            //            if true {
            //
            //            } else {
            //
            //            }
            
            //حق ملاك
            TimeLineView(viewModel: TimeLineViewModel())
                .environmentObject(item)

//            ContentV()
//                .environmentObject(vm)
//                .task {
//                    await vm.requestDataScannerAccessStatus() //1) will be invoce first time user lunch the app, and from here will update (@Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined)
//                }

        }
    }
}


