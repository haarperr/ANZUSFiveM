local Translations = {
    notify = {
        no_keys = 'Vous n\'avez pas de clés de ce véhicule.',
        not_near = 'Il n\'y a personne à proximité.',
        vehicle_locked = 'Véhicule verrouillé!',
        vehicle_unlocked = 'Véhicule déverrouillé!',
        vehicle_lockedpick = 'Vous avez réussi à ouvrir le véhicule!',
        failed_lockedpick = 'Vous n\'avez pas réussi à ouvrir le véhicule et vous êtes frustré.',
        gave_keys = 'Vous donnez les clés.',
        keys_taken = 'Vous obtenez les clés du véhicule!',
        fpid = 'Remplissez les arguments ID et plaque.',
        carjack_failed = 'Le détournement de voiture a échoué',
    },
    progress = {
        takekeys = 'Prend les clés du corps..',
        searching_keys = 'Cherche les clés du véhicule..',
        attempting_carjack = 'Tentative de vol de carjack..',
    },
    info = {
        skeys = '~g~[H]~w~ - Chercher les clés',
        toggle_locks = 'Verrouiller/Déverrouiller le véhicule',
        vehicle_theft = 'Vol de véhicule en cours. Type: ',
        engine = 'Allumer/Eteindre le moteur',
    },
    addcom = {
        givekeys = 'Donner les clés à quelqu\'un. Si aucun ID, donne à la personne la plus proche ou à tout le monde dans le véhicule.',
        givekeys_id = 'id',
        givekeys_id_help = 'ID du joueur',
        addkeys = 'Ajouter les clés à un véhicule pour quelqu\'un.',
        addkeys_id = 'id',
        addkeys_id_help = 'ID du joueur',
        addkeys_plate = 'plaque',
        addkeys_plate_help = 'Plaque',
        remove_keys = 'Retirer les clés à un véhicule pour quelqu\'un.',
        remove_keys_id = 'id',
        remove_keys_id_help = 'ID du joueur',
        remove_keys_plate = 'plaque',
        remove_keys_plate_help = 'Plaque',
    }

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
