
import Foundation

/// Factory for every multiple-choice quiz item.
/// Each helper returns a **DiscreteMathQuestion** ready for the UI.
enum QuestionGenerator {

    static let maxCount: Int = 100   // upper-bound safeguarding

    // MARK: -- Internal convenience
    private static func make(
        _ prompt: String,
        _ options: [String],
        _ correct: Int,
        _ explanation: String,
        _ topic: Topic
    ) -> DiscreteMathQuestion {
        DiscreteMathQuestion(
            question: prompt,
            answers: options,
            correctAnswerIndex: correct,
            explanation: explanation,
            topic: topic
        )
    }

    // ──────────────────────────────────────────────────────────
    // Existing question builders (unchanged)
    // ──────────────────────────────────────────────────────────
    static func variableKeywordQuestion() -> DiscreteMathQuestion {
        make(
            "Which operator assigns a value to a variable in Python?",
            ["=", "==", ":=", "->"],
            0,
            "`=` binds a name to an object; `==` tests equality, `:=` is the walrus operator, and `->` annotates returns.",
            .variableKeyword
        )
    }

    static func constantKeywordQuestion() -> DiscreteMathQuestion {
        make(
            "How are constants typically indicated in Python code?",
            ["ALL_CAPS variable names", "Using a `const` keyword", "Prefixing with `!`", "Using `final` at runtime"],
            0,
            "Python has no `const`; uppercase names at module scope signal constants by convention.",
            .constantKeyword
        )
    }

    static func optionalsQuestion() -> DiscreteMathQuestion {
        make(
            "What object represents the absence of a value in Python?",
            ["None", "nil", "null", "undefined"],
            0,
            "`None` is Python’s null singleton.",
            .optionals
        )
    }

    static func closuresQuestion() -> DiscreteMathQuestion {
        make(
            "What keyword defines an anonymous function in Python?",
            ["lambda", "def", "func", "anonymous"],
            0,
            "`lambda` creates a closure capturing outer variables.",
            .closures
        )
    }

    static func structsVsClassesQuestion() -> DiscreteMathQuestion {
        make(
            "Which decorator simplifies creation of data-carrier classes?",
            ["@dataclass", "@staticmethod", "@property", "@abstractmethod"],
            0,
            "`@dataclass` auto-generates boilerplate like `__init__`.",
            .structsVsClasses
        )
    }

    static func protocolsQuestion() -> DiscreteMathQuestion {
        make(
            "PEP 544 introduced which typing feature?",
            ["Protocols for structural subtyping", "Mandatory interface inheritance", "Checked exceptions", "Null-safety operators"],
            0,
            "Protocols enable duck-typed static type checking.",
            .protocols
        )
    }

    static func genericsQuestion() -> DiscreteMathQuestion {
        make(
            "Which module provides `TypeVar`?",
            ["typing", "types", "collections", "sys"],
            0,
            "`typing` underpins generics and type hints.",
            .generics
        )
    }

    static func concurrencyQuestion() -> DiscreteMathQuestion {
        make(
            "Which std-lib module underlies `async`/`await`?",
            ["asyncio", "threading", "multiprocessing", "queue"],
            0,
            "`asyncio` supplies the event loop.",
            .concurrency
        )
    }

    static func controlFlowQuestion() -> DiscreteMathQuestion {
        make(
            "Which keyword starts a `while` loop?",
            ["while", "loop", "for", "do"],
            0,
            "`while` repeats until the condition is false.",
            .controlFlow
        )
    }

    static func listComprehensionsQuestion() -> DiscreteMathQuestion {
        make(
            "Which expression creates a list of squares 0-9?",
            ["[x**2 for x in range(10)]", "list(x**2 for x in range(10))", "{x**2 for x in range(10)}", "(x**2 for x in range(10))"],
            0,
            "Brackets build a list; braces a set; parentheses a generator.",
            .listComprehensions
        )
    }

    static func dictSetComprehensionsQuestion() -> DiscreteMathQuestion {
        make(
            "Which syntax builds a set of even numbers from 0-9?",
            ["{x for x in range(10) if x%2==0}", "[x for x in range(10) if x%2==0]", "{x: x%2 for x in range(10)}", "(x for x in range(10) if x%2==0)"],
            0,
            "Braces with a single expression create a set comprehension.",
            .dictSetComprehensions
        )
    }

    static func decoratorsQuestion() -> DiscreteMathQuestion {
        make(
            "Which symbol prefixes a decorator?",
            ["@", "#", "$", "%"],
            0,
            "`@decorator` precedes the function/class header.",
            .decorators
        )
    }

    static func contextManagersQuestion() -> DiscreteMathQuestion {
        make(
            "Which keyword acquires a context manager?",
            ["with", "use", "open", "as"],
            0,
            "`with` ensures deterministic cleanup via `__exit__`.",
            .contextManagers
        )
    }

    static func exceptionsQuestion() -> DiscreteMathQuestion {
        make(
            "Which keyword begins a try/except construct?",
            ["try", "catch", "except", "raise"],
            0,
            "`try` encloses code that may raise.",
            .exceptions
        )
    }

    static func modulesPackagesQuestion() -> DiscreteMathQuestion {
        make(
            "Which file marks a directory as a package (pre-3.3)?",
            ["__init__.py", "__main__.py", "setup.py", "pyproject.toml"],
            0,
            "`__init__.py` historically signals a package.",
            .modulesPackages
        )
    }

    static func iteratorsGeneratorsQuestion() -> DiscreteMathQuestion {
        make(
            "Which keyword yields a value lazily?",
            ["yield", "return", "produce", "next"],
            0,
            "`yield` pauses and resumes generator execution.",
            .iteratorsGenerators
        )
    }

    static func functionsQuestion() -> DiscreteMathQuestion {
        make(
            "Which symbol packs arbitrary positional args in a function signature?",
            ["*", "**", "&", "..."],
            0,
            "`*args` collects extra positional parameters.",
            .functions
        )
    }

    static func stringFormattingQuestion() -> DiscreteMathQuestion {
        make(
            "Which formatting style allows in-line expressions since Python 3.6?",
            ["f-strings", "% formatting", "`str.format`", "Template strings"],
            0,
            "Prefix with `f` to create an f-string.",
            .stringFormatting
        )
    }

    static func fileIOQuestion() -> DiscreteMathQuestion {
        make(
            "Which mode opens a file for reading binary data?",
            ["'rb'", "'r'", "'wb'", "'ab'"],
            0,
            "`'rb'` stands for *read-binary*.",
            .fileIO
        )
    }

    static func loggingQuestion() -> DiscreteMathQuestion {
        make(
            "Which function emits an INFO-level log message?",
            ["logging.info()", "logging.debug()", "logging.warning()", "logging.error()"],
            0,
            "`logging.info()` logs at INFO level.",
            .logging
        )
    }

    static func testingQuestion() -> DiscreteMathQuestion {
        make(
            "Which assertion style is preferred by pytest?",
            ["Plain `assert` statement", "`self.assertEqual`", "`expect`", "`assertThat`"],
            0,
            "Pytest rewrites Python’s `assert` for rich output.",
            .testing
        )
    }

    static func patternMatchingQuestion() -> DiscreteMathQuestion {
        make(
            "Which keyword introduces structural pattern matching?",
            ["match", "switch", "case", "pattern"],
            0,
            "`match` at top level followed by `case` clauses.",
            .patternMatching
        )
    }

    static func virtualEnvQuestion() -> DiscreteMathQuestion {
        make(
            "Which command creates a virtual environment using the std-lib?",
            ["python -m venv env", "pip install virtualenv", "conda create -n env", "virtualenv env"],
            0,
            "`python -m venv` is built-in since 3.3.",
            .virtualEnv
        )
    }

    static func performanceQuestion() -> DiscreteMathQuestion {
        make(
            "Which decorator memoises function results in std-lib?",
            ["functools.lru_cache", "functools.cache", "functools.memoize", "lru"],
            0,
            "`functools.lru_cache` caches call results.",
            .performance
        )
    }

    static func itertoolsFunctoolsQuestion() -> DiscreteMathQuestion {
        make(
            "Which `itertools` function returns a Cartesian product?",
            ["product", "chain", "zip_longest", "combinations"],
            0,
            "`itertools.product` computes Cartesian products.",
            .itertoolsFunctools
        )
    }

    // ──────────────────────────────────────────────────────────
    // NEW  – 20 additional question builders
    // ──────────────────────────────────────────────────────────
    static func indentationQuestion() -> DiscreteMathQuestion {
        make(
            "According to PEP 8, how many spaces should one indentation level be?",
            ["4", "2", "Tab character", "8"],
            0,
            "PEP 8 mandates 4 spaces per level; avoid tabs.",
            .indentation
        )
    }

    static func dataTypesQuestion() -> DiscreteMathQuestion {
        make(
            "Which of these is an *immutable* built-in sequence type?",
            ["tuple", "list", "dict", "set"],
            0,
            "`tuple` cannot be modified after creation.",
            .dataTypes
        )
    }

    static func listsTuplesQuestion() -> DiscreteMathQuestion {
        make(
            "Which list method appends a single element to the end?",
            ["append()", "add()", "push()", "extend()"],
            0,
            "`list.append(x)` adds *one* element.",
            .listsTuples
        )
    }

    static func setsDictsQuestion() -> DiscreteMathQuestion {
        make(
            "Which operator tests membership in a dictionary’s *keys*?",
            ["in", "has", "contains", "exists"],
            0,
            "`key in my_dict` checks key membership.",
            .setsDicts
        )
    }

    static func slicingQuestion() -> DiscreteMathQuestion {
        make(
            "What is the result of \"abcde\"[1:4] ?",
            ["\"bcd\"", "\"abc\"", "\"bcde\"", "\"abcd\""],
            0,
            "Slice is inclusive of start index 1 and exclusive of stop index 4.",
            .slicing
        )
    }

    static func variableScopeQuestion() -> DiscreteMathQuestion {
        make(
            "Which keyword re-binds an *enclosing-scope* variable inside a nested function?",
            ["nonlocal", "global", "outer", "static"],
            0,
            "`nonlocal` targets the nearest enclosing (non-global) scope.",
            .variableScope
        )
    }

    static func builtinsQuestion() -> DiscreteMathQuestion {
        make(
            "Which built-in converts an iterable into a *set*?",
            ["set()", "list()", "tuple()", "dict()"],
            0,
            "`set(iterable)` removes duplicates and returns a set.",
            .builtins
        )
    }

    static func sortingQuestion() -> DiscreteMathQuestion {
        make(
            "Which parameter of `sorted()` lets you supply a custom key function?",
            ["key", "cmp", "order", "by"],
            0,
            "`sorted(seq, key=str.lower)` for case-insensitive sort.",
            .sorting
        )
    }

    static func regexQuestion() -> DiscreteMathQuestion {
        make(
            "Which std-lib module provides regular expressions?",
            ["re", "regex", "pattern", "regexp"],
            0,
            "`import re` gives access to regex functionality.",
            .regex
        )
    }

    static func serializationQuestion() -> DiscreteMathQuestion {
        make(
            "Which function serialises a Python object to a JSON *string*?",
            ["json.dumps()", "json.dump()", "json.loads()", "json.load()"],
            0,
            "`json.dumps(obj)` → str; `dump()` writes to a file.",
            .serialization
        )
    }

    static func subprocessQuestion() -> DiscreteMathQuestion {
        make(
            "Which `subprocess` helper executes a command and returns a `CompletedProcess`?",
            ["subprocess.run()", "subprocess.call()", "subprocess.Popen()", "subprocess.check_output()"],
            0,
            "`run()` is a high-level wrapper introduced in Python 3.5.",
            .subprocessModule
        )
    }

    static func networkingQuestion() -> DiscreteMathQuestion {
        make(
            "Which THIRD-PARTY library is famous for simplifying HTTP requests?",
            ["Requests", "urllib", "http.client", "aiohttp"],
            0,
            "`Requests` (pip install requests) offers a friendly API.",
            .networking
        )
    }

    static func oopInheritanceQuestion() -> DiscreteMathQuestion {
        make(
            "Choose the correct syntax for declaring a class *Child* that inherits from *Base*.",
            ["class Child(Base): pass", "class Child < Base: pass", "class Child inherits Base: pass", "class Child: Base"],
            0,
            "Put the base class in parentheses after the class name.",
            .oopInheritance
        )
    }

    static func magicMethodsQuestion() -> DiscreteMathQuestion {
        make(
            "Which magic method makes an object *iterable*?",
            ["__iter__", "__len__", "__call__", "__next__"],
            0,
            "`__iter__` must return an iterator.",
            .magicMethods
        )
    }

    static func propertiesQuestion() -> DiscreteMathQuestion {
        make(
            "Which decorator turns a method into a read-only attribute?",
            ["@property", "@cached_property", "@attribute", "@getter"],
            0,
            "`@property` decorates a zero-argument method.",
            .properties
        )
    }

    static func advancedTypingQuestion() -> DiscreteMathQuestion {
        make(
            "Which typing construct restricts a value to a fixed set of literals?",
            ["typing.Literal", "typing.Union", "typing.Any", "typing.Optional"],
            0,
            "`Literal[\"red\", \"green\"]` enforces specific allowed strings.",
            .advancedTyping
        )
    }

    static func metaclassesQuestion() -> DiscreteMathQuestion {
        make(
            "Which dunder attribute sets a custom metaclass (Py 2 legacy style)?",
            ["__metaclass__", "__class__", "__buildclass__", "__meta__"],
            0,
            "In modern code use `class X(metaclass=Meta): …` at class header.",
            .metaclasses
        )
    }

    static func debuggingQuestion() -> DiscreteMathQuestion {
        make(
            "Which built-in module provides an interactive debugger?",
            ["pdb", "debug", "inspect", "logging"],
            0,
            "`import pdb; pdb.set_trace()` drops into the debugger.",
            .debugging
        )
    }

    static func styleGuideQuestion() -> DiscreteMathQuestion {
        make(
            "Which tool auto-formats Python code according to PEP 8?",
            ["black", "flake8", "pylint", "autopep8"],
            0,
            "`black` makes code *uniformly* formatted (“any colour you like”).",
            .styleGuide
        )
    }

    static func databaseSqliteQuestion() -> DiscreteMathQuestion {
        make(
            "Which std-lib module offers built-in SQLite database support?",
            ["sqlite3", "mysqldb", "pysqlite", "sqlalchemy"],
            0,
            "`sqlite3` has been in the std-lib since Python 2.5.",
            .databaseSqlite
        )
    }
}
