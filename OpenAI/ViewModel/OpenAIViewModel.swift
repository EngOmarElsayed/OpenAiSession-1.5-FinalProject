//
//  OpenAIViewModel.swift
//  OpenAI
//
//  Created by Eng.Omar Elsayed on 05/12/2023.
//

import Foundation

@MainActor class OpenAIViewModel: ObservableObject {
    @Published var message = ""
    @Published var response = ""
    @Published var isloading = false
    
    let apiManger = APiManger.shared
}

extension OpenAIViewModel {
    func sendMessage() async throws {
        isloading = true
        response = ""
        do {
            let response = try await apiManger.makeRequest(message: message)
            TypoAnimation(for: response.choices[0].message.content)
        }catch{
            print(error.localizedDescription)
            self.response = "There is an error, please check your internat connection"
        }
        isloading = false
    }
}

extension OpenAIViewModel {
    private func TypoAnimation(for AiResponse: String) {
        var charindex = 0.0
        
        for letter in AiResponse {
            Timer.scheduledTimer(withTimeInterval: 0.02*charindex, repeats: false) { timer in // small number equale to fast writing
                if letter != "." {
                    self.response.append(letter)
                }
            }
            charindex += 1
        }
    }
}
