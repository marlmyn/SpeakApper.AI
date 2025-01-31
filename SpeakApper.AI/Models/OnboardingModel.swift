//
//  OnboardingModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 30.01.2025.
//

import Foundation
import SwiftUI

struct OnboardingModel: Identifiable {
  var id = UUID()
  var image: String
  var title: String
  var headline: String?
  var description: [String]
}
