# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Fucking Math** is a Flutter application designed to help students efficiently manage and study their mistake problems (错题本). It provides a comprehensive system for recording, tagging, and reviewing mathematical errors along with related knowledge points.

**Current Status**: Pre-MVP (v0.0.x) - Early development, database schema may change before v0.1.0

## Development Commands

### Build & Run
- `flutter pub get` - Install dependencies
- `flutter pub upgrade --major-versions` - Upgrade dependencies to latest major versions
- `flutter run` - Run app in debug mode
- `flutter run -d <device_id>` - Run on specific device
- `dart run build_runner build` - Generate Drift database code (required after modifying database tables)
- `dart run build_runner watch` - Watch mode for automatic code generation

### Analysis & Testing
- `flutter analyze` - Run static analysis on Dart code
- `flutter test` - Run all unit tests
- `flutter test test/specific_test.dart` - Run specific test file

### Release
- `flutter build <platform>` - Build for Android, iOS, Windows, Linux, or macOS

## Architecture

The project follows a **4-layer architecture**:

```
UI (Widgets)
    ↓
Provider (State Management + Business Logic)
    ↓
Repository (Data Abstraction)
    ↓
Dao (Database Access Objects from Drift)
    ↓
Database (SQLite via Drift)
```

### Routing Structure (`lib/pages/router_config.dart`)

Uses **GoRouter** with a shell-based navigation system. Three main modules have shell routes with nested sub-pages:

- **English Module** (`/english_shell`): Word learning, editor
- **Mistakes Module** (`/mistakes_shell`): Mistake practice, editor
- **Knowledge Module** (`/knowledge_shell`): Knowledge review, editor
- **Top-level routes**: Home, Tags Manager, Settings, Debug (debug mode only)

Custom `RouterConfig` class provides unified configuration for both GoRouter navigation and NavRail bottom navigation.

### Database (`lib/db/`)

**Drift** is used for type-safe database access with SQLite. Key components:

- **Tables** (`tables/`):
  - `tables_english.dart` - Words, Phrases, WordLogs, PhraseLogs, WordTagLink, PhrasesTagLink
  - `tables_knowledge.dart` - Knowledge, KnowledgeLogs, KnowledgeTagLink
  - `tables_mistakes.dart` - Mistakes, Answers, MistakeAnalysis, MistakePicsLink, AnswerPicsLink, MistakeLogs, AnswersTagsLink, MistakeKnowledgeLink
  - `tables_tags.dart` - Tags
  - `tables_images.dart` - Images

- **DAOs** (`daos/`): `TagsDao`, `WordsDao`, `KnowledgeDao`, `MistakesDao`, `PhrasesDao`, `ImagesDao`
  - Each DAO is auto-generated from its corresponding table definition
  - Always run `dart run build_runner build` after modifying table definitions or DAO methods

- **Database Initialization** (`app_database.dart`):
  - Schema version is always 1 until MVP (v0.1.0)
  - Default tags are created on first run via `DefaultTag` enum (configured in `lib/configs/tags.dart`)

### Provider Pattern (`lib/providers/`)

**Base Classes** (`base_db_proivder.dart`):

- `BaseProvider` - Handles loading state and error messages
  - `isLoading`, `error` getters
  - Protected methods: `onLoading()`, `onStopLoading()`, `setError(msg)`, `clearError()`

- `BaseRepositoryProvider<T, R>` - Extends BaseProvider with item management
  - Holds a repository instance and list of items
  - Protected methods: `setItems(list)`, `getItems` getter

**Mixins**:

- `ProviderActionNotifier` - Encapsulates try-catch-finally logic for async operations
  - `justDoIt()` - Execute action, handle state/errors, notify listeners (returns void)
  - `justDoItNext<T>()` - Same but returns the action result

- `FuzzySearchMixin<T, R>` - Provides fuzzy search filtering
  - `search(query)` - Updates search results
  - `filteredList` getter - Returns filtered or full list
  - Requires subclass to define `fuzzyKeys` property with `WeightedKey<T>` list

- `SingleObjectSelectMixin<T>` - Single item selection state
  - `select(item)`, `selectedItem` getter, `isSelected(item)` check

**Provider Implementations**:
- `WordsProvider`, `PhraseProvider`, `TagProvider`, `KnowledgeProvider`, `MistakesProvider`, `ImagesProvider`
- All providers auto-load their data on creation

### Repository Pattern (`lib/utils/repository/`)

Repositories abstract database operations:

- Take a DAO in constructor
- Provide public async methods for CRUD operations
- Handle validation and error conversion
- Example: `TagRepository(dao).upsertTag(tag)`, `saveTag(name, ...)`

### Configuration (`lib/configs/`)

- `config.dart` - App-wide settings, theme, database path
- `tags.dart` - Default tags configuration (via `DefaultTag` enum)
- `config_loader.dart` - TOML-based configuration loading

### Utilities (`lib/utils/`)

- `types.dart` - Subject enum and converter for Drift
- `uuid.dart` - UUID generation helpers
- `image.dart` - Image handling utilities
- `form/` - Form validation utilities
- `mixin/` - Reusable mixins (form_helper, provider_error_handle)
- `repository/helper/` - Exception types and utility functions

## Code Patterns & Conventions

### Adding a New Database Feature

1. **Define Table** in `lib/db/tables/tables_*.dart`:
   ```dart
   @DataClassName("MyItem")
   class MyTable extends Table {
     IntColumn get id => integer().autoIncrement()();
     TextColumn get name => text()();
     // ... more columns
   }
   ```

2. **Create DAO** in `lib/db/daos/my_item.dart`:
   ```dart
   @DriftAccessor(tables: [MyTable])
   class MyItemDao extends DatabaseAccessor<AppDatabase> {
     MyItemDao(AppDatabase db) : super(db);
     // Define queries here
   }
   ```

3. **Add to AppDatabase**:
   - Import DAO in `app_database.dart`
   - Add table to `@DriftDatabase(tables: [...], daos: [...])`
   - Generate code: `dart run build_runner build`

4. **Create Repository** in `lib/utils/repository/my_item.dart`:
   - Wrap DAO operations with error handling
   - Provide business-logic methods

5. **Create Provider** in `lib/providers/my_items.dart`:
   - Extend `BaseRepositoryProvider<MyItem, MyItemRepository>`
   - Mix in `FuzzySearchMixin` if search is needed
   - Implement `fuzzyKeys` getter
   - Call `loadItems()` to fetch data

### Adding a New Page/Feature

1. Create page file in `lib/pages/<module>/` with appropriate Shell structure
2. Update router config in `lib/pages/router_config.dart`
3. Create or reuse provider in `lib/providers/`
4. Add widgets to `lib/widget/`

### Form Handling

Common patterns in form widgets:
- Use `BaseForm` or `FormBuilder` utilities from `lib/widget/forms/`
- Mix `FormHelper` mixin for common form operations
- Use `ProviderErrorHandle` mixin in widgets to display provider errors

### Fuzzy Search Implementation

When implementing search in a provider:
```dart
class MyItemsProvider extends BaseRepositoryProvider<MyItem, MyItemRepository>
    with FuzzySearchMixin<MyItem, MyItemRepository> {

  @override
  List<WeightedKey<MyItem>> get fuzzyKeys => [
    WeightedKey(name: 'title', getter: (item) => item.title, weight: 1),
    WeightedKey(name: 'description', getter: (item) => item.description, weight: 0.5),
  ];

  // Usage in UI: provider.search("query")
  // Access results: provider.filteredList
}
```

## Important Notes

### Database Schema Changes
- **Before MVP (v0.1.0)**: No database migration support provided yet
- Update `schemaVersion` in `AppDatabase.get schemaVersion` when making breaking changes
- Running app with new schema may require deleting old database

### Code Quality
- Project uses AI-assisted development - focus on functionality over perfection
- Many components are subject to refactoring as features mature
- Static analysis defaults to Flutter lints (`flutter_lints`)

### Git Workflow
- Currently all active development is on `main` branch
- After v0.1.0, active development moves to `dev` branch

## File Structure Summary

```
lib/
├── db/                    # Database layer (Drift)
│   ├── tables/           # Drift table definitions
│   ├── daos/             # Data access objects
│   └── app_database.dart # Database configuration
├── pages/                # UI pages/screens
│   ├── routers/          # Navigation shells
│   ├── english/          # English module pages
│   ├── mistakes/         # Mistakes module pages
│   ├── knowledge/        # Knowledge module pages
│   └── router_config.dart # Routing configuration
├── providers/            # State management layer
├── utils/                # Business logic & utilities
│   ├── repository/       # Repository layer
│   └── mixin/            # Reusable mixins
├── widget/               # Reusable widgets & components
│   ├── common/           # Common widgets (tag_selection, images_picker, etc.)
│   ├── forms/            # Form-related widgets
│   ├── inputs/           # Input widgets
│   ├── navigation/       # Navigation widgets
│   ├── mistake/          # Mistake-related widgets
│   └── knowledge/        # Knowledge-related widgets
├── configs/              # Configuration files
├── extensions/           # Dart extensions
└── main.dart             # App entry point
```

