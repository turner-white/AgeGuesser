//
//  ageGuesserApp.swift
//  ageGuesser
//
//  Created by Turner White on 9/15/22.
//

import SwiftUI

@main
struct ageGuesserApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AgeViewModel()
            ContentView(vm: viewModel)
        }
    }
}
