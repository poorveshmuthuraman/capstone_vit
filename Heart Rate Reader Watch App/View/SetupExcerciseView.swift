//
//  SetupExcerciseView.swift
//  Heart Rate Reader Watch App
//
//  Created by Saaketha Krishna on 27/01/24.
//

import SwiftUI

enum ExerciseMinutes: Int, CaseIterable, Identifiable {
    case ThreeMinutes = 3
    case FiveMinute = 5
    case TenMinute = 10
    
    var id: Self { self }
}

struct SetupExcerciseView: View {
    @State var moveToExcersiceView = false
    @State var exerciseTime = ExerciseMinutes.ThreeMinutes
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $exerciseTime) {
                    ForEach(ExerciseMinutes.allCases) { minute in
                        Text("\(minute.rawValue) minutes")
                    }
                }
                .foregroundStyle(.white)
                
                Button {
                    moveToExcersiceView = true
                } label: {
                    Text("Start")
                }
                .padding(.horizontal)
            }
            .navigationTitle("Setup Exercise Time")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $moveToExcersiceView) {
                ExcerciseView(timeRemaining: 60*exerciseTime.rawValue)
            }
        }
    }
}

#Preview {
    SetupExcerciseView()
}
