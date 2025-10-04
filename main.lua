--[[============================================================================
main.lua
============================================================================]]--

-- Simple class function implementation for compatibility
if not class then
  function class(name, parent)
    local class_table = {}
    class_table.__index = class_table
    class_table.__name = name
    
    if parent then
      -- Handle inheritance properly
      if type(parent) == "string" then
        -- Parent is a string name, get the actual class
        parent = _G[parent]
      end
      if parent then
        setmetatable(class_table, {__index = parent})
      end
    end
    
    local constructor = function(self, ...)
      local instance = {}
      setmetatable(instance, class_table)
      if class_table.__init then
        class_table.__init(instance, ...)
      end
      return instance
    end
    
    _G[name] = constructor
    return constructor
  end
end

-- Simple table.create implementation for compatibility
if not table.create then
  function table.create(size, default_value)
    local t = {}
    if size then
      for i = 1, size do
        t[i] = default_value
      end
    end
    return t
  end
end

--[[

Unit-tests for the cLib library
.
#

TODO 
* capture results from asynchroneous test methods

PLANNED 
* turn tool into simple testrunner framework (class)


]]
local SLAXML=nil
_tests = table.create()
_test_path = "unit_tests"

_trace_filters = {".*"}
_clibroot = "classes/"
separator = package.config:sub(1,1)  -- Gets \ for Windows, / for Unix

require (_clibroot.."cLib")
require (_clibroot.."cDebug")
require (_clibroot.."cFilesystem")
require (_clibroot.."cParseXML")

require ("vDialog")
require ("TestRunner")

--------------------------------------------------------------------------------
-- test runner
--------------------------------------------------------------------------------

-- this string is assigned as the dialog title
APP_DISPLAY_NAME = "cLib"

-- TestRunner, the dialog containing the app 
local runner = nil


-- implementing preferences as a class only has benefits
-- (you can still use renoise.tool().preferences from anywhere...)   
local prefs = TestRunnerPrefs()
renoise.tool().preferences = prefs

rns = nil 

--------------------------------------------------------------------------------
-- Show the application UI 
--------------------------------------------------------------------------------

function show()

  -- set global reference to the renoise song
  rns = renoise.song()

  -- create dialog if it doesn't exist
  if not runner then
    runner = TestRunner{
      dialog_title = APP_DISPLAY_NAME,
      waiting_to_show_dialog = prefs.autostart.value,
      tests = _tests,
      test_path = _test_path,
    }
  end

  runner:show()
  
end

--------------------------------------------------------------------------------
-- menu entries
--------------------------------------------------------------------------------

renoise.tool():add_menu_entry {
  name = "Main Menu:Tools:"..APP_DISPLAY_NAME,
  invoke = function()
    show()
  end  
}

--------------------------------------------------------------------------------
-- notifications
--------------------------------------------------------------------------------

renoise.tool().app_new_document_observable:add_notifier(function()
  rns = renoise.song()
  if prefs.autostart.value then
    show()
  end
end)
