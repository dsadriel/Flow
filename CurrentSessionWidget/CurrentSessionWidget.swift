//
//  CurrentSessionWidget.swift
//  CurrentSessionWidget
//
//  Created by sofia leitao on 22/10/25.
//

import WidgetKit
import SwiftUI

// provider: define placeholder, snapshot e a timeline
struct Provider: AppIntentTimelineProvider {
    // exibida na galeria de widgets antes de carregar dados reais
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    //usado para preview rápido (ex.: na tela de seleção de widgets)
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    // devolve uma entrada e nao pedimos atualização automática (policy)
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        // Entrada única (sem variação ao longo do tempo)
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        // .never = o sistema não vai solicitar novas timelines sozinho
        return Timeline(entries: [entry], policy: .never)
    }
}

//dados que a View recebe para desenhar o widget
struct SimpleEntry: TimelineEntry {
    let date: Date                         // obrigatorio pelo protocolo (não vamos usar)
    let configuration: ConfigurationAppIntent // intent de configuração (não vamos usar)
}

//view
struct CurrentSessionWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.clear
            Text("Clique aqui e comece seu flow")
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding(.horizontal, 8)
        }
        //fundo padrão de widget que respeita o sistema (light/dark)
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

//widget = identidade + como ele é configurado
struct CurrentSessionWidget: Widget {
    let kind: String = "CurrentSessionWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            CurrentSessionWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Current Session")
        .description("Mostra um texto fixo convidando o usuário a iniciar o flow.")
        //famílias suportadas
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
