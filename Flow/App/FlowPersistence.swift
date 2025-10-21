//
//  FlowPersistence.swift
//  Flow
//
//  Created by Adriel de Souza on 21/10/25.
//

import SwiftData
import Foundation

actor FlowPersistence {
    static let shared = FlowPersistence()
    
    private var modelContext: ModelContext?
    
    private init() {}
    
    func initialize(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Create
    
    func insert(_ session: FlowSession) {
        guard let modelContext = modelContext else {
            print("Error: ModelContext not initialized")
            return
        }
        modelContext.insert(session)
        save()
    }
    
    // MARK: - Read
    
    func fetchAllSessions() -> [FlowSession] {
        guard let modelContext = modelContext else {
            print("Error: ModelContext not initialized")
            return []
        }
        
        let descriptor = FetchDescriptor<FlowSession>(
            sortBy: [SortDescriptor(\.start, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching sessions: \(error)")
            return []
        }
    }
    
    func fetchSessions(from startDate: Date, to endDate: Date) -> [FlowSession] {
        guard let modelContext = modelContext else {
            print("Error: ModelContext not initialized")
            return []
        }
        
        let predicate = #Predicate<FlowSession> { session in
            session.start >= startDate && session.start <= endDate
        }
        
        let descriptor = FetchDescriptor<FlowSession>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.start, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching sessions: \(error)")
            return []
        }
    }
    
    // MARK: - Update
    
    func update(_ session: FlowSession) {
        save()
    }
    
    // MARK: - Delete
    
    func delete(_ session: FlowSession) {
        guard let modelContext = modelContext else {
            print("Error: ModelContext not initialized")
            return
        }
        modelContext.delete(session)
        save()
    }
    
    // MARK: - Save
    
    private func save() {
        guard let modelContext = modelContext else {
            print("Error: ModelContext not initialized")
            return
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
