//
//  APiManger.swift
//  OpenAI
//
//  Created by Eng.Omar Elsayed on 05/12/2023.
//

import Foundation

class APiManger {
    let apiKey = "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" // your api key.
    let urlString = "https://api.openai.com/v1/chat/completions" // api url
    static let shared = APiManger()
}

extension APiManger {
    
    private func ConfigureURLSession(for url: URL, message: String) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        let usermessage = UserMessage(content: message)
        let request = RequestData(model: "gpt-3.5-turbo", messages: [usermessage])
        let body = JSONEncoder().Encode(request)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    func makeRequest(message: String) async throws -> AiResponse {
        guard let url = URL(string: urlString) else {throw String.errorInURL}
        
        let request = ConfigureURLSession(for: url, message: message)
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard (response as! HTTPURLResponse).statusCode == 200 else {
            throw String.serverError.localizedDescription
        }
        
        return try JSONDecoder().decode(AiResponse.self, from: data)
    }
    
}
