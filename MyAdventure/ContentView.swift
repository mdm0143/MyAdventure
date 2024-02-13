//
//  ContentView.swift
//  MyAdventure
//
//  Created by Micah Moore on 2/11/24.
//

import SwiftUI

class AdventureViewModel: ObservableObject {
    @Published var currentStep: AdventureStep = startAdventure  // This is your initial step

    func makeChoice(_ choice: Int) {
        if choice < currentStep.choices.count, let nextStep = currentStep.nextSteps[choice] {
            currentStep = nextStep
        } else {
            print("Invalid choice or end of the adventure.")
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel = AdventureViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        NavigationView {
            VStack {
               
                if verticalSizeClass == .compact {

                    ScrollView {
                        Text(viewModel.currentStep.description)
                            .padding()
                            .font(.body)
                    }
                } else {
                  
                    ScrollView {
                        Text(viewModel.currentStep.description)
                            .padding()
                            .font(.title)
                    }
                }
                
                LazyVStack {
                    ForEach(0..<viewModel.currentStep.choices.count, id: \.self) { index in
                        Button(action: {
                            viewModel.makeChoice(index)
                        }) {
                            Text(viewModel.currentStep.choices[index])
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarTitle("Adventure", displayMode: .inline)
        }
        
        .padding(horizontalSizeClass == .compact ? 0 : 20)
        .navigationViewStyle(StackNavigationViewStyle())  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


