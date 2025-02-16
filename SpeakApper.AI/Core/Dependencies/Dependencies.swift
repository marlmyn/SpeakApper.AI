//
//  Dependencies.swift
//  SpeakApper.AI
//
//  Created by Daniyar Merekeyev on 16.02.2025.
//

import Foundation

final class Dependencies {
    private let network: Networking
    
    init() {
        self.network = Network()
    }
}
