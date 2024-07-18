import SwiftUI
import SwiftData

@Model
class User {
    var id: UUID? // Optional unique identifier for the user
    var username: String?
    var tagName: String?
    var avatar: String?
    var tier: Int? // Optional tier property
    @Relationship(deleteRule: .cascade) var messages: [Message]?
    @Relationship(deleteRule: .cascade) var sessions: [Session]?
    
    init(id: UUID? = nil, username: String? = nil, tagName: String? = nil, avatar: String? = nil, tier: Int? = nil) {
        self.id = id
        self.username = username
        self.tagName = tagName
        self.avatar = avatar
        self.tier = tier
    }
}
