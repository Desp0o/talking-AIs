//
//  ContentView.swift
//  talking-AIs
//
//  Created by Despo on 27.06.25.
//

import SwiftUI

struct ContentView: View {
  @State private var vm = ViewModel()
  @State private var question: String = ""
  
  var body: some View {
    VStack {
      ScrollView {
        ForEach(vm.chat, id: \.id) { chat in
          VStack(alignment: .leading) {
            
            if let ans1 = chat.answer1 {
              HStack(alignment: .top) {
                Text("C-3PO: ")
                  .foregroundStyle(.red)
                  .fontWeight(.bold)
                Text(ans1)
                
                Spacer()
              }
              .onAppear {
                vm.sessionTwo(question: ans1)
              }
            }
            
            if let ans2 = chat.answer2 {
              HStack(alignment: .top) {
                Text("R2-D2: ")
                  .foregroundStyle(.black)
                  .fontWeight(.bold)
                Text(ans2)
                
                Spacer()
              }
              .onAppear {
                vm.sessionOne(question: ans2)
              }
            }
            
            Spacer()
              .frame(height: 20)
          }
        }
      }
      .scrollIndicators(.hidden)
      .defaultScrollAnchor(.bottom)
      
      if vm.chat.isEmpty {
        TextEditor(text: $question)
          .padding(10)
          .clipShape(RoundedRectangle(cornerRadius: 12))
          .overlay {
            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
          }
          .frame(maxHeight: 100)
          .scrollContentBackground(.hidden)
        
        Button("Start") {
          vm.sessionOne(question: question)
        }
        .buttonStyle(.glassProminent)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
    .background(.indigo.gradient)
    .animation(.smooth, value: vm.chat)
  }
}

#Preview {
  ContentView()
}
