//
//  CalendarEventView.swift
//  starapp
//
//  Created by Peter Tran on 07/07/2024.
//

import SwiftUI

struct CalendarEventView: View {
    //@StateObject private var viewModel = CalendarEventViewModel()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var distance: Double?
    @State private var duration: Double?
    @State private var lactate: Double?
    @State private var selectedDate = Date()
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.zeroSymbol = ""
        return formatter
    }
    
    var body: some View {
        ZStack {
            Color.starBlack.ignoresSafeArea()
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .colorScheme(.dark)
                    .padding()
                    .background(Color.starBlack)
                    .cornerRadius(5)
                // Distance
                HStack{
                    Text("Distance")
                        .foregroundStyle(.whiteOne)
                    Spacer()
                    ZStack(alignment: .leading) {
                        TextField("Kilometer", value: $distance, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                            .foregroundStyle(.whiteTwo)
                        
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(maxWidth: 150)
                }
                .padding()
                
                // Duration
                HStack{
                    Text("Duration")
                        .foregroundStyle(.whiteOne)
                    Spacer()
                    ZStack(alignment: .leading) {
                        TextField("Minutes", value: $duration, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                            .foregroundStyle(.whiteTwo)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(maxWidth: 150) // Adjust the width as needed
                }
                .padding()
                
                // Lactate
                HStack{
                    Text("Lactate")
                        .foregroundStyle(.whiteOne)
                    Spacer()
                    ZStack(alignment: .leading) {
                        TextField("mM", value: $lactate, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                            .foregroundStyle(.whiteTwo)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(maxWidth: 150) // Adjust the width as needed
                }
                .padding()
                
                Button("Save") {
                    let newSession = Session(
                        distance: distance ?? 0.0,
                        duration: duration ?? 0.0,
                        lactate: lactate ?? 0.0
                    )
                    context.insert(newSession)
                    dismiss()
                }
                .foregroundColor(.starMain)
                .padding()
            }
            .background(Color.starBlack)
            .padding()
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    CalendarEventView()
}
