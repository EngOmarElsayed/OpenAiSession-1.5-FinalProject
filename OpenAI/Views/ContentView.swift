//
//  ContentView.swift
//  OpenAI
//
//  Created by Eng.Omar Elsayed on 05/12/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: OpenAIViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in // proxy reades the size of the scroll view
                    Image(systemName: "globe") // OpenAI Logo
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .padding()
                    
                    VStack(alignment: .leading){
                        TextField("Ask Anything OpenAI", text: $viewModel.message)
                            .fontDesign(.monospaced)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 0.4)
                                    .foregroundStyle(.white)
                            }
                            .onSubmit {
                                Task {
                                    try await viewModel.sendMessage()
                                }
                            }
                        HStack(alignment: .firstTextBaseline) {
                            Text("AI: ")
                                .foregroundStyle(.white)
                                .fontDesign(.monospaced)
                                .padding(.vertical)
                            
                            Text(viewModel.response)
                                .foregroundStyle(.white)
                                .fontDesign(.monospaced)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical)
                                .id("response")
                                .onChange(of: viewModel.response, {
                                    proxy.scrollTo("response", anchor: .bottom)
                                })
                                .overlay {
                                    if viewModel.isloading {
                                        circuleAnimationView()
                                    }
                                }
                            
                        }
                    }
                }
            }
        }.padding()
        
    }
}

#Preview {
    ContentView()
        .environmentObject(OpenAIViewModel())
}
