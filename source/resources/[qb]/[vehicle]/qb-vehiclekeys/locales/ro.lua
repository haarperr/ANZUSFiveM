--[[
Romanian base language translation for qb-vehiclekeys
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    notify = {
        no_keys = 'Nu ai cheile acestui vehicul.',
        not_near = 'Nu este nimeni langa tine sa-i dai cheile vehiculului',
        vehicle_locked = 'Vehicul blocat - Alarma activa!',
        vehicle_unlocked = 'Vehicul deblocat - Alarma inactiva!',
        vehicle_lockedpick = 'Felicitari, ai reusit sa spargi incuietoarea!',
        failed_lockedpick = 'Nu ai putut clona cheile masinii si te stresezi.',
        gave_keys = 'Ai dat cheile vehiculului.',
        keys_taken = 'Ai primit cheile vehiculului!',
        fpid = 'Trebuie sa introduci ID-ul jucatorului si numarul de inmatriculare',
        carjack_failed = 'Furtul de mașină a eșuat',
    },
    progress = {
        takekeys = 'Iei chile de la vehicul...',
        searching_keys = 'Clonezi cheile vehiculului...',
        attempting_carjack = 'Incerci sa fur vehiculul...',
    },
    info = {
        skeys = '~g~[H]~w~ - Cloneaza cheile',
        toggle_locks = 'Blocheaza/Deblocheaza vehiculul',
        vehicle_theft = 'Furt auto in desfasurare. Tip: ',
        engine = 'Porneste/Opreste motorul',
    },
    addcom = {
        givekeys = 'Dai cheile vehiculului unei alte persoane. Daca nu se precizeaza ID-ul, cheile se duc celei mai apropiate persoane de tine.',
        givekeys_id = 'ID',
        givekeys_id_help = 'ID-ul jucatorului caruia vrei sa-i dai cheile',
        addkeys = 'Adaugi un set de chei al unui vehicul pentru o alta persoana.',
        addkeys_id = 'ID',
        addkeys_id_help = 'ID-ul jucatorului',
        addkeys_plate = 'numar',
        addkeys_plate_help = 'Numarul de inmatriculare al vehiculului',
        remove_keys = 'Anulezi setul de chei aditional, pentru o persoana.',
        remove_keys_id = 'ID',
        remove_keys_id_help = 'ID-ul jucatorului',
        remove_keys_plate = 'numar',
        remove_keys_plate_help = 'Numarul de inmatriculare al vehiculului',
    }

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
