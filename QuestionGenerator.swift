//
//  QuestionGenerator.swift
//  Swift_programming_with_XCode_tutor
//  Updated 7/26/25 – Added many more Swift, SwiftUI & Xcode questions
//

import Foundation

enum QuestionGenerator {
    static let maxCount = 500   // arbitrary upper bound

    private static func make(_ q: String,
                             _ opts: [String],
                             _ correct: Int,
                             _ expl: String,
                             _ top: Topic) -> DiscreteMathQuestion {
        DiscreteMathQuestion(
            question: q,
            answers: opts,
            correctAnswerIndex: correct,
            explanation: expl,
            topic: top)
    }

    // MARK: - Swift fundamentals
    static func variableKeywordQuestion() -> DiscreteMathQuestion {
        make("Which keyword declares a mutable variable in Swift?",
             ["var", "let", "func", "enum"], 0,
             "`var` declares a variable whose value can change.", .variableKeyword)
    }
    static func constantKeywordQuestion() -> DiscreteMathQuestion {
        make("Which keyword declares an immutable constant?",
             ["let", "var", "static", "mutating"], 0,
             "`let` creates a constant that cannot be reassigned.", .constantKeyword)
    }
    static func optionalsQuestion() -> DiscreteMathQuestion {
        make("An optional in Swift represents …?",
             ["A value that may be nil", "A generic type", "A type alias", "A protocol"], 0,
             "Optionals wrap a value that can be present or `nil`.", .optionals)
    }
    static func closuresQuestion() -> DiscreteMathQuestion {
        make("In Swift, a closure is …?",
             ["A self-contained block of code", "A stored property", "A protocol extension", "A generic constraint"], 0,
             "Closures are anonymous functions that can capture surrounding context.", .closures)
    }
    static func structsVsClassesQuestion() -> DiscreteMathQuestion {
        make("Which statement about structs and classes is correct?",
             ["Classes support inheritance", "Structs support inheritance", "Both are reference types", "Only structs have deinitializers"], 0,
             "Classes are reference types and can inherit; structs are value types.", .structsVsClasses)
    }
    static func protocolsQuestion() -> DiscreteMathQuestion {
        make("What does a protocol provide in Swift?",
             ["Blueprint of methods and properties", "A concrete data type", "A way to handle errors", "A compile-time attribute"], 0,
             "Protocols define requirements adopted by types.", .protocols)
    }
    static func genericsQuestion() -> DiscreteMathQuestion {
        make("Generics in Swift enable …?",
             ["Code that works with any type", "Runtime reflection", "Automatic memory management", "Dynamic dispatch only"], 0,
             "Generics let you write flexible, reusable code.", .generics)
    }
    static func extensionsFeatureQuestion() -> DiscreteMathQuestion {
        make("Extensions in Swift allow you to …?",
             ["Add new functionality to existing types", "Create new protocols", "Allocate memory manually", "Define new access levels"], 0,
             "Extensions add methods, properties, or conformance without subclassing.", .extensionsFeature)
    }
    static func propertiesQuestion() -> DiscreteMathQuestion {
        make("Which property stores a value directly and doesn’t compute on access?",
             ["Stored property", "Computed property", "Lazy property", "Type property"], 0,
             "Stored properties keep values directly; computed properties calculate on access.", .properties)
    }
    static func subscriptsQuestion() -> DiscreteMathQuestion {
        make("The `subscript` keyword enables …?",
             ["Indexed access like array[key]", "Protocol conformance", "Generics specialization", "Automatic memory management"], 0,
             "Subscripts give shortcut access to collection-like types.", .subscripts)
    }
    static func guardStatementQuestion() -> DiscreteMathQuestion {
        make("`guard` statements are mainly used to …?",
             ["Exit early when a condition fails", "Allocate memory", "Start a thread", "Catch errors"], 0,
             "`guard` unwraps/validates and must exit scope if the condition is false.", .guardStatement)
    }
    static func deferStatementQuestion() -> DiscreteMathQuestion {
        make("Code within a `defer` block executes …?",
             ["When the current scope is about to exit", "Immediately", "Before every return", "Only on success"], 0,
             "`defer` is ideal for cleanup like closing files.", .deferStatement)
    }
    static func lazyKeywordQuestion() -> DiscreteMathQuestion {
        make("A `lazy` property is initialized …?",
             ["On first access", "During object allocation", "At compile time", "After deinit"], 0,
             "Lazy properties delay expensive initialization until needed.", .lazyKeyword)
    }
    static func typealiasKeywordQuestion() -> DiscreteMathQuestion {
        make("`typealias` in Swift is used to …?",
             ["Provide an alternative name for a type", "Allocate memory", "Implement inheritance", "Define a protocol"], 0,
             "`typealias` improves readability and abstraction.", .typealiasKeyword)
    }
    static func stringInterpolationQuestion() -> DiscreteMathQuestion {
        make("The syntax `\"Hello \\(name)!\"` is an example of …?",
             ["String interpolation", "Tuple destructuring", "KeyPath expression", "Mirror reflection"], 0,
             "String interpolation inserts expression values into literals.", .stringInterpolation)
    }
    static func tuplesQuestion() -> DiscreteMathQuestion {
        make("Which code defines a tuple of Int and String?",
             ["(42, \"Answer\")", "[42, \"Answer\"]", "{42, \"Answer\"}", "<42, \"Answer\">"], 0,
             "Parentheses create tuples: `(value1, value2, …)`.", .tuples)
    }
    static func collectionsQuestion() -> DiscreteMathQuestion {
        make("Which collection type guarantees uniqueness of its elements?",
             ["Set", "Array", "Dictionary", "Tuple"], 0,
             "`Set` stores unordered, unique elements.", .collections)
    }
    static func controlFlowQuestion() -> DiscreteMathQuestion {
        make("Which keyword starts a conditional statement in Swift?",
             ["if", "when", "case", "cond"], 0,
             "`if` evaluates a Boolean condition and executes code accordingly.", .controlFlow)
    }

    // MARK: - Additional Swift topics
    static func functionsQuestion() -> DiscreteMathQuestion {
        make("Which keyword defines a function in Swift?",
             ["func", "fun", "def", "function"], 0,
             "`func` introduces a reusable function.", .functions)
    }
    static func enumsQuestion() -> DiscreteMathQuestion {
        make("Which keyword declares an enumeration?",
             ["enum", "struct", "case", "option"], 0,
             "`enum` defines a type with multiple cases.", .enums)
    }
    static func errorHandlingQuestion() -> DiscreteMathQuestion {
        make("Which keyword marks a Swift function that can throw an error?",
             ["throws", "throw", "try", "catch"], 0,
             "`throws` indicates a function may propagate errors.", .errorHandling)
    }
    static func accessControlQuestion() -> DiscreteMathQuestion {
        make("What is the most permissive access level in Swift?",
             ["open", "public", "internal", "private"], 0,
             "`open` allows use and subclassing outside the defining module.", .accessControl)
    }
    static func memoryManagementQuestion() -> DiscreteMathQuestion {
        make("Swift uses which memory-management model?",
             ["Automatic Reference Counting (ARC)", "Garbage Collection", "Manual Reference Counting", "Region-based Allocation"], 0,
             "ARC automatically manages object lifetimes via reference counts.", .memoryManagement)
    }

    // MARK: - Advanced language
    static func concurrencyQuestion() -> DiscreteMathQuestion {
        make("Swift concurrency is primarily expressed with …?",
             ["`async` and `await`", "`goto` statements", "Polling loops", "Global locks only"], 0,
             "Structured concurrency uses `async`/`await` and task groups.", .concurrency)
    }
    static func propertyWrappersQuestion() -> DiscreteMathQuestion {
        make("Which attribute defines a property wrapper?",
             ["@propertyWrapper", "@wrapper", "@property", "@delegate"], 0,
             "`@propertyWrapper` creates reusable get/set behavior.", .propertyWrappers)
    }
    static func resultBuildersQuestion() -> DiscreteMathQuestion {
        make("Result builders in Swift enable …?",
             ["Declarative DSL syntax", "Reference counting", "Error handling", "Memory copying"], 0,
             "Result builders transform block syntax into chained calls (e.g., SwiftUI).", .resultBuilders)
    }
    static func actorsQuestion() -> DiscreteMathQuestion {
        make("An `actor` in Swift is …?",
             ["A reference type isolating mutable state", "A compile-time macro", "A value type for animations", "An Objective-C class"], 0,
             "Actors serialize access to their internal state across tasks.", .actors)
    }
    static func distributedActorsQuestion() -> DiscreteMathQuestion {
        make("Distributed actors differ from regular actors by …?",
             ["Isolating state across process or network boundaries", "Allowing subclass inheritance", "Requiring Objective-C runtime", "Disabling async/await"], 0,
             "Distributed actors communicate securely across boundaries.", .distributedActors)
    }
    static func asyncLetQuestion() -> DiscreteMathQuestion {
        make("`async let` is used to …?",
             ["Start a child task concurrently", "Define a constant", "Handle errors", "Create a macro"], 0,
             "`async let` launches a child task and binds its result.", .asyncLet)
    }
    static func taskGroupsQuestion() -> DiscreteMathQuestion {
        make("Task groups in Swift enable …?",
             ["Dynamic, structured spawning of child tasks", "Global locks", "Manual thread pools", "Blocking synchronization"], 0,
             "Task groups run many tasks concurrently and gather results.", .taskGroups)
    }
    static func macrosQuestion() -> DiscreteMathQuestion {
        make("Swift macros provide …?",
             ["Compile-time code generation", "Just-in-time compilation", "Manual memory management", "Exclusive Objective-C interop"], 0,
             "Macros expand source code during compilation for boilerplate reduction.", .macros)
    }
    static func asyncSequenceQuestion() -> DiscreteMathQuestion {
        make("An `AsyncSequence` differs from `Sequence` because …?",
             ["It delivers values asynchronously over time", "It works only with arrays", "It runs only on the main thread", "It cannot throw errors"], 0,
             "`AsyncSequence` integrates with `for await` to consume values asynchronously.", .asyncSequence)
    }
    static func patternMatchingQuestion() -> DiscreteMathQuestion {
        make("The `_` symbol in a `switch` case represents …?",
             ["A wildcard pattern", "A default enum case", "Nil coalescing", "Type erasure"], 0,
             "Wildcard `_` matches any remaining values.", .patternMatching)
    }
    static func typeInferenceQuestion() -> DiscreteMathQuestion {
        make("Type inference in Swift allows …?",
             ["Omitting explicit type annotations", "Runtime reflection only", "Dynamic typing", "Skipping compilation"], 0,
             "The compiler deduces types from context.", .typeInference)
    }
    static func codableQuestion() -> DiscreteMathQuestion {
        make("`Codable` is a type alias for …?",
             ["Encodable & Decodable", "Hashable & Equatable", "Sendable & Decodable", "RawRepresentable & CaseIterable"], 0,
             "`Codable` simplifies serialization of data structures.", .codable)
    }
    static func opaqueTypesQuestion() -> DiscreteMathQuestion {
        make("Which keyword introduces an opaque return type?",
             ["some", "any", "Self", "opaque"], 0,
             "`some` hides the concrete return type behind a protocol.", .opaqueTypes)
    }
    static func existentialTypesQuestion() -> DiscreteMathQuestion {
        make("What does the `any` keyword denote in Swift?",
             ["An existential type", "A generic parameter", "An Objective-C class", "A macro expansion"], 0,
             "`any Protocol` forms an existential container hiding the concrete type.", .existentialTypes)
    }
    static func moveOnlyTypesQuestion() -> DiscreteMathQuestion {
        make("Move-only types are designed primarily to …?",
             ["Prevent implicit copies", "Enable multiple inheritance", "Allow reflection", "Disable ARC"], 0,
             "They enforce single ownership to improve performance & safety.", .moveOnlyTypes)
    }
    static func unsafePointersQuestion() -> DiscreteMathQuestion {
        make("Which Swift type lets you work with raw memory addresses?",
             ["UnsafePointer", "AnyPointer", "RawAddress", "MemoryRef"], 0,
             "`UnsafePointer` and its mutable variant expose raw memory.", .unsafePointers)
    }

    // MARK: - Tooling & packages
    static func swiftPackageManagerQuestion() -> DiscreteMathQuestion {
        make("Dependencies in Swift Package Manager are declared in …?",
             ["Package.swift", "Podfile", "Cartfile", "build.gradle"], 0,
             "`Package.swift` defines products, targets, and dependencies.", .swiftPackageManager)
    }
    static func doccQuestion() -> DiscreteMathQuestion {
        make("DocC is primarily used to …?",
             ["Generate API documentation", "Manage code signing", "Debug LLDB sessions", "Profile performance"], 0,
             "DocC converts Markdown comments into browsable documentation.", .docc)
    }
    static func swiftPlaygroundsQuestion() -> DiscreteMathQuestion {
        make("Swift Playgrounds is best described as …?",
             ["An interactive Swift learning environment", "A continuous integration service", "A documentation tool", "A memory profiler"], 0,
             "Playgrounds provide immediate feedback while you experiment with Swift.", .swiftPlaygrounds)
    }
    static func swiftLintQuestion() -> DiscreteMathQuestion {
        make("SwiftLint is primarily used to …?",
             ["Enforce style and lint rules", "Manage dependencies", "Generate docs", "Profile memory"], 0,
             "SwiftLint scans code for style violations and best-practice issues.", .swiftLint)
    }

    // MARK: - SwiftUI
    static func swiftUIQuestion() -> DiscreteMathQuestion {
        make("In SwiftUI, UI is defined using …?",
             ["Structs conforming to `View`", "Storyboards", "XIBs", "Nib files"], 0,
             "SwiftUI views are value-type structs with declarative syntax.", .swiftUI)
    }
    static func viewModifiersQuestion() -> DiscreteMathQuestion {
        make("Calling `.padding()` on a SwiftUI view is an example of …?",
             ["A view modifier", "A property wrapper", "A macro expansion", "A storyboard segue"], 0,
             "View modifiers return new views with added behavior or style.", .viewModifiers)
    }
    static func navigationStackQuestion() -> DiscreteMathQuestion {
        make("`NavigationStack` replaces which older SwiftUI API?",
             ["NavigationView", "TabView", "List", "Form"], 0,
             "NavigationStack supports data-driven navigation & deep-linking.", .navigationStack)
    }
    static func animationsQuestion() -> DiscreteMathQuestion {
        make("Which function wraps view changes in an explicit SwiftUI animation?",
             ["withAnimation {}", "animate {}", "UIView.animate()", "startAnimation"], 0,
             "`withAnimation` animates property changes.", .animations)
    }
    static func gesturesQuestion() -> DiscreteMathQuestion {
        make("`TapGesture` and `DragGesture` are examples of …?",
             ["SwiftUI gestures", "UIKit recognizers", "Combine publishers", "Core Motion APIs"], 0,
             "SwiftUI gestures attach interactive behavior to views.", .gestures)
    }
    static func environmentValuesQuestion() -> DiscreteMathQuestion {
        make("Use which property wrapper to read a value from the SwiftUI environment?",
             ["@Environment", "@State", "@Binding", "@ObservedObject"], 0,
             "`@Environment` reads shared values like locale or colorScheme.", .environmentValues)
    }
    static func stateManagementQuestion() -> DiscreteMathQuestion {
        make("Which property wrapper creates the single source of truth for a view’s local state?",
             ["@State", "@Binding", "@EnvironmentObject", "@Published"], 0,
             "`@State` owns view-local, value-typed state.", .stateManagement)
    }

    // MARK: - Xcode topics
    static func xcodeProjectQuestion() -> DiscreteMathQuestion {
        make("A single Xcode project can contain one or more …?",
             ["targets", "schemes", "workspaces", "packages"], 0,
             "Targets compile code/products like apps or frameworks.", .xcodeProject)
    }
    static func interfaceBuilderQuestion() -> DiscreteMathQuestion {
        make("Which Xcode component lets you design UI visually?",
             ["Interface Builder", "Instruments", "Source Control Navigator", "Console"], 0,
             "Interface Builder works with storyboards, XIBs, and SwiftUI previews.", .interfaceBuilder)
    }
    static func xcodeDebuggerQuestion() -> DiscreteMathQuestion {
        make("To pause execution at a specific line in Xcode you set a …?",
             ["breakpoint", "checkpoint", "anchor", "flag"], 0,
             "Breakpoints let you inspect state at runtime.", .xcodeDebugger)
    }
    static func unitTestingQuestion() -> DiscreteMathQuestion {
        make("Which framework is used for unit testing in Xcode?",
             ["XCTest", "JUnit", "Mocha", "NUnit"], 0,
             "`XCTest` provides assertions, expectations, and test runners.", .unitTesting)
    }
    static func instrumentsQuestion() -> DiscreteMathQuestion {
        make("The Instruments Time Profiler tool is primarily used to analyze …?",
             ["CPU usage", "Memory leaks", "Network traffic", "Energy impact"], 0,
             "Time Profiler samples stacks to measure CPU hotspots.", .instruments)
    }
    static func buildSettingsQuestion() -> DiscreteMathQuestion {
        make("Compiler and linker flags are configured in Xcode's …?",
             ["Build Settings tab", "General tab", "Info tab", "Build Phases tab"], 0,
             "The Build Settings tab exposes granular configuration for each target.", .buildSettings)
    }
    static func sourceControlQuestion() -> DiscreteMathQuestion {
        make("Which navigator shows commit history in Xcode?",
             ["Source Control Navigator", "Debug Navigator", "Issue Navigator", "Trace Navigator"], 0,
             "Source Control Navigator integrates Git operations.", .sourceControl)
    }
    static func signingCapabilitiesQuestion() -> DiscreteMathQuestion {
        make("Code signing identities are configured in Xcode's …?",
             ["Signing & Capabilities tab", "General tab", "Build Settings", "Preview canvas"], 0,
             "Signing & Capabilities manages certificates and entitlements.", .signingCapabilities)
    }
    static func previewsQuestion() -> DiscreteMathQuestion {
        make("SwiftUI previews rely on types conforming to …?",
             ["PreviewProvider", "Scene", "App", "ObservableObject"], 0,
             "`PreviewProvider` supplies sample views for live rendering.", .previews)
    }
    static func xcodeCloudQuestion() -> DiscreteMathQuestion {
        make("Xcode Cloud primarily provides …?",
             ["Continuous integration and delivery", "Memory profiling", "Visual UI design", "Static code analysis"], 0,
             "Xcode Cloud automates building, testing, and distributing apps.", .xcodeCloud)
    }
    static func simulatorsQuestion() -> DiscreteMathQuestion {
        make("Xcode Simulators let you …?",
             ["Run apps on virtual devices", "Generate documentation", "Upload builds to TestFlight", "Edit storyboards"], 0,
             "Simulators emulate hardware and OS versions for testing.", .simulators)
    }
    static func memoryGraphDebuggerQuestion() -> DiscreteMathQuestion {
        make("The Memory Graph Debugger helps you detect …?",
             ["Retain cycles and leaks", "CPU hotspots", "Network latency", "App Store compliance"], 0,
             "It visualizes object graphs to track down leaks.", .memoryGraphDebugger)
    }
    static func testFlightQuestion() -> DiscreteMathQuestion {
        make("TestFlight is mainly used to …?",
             ["Distribute beta builds to testers", "Profile GPU usage", "Design storyboards", "Run unit tests"], 0,
             "TestFlight delivers prerelease apps through App Store Connect.", .testFlight)
    }
    static func codeSnippetsQuestion() -> DiscreteMathQuestion {
        make("The shortcut to create a code snippet from selected source is …?",
             ["Drag-and-drop into the Snippets Library", "⌘C then ⌘V", "Right-click › Create Snippet", "Save as Template"], 0,
             "Drag selected code into the Code Snippets Library to save it.", .codeSnippets)
    }
    static func localizationQuestion() -> DiscreteMathQuestion {
        make("`NSLocalizedString` helps with …?",
             ["Localization of user-visible text", "Memory debugging", "Gesture recognition", "Dependency injection"], 0,
             "Localization adapts apps to different languages and regions.", .localization)
    }
    static func assetCatalogsQuestion() -> DiscreteMathQuestion {
        make(".xcassets files primarily store …?",
             ["Images, colors, and data assets", "Swift packages", "Breakpoints", "Unit tests"], 0,
             "Asset catalogs centralize resources with variant support.", .assetCatalogs)
    }
    static func refactoringQuestion() -> DiscreteMathQuestion {
        make("The keyboard shortcut ⌥-⌘-X triggers which Xcode feature?",
             ["Refactor menu", "Run tests", "Build clean", "Open quick help"], 0,
             "Xcode’s refactor tools rename symbols, extract methods, etc.", .refactoring)
    }
    static func quickHelpQuestion() -> DiscreteMathQuestion {
        make("Holding ⌥ (Option) and clicking a symbol opens …?",
             ["Quick Help", "Code Snippets", "Live Preview", "Assistant Editor"], 0,
             "Quick Help shows inline documentation for the symbol.", .quickHelp)
    }
}
