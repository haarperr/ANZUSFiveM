local MySQL = MySQL
local db = {}

local SQL_QUERIES = {
  ADD_CANDIDATE = 'INSERT INTO election (name) VALUES (?)',
  GET_CANDIDATES = 'SELECT id, name from election',
  DELETE_CANDIDATE = 'DELETE FROM election WHERE id = ?',
  UPSERT_SETTING = 'REPLACE INTO settings (`key`, `value`) VALUES (?, ?)',
  GET_SETTING = 'SELECT value from settings WHERE `key` = ?',
  VIEW_RESULTS = 'SELECT results FROM election_archive ORDER BY created DESC LIMIT 1',
  FORMAT_ELECTION_RESULTS =
  'SELECT GROUP_CONCAT(JSON_OBJECT( "id", id, "name", NAME, "votes", ( SELECT GROUP_CONCAT(userid) FROM election_votes ev WHERE ev.candidate = e.id ), "sum", ( SELECT COUNT(userid) FROM election_votes ev WHERE ev.candidate = e.id ))) as data FROM election e',
  ARCHIVE_RESULTS = 'INSERT INTO election_archive (results) VALUES (?)',
  WIPE_CANDIDATES = 'TRUNCATE TABLE election',
  VOTE_CANDIDATE = 'UPDATE election SET votes = votes + 1 WHERE id = ?',
  ADD_USER_VOTE = 'INSERT INTO election_votes (userid, candidate) VALUES (?, ?)',
  GET_VOTES = 'SELECT userid FROM election_votes'
}

---@param name string
---@return number
function db.addCandidate(name)
  return MySQL.insert.await(SQL_QUERIES.ADD_CANDIDATE, { name })
end

function db.getCandidates()
  return MySQL.query.await(SQL_QUERIES.GET_CANDIDATES)
end

---@param id number
function db.deleteCandidate(id)
  return MySQL.prepare.await(SQL_QUERIES.DELETE_CANDIDATE, { id })
end

function db.getResults()
  return MySQL.query.await(SQL_QUERIES.VIEW_RESULTS)
end

function db.startElection()
  local queries = { { query = SQL_QUERIES.UPSERT_SETTING, values = { 'election_started', '1' } },
    { query = SQL_QUERIES.UPSERT_SETTING, values = { 'election_end', os.time() + (7 * 24 * 60 * 60) } } }

  return MySQL.transaction.await(queries)
end

function db.stopElection()
  local election_results = MySQL.query.await(SQL_QUERIES.FORMAT_ELECTION_RESULTS)
  local queries = {
    { query = SQL_QUERIES.UPSERT_SETTING,  values = { 'election_started', '0' } },
    { query = SQL_QUERIES.UPSERT_SETTING,  values = { 'election_end', nil } },
    { query = SQL_QUERIES.ARCHIVE_RESULTS, values = { string.format('[%s]', election_results[1].data) } },
    { query = SQL_QUERIES.WIPE_CANDIDATES, values = {} },
  }

  return MySQL.transaction.await(queries)
end

---@param name string
---@return any
function db.getSetting(name)
  return MySQL.single.await(SQL_QUERIES.GET_SETTING, { name })
end

---@param name string
---@param value string
function db.setSetting(name, value)
  return MySQL.update.await(SQL_QUERIES.UPSERT_SETTING, { name, value })
end

function db.getVotes()
  return MySQL.query.await(SQL_QUERIES.GET_VOTES)
end

---@param id number
---@param voter number
function db.voteCandidate(id, voter)
  local queries = {
    { query = SQL_QUERIES.ADD_USER_VOTE,  values = { voter, id } },
    { query = SQL_QUERIES.VOTE_CANDIDATE, values = { id } }
  }

  return MySQL.transaction.await(queries)
end

return db
