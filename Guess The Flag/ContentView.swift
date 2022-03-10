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
    @State private var incorrectGuess   = ""
    @State private var correctUser      = false
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia", "Spain","UK","US"].shuffled()
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack (spacing: 40) {
                HStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                Text("Score: \(scoreLabel)")
                        .foregroundColor(.white)
                    Spacer()
                }
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                Spacer()
                ForEach(0..<3) { number in
                    Button {
                        checkAnswer(number)
                        if scoreTitle != "Correct" {
                            correctUser = true
                            incorrectGuess = countries[number]
                        }
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                    
                }
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("OK") {
                shuffleCountries()
                correctUser = false
            }
        }message: {
            if correctUser {
                Text("You selected the flag for \(incorrectGuess)!")
            }
            Text("Score is \(scoreLabel)")
        }
    }
    
    
    func checkAnswer(_ number: Int) {
        if correctAnswer  == number {
            scoreTitle = "Correct"
            scoreLabel += 1
        }else {
            scoreTitle = "Wrong"
            incorrectGuess = countries[number]
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
