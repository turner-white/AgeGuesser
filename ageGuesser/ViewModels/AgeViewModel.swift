//
//  AgeViewModel.swift
//  ageGuesser
//
//  Created by Turner White on 9/15/22.
//

import Foundation

private let defaultResponse = AgeResponse(name: "", age: -1, count: 0)
private let defaultResponse2 = GenderResponse(name: "", gender: "male", probability: 0.0, count: 0)

private let defaultIcon = "❓"

@MainActor public class AgeViewModel: ObservableObject {
    let apiService: ApiService
    @Published var ageResult = defaultResponse
    @Published var genderResult = defaultResponse2
    @Published var emoji = defaultIcon
    
    init() {
        apiService = ApiService()
    }
    public func resetInfo() {
        ageResult = defaultResponse
        emoji = defaultIcon
    }
    
    public func getInfo(name: String) async throws {
        //print("starting get age")
        await ageResult = apiService.findAge(name: name)
        await genderResult = apiService.findGender(name: name)
        //print("got age")
        if 0 < ageResult.age && ageResult.age < 6 {
            emoji = "👶"
        } else if 6 <= ageResult.age && ageResult.age < 21 {
            if genderResult.gender == "male" {
                emoji = "👦"
            } else {
                emoji = "👧"
            }
        } else if 21 <= ageResult.age && ageResult.age < 65 {
            if genderResult.gender == "male" {
                emoji = "👨"
            } else {
                emoji = "👩"
            }
        } else {
            if genderResult.gender == "male" {
                emoji = "👴"
            } else {
                emoji = "👵"
            }
        }
    }
}

