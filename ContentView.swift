//
//  ContentView.swift
//  Moon
//
//  Created by Zach White on 4/12/23.
//
// Things to add: Double click or tap to type in desired time


import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            )
    }
}

struct ContentView: View {
    @State var remainingTime = 60.0 // Default time is 1 minute
    @State var initialRemainingTime = 60.0 // Initial remaining time is also 1 minute
    @State var timer: Timer?
    @State var isTimerRunning = false
    
    let maxTime = 21600.0 // Maximum time is 6 hours
    
    
    
    var body: some View {
        ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
            
            Text(timeString(time: remainingTime))
                .font(.system(size: 40, weight: .thin, design: .monospaced))
                .foregroundColor(.gray)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            // Adjust the time based on the drag direction and distance
                            let change = Double(value.translation.height) / -10
                            if change > 0 {
                                remainingTime = min(remainingTime + change, maxTime)
                            } else {
                                remainingTime = max(remainingTime + change, 0)
                            }
                        }
                )
            
           
            
            Circle()
                .stroke(Color.white, lineWidth: 1)
                .frame(width: 400, height: 300)
                .shadow(color: .gray, radius: 1, x: 3, y: -3)
                .shadow(color: .gray, radius: 1, x: 3, y: 3)
                
            
            Circle()
                .trim(from: 0.0, to: CGFloat(remainingTime / initialRemainingTime))
                .stroke(Color.blue, lineWidth: 4)
                .frame(width: 400, height: 300)
                //.shadow(color: .gray, radius: 1, x: 3, y: -3)
                .shadow(color: .gray, radius: 1, x: 3, y: 3)
                .rotationEffect(Angle(degrees: -90))
                //.animation(.linear(duration: 1.0)) // Add animation for stroke
                .animation(.linear, value: -1.0)
            
               
            
            
            VStack {
               
                Spacer()
                
                //.padding(.vertical, -15) // Add vertical padding
                //.padding(.horizontal, 10) // Add horizontal padding
                
                
                    
                 Spacer()
             
               
                
                
                HStack(spacing: 60) {
                    Button(action: {
                        if remainingTime > 0 && !isTimerRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }) {
                        
                        
                        Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.gray)
                            .padding(.vertical, -10) // Add vertical padding
                            .padding(.horizontal, 10) // Add horizontal padding
                            
                    }
                    .buttonStyle(SimpleButtonStyle())
                    .frame(maxHeight: 30) // set the frame height to maximum to avoid clipping
                    
                    Button(action: {
                        resetTimer()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .background(Color.clear)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            //.buttonStyle(SimpleButtonStyle())
                            //.shadow(color: .gray, radius: 5, x: 3, y: -3)
                            //.shadow(color: .gray, radius: 5, x: 3, y: 3)
                            .padding(.vertical, -10) // Add vertical padding
                            .padding(.horizontal, 10) // Add horizontal padding
                        
                            
                            
                            
                    }
                    .buttonStyle(SimpleButtonStyle())
                    .frame(maxHeight: 90) // set the frame height to maximum to avoid clipping
                    
                }
                .buttonStyle(.bordered)
                
                
                
        
            }
            
        }
        .foregroundColor(.white)
        //.background(Color.black.edgesIgnoringSafeArea(.all))
        .colorScheme(.dark)
        .preferredColorScheme(.light)
        
    }
    
   
    
    func startTimer() {
        isTimerRunning = true
        initialRemainingTime = remainingTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        remainingTime = initialRemainingTime
    }
    
    func timeString(time: Double) -> String {
        let hours = Int(time / 3600)
        let minutes = Int(time / 60) % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


struct ResetButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 30, height: 30)
            .foregroundColor(Color.white)
    }
}


struct PlayPauseButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 30, height: 30)
            .foregroundColor(Color.white)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
