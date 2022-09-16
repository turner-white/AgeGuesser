//
//  AgeService.swift
//  ageGuesser
//
//  Created by Turner White on 9/15/22.
//

import Foundation

struct AgeResponse: Codable {
    let name: String
    let age: Int
    let count: Int
}

struct GenderResponse: Codable {
    let name: String
    let gender: String
    let probability: Double
    let count: Int
}

public final class ApiService: ObservableObject {
    
    func findAge(name: String) async -> AgeResponse {
        //print("Starting find age")
        guard let url = URL(string: "https://api.agify.io?name=\(name)") else {
            print("Wrong URL")
            return AgeResponse(name: "", age: 0, count: 0)
        }
        
        do {
            //print("Starting url session")
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(AgeResponse.self, from: data) {
                //print("response returned")
                //print(decodedResponse)
                return decodedResponse
            }
        } catch {
            print("Invalid data")
        }
        //print("Fell through")
        return AgeResponse(name: "", age: 0, count: 0)
    }
    
    func findGender(name: String) async -> GenderResponse {
        //print("Starting find age")
        guard let url = URL(string: "https://api.genderize.io?name=\(name)") else {
            print("Wrong URL")
            return GenderResponse(name: "", gender: "male", probability: 0.0, count: 0)
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(GenderResponse.self, from: data) {
                return decodedResponse
            }
        } catch {
            print("Invalid data")
        }
        return GenderResponse(name: "", gender: "male", probability: 0.0, count: 0)
    }
}
