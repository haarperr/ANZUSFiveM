local Translations = {
    notify = {
        no_keys = 'Sie haben keine Schlüssel für das Fahrzeug!',
        not_near = 'Es ist niemand in der Nähe, der den Schlüssel bekommen könnte!',
        vehicle_locked = 'Fahrzeug verriegelt!',
        vehicle_unlocked = 'Fahrzeug entriegelt.',
        vehicle_lockedpick = 'Sie haben es geschafft, das Türschloss zu knacken!',
        failed_lockedpick = 'Sie können keine Schlüssel finden und sind frustriert.',
        gave_keys = 'Sie geben die Schlüssel ab.',
        keys_taken = 'Sie erhalten die Schlüssel für das Fahrzeug!',
        fpid = 'Geben Sie alle Argumente, nämlich die Bürger-ID und das Kennzeichen, an.',
        carjack_failed = 'Knacken des Autos fehlgeschlagen!',
    },
    progress = {
        takekeys = 'Fahrzeugschlüssel abnehmen...',
        searching_keys = 'Suche nach Fahrzeugschlüssel...',
        attempting_carjack = 'Versuchter Autodiebstahl...',
    },
    info = {
        skeys = '~g~[H]~w~ - Nach Schlüssel suchen',
        toggle_locks = 'Fahrzeug auf-/zuschließen',
        vehicle_theft = 'Fahrzeugdiebstahl im Gange. Typ: ',
        engine = 'Motor ein-/ausschalten',
    },
    addcom = {
        givekeys = 'Übergeben Sie die Schlüssel an jemanden. Wenn keine Bürger-ID angegeben, geht er an die nächstgelegene Person oder an alle Personen im Fahrzeug.',
        givekeys_id = 'id',
        givekeys_id_help = 'Bürger-ID',
        addkeys = 'Fügt Schlüssel zu einem Fahrzeug für jemanden hinzu.',
        addkeys_id = 'id',
        addkeys_id_help = 'Bürger-ID',
        addkeys_plate = 'kennzeichen',
        addkeys_plate_help = 'Kennzeichen',
        remove_keys = 'Jemandem die Schlüssel eines Fahrzeugs abnehmen.',
        remove_keys_id = 'id',
        remove_keys_id_help = 'Bürger-ID',
        remove_keys_plate = 'kennzeichen',
        remove_keys_plate_help = 'Kennzeichen',
    }

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
