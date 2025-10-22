//
//  FlowWidgetBundle.swift
//  FlowWidget
//
//  Created by Adriel de Souza on 21/10/25.
//

import WidgetKit
import SwiftUI

@main
struct FlowWidgetBundle: WidgetBundle {
    var body: some Widget {
        FlowWidget()
        FlowActivityConfiguration()
    }
}
