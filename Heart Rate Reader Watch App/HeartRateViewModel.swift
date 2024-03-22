//
//  HeartRateViewModel.swift
//  Heart Rate Reader Watch App
//
//  Created by Saaketha Krishna on 18/01/24.
//

import Foundation
import HealthKit

class HeartRateViewModel: ObservableObject {
    @Published var heartRate = HKObjectType.quantityType(forIdentifier: .heartRate)
}
