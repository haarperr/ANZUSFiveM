lib.callback.register('qb-spawn:server:getOwnedHouses', function(_, cid)
  if cid ~= nil then
    local houses = MySQL.query.await([[
          SELECT
              CASE
                  WHEN p.type = 'MLO' THEN JSON_EXTRACT(p.metadata, '$.yardZone.center')
                  WHEN p.buildingid IS NOT NULL THEN JSON_EXTRACT(b.metadata, '$.enterData')
                  ELSE JSON_EXTRACT(p.metadata, '$.enterData')
              END AS camCoords,
              p.id,
              p.label
          FROM
              properties p
          LEFT JOIN
              buildings b ON p.buildingId = b.id
          WHERE p.owner = ?;
      ]], { cid }) -- NEW
    if houses[1] ~= nil then
      return houses
    end
  end
end)
