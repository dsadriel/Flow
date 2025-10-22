//
//  CurrentSessionWidgetBundle.swift
//  CurrentSessionWidget
//
//  Created by sofia leitao on 22/10/25.
//

import WidgetKit
import SwiftUI

@main
struct CurrentSessionWidgetBundle: WidgetBundle {
    var body: some Widget {
        CurrentSessionWidget()
        CurrentSessionWidgetControl()
        CurrentSessionWidgetLiveActivity()
    }
}
