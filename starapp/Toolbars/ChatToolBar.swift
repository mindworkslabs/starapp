import SwiftUI

struct ChatToolbar: View {
    @Binding var showingSheet: Bool
    
    var body: some View {
        HStack {
            Button(action: {
            }) {
                Label("Search", systemImage: "magnifyingglass")
            }
            Menu {
                Button(action: {
                    // Action 1
                }) {
                    Text("Give me a training plan")
                }
                Button(action: {
                    // Action 2
                }) {
                    Text("Maximize my recovery")
                }
                Button(action: {
                    // Action 3
                }) {
                    Text("Help me prevent injuries")
                }
            } label: {
                Label("AI", systemImage: "icloud.and.arrow.up.fill")
            }
        }
    }
}

#Preview {
    ChatToolbar(showingSheet: .constant(false))
}
