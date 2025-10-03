# About cLib

cLib is pure lua library which can make scripting with the Renoise API a bit easier.  
The library contains methods for working with the file system, basic data-types (string, table and so on), as well other lua/Renoise API-specific details. 

## Documentation

Point your browser to this location to browse the auto-generated luadocs:
https://renoise.github.io/libraries/clib/

## Running Unit Tests

This extension includes a comprehensive unit test suite for all cLib classes. To run the tests:

1. **Launch the Test Runner**: Go to `Tools > cLib` in Renoise
2. **Select Tests**: Use checkboxes to select which tests to run
3. **Run Tests**: Click "Run tests" for individual tests or "Run all selected tests" for batch testing
4. **View Results**: Check the status column for "Passed", "Failed", or "Running..." results

### Available Test Suites

- **cLib** - Core utility functions (scaling, clamping, rounding, etc.)
- **cNumber** - Number class with arithmetic operations
- **cFilesystem** - File system operations and path handling
- **cConvert** - Audio conversion (Hz, frames, notes)
- **cReflection** - Object introspection and property access
- **cObservable** - Observable pattern implementation
- **cParseXML** - XML parsing and document handling
- **cTable** - Table manipulation utilities

## Debugging with cLib

As an alternative to using print statements in your code, you can call the TRACE/LOG methods. 

**LOG** = Print to console  
**TRACE** = Print debug info (when debugging is enabled) 

cLib comes with a dedicated class for debugging called cDebug. Including this class will replace the standard TRACE and LOG methods with more sophisticated versions.

## Extension Features

- **Test Runner Interface**: Full-featured UI for running and managing unit tests
- **Automatic Test Discovery**: Scans the unit_tests folder for test files
- **Error Handling**: Detailed error messages and status reporting
- **Preferences**: Autostart option for the test runner
- **Menu Integration**: Accessible via Tools menu in Renoise 

