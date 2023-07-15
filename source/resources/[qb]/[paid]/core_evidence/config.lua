Config = {}

-- IMPORTANT! To configure report text navigate to /html/script.js and find the text you want to replace


-- QB CHARACTER DATA SHOWN IN EVIDENCE REPORT
Config.showFirstname = true
Config.showLastname = true
Config.showGender = true
Config.showBirthdate = false
Config.showPhone = false

Config.ShowBloodSplatsOnGround = true -- Show blood on the ground when player is shot
Config.PlayClipboardAnimation = true  -- Play clipboard animation when reading report

Config.JobRequired = {                -- Jobs that can use this system
    ['lspd'] = true,
    ['bcso'] = true
}

Config.CloseReportKey = 177          -- BACKSPACE -- The key used to close the report
Config.PickupEvidenceKey = 38        -- E -- The key used to pick up evidence

Config.EvidenceAnalysisLocations = { -- The place where the evidence will be analyzed and report generated
    [1] = { coords = vector4(485.61, -988.95, 30.69, 0), length = 2.8, width = 4.8 }
}

Config.ComputerSearch = {
    [1] = { coords = vector4(484.22, -993.91, 29.87, 7), length = 0.4, width = 0.4 }
}

Config.TimeToAnalyze = 10000         -- Time in miliseconds to analyze the given evidence
Config.TimeToFindFingerprints = 3000 -- Time in miliseconds to find fingerprints in a car

--UPDATE V2
Config.RainRemovesEvidence = true     -- Removes evidence when it starts raining!
Config.TimeBeforeCrimsCanDestory = 20 -- Seconds before Criminals can destroy evidence (300 is the time when evidence coolsdown and shows up as WARM)

--

Config.Text = {
    --UPDATE V2
    ['not_in_vehicle'] = 'To use this you need to be in a vehicle!',
    ['remove_evidence'] = 'Destroy evidence [~r~E~w~]',
    ['cooldown_before_pickup'] = 'The evidence is too fresh/hot to destroy',
    ['evidence_removed'] = 'Evidence destroyed!',
    ['open_evidence_archive'] = '[E] View evidence archive',
    ['evidence_archive'] = 'Evidence Archive',
    ['view'] = 'View',
    ['delete'] = 'Delete',
    ['report_list'] = 'Report #',
    ['evidence_deleted_from_archive'] = 'Evidence deleted from archive!',
    --

    ['evidence_colleted'] = 'Evidence #{number} collected!',
    ['no_more_space'] = 'Not enough space for evidence 10/10!',
    ['analyze_evidence'] = '[E] Analyze the evidence',
    ['evidence_being_analyzed'] = 'The evidence is being analyzed by forensics! Please Wait',
    ['evidence_being_analyzed_hologram'] = 'The evidence is being analyzed',
    ['read_evidence_report'] = '[E] Read evidence report',
    ['analyzing_car'] = 'The car is being analyzed! Please wait',
    ['pick_up_evidence_text'] = 'Take evidence [~r~E~w~]',
    ['no_fingerprints_found'] = 'No fingerprints found!',
    ['no_evidence_to_analyze'] = "No evidence to analyze!",
    ['shell_hologram'] = '~b~ {guncategory}~w~ Casing',
    ['blood_hologram'] = '~r~Blood Splat',
    ['bullet_hologram'] = '~w~ Projectile',

    ['blood_after_0_minutes'] = 'Status: ~r~FRESH',
    ['blood_after_5_minutes'] = 'Status: ~y~AGED',
    ['blood_after_10_minutes'] = 'Status: ~b~OLD',

    ['shell_after_0_minutes'] = 'Status: ~r~HOT',
    ['shell_after_5_minutes'] = 'Status: ~y~WARM',
    ['shell_after_10_minutes'] = 'Status: ~b~COLD',


    ['submachine_category'] = 'Submachine',
    ['pistol_category'] = 'Pistol',
    ['shotgun_category'] = 'Shotgun',
    ['assault_category'] = 'Assault Rifle',
    ['lightmachine_category'] = 'Light Machine Gun',
    ['sniper_category'] = 'Sniper',
    ['heavy_category'] = 'Heavy Weapon'
}

-- Only change if you know what are you doing!
