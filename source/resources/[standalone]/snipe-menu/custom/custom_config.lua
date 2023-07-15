CustomPanels = {
  {
    panelTitle = "Custom Panel",
    submitUrl = "customPanelSubmit", -- the callback triggered when you press the submit button on the custom panel. This callback is in client.lua and has the data along with it.
    components = {
      {
        type = "string-input", -- (CHECK README FOR ALL TYPES)
        placeholder = "Enter a string",
        label = "Input String",
        fillCompulsory = true,     --true or false based on if required or not
        keyName = "stringInputKey" --cannot have spaces and should always be unique for each custom panel components - used for sending data after submission
      },
      {
        type = "number-input", -- (CHECK README FOR ALL TYPES)
        placeholder = "Enter a number",
        label = "Input Number",
        fillCompulsory = true,     --true or false based on if required or not
        keyName = "numberInputkey" --cannot have spaces and should always be unique for each custom panel components - used for sending data after submission
      },
      {
        type = "searchable-dropdown",     -- (CHECK README FOR ALL TYPES)
        placeholder = "",                 --not needed
        fetchDataUrl = "customfetchurl",  -- data for this type:  {{id = key1, name = "value1"}, {id = key2, name = "value2"}}
        label = "Player List",
        fillCompulsory = true,            --true or false based on if required or not
        keyName = "searchableDropDownkey" --cannot have spaces and should always be unique for each custom panel components - used for sending data after submission
      },
      {
        type = "regular-dropdown",        -- (CHECK README FOR ALL TYPES)
        placeholder = "",                 --not needed
        fetchDataUrl = "customfetchurl2", -- data for this type: {"value1", "value2"}
        label = "Player List 2",
        fillCompulsory = true,            --true or false based on if required or not
        keyName = "regularDropDownKey"    --cannot have spaces and should always be unique for each custom panel components - used for sending data after submission
      },
      {
        type = "checkbox-input",     -- (CHECK README FOR ALL TYPES)
        placeholder = "",            --not needed
        label = "CustomCheckboxLabel",
        fillCompulsory = true,       --true or false based on if required or not
        keyName = "checkboxInputkey" --cannot have spaces and should always be unique for each custom panel components - used for sending data after submission
      },
    }
  },
  {

    panelTitle = 'Custom Click Button',
    submitUrl = 'custom-clicked', -- in this case, clicking the panel will call this url
    components = {}               -- if the new panel is only clickable without any inputs in it, keep this array empty
  },
  {
    panelTitle = 'Put Player In Vehicle',
    submitUrl = 'putinvehicle', -- in this case, clicking the panel will call this url
    components = {}             -- if the new panel is only clickable without any inputs in it, keep this array empty
  }
}
