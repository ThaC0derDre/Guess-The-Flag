//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Andres Gutierrez on 3/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScore        = false
    @State private var scoreTitle       = ""
    @State private var scoreLabel       = 0
    @State private var correctAnswer    = Int.random(in: 0...2)
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia", "Spain","UK","US"].shuffled()
    
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack (spacing: 40) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                ForEach(0..<3) { number in
                    Button {
                        checkAnswer(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("OK") {
                shuffleCountries()
            }
        }message: {
            Text("Score is \(scoreLabel)")
        }
    }
    
    
    func checkAnswer(_ number: Int) {
        scoreTitle = correctAnswer == number ? "correct" : "Wrong"
        if correctAnswer  == number {
            scoreTitle = "Correct"
            scoreLabel += 1
        }else {
            scoreTitle = "Wrong"
        }
        showScore = true
    }
    
    
    func shuffleCountries() {
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
