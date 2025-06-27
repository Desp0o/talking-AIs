//
//  ViewModel.swift
//  talking-AIs
//
//  Created by Despo on 27.06.25.
//


import FoundationModels
import Observation
import Foundation

@MainActor
@Observable
final class ViewModel {
  var chat: [PromptModel] = []
  var result: PromptModel? = nil
  
  func sessionOne(question: String) {
    let session = LanguageModelSession()
    let prompt = """
    You are one participant in a dialogue. Respond to the following message with a short and natural reply. Don't feel obligated to agree — share your own view confidently, and steer the conversation forward. Avoid repeating the previous point; instead, add a fresh perspective, connect a new idea, or raise an interesting question:

    \(question)
    """
    
    Task {
      defer {
        
      }
      
      do {
        let response = try await session.respond(to: prompt )
        
        let bot = PromptModel(answer1: response.content)
        chat.append(bot)
      } catch {
        print("❌", error)
      }
    }
  }
  
  func sessionTwo(question: String) {
    let session = LanguageModelSession()
    
    let prompt = """
    You are the second participant in a dialogue. Respond to the following message with a short and natural reply. If you disagree, do not hesitate to express your opinion. Stay respectful, but don't agree just to be polite — stand by your perspective and explain briefly why. Avoid repeating ideas or staying on the same topic; instead, challenge, question, or redirect the conversation naturally:

    \(question)
    """
    
    Task {
      do {
        let response = try await session.respond(to: prompt )
        
        
        let bot = PromptModel(answer2: response.content)
        chat.append(bot)
      } catch {
        print("❌", error)
      }
    }
  }
}

struct PromptModel: Equatable {
  let id = UUID()
  let answer1: String?
  let answer2: String?
  
  init(answer1: String? = nil, answer2: String? = nil) {
    self.answer1 = answer1
    self.answer2 = answer2
  }
}
