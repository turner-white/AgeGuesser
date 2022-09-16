//
//  AgeView.swift
//  ageGuesser
//
//  Created by Turner White on 9/15/22.
//

import SwiftUI

private let defaultResponse = AgeResponse(name: "", age: 0, count: 0)

struct AgeView: View {
    @State var name: String
    @ObservedObject var vm: AgeViewModel
    @State var resetFlag:Bool = true
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(vm.emoji).font(.system(size: 200))
            if vm.ageResult.age < 0 {
                Text("Enter a name and press guess!").bold()
            }
            if vm.ageResult.age > 0 {
                Text("Your age is \(vm.ageResult.age)!").bold()
            }
            TextField("Enter name here", text: $name).textFieldStyle(.roundedBorder)
                .padding([.horizontal, .bottom])
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Button {
                resetFlag = false
                Task {
                    let () = try await vm.getInfo(name: name)
                }
            } label: { Text("Guess Age").padding(.vertical, 6)
                    .padding(.horizontal, 12)
                .foregroundColor(.white).background(.green)
            }.padding(.bottom).cornerRadius(20).padding(.top)
            Button {
                name = ""
                vm.resetInfo()
            } label: {Text("Reset Name")
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                .foregroundColor(.white).background(.blue)}.cornerRadius(20)
            Spacer()
        }.background(Color(red: 91/255, green: 180/255, blue: 243/255)).ignoresSafeArea()
    }
}

struct AgeView_Previews: PreviewProvider {
    static var previews: some View {
        AgeView(name:"",vm:AgeViewModel())
    }
}
