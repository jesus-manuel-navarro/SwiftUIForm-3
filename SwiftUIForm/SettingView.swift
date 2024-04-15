//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

struct SettingView: View {
    // esta variable
    @Environment(\.presentationMode) var presentationMode
    var settingStore: SettingStore // no la inicializamos porque vendra de algun sitio    private var displayOrders = [ "Alphabetical", "Show Favorite First", "Show Check-i n First"]
    /*  comento esto para el siguiente ejercicio porque para eso he echo el enum
    private var displayOrders = [ "Alphabetical", "Show Favorite First", "Show Check-in First"] */
    /* estas variables ahora no tienen sentido porque sino siempre se inicializan
    @State private var selectedOrder = 0
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    */
    
    @State private var selectedOrder = DisplayOrderType.alphabetical
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                Picker(selection: $selectedOrder, label: Text("Displayorder")) {
                } }
                ForEach(DisplayOrderType.allCases, id: \.self) {
                    orderType in
                    Text(orderType.text)
                }
                
                Section(header: Text("FILTER PREFERENCE")) {
                    Toggle(isOn: $showCheckInOnly) {
                        Text("Show Check-in Only")
                    }
                    
                    Stepper(onIncrement: {
                        self.maxPriceLevel += 1
                        
                        if self.maxPriceLevel > 5 {
                            self.maxPriceLevel = 5
                        }
                    }, onDecrement: {
                        self.maxPriceLevel -= 1
                        
                        if self.maxPriceLevel < 1 {
                            self.maxPriceLevel = 1
                        }
                    }) {
                        Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
                    }
                }
            }
            .onAppear{
            self.selectedOrder = self.settingStore.displayOrder
            self.showCheckInOnly = self.settingStore.showCheckInOnly
                
                self.maxPriceLevel = self.settingStore.maxPriceLevel
            }
            .navigationBarTitle("Settings")
            
            .navigationBarItems(leading:
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                })
                
                , trailing:

                Button(action: {
                
                self.settingStore.showCheckInOnly = self.showCheckInOnly
                                
                self.settingStore.displayOrder = self.selectedOrder
                
                self.settingStore.maxPriceLevel = self.maxPriceLevel
            
                
                self.presentationMode.wrappedValue.dismiss()
                
                
                }, label: {
                    Text("Save")
                        .foregroundColor(.black)
                })
            )
            
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(settingStore: SettingStore())    }
}
