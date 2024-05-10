//
//  GuessTheFlagView.swift
//  GuessTheFlag
//
//  Created by Amulya Gangam on 5/9/24.
//

import SwiftUI

struct GuessTheFlagView: View {
   @State private var countries = ["Estonia","France", "Germany", "Ireland", "Italy", "Monaco", "Monaco", "Nigeria", "Poland", "Spain", "UK","Ukraine", "US"].shuffled()
   @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var showingQuitView = false
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green.opacity(0.8), .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 30) {
                    HStack {
                        Text("Tap the flag of")
                            .font(.largeTitle.weight(.semibold))
                            .fontDesign(.serif)
                            .shadow(color: .green, radius: 12, x: 0, y: 0)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .fontDesign(.serif)
                            .shadow(color: .green, radius: 12, x: 0, y: 0)
                    }
                    
                    ForEach(0..<3) { index in
                        Button {
                            
                            flagTapped(index)
                            
                        } label: {
                            Image(countries[index])
                        }
                        
                    }
                }
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
            Button("Quit") {
                showingQuitView = true
            }
        } message: {
            Text("Your score is \(score)")
        }
        .fullScreenCover(isPresented: $showingQuitView) {
            QuitView(score: score, onDismiss: {
                showingQuitView = false
                askQuestion()
            })
        }
        
    }
    
    func flagTapped(_ num: Int) {
        if num == correctAnswer {
            scoreTitle = "Correct answer"
            score += 1
        }
        else {
            scoreTitle = "Wrong answer"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        
    }
}

struct QuitView: View {
     var score: Int
    @State var navigateToGame = true
    var onDismiss: () -> Void
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(colors: [
                    .purple.opacity(0.7),
                    .blue.opacity(0.8),
                    .cyan.opacity(0.9),
                    .green.opacity(4.8),
                    .yellow.opacity(5.0),
                    .orange.opacity(4.8),
                    .red.opacity(0.7)
                ]),
                center: .center
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack {
                    Text("Had fun???")
                        .bold()
                        .font(.largeTitle)
                        .shadow(color: .red, radius: 0.4, x: 0,y: 0)
                }
                HStack {
                    Text("Your total score is")
                        .foregroundStyle(.white)
                        .fontDesign(.serif)
                        .font(.headline.weight(.heavy))
                    Text("\(score)")
                        .foregroundStyle(.white)
                }
                .padding(60)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                
                Button("Wanna play again?", systemImage: "arrowshape.turn.up.forward.fill") {
                    onDismiss()
                }
                .foregroundStyle(.white)
                .buttonStyle(.plain)
                
            }
        }
    }
}

#Preview {
    GuessTheFlagView()
}
