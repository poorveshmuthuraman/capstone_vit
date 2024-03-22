//
//  ExcerciseView.swift
//  Heart Rate Reader Watch App
//
//  Created by Saaketha Krishna on 27/01/24.
//

import SwiftUI
import HealthKit

struct ExcerciseView: View {
    @State var value: Double = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 0
    @State var heartEmoji = "❤️"
    @State var bpmText = "BPM"
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    Text(heartEmoji)
                        .font(.system(size: 50))
                    
                    Text("\(timeRemaining) seconds")
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                    Spacer()
                }
                
                HStack{
                    Text("\(Int(value))")
                        .fontWeight(.regular)
                        .font(.system(size: 70))
                    
                    Text(bpmText)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .padding(.bottom, 28.0)
                    Spacer()
                }
            }
            .padding()
            .onReceive(timer, perform: { time in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    //print(timeRemaining % 30)
                    if (timeRemaining % 30) == 0 && (timeRemaining > 0) {
                        heartEmoji = "💖"
                        bpmText = "Just keep breathing 😮‍💨"
                        DispatchQueue.main.async {
                            WKInterfaceDevice.current().play(.success)
                        }
                    } else if timeRemaining == 0 {
                        bpmText = "You're done 🥳"
                    } else {
                        heartEmoji = "❤️"
                        bpmText = "BPM"
                    }
                }
            })
            
            
        }
    }
    
    private func getHeartRate() {
            let healthStore = HKHealthStore()
            let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
            let date = Date()
            let predicate = HKQuery.predicateForSamples(withStart: date.addingTimeInterval(-60), end: date, options: .strictEndDate)
            let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
                guard let result = result, let quantity = result.averageQuantity() else {
                    return
                }
                self.value = quantity.doubleValue(for: HKUnit(from: "count/min"))
            }
            healthStore.execute(query)
        }
}

#Preview {
    ExcerciseView(timeRemaining: 3)
}
