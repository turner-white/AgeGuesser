//
//  ContentView.swift
//  ageGuesser
//
//  Created by Turner White on 9/15/22.
//

import SwiftUI

struct ContentView: View {
    let vm: AgeViewModel
    
    var body: some View {
        AgeView(name: "",vm:vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm:AgeViewModel())
    }
}
