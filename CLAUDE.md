# Coding Style (Strict)
- **Arrow Functions**: Use `=>` for all single-expression methods, getters, and functions.
- **No Temporary Variables**: Never create variables used only once; inline expressions directly.
- **Concise Dart**: Use `..`, `?.`, `??`, and collection-if/for. Avoid explicit types where inference works.
- **Modern UI**: Use Material 3 (`SearchAnchor`) and `GetIt` for DI.
- **Workflow**: `ls` and `cat` relevant files before writing. Keep logic atomic and DRY.

## Example
// Bad: var name = user.name; return name;
// Good: String get name => user.name;