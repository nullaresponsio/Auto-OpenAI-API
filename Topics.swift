
//
//  Topics.swift
//  Swift_programming_with_XCode_tutor
//  Updated 7/26/25 – Major expansion of Swift, SwiftUI & Xcode topics
//

import Foundation
import SwiftUI

// MARK: - Master list of all teachable / quizzable subjects
enum Topic: String, CaseIterable, Hashable, Identifiable {

    // ─────────────────── Swift fundamentals ───────────────────
    case variableKeyword, constantKeyword, optionals, closures, structsVsClasses, protocols
    case generics, functions, enums, errorHandling, accessControl, memoryManagement
    case extensionsFeature, properties, subscripts
    case guardStatement, deferStatement, lazyKeyword, typealiasKeyword
    case stringInterpolation, tuples, collections, controlFlow                       // NEW

    // ─────────────────── Advanced language ────────────────────
    case concurrency, propertyWrappers, resultBuilders, actors, distributedActors, asyncLet, taskGroups
    case macros, asyncSequence, patternMatching, typeInference, codable
    case opaqueTypes, existentialTypes, moveOnlyTypes, unsafePointers                // NEW

    // ─────────────────── SwiftUI ───────────────────────────────
    case swiftUI, viewModifiers, navigationStack
    case animations, gestures, environmentValues, stateManagement                   // NEW

    // ─────────────────── Tooling & packages ────────────────────
    case swiftPackageManager, docc, swiftPlaygrounds
    case swiftLint                                                                     // NEW

    // ─────────────────── Xcode  ────────────────────────────────
    case xcodeProject, interfaceBuilder, xcodeDebugger, unitTesting, instruments, buildSettings
    case sourceControl, signingCapabilities, previews, xcodeCloud, simulators
    case memoryGraphDebugger, testFlight
    case codeSnippets, localization, assetCatalogs, refactoring, quickHelp            // NEW

    var id: String { rawValue }
}

// MARK: - Human-readable titles
extension Topic {
    var title: String {
        switch self {

        // Swift fundamentals
        case .variableKeyword:        return "Variables"
        case .constantKeyword:        return "Constants"
        case .optionals:              return "Optionals"
        case .closures:               return "Closures"
        case .structsVsClasses:       return "Structs vs Classes"
        case .protocols:              return "Protocols"
        case .generics:               return "Generics"
        case .functions:              return "Functions"
        case .enums:                  return "Enums"
        case .errorHandling:          return "Error Handling"
        case .accessControl:          return "Access Control"
        case .memoryManagement:       return "Memory Management"
        case .extensionsFeature:      return "Extensions"
        case .properties:             return "Properties"
        case .subscripts:             return "Subscripts"
        case .guardStatement:         return "`guard` Statement"
        case .deferStatement:         return "`defer` Statement"
        case .lazyKeyword:            return "`lazy` Properties"
        case .typealiasKeyword:       return "`typealias`"
        case .stringInterpolation:    return "String Interpolation"
        case .tuples:                 return "Tuples"
        case .collections:            return "Collections"
        case .controlFlow:            return "Control Flow"

        // Advanced language
        case .concurrency:            return "Concurrency"
        case .propertyWrappers:       return "Property Wrappers"
        case .resultBuilders:         return "Result Builders"
        case .actors:                 return "Actors"
        case .distributedActors:      return "Distributed Actors"
        case .asyncLet:               return "async let"
        case .taskGroups:             return "Task Groups"
        case .macros:                 return "Macros"
        case .asyncSequence:          return "AsyncSequence"
        case .patternMatching:        return "Pattern Matching"
        case .typeInference:          return "Type Inference"
        case .codable:                return "Codable"
        case .opaqueTypes:            return "Opaque Types"
        case .existentialTypes:       return "Existential Types"
        case .moveOnlyTypes:          return "Move-only Types"
        case .unsafePointers:         return "Unsafe Pointers"

        // SwiftUI
        case .swiftUI:                return "SwiftUI"
        case .viewModifiers:          return "View Modifiers"
        case .navigationStack:        return "NavigationStack"
        case .animations:             return "Animations"
        case .gestures:               return "Gestures"
        case .environmentValues:      return "Environment Values"
        case .stateManagement:        return "State Management"

        // Tooling & packages
        case .swiftPackageManager:    return "Swift Package Manager"
        case .docc:                   return "DocC"
        case .swiftPlaygrounds:       return "Swift Playgrounds"
        case .swiftLint:              return "SwiftLint"

        // Xcode
        case .xcodeProject:           return "Xcode Project"
        case .interfaceBuilder:       return "Interface Builder"
        case .xcodeDebugger:          return "Xcode Debugger"
        case .unitTesting:            return "Unit Testing"
        case .instruments:            return "Instruments"
        case .buildSettings:          return "Build Settings"
        case .sourceControl:          return "Source Control"
        case .signingCapabilities:    return "Signing & Capabilities"
        case .previews:               return "Previews"
        case .xcodeCloud:             return "Xcode Cloud"
        case .simulators:             return "Simulators"
        case .memoryGraphDebugger:    return "Memory Graph Debugger"
        case .testFlight:             return "TestFlight"
        case .codeSnippets:           return "Code Snippets"
        case .localization:           return "Localization"
        case .assetCatalogs:          return "Asset Catalogs"
        case .refactoring:            return "Refactoring"
        case .quickHelp:              return "Quick Help"
        }
    }
}

extension Topic { static var modularAddition: Topic { .variableKeyword } }

// MARK: - Short explanations (Markdown allowed)
struct TopicExplanations {
    private static let map: [Topic: String] = [

        // Swift fundamentals
        .variableKeyword:     "**Variables** are declared with `var` and are mutable.",
        .constantKeyword:     "**Constants** are declared with `let` and are immutable.",
        .optionals:           "**Optionals** (`?`) allow a value to be either a type value or `nil`; they must be safely unwrapped.",
        .closures:            "**Closures** are self-contained blocks of functionality that can capture surrounding context.",
        .structsVsClasses:    "**Structs** are value types; **classes** are reference types that support inheritance.",
        .protocols:           "**Protocols** declare a blueprint of requirements adopted by conforming types.",
        .generics:            "**Generics** let you write flexible, reusable code that works with any type.",
        .functions:           "`func` defines reusable code blocks that may take parameters and return values.",
        .enums:               "**Enums** group related cases into a single type and can store associated values.",
        .errorHandling:       "Swift **error handling** uses `throw`, `throws`, `try`, `catch`, and `rethrows`.",
        .accessControl:       "Five levels—`open`, `public`, `internal`, `fileprivate`, `private`—govern **access control**.",
        .memoryManagement:    "**Automatic Reference Counting (ARC)** tracks strong references to deallocate objects.",
        .extensionsFeature:   "**Extensions** add new functionality to an existing type without subclassing.",
        .properties:          "**Stored** and **computed** properties hold or derive values; property observers run code on change.",
        .subscripts:          "`subscript` exposes index-like access (e.g., `matrix[row, col]`).",
        .guardStatement:      "`guard` performs early-exit validation that must succeed for execution to proceed.",
        .deferStatement:      "`defer` schedules code to run just before scope exits—handy for cleanup.",
        .lazyKeyword:         "`lazy` postpones property initialization until first access.",
        .typealiasKeyword:    "`typealias` assigns a new, usually shorter or context-specific name to an existing type.",
        .stringInterpolation: "**String interpolation** embeds expressions inside `\"\\(…)\"` literals for type-safe formatting.",
        .tuples:              "**Tuples** group multiple values into a single compound value `(x, y)` without creating a struct.",
        .collections:         "Arrays, sets, and dictionaries are the core **collection** types, each with value semantics.",
        .controlFlow:         "`if`, `guard`, `switch`, `for-in`, `while`, and `repeat-while` make up Swift **control flow**.",

        // Advanced language
        .concurrency:         "Structured **concurrency** uses `async`/`await`, tasks, actors, and task groups.",
        .propertyWrappers:    "`@propertyWrapper` types encapsulate get/set logic reusable on any property.",
        .resultBuilders:      "Compile-time **result builders** convert block syntax to method chains (e.g., SwiftUI).",
        .actors:              "**Actors** are reference types that protect mutable state from data races.",
        .distributedActors:   "**Distributed actors** extend actors across process or network boundaries.",
        .asyncLet:            "`async let` launches child tasks and awaits their results later.",
        .taskGroups:          "**Task groups** spawn dynamic sets of child tasks while aggregating errors and results.",
        .macros:              "**Macros** generate or transform code at compile time, reducing boilerplate.",
        .asyncSequence:       "`AsyncSequence` delivers values over time and is consumed with `for await`.",
        .patternMatching:     "**Pattern matching** (`switch`, `if case`, `guard case`) destructures and tests values.",
        .typeInference:       "The compiler performs **type inference**, letting you omit obvious type annotations.",
        .codable:             "`Codable` combines `Encodable` & `Decodable` for easy JSON and plist serialization.",
        .opaqueTypes:         "`some Type` declares an **opaque return type** whose concrete type is hidden.",
        .existentialTypes:    "An **existential** (e.g., `any Collection`) erases the concrete type behind a protocol.",
        .moveOnlyTypes:       "**Move-only types** (upcoming) allow values that cannot be implicitly copied, enabling safe ownership transfer.",
        .unsafePointers:      "`UnsafePointer` / `UnsafeMutablePointer` expose raw memory—useful but dangerous.",

        // SwiftUI
        .swiftUI:             "**SwiftUI** is a declarative, data-driven UI framework across Apple platforms.",
        .viewModifiers:       "**View modifiers** are chainable methods that return a new, styled or behavioral view.",
        .navigationStack:     "`NavigationStack` provides type-safe, data-driven navigation and deep-linking.",
        .animations:          "Implicit and explicit **animations** interpolate view properties over time.",
        .gestures:            "High-level **gestures** like `TapGesture` and `DragGesture` add interactivity.",
        .environmentValues:   "`@Environment` & `EnvironmentValues` inject global app data (e.g., colorScheme).",
        .stateManagement:     "`@State`, `@Binding`, `@ObservedObject`, `@StateObject`, and `@EnvironmentObject` drive **state management**.",

        // Tooling & packages
        .swiftPackageManager: "**Swift Package Manager** (`swift package`, `Package.swift`) handles dependency management and builds.",
        .docc:                "**DocC** generates interactive API documentation directly from your source.",
        .swiftPlaygrounds:    "**Swift Playgrounds** offers an interactive sandbox for rapid experimentation.",
        .swiftLint:           "**SwiftLint** is a linter enforcing style & best-practice rules via `swiftlint.yml`.",

        // Xcode
        .xcodeProject:        "**Xcode projects** group targets, schemes, and settings defining how to build your products.",
        .interfaceBuilder:    "**Interface Builder** provides storyboard, XIB, and SwiftUI design previews.",
        .xcodeDebugger:       "The **Xcode debugger** leverages breakpoints and LLDB commands to inspect runtime state.",
        .unitTesting:         "`XCTest` underpins **unit testing** and performance measurement.",
        .instruments:         "**Instruments** profiles CPU, memory, energy, I/O, and more.",
        .buildSettings:       "**Build settings** configure compiler, linker, and pre-/post-build phases.",
        .sourceControl:       "**Source Control Navigator** integrates Git operations, branching, and diffs.",
        .signingCapabilities: "**Signing & Capabilities** manages certificates, profiles, and entitlements.",
        .previews:            "**SwiftUI previews** render UI live using `PreviewProvider`.",
        .xcodeCloud:          "**Xcode Cloud** delivers continuous integration and deployment pipelines.",
        .simulators:          "**Simulators** emulate hardware and multiple OS versions for on-Mac testing.",
        .memoryGraphDebugger: "**Memory Graph Debugger** visualizes retain cycles and leaks.",
        .testFlight:          "**TestFlight** distributes beta builds via App Store Connect.",
        .codeSnippets:        "**Code Snippets Library** stores reusable templates triggered by shortcuts.",
        .localization:        "**Localization** tools translate strings, assets, and storyboards.",
        .assetCatalogs:       "**Asset Catalogs** organize images, colors, data assets, and variants.",
        .refactoring:         "**Refactoring** commands (⌥-⌘-X) rename symbols, extract methods, and more.",
        .quickHelp:           "**Quick Help** (⌥-single-click) surfaces documentation inline."
    ]

    static func text(for topic: Topic) -> String { map[topic] ?? "" }
}

// MARK: - Quiz-supporting helper types (unchanged)
struct DiscreteMathQuestion: Identifiable, Hashable {
    var id = UUID()
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
    let explanation: String
    let topic: Topic
}

struct Question: Identifiable, Hashable {
    let id = UUID()
    let prompt: String
    let answer: String
}

enum QuizQuestion: Identifiable, Hashable {
    case multiple(DiscreteMathQuestion)
    case submit(Question)

    var id: UUID {
        switch self {
        case .multiple(let q): return q.id
        case .submit(let q):   return q.id
        }
    }
    var prompt: String {
        switch self {
        case .multiple(let q): return q.question
        case .submit(let q):   return q.prompt
        }
    }
    var isMultipleChoice: Bool { if case .multiple = self { return true } else { return false } }
    var options: [String]?    { if case .multiple(let q) = self { return q.answers } else { return nil } }
    var solution: String {
        switch self {
        case .multiple(let q): return q.answers[q.correctAnswerIndex]
        case .submit(let q):   return q.answer
        }
    }
}

// MARK: - Topic-specific question creation dispatcher
extension Topic {
    func generated() -> DiscreteMathQuestion {
        switch self {

        // Swift fundamentals
        case .variableKeyword:        return QuestionGenerator.variableKeywordQuestion()
        case .constantKeyword:        return QuestionGenerator.constantKeywordQuestion()
        case .optionals:              return QuestionGenerator.optionalsQuestion()
        case .closures:               return QuestionGenerator.closuresQuestion()
        case .structsVsClasses:       return QuestionGenerator.structsVsClassesQuestion()
        case .protocols:              return QuestionGenerator.protocolsQuestion()
        case .generics:               return QuestionGenerator.genericsQuestion()
        case .functions:              return QuestionGenerator.functionsQuestion()
        case .enums:                  return QuestionGenerator.enumsQuestion()
        case .errorHandling:          return QuestionGenerator.errorHandlingQuestion()
        case .accessControl:          return QuestionGenerator.accessControlQuestion()
        case .memoryManagement:       return QuestionGenerator.memoryManagementQuestion()
        case .extensionsFeature:      return QuestionGenerator.extensionsFeatureQuestion()
        case .properties:             return QuestionGenerator.propertiesQuestion()
        case .subscripts:             return QuestionGenerator.subscriptsQuestion()
        case .guardStatement:         return QuestionGenerator.guardStatementQuestion()
        case .deferStatement:         return QuestionGenerator.deferStatementQuestion()
        case .lazyKeyword:            return QuestionGenerator.lazyKeywordQuestion()
        case .typealiasKeyword:       return QuestionGenerator.typealiasKeywordQuestion()
        case .stringInterpolation:    return QuestionGenerator.stringInterpolationQuestion()
        case .tuples:                 return QuestionGenerator.tuplesQuestion()
        case .collections:            return QuestionGenerator.collectionsQuestion()
        case .controlFlow:            return QuestionGenerator.controlFlowQuestion()

        // Advanced language
        case .concurrency:            return QuestionGenerator.concurrencyQuestion()
        case .propertyWrappers:       return QuestionGenerator.propertyWrappersQuestion()
        case .resultBuilders:         return QuestionGenerator.resultBuildersQuestion()
        case .actors:                 return QuestionGenerator.actorsQuestion()
        case .distributedActors:      return QuestionGenerator.distributedActorsQuestion()
        case .asyncLet:               return QuestionGenerator.asyncLetQuestion()
        case .taskGroups:             return QuestionGenerator.taskGroupsQuestion()
        case .macros:                 return QuestionGenerator.macrosQuestion()
        case .asyncSequence:          return QuestionGenerator.asyncSequenceQuestion()
        case .patternMatching:        return QuestionGenerator.patternMatchingQuestion()
        case .typeInference:          return QuestionGenerator.typeInferenceQuestion()
        case .codable:                return QuestionGenerator.codableQuestion()
        case .opaqueTypes:            return QuestionGenerator.opaqueTypesQuestion()
        case .existentialTypes:       return QuestionGenerator.existentialTypesQuestion()
        case .moveOnlyTypes:          return QuestionGenerator.moveOnlyTypesQuestion()
        case .unsafePointers:         return QuestionGenerator.unsafePointersQuestion()

        // SwiftUI
        case .swiftUI:                return QuestionGenerator.swiftUIQuestion()
        case .viewModifiers:          return QuestionGenerator.viewModifiersQuestion()
        case .navigationStack:        return QuestionGenerator.navigationStackQuestion()
        case .animations:             return QuestionGenerator.animationsQuestion()
        case .gestures:               return QuestionGenerator.gesturesQuestion()
        case .environmentValues:      return QuestionGenerator.environmentValuesQuestion()
        case .stateManagement:        return QuestionGenerator.stateManagementQuestion()

        // Tooling & packages
        case .swiftPackageManager:    return QuestionGenerator.swiftPackageManagerQuestion()
        case .docc:                   return QuestionGenerator.doccQuestion()
        case .swiftPlaygrounds:       return QuestionGenerator.swiftPlaygroundsQuestion()
        case .swiftLint:              return QuestionGenerator.swiftLintQuestion()

        // Xcode
        case .xcodeProject:           return QuestionGenerator.xcodeProjectQuestion()
        case .interfaceBuilder:       return QuestionGenerator.interfaceBuilderQuestion()
        case .xcodeDebugger:          return QuestionGenerator.xcodeDebuggerQuestion()
        case .unitTesting:            return QuestionGenerator.unitTestingQuestion()
        case .instruments:            return QuestionGenerator.instrumentsQuestion()
        case .buildSettings:          return QuestionGenerator.buildSettingsQuestion()
        case .sourceControl:          return QuestionGenerator.sourceControlQuestion()
        case .signingCapabilities:    return QuestionGenerator.signingCapabilitiesQuestion()
        case .previews:               return QuestionGenerator.previewsQuestion()
        case .xcodeCloud:             return QuestionGenerator.xcodeCloudQuestion()
        case .simulators:             return QuestionGenerator.simulatorsQuestion()
        case .memoryGraphDebugger:    return QuestionGenerator.memoryGraphDebuggerQuestion()
        case .testFlight:             return QuestionGenerator.testFlightQuestion()
        case .codeSnippets:           return QuestionGenerator.codeSnippetsQuestion()
        case .localization:           return QuestionGenerator.localizationQuestion()
        case .assetCatalogs:          return QuestionGenerator.assetCatalogsQuestion()
        case .refactoring:            return QuestionGenerator.refactoringQuestion()
        case .quickHelp:              return QuestionGenerator.quickHelpQuestion()
        }
    }

    func randomQuestion() -> Question {
        let q = generated()
        return Question(prompt: q.question, answer: q.answers[q.correctAnswerIndex])
    }

    func mixedQuestion() -> QuizQuestion {
        Bool.random() ? .multiple(generated()) : .submit(randomQuestion())
    }

    var explanation: String { TopicExplanations.text(for: self) }
    var short: String        { String(title.prefix(12)) }

    func answer(for _: String) -> String {
        "\(explanation)\n\n(For full details, ask about a concrete example.)"
    }
}

// MARK: - Quiz factory
struct QuizFactory {
    static func generate(count: Int = 20) -> [QuizQuestion] {
        var out: [QuizQuestion] = []
        var topics = Topic.allCases.shuffled()
        while out.count < count {
            if topics.isEmpty { topics = Topic.allCases.shuffled() }
            out.append(topics.removeFirst().mixedQuestion())
        }
        return out.shuffled()
    }
}


