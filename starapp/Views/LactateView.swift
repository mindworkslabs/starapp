//
//  LactateView.swift
//  starapp
//
//  Created by Peter Tran on 07/07/2024.
//

import SwiftUI
import SwiftData

struct LactateView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Session.date) private var sessions: [Session]
    @State private var selectedSession: Session?
    @State private var showingSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.starBlack.ignoresSafeArea()
            if sessions.isEmpty {
                ContentUnavailableView("No Sessions Found", systemImage: "figure.run")
                    .foregroundStyle(.whiteOne)
            } else {
                List {
                    ForEach(sessions) { session in
                        Button(action: {
                            selectedSession = session
                            showingSheet = true
                        }) {
                            HStack(spacing: 20) {
                                Image(systemName: "figure.run")
                                    .font(.system(size: 38))
                                    .padding(8)
                                    .foregroundStyle(.starMain)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(session.distance ?? 0.0, specifier: "%.0f")K@\(session.duration ?? 0.0, specifier: "%.0f")'")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundStyle(.whiteTwo)
                                    HStack {
                                        Text("\(session.heartRate ?? 0)")
                                        Image(systemName: "heart.fill")
                                        Text(" | ")
                                        if let temperature = session.temperature {
                                            Text("\(temperature, specifier: "%.1f")°C")
                                        } else {
                                            Text("N/A")
                                        }
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray)
                                }
                                .foregroundStyle(.whiteOne)
                                Spacer()
                                if let lactate = session.lactate {
                                    Text("\(lactate, specifier: "%.1f") mM")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundStyle(.starMain)
                                } else {
                                    Text("N/A mM")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundStyle(.starMain)
                                }
                            }
                        }
                        .padding(.vertical, 10)
                        .background(Color.starBlack)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let session = sessions[index]
                            context.delete(session)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .sheet(item: $selectedSession) { session in
                    TrainingView(session: session)
                }
            }
        }
        .onAppear {
            //delete after finished layout
            if sessions.isEmpty {
                let mockSessions = [
                    Session(distance: 5.0, duration: 30.0, heartRate: 140, temperature: 38.2, lactate: 1.2, date: Date()),
                    Session(distance: 10.0, duration: 60.0, heartRate: 160, temperature: 39.0, lactate: 2.3, date: Date().addingTimeInterval(-86400)), // 1 day ago
                    Session(distance: 7.5, duration: 45.0, heartRate: 145, temperature: 39.6, lactate: 1.8, date: Date().addingTimeInterval(-172800)) // 2 days ago
                ]
                
                for session in mockSessions {
                    context.insert(session)
                }
            }
        }
    }
}

#Preview {
    LactateView()
        .modelContainer(for: Session.self, inMemory: true)
}
