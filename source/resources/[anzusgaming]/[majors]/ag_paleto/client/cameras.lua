local function viewCameras()
  local options = {}
  for i = 1, 3, 1 do
    options[#options + 1] = {
      title = ('Paleto Office %d'):format(i),
      icon = 'circle',
      onSelect = function()
        lib.hideContext()
        Camera(('office%d'):format(i))
      end,
    }
  end

  lib.registerContext({
    id = 'paleto_major_cameras',
    title = 'Security Cameras',
    options = options
  })

  lib.showContext('paleto_major_cameras')
end

function SetupCameraZone(index)
  local config = Config.Paleto.camera[index]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        name = ('agmajor:PaletoPaletoCameras%d'):format(index),
        label = 'Cameras',
        icon = 'fas fa-video',
        onSelect = function()
          viewCameras()
        end,
        distance = 2
      }
    },
  })
end
