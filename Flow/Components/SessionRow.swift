//
//  SessionRow.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftUI

struct SessionRow: View {
    let session: FlowSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(session.start, style: .date)
                    .font(.headline)
                Spacer()
                Text(formatDuration(session.duration ?? 0))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text(session.start, style: .time)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                if let end = session.end {
                    Image(systemName: "arrow.right")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                    Text(end, style: .time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            if let note = session.note, !note.isEmpty {
                Text(note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else if minutes > 0 {
            return "\(minutes)m"
        } else {
            let seconds = Int(duration) % 60
            return "\(seconds)s"
        }
    }
}

#Preview {
    SessionRow(session: .init())
}
