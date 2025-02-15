import SwiftUI

struct AccountView: View {
    @State private var deleteOffset: CGFloat = 0
    @State private var showDeleteAlert = false
    @State private var showingSheet = false
    @State private var startPositionPercentage: CGFloat = 0.025
    @State private var deleteUser = false
    @AppStorage("Notifications") var notificationsToggle: Bool = false
    @AppStorage("Pace") var paceToggle: Bool = false
    @AppStorage("Power") var powerToggle: Bool = false
    @AppStorage("Heartrate") var heartRateToggle: Bool = false
    @AppStorage("Distance") var distanceToggle: Bool = false

    var body: some View {
        ZStack {
            Color.starBlack.ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Toggle("Duration", isOn: $distanceToggle)
                    }
                    .padding()
                    .foregroundColor(.whiteOne)
                    .tint(.green)
                    HStack {
                        Toggle("Heartrate", isOn: $heartRateToggle)
                    }
                    .padding()
                    .foregroundColor(.whiteOne)
                    .tint(.green)
                    HStack {
                        Toggle("Pace", isOn: $paceToggle)
                    }
                    .padding()
                    .foregroundColor(.whiteOne)
                    .tint(.green)
                    HStack {
                        Toggle("Power", isOn: $powerToggle)
                    }
                    .padding()
                    .foregroundColor(.whiteOne)
                    .tint(.green)
                    HStack {
                        Toggle("Notifications", isOn: $notificationsToggle)
                    }
                    .padding()
                    .foregroundColor(.whiteOne)
                    .tint(.green)
                    
                }
                .padding()
                .background(Color.starBlack)
                .cornerRadius(16)

                GeometryReader { geometry in
                    let width = geometry.size.width
                    let sliderWidth = width - 40
                    let ballDiameter: CGFloat = 50
                    let maxOffsetPercentage: CGFloat = 0.86
                    let maxOffset = (sliderWidth - ballDiameter) * maxOffsetPercentage
                    let initialOffset = (sliderWidth - ballDiameter) * startPositionPercentage

                    VStack {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill({
                                    let progress = deleteOffset / maxOffset
                                    return Color.red.opacity(0.2 + progress * 0.9)
                                }())
                                .frame(height: 60)

                            Text("Slide to delete all data")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)

                            Circle()
                                .fill(Color.white)
                                .frame(width: ballDiameter, height: ballDiameter)
                                .offset(x: min(max(initialOffset, deleteOffset), maxOffset))
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let newOffset = min(max(initialOffset, initialOffset + value.translation.width), maxOffset)
                                            deleteOffset = newOffset
                                        }
                                        .onEnded { value in
                                            if deleteOffset > maxOffset * 0.95 {
                                                withAnimation {
                                                    deleteUser = true
                                                    deleteOffset = maxOffset
                                                    showDeleteAlert = true
                                                }
                                            } else {
                                                withAnimation {
                                                    deleteOffset = initialOffset
                                                }
                                            }
                                        }
                                )
                        }
                        .frame(height: 60)
                        .padding(.horizontal, 20)
                    }
                    .padding()
                    .background(Color.starBlack)
                    .cornerRadius(16)
                }
                .frame(height: 100)
            }
            .padding()
            .background(Color.starBlack)
            .cornerRadius(16)
            .onAppear {
                showingSheet = true
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete All Data"),
                    message: Text("Are you sure you want to delete all data? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        // Handle delete action
                    },
                    secondaryButton: .cancel {
                        withAnimation {
                            deleteOffset = 0
                        }
                    }
                )
            }
        }
    }
}

#Preview {
    AccountView()
}
