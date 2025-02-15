import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var selectedTab: Int = 0
    @State private var searchText: String = ""
    @State private var showingSheet: Bool = false
    @State private var currentUser: User?

    var body: some View {
        ZStack {
            Color.starBlack.ignoresSafeArea()
            NavigationStack {
                Group {
                    if let user = currentUser {
                        TabView(selection: $selectedTab) {
                            HomeView()
                                .tabItem {
                                    Image(systemName: "sum")
                                    Text("Home")
                                }
                                .tag(0)
                            CalendarView()
                                .tabItem {
                                    Image(systemName: "calendar")
                                    Text("Calendar")
                                }
                                .tag(1)
                            LactateView()
                                .tabItem {
                                    Image(systemName: "dot.radiowaves.left.and.right")
                                    Text("Lactate")
                                }
                                .tag(2)
                            ChatView(user: user)
                                .tabItem {
                                    Image(systemName: "person.2")
                                    Text("Chat")
                                }
                                .tag(3)
                            MetricView()
                                .tabItem {
                                    Image(systemName: "chart.xyaxis.line")
                                    Text("Metrics")
                                }
                                .tag(4)
                        }
                        .tint(.starMain)
                    } else {
                        Text("Loading...")
                            .onAppear {
                                currentUser = UserService.fetchOrCreateUser(context: context)
                            }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        if let user = currentUser {
                            NavigationLink(destination: ProfileView(user: user)) {
                                Label("Profile", systemImage: "person.fill")
                            }
                        }
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        if let _ = currentUser {
                            switch selectedTab {
                            case 1:
                                CalendarToolbar(showingSheet: $showingSheet)
                            case 2:
                                LactateToolbar(showingSheet: $showingSheet)
                            case 3:
                                ChatToolbar(showingSheet: $showingSheet)
                            case 4:
                                MetricToolBar(showingSheet: $showingSheet)
                            default:
                                HomeToolBar(showingSheet: $showingSheet)
                            }
                        }
                    }
                }
                .tint(.whiteTwo)
            }
        }
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
