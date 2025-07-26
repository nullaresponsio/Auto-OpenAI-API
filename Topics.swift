import Foundation
import SwiftUI

/// Enumeration of every Python-learning topic handled by the quiz engine.
enum Topic: String, CaseIterable, Hashable, Identifiable {

    // -- Existing topics
    case variableKeyword, constantKeyword, optionals
    case closures, structsVsClasses, protocols
    case generics, concurrency
    case controlFlow, listComprehensions, dictSetComprehensions
    case decorators
    case contextManagers, exceptions, modulesPackages
    case iteratorsGenerators
    case functions, stringFormatting, fileIO, logging
    case testing, patternMatching, virtualEnv, performance
    case itertoolsFunctools

    // -- New topics
    case indentation, dataTypes, listsTuples, setsDicts, slicing
    case variableScope, builtins, sorting, regex, serialization
    case subprocessModule, networking, oopInheritance, magicMethods
    case properties, advancedTyping, metaclasses, debugging
    case styleGuide, databaseSqlite

    var id: String { rawValue }

    /// User-facing title (≤ 25 characters each so they fit nicely in UI).
    var title: String {
        switch self {
        // ————— Existing —————
        case .variableKeyword:       return "Variables"
        case .constantKeyword:       return "Constants"
        case .optionals:             return "None & Nullability"
        case .closures:              return "Lambda Functions"
        case .structsVsClasses:      return "Classes & Data Classes"
        case .protocols:             return "Protocols"
        case .generics:              return "Type Hints & Generics"
        case .concurrency:           return "Asyncio & Concurrency"
        case .controlFlow:           return "Control Flow"
        case .listComprehensions:    return "List Comprehensions"
        case .dictSetComprehensions: return "Dict & Set Comprehensions"
        case .decorators:            return "Decorators"
        case .contextManagers:       return "Context Managers"
        case .exceptions:            return "Exceptions"
        case .modulesPackages:       return "Modules & Packages"
        case .iteratorsGenerators:   return "Iterators & Generators"
        case .functions:             return "Functions"
        case .stringFormatting:      return "F-Strings"
        case .fileIO:                return "File I/O"
        case .logging:               return "Logging"
        case .testing:               return "Testing & pytest"
        case .patternMatching:       return "Pattern Matching"
        case .virtualEnv:            return "Virtual Environments"
        case .performance:           return "Performance"
        case .itertoolsFunctools:    return "Itertools & functools"

        // ————— New —————
        case .indentation:           return "Indentation"
        case .dataTypes:             return "Core Data Types"
        case .listsTuples:           return "Lists & Tuples"
        case .setsDicts:             return "Sets & Dicts"
        case .slicing:               return "Slicing"
        case .variableScope:         return "Variable Scope"
        case .builtins:              return "Built-ins"
        case .sorting:               return "Sorting"
        case .regex:                 return "Regular Expressions"
        case .serialization:         return "JSON & Serialising"
        case .subprocessModule:      return "subprocess"
        case .networking:            return "Networking"
        case .oopInheritance:        return "OOP Inheritance"
        case .magicMethods:          return "Magic Methods"
        case .properties:            return "Properties"
        case .advancedTyping:        return "Advanced Typing"
        case .metaclasses:           return "Metaclasses"
        case .debugging:             return "Debugging"
        case .styleGuide:            return "Style & Formatting"
        case .databaseSqlite:        return "sqlite3"
        }
    }
}

extension Topic { static var modularAddition: Topic { .variableKeyword } }

/// ---------------------------------------------------------------------
/// MARK:  Topic-centric explanations
/// ---------------------------------------------------------------------
private struct TopicExplanations {
    private static let map: [Topic: String] = [

        // ————— Existing —————
        .variableKeyword:       "**Variables** are bound with `=`; names reference objects and can re-bind freely.",
        .constantKeyword:       "**Constants** rely on convention: ALL_CAPS at module scope (e.g. `PI = 3.14159`).",
        .optionals:             "**None** is the singleton signifying “no value”. Use `Optional[T]` or `T | None` in type hints.",
        .closures:              "**Lambda functions** create anonymous callables and can close over outer-scope names.",
        .structsVsClasses:      "**Classes** model state/behaviour; `@dataclass` (PEP 557) auto-generates boilerplate.",
        .protocols:             "**Protocols** (PEP 544) define structural contracts—implementation checked by attribute presence.",
        .generics:              "**Generics** via `typing` enable precise, reusable APIs.",
        .concurrency:           "**Concurrency**: `async`/`await` with `asyncio`, plus `threading` & `multiprocessing`.",
        .controlFlow:           "**Control flow**: `if`/`elif`/`else`, `for`, `while`, `break`, `continue`, `pass`.",
        .listComprehensions:    "**List comprehensions** build lists concisely: `[expr for x in seq if cond]`.",
        .dictSetComprehensions: "**Dict/Set comprehensions**: `{k:v for k,v in pairs}` or `{f(x) for x in seq}`.",
        .decorators:            "**Decorators** wrap callables and are declared with a leading `@decorator` line.",
        .contextManagers:       "**Context managers** via `with` manage resources deterministically.",
        .exceptions:            "**Exceptions**: raise subclasses of `Exception`; handle with `try`/`except`.",
        .modulesPackages:       "**Modules & packages**: `.py` files + directories with `__init__.py` (pre-3.3 requirement).",
        .iteratorsGenerators:   "**Iterators & generators**: objects with `__iter__`/`__next__`; `yield` creates generators.",
        .functions:             "**Functions** are defined with `def`; support `*args`, `**kwargs`, annotations & defaults.",
        .stringFormatting:      "**F-strings** (PEP 498) embed expressions: `f\"{value:.2f}\"`.",
        .fileIO:                "**File I/O** uses `open()`, plus `pathlib.Path` for OO paths.",
        .logging:               "**Logging** via `logging` module; configure levels, handlers & formatters.",
        .testing:               "**Testing**: `unittest`; `pytest` offers fixtures & expressive assertions.",
        .patternMatching:       "**Structural pattern matching** (`match`/`case`) landed in 3.10.",
        .virtualEnv:            "**Virtual environments** (`python -m venv`, `pipenv`, `poetry`) isolate dependencies.",
        .performance:           "**Performance**: profiling with `cProfile`, optimisation with `lru_cache`, Cython, NumPy.",
        .itertoolsFunctools:    "**Itertools & functools** supply high-performance iterator helpers & function utilities.",

        // ————— New —————
        .indentation:           "**Indentation** is syntactic—PEP 8 mandates 4 spaces; mixing tabs & spaces raises `TabError`.",
        .dataTypes:             "**Core data types**: `int`, `float`, `complex`, `bool`, `str`, `bytes`, `list`, `tuple`, `set`, `dict`.",
        .listsTuples:           "**Lists** are mutable ordered sequences; **tuples** are immutable and thus hashable if their elements are.",
        .setsDicts:             "**Sets** store unique unordered items; **dicts** map keys → values and preserve insertion order (≥3.7).",
        .slicing:               "**Slicing** `[start:stop:step]` returns subsequences; omit indices for defaults; negative indices count from the end.",
        .variableScope:         "**Scope** follows LEGB (Local, Enclosing, Global, Built-in); `global` & `nonlocal` re-bind outer scopes.",
        .builtins:              "**Built-ins** (`len`, `sum`, `enumerate`, `zip`, `map`, …) are always available without import.",
        .sorting:               "**Sorting**: `sorted(iterable, key=…, reverse=…)` returns a new list; `list.sort()` sorts in-place.",
        .regex:                 "**Regular expressions** via `re` with helpers like `search`, `match`, `findall`, and compiled patterns.",
        .serialization:         "**JSON serialisation** uses `json.dumps/loads`; for arbitrary objects use `pickle` (unsafe) or 3rd-party `yaml`.",
        .subprocessModule:      "**subprocess** executes external commands; high-level `run()` wraps `Popen` and returns `CompletedProcess`.",
        .networking:            "**Networking**: low-level `socket`; `urllib.request` for HTTP; 3rd-party **Requests** for ergonomic HTTP.",
        .oopInheritance:        "**Inheritance** allows subclasses to extend or override base behaviour; multiple inheritance is supported.",
        .magicMethods:          "**Magic (dunder) methods** (`__str__`, `__len__`, `__iter__`, …) integrate objects with Python protocols.",
        .properties:            "`@property` turns a method into an attribute; optional setters/getters give controlled access.",
        .advancedTyping:        "**Advanced typing**: `Union`, `Literal`, `TypedDict`, `NewType`, generics with `TypeVar`, `ParamSpec`, `Self`.",
        .metaclasses:           "**Metaclasses** customise class creation via `__new__`/`__init__`; declare with `class X(metaclass=Meta): …`",
        .debugging:             "**Debugging**: `pdb`, `breakpoint()` (3.7+), IDE debuggers, `logging` & assertions.",
        .styleGuide:            "**Style**: PEP 8, `black` auto-formatter, `flake8`/`pylint` linters, `isort` for imports.",
        .databaseSqlite:        "**sqlite3** std-lib module offers zero-config relational DBs via `sqlite3.connect()` and cursors."
    ]

    static func text(for topic: Topic) -> String { map[topic] ?? "" }
}

/// ---------------------------------------------------------------------
/// MARK:  Question factory helpers
/// ---------------------------------------------------------------------
extension Topic {

    /// Returns a *multiple-choice* question object for this topic.
    func generated() -> DiscreteMathQuestion {
        switch self {
        // ————— Existing generators —————
        case .variableKeyword:       return QuestionGenerator.variableKeywordQuestion()
        case .constantKeyword:       return QuestionGenerator.constantKeywordQuestion()
        case .optionals:             return QuestionGenerator.optionalsQuestion()
        case .closures:              return QuestionGenerator.closuresQuestion()
        case .structsVsClasses:      return QuestionGenerator.structsVsClassesQuestion()
        case .protocols:             return QuestionGenerator.protocolsQuestion()
        case .generics:              return QuestionGenerator.genericsQuestion()
        case .concurrency:           return QuestionGenerator.concurrencyQuestion()
        case .controlFlow:           return QuestionGenerator.controlFlowQuestion()
        case .listComprehensions:    return QuestionGenerator.listComprehensionsQuestion()
        case .dictSetComprehensions: return QuestionGenerator.dictSetComprehensionsQuestion()
        case .decorators:            return QuestionGenerator.decoratorsQuestion()
        case .contextManagers:       return QuestionGenerator.contextManagersQuestion()
        case .exceptions:            return QuestionGenerator.exceptionsQuestion()
        case .modulesPackages:       return QuestionGenerator.modulesPackagesQuestion()
        case .iteratorsGenerators:   return QuestionGenerator.iteratorsGeneratorsQuestion()
        case .functions:             return QuestionGenerator.functionsQuestion()
        case .stringFormatting:      return QuestionGenerator.stringFormattingQuestion()
        case .fileIO:                return QuestionGenerator.fileIOQuestion()
        case .logging:               return QuestionGenerator.loggingQuestion()
        case .testing:               return QuestionGenerator.testingQuestion()
        case .patternMatching:       return QuestionGenerator.patternMatchingQuestion()
        case .virtualEnv:            return QuestionGenerator.virtualEnvQuestion()
        case .performance:           return QuestionGenerator.performanceQuestion()
        case .itertoolsFunctools:    return QuestionGenerator.itertoolsFunctoolsQuestion()

        // ————— New generators —————
        case .indentation:           return QuestionGenerator.indentationQuestion()
        case .dataTypes:             return QuestionGenerator.dataTypesQuestion()
        case .listsTuples:           return QuestionGenerator.listsTuplesQuestion()
        case .setsDicts:             return QuestionGenerator.setsDictsQuestion()
        case .slicing:               return QuestionGenerator.slicingQuestion()
        case .variableScope:         return QuestionGenerator.variableScopeQuestion()
        case .builtins:              return QuestionGenerator.builtinsQuestion()
        case .sorting:               return QuestionGenerator.sortingQuestion()
        case .regex:                 return QuestionGenerator.regexQuestion()
        case .serialization:         return QuestionGenerator.serializationQuestion()
        case .subprocessModule:      return QuestionGenerator.subprocessQuestion()
        case .networking:            return QuestionGenerator.networkingQuestion()
        case .oopInheritance:        return QuestionGenerator.oopInheritanceQuestion()
        case .magicMethods:          return QuestionGenerator.magicMethodsQuestion()
        case .properties:            return QuestionGenerator.propertiesQuestion()
        case .advancedTyping:        return QuestionGenerator.advancedTypingQuestion()
        case .metaclasses:           return QuestionGenerator.metaclassesQuestion()
        case .debugging:             return QuestionGenerator.debuggingQuestion()
        case .styleGuide:            return QuestionGenerator.styleGuideQuestion()
        case .databaseSqlite:        return QuestionGenerator.databaseSqliteQuestion()
        }
    }

    /// Helper that converts a multiple-choice question into a simple prompt–answer pair.
    func randomQuestion() -> Question {
        let q = generated()
        return Question(prompt: q.question, answer: q.answers[q.correctAnswerIndex])
    }

    /// Randomly returns either a multiple-choice or short-answer wrapper.
    func mixedQuestion() -> QuizQuestion {
        Bool.random() ? .multiple(generated()) : .submit(randomQuestion())
    }

    var explanation: String { TopicExplanations.text(for: self) }
    var short: String       { String(title.prefix(12)) }

    func answer(for _: String) -> String {
        "\(explanation)\n\n(For full details, ask about a concrete example.)"
    }
}

