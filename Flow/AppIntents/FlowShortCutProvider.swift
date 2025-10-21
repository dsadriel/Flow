//
//  ShortCutProvider.swift
//  Flow
//
//  Created by Vítor Bruno on 21/10/25.
//

import Foundation
import AppIntents

struct FlowShortCutProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        
        //MARK: Start Session shortcut
        AppShortcut(
            intent: StartSessionIntent(),
            phrases: [
                //English
                "Start new session on \(.applicationName)",
                "Start a session on \(.applicationName)",
                "Run session on \(.applicationName)",
                "Session on \(.applicationName)",
                //portuguese
                "Começar nova sessão no \(.applicationName)",
                "Começar sessão no \(.applicationName)",
                "Nova sessão no \(.applicationName)"
            ],
            shortTitle: "Start session",
            systemImageName: "timer.circle"
        )
        
        //MARK: End session shortcut
        AppShortcut(
            intent: EndSessionIntent(),
            phrases: [
                //English
                "End curretn session on \(.applicationName)",
                "Finish curretn session on \(.applicationName)",
                "Cancel curretn session on \(.applicationName)",
                "Finish session on \(.applicationName)",
                "End session on \(.applicationName)",
                //Portuguese
                "Terminar sessão no \(.applicationName)"
            ],
            shortTitle: "End session",
            systemImageName: "xmark.circle",
        )
        
        //MARK: Pause session shortcut
        AppShortcut(
            intent: PauseSessionIntent(),
            phrases: [
                //English
                "Pause the current session on \(.applicationName)",
                "Pause session on \(.applicationName)",
                "Pause on \(.applicationName)",
                //Poruguese
                "Pausar sessão atual no \(.applicationName)",
                "Pausar sessão no \(.applicationName)"
            ],
            shortTitle: "Pause session",
            systemImageName: "pause.circle"
        )
        
        //MARK: Resume session shortcut
        AppShortcut(
            intent: ResumeSessionIntent(),
            phrases: [
                //English
                "Resume session on \(.applicationName)",
                "Resume current session o \(.applicationName)",
                //Portuguese
                "Despausar sessão no \(.applicationName)",
                "Despausar sessão atual no \(.applicationName)",
                "Retomar sessão atual no \(.applicationName)",
                "Retomar sessão no \(.applicationName)"
            ],
            shortTitle: "Resume session",
            systemImageName: "play.circle"
        )
        
        //MARK: Start a session with a note
        AppShortcut(
            intent: StartSessionWithNote(),
            phrases: [
                //English
                "Start session with note on \(.applicationName)",
                "Run session with note on \(.applicationName)",
                "Start new session with note on \(.applicationName)",
                "Run new session with note on \(.applicationName)",
                //portuguese
                "Começar sessão com nota no \(.applicationName)",
                "Iniciar sessão com nota no \(.applicationName)"
            ],
            shortTitle: "Start with note",
            systemImageName: "clipboard"
        )
        
    }
}
