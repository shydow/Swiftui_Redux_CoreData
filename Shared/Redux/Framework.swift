//
//  Framework.swift
//  Akeso
//
//  Created by Shydow Lee on 7/1/21.
//

import Foundation
import Combine


typealias Reducer<State, Action> = (State, Action) -> State

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>

class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    
    private let queue = DispatchQueue(label: "com.tangpian.Sample", qos: .userInitiated)
    private var subscriptions: Set<AnyCancellable> = []
    
    init(
      initial: State,
      reducer: @escaping Reducer<State, Action>,
      middlewares: [Middleware<State, Action>] = []
    ) {
      self.state = initial
      self.reducer = reducer
      self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action) {
      queue.sync {
        self.dispatch(self.state, action)
      }
    }
    
    private func dispatch(_ currentState: State, _ action: Action) {
      // generate a new state using the reducer
      let newState = reducer(currentState, action)

      // pass the new state and action to all the middlewares
      // if they publish an action dispatch pass it to the dispatch function
      middlewares.forEach { middleware in
        let publisher = middleware(newState, action)
        publisher
          .receive(on: DispatchQueue.main)
          .sink(receiveValue: dispatch)
          .store(in: &subscriptions)
      }

      // Finally set the state to the new state
      state = newState
    }
}
