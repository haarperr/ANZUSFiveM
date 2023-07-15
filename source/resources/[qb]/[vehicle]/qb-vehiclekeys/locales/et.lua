local Translations = {
    notify = {
        no_keys = 'Teil pole selle sõiduki võtmeid.',
        not_near = 'Läheduses pole kedagi, kellele võtmed kätte anda',
        vehicle_locked = 'Sõiduk lukus!',
        vehicle_unlocked = 'Sõiduk avatud!',
        vehicle_lockedpick = 'Sul õnnestus ukselukk lahti keerata!',
        failed_lockedpick = 'Te ei leia võtmeid ja olete pettunud.',
        gave_keys = 'Annad võtmed üle.',
        keys_taken = 'Saate auto võtmed!',
        fpid = 'Täitke mängija ID ja plaadi argumendid',
        carjack_failed = 'Autovargamine ebaõnnestus!',
    },
    progress = {
        takekeys = 'Võtmete kehast võtmine...',
        searching_keys = 'Autovõtmete otsimine...',
        attempting_carjack = 'Autovarguse katse...',
    },
    info = {
        skeys = '~g~[H]~w~ – Võtmete otsimine',
        toggle_locks = 'Lülitage sõiduki lukud sisse',
        vehicle_theft = 'Sõiduki vargus käsil. Tüüp:',
        engine = 'Mootori sisse- ja väljalülitamine',
    },
    addcom = {
        givekeys = 'Andke võtmed kellelegi üle. Kui isikut tõendav dokument puudub, annab see lähimale inimesele või kõigile sõidukis viibijatele.',
        givekeys_id = 'id',
        givekeys_id_help = 'Mängija ID',
        addkeys = 'Lisab kellegi jaoks sõidukile võtmed.',
        addkeys_id = 'id',
        addkeys_id_help = 'Mängija ID',
        addkeys_plate = 'Numbrimärk',
        addkeys_plate_help = 'Numbrimärk',
        remove_keys = 'Eemaldage kellegi jaoks sõiduki võtmed.',
        remove_keys_id = 'id',
        remove_keys_id_help = 'Mängija ID',
        remove_keys_plate = 'Numbrimärk',
        remove_keys_plate_help = 'Numbrimärk',
    }

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
