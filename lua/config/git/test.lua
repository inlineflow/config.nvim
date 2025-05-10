local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")

-- Custom entry display with two "lines" visually
local displayer = entry_display.create({
  separator = "abc",
  items = {
    { width = 50 },       -- First line width
    { remaining = true }, -- Second line fills the rest
  },
})

-- Format the display of each entry
local make_display = function(entry)
  return displayer({
    entry.line1,
    entry.line2,
  })
end

-- Entry maker function
local entry_maker = function(entry)
  return {
    value = entry,
    ordinal = entry.line1 .. " " .. entry.line2, -- used for filtering
    display = make_display,
    line1 = entry.line1,
    line2 = entry.line2,
  }
end

-- Sample data
local entries = {
  { line1 = "Fix bug in API",        line2 = "Related to ticket #123" },
  { line1 = "Refactor login module", line2 = "Improves security and speed" },
  { line1 = "Update README",         line2 = "Add installation instructions" },
}

-- Create the picker
pickers.new({}, {
  prompt_title = "Multi-line Entries",
  finder = finders.new_table({
    results = entries,
    entry_maker = entry_maker,
  }),
  sorter = conf.generic_sorter({}),
}):find()
