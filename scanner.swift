//
//  scanner.swift
//  MVVM_CK_TL
//
//  Created by frh alshaalan on 26/06/1444 AH.
//

import SwiftUI
import CTScanText

struct scanner: View {
    @State private var SacnneDdate = ""
    @State private var name = ""
    var body: some View {
        VStack{
            ScanTextField("Name", text: $name)
                .textContentType(.name)
                .keyboardType(.alphabet)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.red)
                .frame(height:30)
            
                .frame(height:30)
            VStack {
                
                ScanTextField("Date", text: $SacnneDdate)
                    .textContentType(.dateTime)
            }
            .frame(height: 60)    }
    }
}

struct scanner_Previews: PreviewProvider {
    static var previews: some View {
        scanner()
    }
}
