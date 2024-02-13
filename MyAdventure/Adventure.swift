//
//  Adventure.swift
//  MyAdventure
//
//  Created by Micah Moore on 2/12/24.
//

import Foundation

import Foundation

struct AdventureStep {
    let description: String
    let choices: [String]
    let nextSteps: [AdventureStep?]
}

struct Adventure {
    var currentStep: AdventureStep
    
    mutating func makeChoice(_ choice: Int) {
        if choice < currentStep.choices.count, let nextStep = currentStep.nextSteps[choice] {
            currentStep = nextStep
        } else {
            print("Invalid choice or end of the adventure.")
        }
    }
    
    func getCurrentStep() -> AdventureStep {
        return currentStep
    }
}

// Define the final outcomes for the third layer
let summitSuccess = AdventureStep(
    description: "You've reached the Shrouded Summit and discovered the lost city! The view is breathtaking, and the ancient treasures are all yours.",
    choices: [],
    nextSteps: []
)

let summitFailure = AdventureStep(
    description: "You took a risky path and got caught in a storm. Unfortunately, you have to turn back without reaching the summit.",
    choices: [],
    nextSteps: []
)

// Define the second layer of choices
let takeShelter = AdventureStep(
    description: "The weather is turning bad. Do you take shelter in a nearby cave, or press on and try to reach the summit before the storm hits?",
    choices: ["Take shelter", "Press on"],
    nextSteps: [summitFailure, summitSuccess]
)

let pathFork = AdventureStep(
    description: "The path forks. One side leads to a steep climb, while the other side winds through a dense forest. Which do you choose?",
    choices: ["Steep climb", "Dense forest"],
    nextSteps: [summitSuccess, summitFailure]
)

// Define the first layer after hiring a guide or going alone
let hireGuide = AdventureStep(
    description: "You've hired a skilled local guide. She offers to take you on a less known but supposedly quicker path. Do you trust her?",
    choices: ["Trust the guide", "Stick to the main path"],
    nextSteps: [takeShelter, pathFork]
)

let goAlone = AdventureStep(
    description: "You decide to go alone, trusting your instincts and the map you have. As you walk, you encounter a river. Do you follow it, or continue based on your map?",
    choices: ["Follow the river", "Trust the map"],
    nextSteps: [pathFork, takeShelter]
)

// Define the initial step
let startAdventure = AdventureStep(
    description: "You stand before the Shrouded Summit, your map in hand. The peak is hidden by clouds and mystery. Do you hire a local guide to assist you, or do you brave the unknown alone?",
    choices: ["Hire a guide", "Go alone"],
    nextSteps: [hireGuide, goAlone]
)

// Initialize the adventure
var myAdventure = Adventure(currentStep: startAdventure)
