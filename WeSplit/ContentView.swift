//
//  ContentView.swift
//  WeSplit
//
//  Created by Denis Evdokimov on 5/20/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    private let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    var grandTotal: Double  {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Общий счет") {
                    TextField("Общий счет",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "RU"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Кол-во человек", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) ")
                        }
                    }
                    .pickerStyle(.navigationLink)
                   
                }
                Section("Какие чаевые оставляем") {
                   
                    Picker("Размер чаевых", selection: $tipPercentage) {
                        ForEach(0..<101, id: \ .self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Сумма на человека") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "RU"))
                }
                
                Section("Общая сумма чека с чаевыми") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "RU"))
                }
            }
            .navigationTitle("Делёжка")
            .toolbar(content: {
                if amountIsFocused {
                    Button {
                        amountIsFocused = false
                    } label: {
                        Text("Done")
                    }

                }
            })
        }
    }
}

#Preview {
    ContentView()
}
