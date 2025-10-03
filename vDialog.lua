--[[============================================================================
vDialog - Minimal implementation for cLib TestRunner
============================================================================]]--

-- Minimal vDialog implementation for cLib TestRunner
-- This is a simplified version that provides just enough functionality
-- for the TestRunner to work without requiring the full vLib

vDialog = {}
vDialog.__index = vDialog

function vDialog:__init(args)
  local self = {}
  setmetatable(self, vDialog)
  
  self.dialog_title = args.dialog_title or "Dialog"
  self.waiting_to_show_dialog = args.waiting_to_show_dialog or false
  
  return self
end

function vDialog:show()
  if not self.dialog then
    local content = self:create_dialog()
    self.dialog = renoise.app():show_custom_dialog(
      self.dialog_title,
      content
    )
  else
    self.dialog:show()
  end
end

function vDialog:close()
  if self.dialog then
    self.dialog:close()
    self.dialog = nil
  end
end

function vDialog:create_dialog()
  -- This should be overridden by subclasses
  local vb = renoise.ViewBuilder()
  return vb:column {
    margin = 10,
    vb:text { text = "Default dialog content" }
  }
end
