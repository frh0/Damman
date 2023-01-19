//
//  ContentView.swift
//  MVVM_CK_TL
//
//  Created by Malak  on 24/05/1444 AH.
//

import Foundation
import SwiftUI
import AVKit
import VisionKit
import CoreML
struct ContentView: View {
  
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                        .frame(width: 300, height: 300)
                } else {
                    Image(systemName: "photo.artframe")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                            }
                
          
                
                //Button("Camera") {
                  //  self.sourceType = .camera
                   // self.isImagePickerDisplay.toggle()
               // }.padding()
                Button("Camera") {
                              self.sourceType = .camera
                              self.isImagePickerDisplay.toggle()
                          }.padding()
                
                Button("Photo Library") {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }.padding()
            }
            .navigationBarTitle("Item image")
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            
        }
    }
}
