# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Fucking Math** is a Flutter application designed to help students efficiently manage and study their mistake problems (错题本). It provides a comprehensive system for recording, tagging, and reviewing mathematical errors along with related knowledge points.

**Current Status**: Pre-MVP (v0.0.x) - Early development, database schema may change before v0.1.0

## Development Commands

### Build & Run
- `flutter pub get` - Install dependencies
- `flutter run` - Run app in debug mode
- `dart run build_runner build` - Generate Drift database code (required after modifying tables/DAOs)

### Analysis & Testing
- `flutter analyze` - Run static analysis
- `flutter test` - Run all unit tests

### Release
- `flutter build <platform>` - Build for Android, iOS, Windows, Linux, or macOS

## Architecture

4-layer architecture:

```
UI (Widgets) → Provider (State + Logic) → Repository (Abstraction) → DAO (Drift) → SQLite
```

### Routing (`lib/pages/router_config.dart`)

GoRouter with shell-based navigation. Three main modules: English (`/english_shell`), Mistakes (`/mistakes_shell`), Knowledge (`/knowledge_shell`). Top-level routes: Home, Tags Manager, Settings, Debug (debug mode only).

### Database (`lib/db/`)

**Drift** for type-safe SQLite access.

- **Tables** (`tables/`): `tables_english.dart`, `tables_knowledge.dart`, `tables_mistakes.dart`, `tables_tags.dart`, `tables_images.dart`, `tables_ai.dart`
- **DAOs** (`daos/`): `TagsDao`, `WordsDao`, `KnowledgeDao`, `MistakesDao`, `PhrasesDao`, `ImagesDao`, `AiProviderDao`, `AiHistoryDao`, `AiHistoryImagesLinkDao`, `PromptDao`
  - DAOs return Drift data classes (e.g., `SessionData`), converted to business types in Repository layer
  - Always run `dart run build_runner build` after modifying table/DAO definitions
- **Schema version**: Always 1 until MVP (v0.1.0). Breaking changes may require deleting old database.

### Provider Pattern (`lib/providers/`)

- `BaseProvider` - Loading state + error handling (`isLoading`, `error`, `onLoading()`, `setError()`)
- `BaseRepositoryProvider<T, R>` - Extends BaseProvider with item list management
- `ProviderActionNotifier` mixin - `justDoIt()` (void) / `justDoItNext<T>()` (returns result) for async operations
- `FuzzySearchMixin<T, R>` - `search(query)`, `filteredList`, requires `fuzzyKeys` getter
- `SingleObjectSelectMixin<T>` - Single item selection state
- All providers auto-load data on creation

### Repository Pattern (`lib/utils/repository/`)

Repositories wrap DAOs with error handling and business logic. Take a DAO in constructor, provide async CRUD methods, handle validation and exception conversion.

### AI Module (`lib/ai/`)

#### Types (`types.dart`)
- `Roles` enum (user, system, tool, assistant)
- `AiProvider` - Business type for provider config (note: Drift also generates an `AiProvider` data class with non-null `id`)
- `Message` - Message with role, content, toolCalls, toolId, images
- `Session`, `Prompt`, `Conversation` (with `toOpenAIFormat()` and immutable `addMessage()`)
- `AiResponse` - Raw API response data class

#### Repositories (`lib/ai/repository/`)
- `AiProviderRepository` - Provider management
- `AiHistoryRepository(AiHistoryDao, AiHistoryImagesLinkDao)` - Message & Session CRUD, type conversion, image management
  - Key method: `getConversation(sessionId, providerId)` - Fetch complete conversation
- `PromptRepository` - Prompt management with search

#### Config (`lib/ai/config/ai_config.dart`)
- `AiConfig` - Global singleton (ChangeNotifier), manages active AI provider
- Exposes `activeProvider`, `baseUrl`, `apiKey`

#### Tools (`lib/ai/tools/`)
- `BaseAiTool` (`_base_tool.dart`) - Abstract base with `name`, `description`, `fields`, `toJsonDefinition()`
- `call(Map<String, dynamic> args, [ToolContext? context])` - Optional `ToolContext` for logging/interaction
- `AiType` hierarchy (`AiString`, `AiInt`, `AiObject`) + `AiField` for typed parameter definitions

#### Engine (`lib/ai/engine/`) - Task Execution Engine

Core execution engine implementing the self-managing loop: API request → tool parsing → user confirmation → tool execution → result persistence.

- **`TaskEvent`** (`task_event.dart`) - Sealed class event protocol for UI decoupling:
  - `ThinkingEvent` - AI text response
  - `ToolStartEvent` / `ToolEndEvent` - Tool execution lifecycle
  - `LogEvent` - Tool internal logs
  - `WaitUserEvent` - Suspends loop for user confirmation (via Completer)
  - `ErrorEvent` / `DoneEvent` - Terminal states

- **`ToolCall`** (`tool_context.dart`) - Parsed from `AiResponse.toolCalls` JSON string via `ToolCall.parseFromJson()`
- **`ToolContext`** (`tool_context.dart`) - Injected into `BaseAiTool.call()`, provides `onLog` and `onConfirm` callbacks. `ToolContext.noop` for tests.

- **`AiTaskProcessor`** (`ai_task_processor.dart`) - Core engine:
  - Constructor: `taskId`, `providerId`, `sessionId`, `model`, `tools`, `systemPrompt?`, `aiConfig`, `historyRepo`, `maxIterations=10`
  - `run()` - Starts the while loop. Loads conversation from DB, calls API, processes tool calls, persists all messages
  - `events` stream - UI subscribes via StreamBuilder
  - `respond(bool)` - Resumes from WaitUserEvent
  - `interrupt()` - Cleanly stops the loop
  - System prompt is prepended to API messages (not stored in DB)
  - Single tool failure returns error text as result, doesn't interrupt the batch
  - Provider config (baseUrl/apiKey) captured at `run()` start to prevent mid-task switching

- **`AiTaskService`** (`ai_task_service.dart`) - Manages multiple processors:
  - `startTask(sessionId, model, tools, systemPrompt?, maxIterations?)` - Creates & starts processor
  - `getTask(taskId)` - Retrieve existing processor (UI reconnect)
  - `cancelTask(taskId)` - Interrupt & remove
  - `cleanupCompleted()` - Remove finished tasks

#### Exception Handling (`lib/utils/repository/helper/exceptions.dart`)
- `AiSessionNotFoundException`, `AiPromptNotFoundException`, `AiProviderNotFoundException`
- `AiHistoryException` - Business logic errors
- `AiTaskException` - Task engine errors (with optional `taskId`)
- **Rule**: Use custom exceptions for business logic; reserve `AppDatabaseException` for severe structural DB failures

### Configuration (`lib/configs/`)
- `config.dart` - App-wide settings, theme, database path
- `tags.dart` - Default tags via `DefaultTag` enum
- `config_loader.dart` - TOML-based configuration loading

### Utilities (`lib/utils/`)
- `types.dart` - Subject enum, ImageStorage, Drift converters
- `uuid.dart` - UUID generation (`getUuidV1()`)
- `form/`, `mixin/`, `repository/helper/` - Form validation, reusable mixins, exception types

## Code Patterns & Conventions

### Adding a New Database Feature
1. Define table in `lib/db/tables/tables_*.dart`
2. Create DAO in `lib/db/daos/`, add to `@DriftDatabase` in `app_database.dart`
3. Run `dart run build_runner build`
4. Create Repository wrapping DAO with error handling
5. Create Provider extending `BaseRepositoryProvider`, mix in `FuzzySearchMixin` if needed

### Adding a New Page
1. Create page in `lib/pages/<module>/`
2. Update `lib/pages/router_config.dart`
3. Create or reuse Provider, add widgets to `lib/widget/`

### AI Tool Implementation
Extend `BaseAiTool`, define `name`, `description`, `fields`, implement `call()`. Use optional `ToolContext` parameter for logging (`context?.onLog()`) and user confirmation (`context?.onConfirm()`).

### GetIt Service Registration (`main.dart`)
Key singletons: `AppDatabase`, `Dio`, `AiConfig`, `AiHistoryRepository`, `AiTaskService`, all domain Providers. Providers are also registered with `MultiProvider` for widget tree access.

## Important Notes

- **Drift types vs business types**: Drift generates data classes (e.g., Drift `AiProvider` has non-null `int id`). Business types in `ai/types.dart` (e.g., `AiProvider` has `int? id`). Repositories handle conversion.
- **Git**: All development on `main` branch until v0.1.0, then moves to `dev`
- **Code quality**: AI-assisted development, focus on functionality. Static analysis via `flutter_lints`.

## File Structure

```
lib/
├── ai/
│   ├── types.dart            # Business models (Message, Conversation, etc.)
│   ├── client.dart           # High-level AI assistant
│   ├── config/               # AiConfig (provider management)
│   ├── core/                 # AiClient (Dio → OpenAI API)
│   ├── engine/               # Task execution engine
│   │   ├── task_event.dart   # TaskEvent sealed class
│   │   ├── tool_context.dart # ToolCall + ToolContext
│   │   ├── ai_task_processor.dart  # Core while-loop engine
│   │   └── ai_task_service.dart    # Multi-task manager
│   ├── repository/           # AiProviderRepo, AiHistoryRepo, PromptRepo
│   └── tools/                # BaseAiTool + implementations
├── db/
│   ├── tables/               # Drift table definitions
│   ├── daos/                 # Data access objects
│   └── app_database.dart     # Database configuration
├── pages/
│   ├── routers/              # Navigation shells
│   ├── english/              # English module
│   ├── mistakes/             # Mistakes module
│   ├── knowledge/            # Knowledge module
│   └── router_config.dart    # GoRouter configuration
├── providers/                # State management (Words, Tags, Knowledge, Mistakes, etc.)
├── utils/
│   ├── repository/           # Repository layer + helper/exceptions
│   └── mixin/                # Reusable mixins
├── widget/                   # Reusable UI components
├── configs/                  # App config, default tags, TOML loader
├── extensions/               # Dart extensions
└── main.dart                 # Entry point + GetIt/Provider registration
```
