//
//  LactateHelper.swift
//  starapp
//
//  Created by Peter Tran on 26/07/2024.
//

import SwiftUI

enum LactateIntensity: String {
    case recovery = "Recovery"
    case light = "Light"
    case moderate = "Moderate"
    case hard = "Hard"
    case veryHard = "Very Hard"
    
    var icon: String {
        switch self {
        case .recovery: return "tortoise.fill"
        case .light: return "leaf.fill"
        case .moderate: return "wind"
        case .hard: return "flame.fill"
        case .veryHard: return "exclamationmark.triangle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .recovery: return .blue
        case .light: return .green
        case .moderate: return .yellow
        case .hard: return .orange
        case .veryHard: return .red
        }
    }
}

struct LactateHelper {
    static func intensity(for lactate: Double?) -> LactateIntensity {
        guard let lactate = lactate else { return .recovery }
        
        switch lactate {
        case ..<1.0: return .recovery
        case 1.0...1.5: return .light
        case 1.5...3.0: return .moderate
        case 3.0...4.9: return .hard
        default: return .veryHard
        }
    }
    
    static func color(for lactate: Double?) -> Color {
        guard let lactate = lactate else { return .whiteOne }
        return intensity(for: lactate).color
    }
}
