Config = Config or {}

Config.RosterLink = {
  ['police'] = '',
  ['ambulance'] = '',
  ['bcso'] = '',
  ['doj'] = '',
  ['sast'] = '',
  ['sasp'] = '',
  ['doc'] = '',
  ['lssd'] = '',
  ['sapr'] = '',
}

Config.sopLink = {
  ['police'] = '',
  ['ambulance'] = '',
  ['bcso'] = '',
  ['doj'] = '',
  ['sast'] = '',
  ['sasp'] = '',
  ['doc'] = '',
  ['lssd'] = '',
  ['sapr'] = '',
}


Config.UseWolfknightRadar = false
Config.WolfknightNotifyTime = 5000 --How long the notification displays for in milliseconds (30000 = 30 seconds)
--[[
Adds support for Wraith ARS 2X by WolfKnight98 (wk_wars2x)
https://github.com/WolfKnight98/wk_wars2x
To save on unnecessary database queries, in wk_wars2x/config.lua set 'CONFIG.use_sonorancad = true'
This will only check plates of vehicles that have been occupied by a player
--]]

Config.OnlyShowOnDuty = true

Config.Fuel = "ps-fuel" -- "LegacyFuel", "lj-fuel"

Config.PenalCodeTitles = {
  [1] = 'CAPITAL CRIMES',
  [2] = 'VIOLENT CRIMES',
  [3] = 'FIREARMS/EXPLOSIVES',
  [4] = 'NARCOTICS',
  [5] = 'FINANCIAL',
  [6] = 'HARASSMENT',
  [7] = 'MISCELLANEOUS FELONIES',
  [8] = 'VEHICULAR FELONIES',
  [9] = 'CONTRABAND/NARCOTICS',
  [10] = 'MISCELLANEOUS MISDEMEANORS',
}

Config.PenalCode = {
  [1] = {
    [1] = { title = 'First Degree Murder', class = 'Felony', id = 'PC101', months = 'HUT', fine = 'HUT', color = 'red', description =
    'Directly or indirectly causing the death of another person (i) with malice aforethought (ii), with premeditated intent (iii).' },
    [2] = { title = 'Second Degree Murder', class = 'Felony', id = 'PC102', months = 'HUT', fine = 'HUT', color = 'red', description =
    'Directly or indirectly causing the death of another person (i) with malice aforethought (ii) either without premeditated intent or due to extreme disregard for human life(iii).' },
    [3] = { title = 'Mass Murder', class = 'Felony', id = 'PC103', months = 'HUT', fine = 'HUT', color = 'red', description =
    'Directly or indirectly causing the death of at least 4 people (i) with malice aforethought (ii), with premeditated intent (iii).' },
    [4] = { title = 'Attempted  Murder', class = 'Felony', id = 'PC104', months = 70, fine = 4500, color = 'red', description =
    'Attempted to Directly or indirectly causing the death of another person (i)' },
    [5] = { title = 'Terrorism', class = 'Felony', id = 'PC105', months = 'HUT', fine = 'HUT', color = 'red', description =
    'A person engages in terrorism if they do an act "dangerous to human life" that is a violation of the criminal laws of San Andreas, if the act appears to be intended to: (i) intimidate or coerce a civilian population; (ii) influence the policy of a government by intimidation or coercion; or (iii) to affect the conduct of a government by mass destruction, assassination or kidnapping.' },
  },
  [2] = {
    [1] = { title = 'Manslaughter', class = 'Felony', id = 'PC201', months = 50, fine = 5000, color = 'red', description =
    'The act of unintentionally causing bodily harm to another person (i) that ends in the death of another person (ii) without malice aforethought (iii).' },
    [2] = { title = 'Bank Robbery', class = 'Felony', id = 'PC202', months = 30, fine = 5000, color = 'red', description =
    'The act of committing a robbery (i) on a bank (ii).' },
    [3] = { title = 'Assault of a Govenment Employee', class = 'Felony', id = 'PC203', months = 25, fine = 4500, color =
    'red', description =
    'Threats of or actions of body harm were made, attempted or carried out (i) towards an active member of the San Andreas or United States Govenment (ii) with an apparent, present ability to cause the harm (iii)' },
    [4] = { title = 'Kidnapping', class = 'Felony', id = 'PC204', months = 20, fine = 3000, color = 'red', description =
    'The act of taking a person captive (i) and moving that person without their consent (ii) with intention to use their captivity for a nefarious purpose (iii).' },
    [5] = { title = 'Arson', class = 'Felony', id = 'PC205', months = 10, fine = 1500, color = 'red', description =
    'The intentional destruction of property (i) resulting in explosion or fire (ii).' },
    [6] = { title = 'Felony Criminal Negligence', class = 'Felony', id = 'PC206', months = 15, fine = 2000, color = 'red', description =
    'To not act with a level of care that any other reasonable person would in the same circumstance (i) that leads to extreme physical or property damage (ii).' },
    [7] = { title = 'Armed Robbery', class = 'Felony', id = 'PC207', months = 20, fine = 3000, color = 'red', description =
    'The taking of another persons property (i) without their permission (ii), through use of threats or violence (iii). (iv) A weapon or instrument was used' },
    [8] = { title = 'Human Trafficking', class = 'Felony', id = 'PC208', months = 20, fine = 3000, color = 'red', description =
    'The act of taking another captive (i), and moving them to another place (ii), with the intent to use them to perform service (iii).' },
    [9] = { title = 'Assault of a member of the Judiciary', class = 'Felony', id = 'PC209', months = 100, fine = 10000, color =
    'red', description =
    'Threats of or actions of body harm were made, attempted or carried out (i) towards an active member of the San Andreas State Judiciary (ii) with an apparent, present ability to cause the harm (iii)' },
    [10] = { title = 'Assault with Deadly Weapon', class = 'Felony', id = 'PC210', months = 30, fine = 2500, color =
    'red', description =
    'Threats of or actions of body harm were made, attempted or carried out (i) With the use of a deadly weapon or firearm (ii) with an apparent, present ability to cause the harm (iii)' },
  },
  [3] = {
    [1] = { title = 'Weapons Stockpiling', class = 'Felony', id = 'PC301', months = 100, fine = 10000, color = 'orange', description =
    'Possession of 5 or more (i) Illegal Firearms (ii).' },
    [2] = { title = 'Weapons Caching', class = 'Felony', id = 'PC302', months = 75, fine = 7500, color = 'orange', description =
    'Possession less than 5, but more than 2 (i) Illegal Firearms (ii).' },
    [3] = { title = 'Weapons Distribution', class = 'Felony', id = 'PC303', months = 45, fine = 7500, color = 'orange', description =
    'Sale or exchange of weapons without a license (i) or the sale or exchange of illegal weapons (ii).' },
    [4] = { title = 'Weapons Trafficking', class = 'Felony', id = 'PC304', months = 100, fine = 10000, color = 'orange', description =
    'The transportation of 5 or more (i) illegal Firearms (ii).' },
    [5] = { title = 'Possession of Explosives', class = 'Felony', id = 'PC305', months = 30, fine = 3000, color =
    'orange', description = 'Possession of an explosive device  (i)' },
    [6] = { title = 'Possession of a Class 3 Firearm', class = 'Felony', id = 'PC306', months = 50, fine = 6500, color =
    'orange', description = 'Possession of a Class 3 Firearm (i).' },
    [7] = { title = 'Possession of a Class 2 Firearm', class = 'Felony', id = 'PC308', months = 35, fine = 4500, color =
    'orange', description = 'Possession of a Class 2 Firearm (i) without a license (ii).' },
    [8] = { title = 'Possession of a Class 1 Firearm', class = 'Felony', id = 'PC309', months = 15, fine = 1500, color =
    'orange', description = 'Possession of a Class 1 Firearm (i) without a license (ii).' },
    [9] = { title = 'Unlawful Discharge of a Firearm', class = 'Felony', id = 'PC310', months = 5, fine = 1000, color =
    'orange', description = 'Discharging a firearm without a lawful reason (i).' },
    --[2] = {title = 'Criminal Possession of Weapon Class B', class = 'Felony', id = 'P.C. 8002', months = 15, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
    --[3] = {title = 'Criminal Possession of Weapon Class C', class = 'Felony', id = 'P.C. 8003', months = 30, fine = 3500, color = 'green', description = 'Insert Charge Description Here'},
    --[4] = {title = 'Criminal Possession of Weapon Class D', class = 'Felony', id = 'P.C. 8004', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[5] = {title = 'Criminal Sale of Weapon Class A', class = 'Felony', id = 'P.C. 8005', months = 15, fine = 1000, color = 'orange', description = 'Insert Charge Description Here'},
    --[6] = {title = 'Criminal Sale of Weapon Class B', class = 'Felony', id = 'P.C. 8006', months = 20, fine = 2000, color = 'orange', description = 'Insert Charge Description Here'},
    --[7] = {title = 'Criminal Sale of Weapon Class C', class = 'Felony', id = 'P.C. 8007', months = 35, fine = 7000, color = 'orange', description = 'Insert Charge Description Here'},
    --[8] = {title = 'Criminal Sale of Weapon Class D', class = 'Felony', id = 'P.C. 8008', months = 30, fine = 3000, color = 'orange', description = 'Insert Charge Description Here'},
    --[9] = {title = 'Criminal Use of Weapon', class = 'Misdemeanor', id = 'P.C. 8009', months = 10, fine = 450, color = 'orange', description = 'Insert Charge Description Here'},
    --[10] = {title = 'Possession of Illegal Firearm Modifications', class = 'Misdemeanor', id = 'P.C. 8010', months = 10, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
    --[11] = {title = 'Weapon Trafficking', class = 'Felony', id = 'P.C. 8011', months = 0, fine = 0, color = 'red', description = 'Insert Charge Description Here'},
    --[12] = {title = 'Brandishing a Weapon', class = 'Misdemeanor', id = 'P.C. 8012', months = 15, fine = 500, color = 'orange', description = 'Insert Charge Description Here'},
    --[13] = {title = 'Insurrection', class = 'Felony', id = 'P.C. 8013', months = 0, fine = 0, color = 'red', description = 'Insert Charge Description Here'},
    --[14] = {title = 'Flying into Restricted Airspace', class = 'Felony', id = 'P.C. 8014', months = 20, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[15] = {title = 'Jaywalking', class = 'Infraction', id = 'P.C. 8015', months = 0, fine = 150, color = 'green', description = 'Insert Charge Description Here'},
    --[16] = {title = 'Criminal Use of Explosives', class = 'Felony', id = 'P.C. 8016', months = 30, fine = 2500, color = 'orange', description = 'Insert Charge Description Here'},
  },
  [4] = {
    [1] = { title = 'Narcotics Cultivation and Manufacturing', class = 'Felony', id = 'PC401', months = 20, fine = 1500, color =
    'orange', description =
    'The act of planting, cultivation, or harvesting (i) either a Class 1 CDS or a Class 2 CDS (ii). (Weed, Cocaine, LSD, Heroin)' },
    [2] = { title = 'Class 1 CDS Distribution/Trafficking', class = 'Felony', id = 'PC402', months = 100, fine = 10000, color =
    'orange', description =
    'Transporting or storing any type of CDS in/on a vehicle/person/property (combined total of any CDS) in an excess of 200 or more.  Also applies to the cultivation and manufacturing of more than 150 plants (combined total of any plant that can be manufactured into CDS) does not apply to seeds.' },
    [3] = { title = 'Class 1 CDS Possession First Degree', class = 'Felony', id = 'PC403', months = 45, fine = 6500, color =
    'orange', description =
    'Possession of less than 40 but more than 20 (i) of a Class 1 CDS (ii) without intent to move or sell them (iii).' },
    [4] = { title = 'Class 2 CDS Possession First Degree', class = 'Felony', id = 'PC404', months = 30, fine = 3500, color =
    'orange', description =
    'Possession of less than 40 but more than 20 (i) of a Class 2 CDS (ii) without intent to move or sell them (iii).(Heroin, Cocaine and LSD)' },
    [5] = { title = 'Class 2 Drug Possession Second Degree', class = 'Felony', id = 'PC405', months = 15, fine = 1500, color =
    'orange', description =
    'Possession of less than 20 units (i) of Class 2 CDS (ii) without the intent to move or sell them (iii). (Heroin, Cocaine and LSD)' },
    --[2] = {title = 'Felony Possession of Marijuana', class = 'Felony', id = 'P.C. 7002', months = 15, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
    --[3] = {title = 'Cultivation of Marijuana A', class = 'Misdemeanor', id = 'P.C. 7003', months = 10, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
    --[4] = {title = 'Cultivation of Marijuana B', class = 'Felony', id = 'P.C. 7004', months = 30, fine = 1500, color = 'orange', description = 'Insert Charge Description Here'},
    --[5] = {title = 'Possession of Marijuana with Intent to Distribute', class = 'Felony', id = 'P.C. 7005', months = 30, fine = 3000, color = 'orange', description = 'Insert Charge Description Here'},
    --[6] = {title = 'Misdemeanor Possession of Cocaine', class = 'Misdemeanor', id = 'P.C. 7006', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[7] = {title = 'Felony Possession of Cocaine', class = 'Felony', id = 'P.C. 7007', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[8] = {title = 'Possession of Cocaine with Intent to Distribute', class = 'Felony', id = 'P.C. 7008', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[9] = {title = 'Misdemeanor Possession of Methamphetamine', class = 'Misdemeanor', id = 'P.C. 7009', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[10] = {title = 'Felony Possession of Methamphetamine', class = 'Felony', id = 'P.C. 7010', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[11] = {title = 'Possession of Methamphetamine with Intent to Distribute', class = 'Felony', id = 'P.C. 7011', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[12] = {title = 'Misdemeanor Possession of Oxy / Vicodin', class = 'Felony', id = 'P.C. 7012', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[13] = {title = 'Felony Possession of Oxy / Vicodin', class = 'Felony', id = 'P.C. 7013', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[14] = {title = 'Felony Possession of Oxy / Vicodin with Intent to Distribute', class = 'Felony', id = 'P.C. 7014', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[15] = {title = 'Misdemeanor Possession of Ecstasy', class = 'Misdemeanor', id = 'P.C. 7015', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[16] = {title = 'Felony Possession of Ecstasy', class = 'Felony', id = 'P.C. 7016', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[17] = {title = 'Possession of Ecstasy with Intent to Distribute', class = 'Felony', id = 'P.C. 7017', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[18] = {title = 'Misdemeanor Possession of Opium', class = 'Misdemeanor', id = 'P.C. 7018', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[19] = {title = 'Felony Possession of Opium', class = 'Felony', id = 'P.C. 7019', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[20] = {title = 'Possession of Opium with Intent to Distribute', class = 'Felony', id = 'P.C. 7020', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[21] = {title = 'Misdemeanor Possession of Adderall', class = 'Misdemeanor', id = 'P.C. 7021', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[22] = {title = 'Felony Possession of Adderall', class = 'Felony', id = 'P.C. 7022', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[23] = {title = 'Possession of Adderall with Intent to Distribute', class = 'Felony', id = 'P.C. 7023', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[24] = {title = 'Misdemeanor Possession of Xanax', class = 'Misdemeanor', id = 'P.C. 7024', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[25] = {title = 'Felony Possession of Xanax', class = 'Felony', id = 'P.C. 7025', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[26] = {title = 'Possession of Xanax with Intent to Distribute', class = 'Felony', id = 'P.C. 7026', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[27] = {title = 'Misdemeanor Possession of Shrooms', class = 'Misdemeanor', id = 'P.C. 7027', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[28] = {title = 'Felony Possession of Shrooms', class = 'Felony', id = 'P.C. 7028', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[29] = {title = 'Possession of Shrooms with Intent to Distribute', class = 'Felony', id = 'P.C. 7029', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[30] = {title = 'Misdemeanor Possession of Lean', class = 'Misdemeanor', id = 'P.C. 7030', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[31] = {title = 'Felony Possession of Lean', class = 'Felony', id = 'P.C. 7031', months = 25, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
    --[32] = {title = 'Possession of Lean with Intent to Distribute', class = 'Felony', id = 'P.C. 7032', months = 35, fine = 4500, color = 'orange', description = 'Insert Charge Description Here'},
    --[33] = {title = 'Sale of a controlled substance', class = 'Misdemeanor', id = 'P.C. 7033', months = 10, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
    --[34] = {title = 'Drug Trafficking', class = 'Felony', id = 'P.C. 7034', months = 0, fine = 0, color = 'red', description = 'Insert Charge Description Here'},
    --[35] = {title = 'Desecration of a Human Corpse', class = 'Felony', id = 'P.C. 7035', months = 20, fine = 1500, color = 'orange', description = 'Insert Charge Description Here'},
    --[36] = {title = 'Public Intoxication', class = 'Infraction', id = 'P.C. 7036', months = 0, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
    --[37] = {title = 'Public Indecency', class = 'Misdemeanor', id = 'P.C. 7037', months = 10, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  },
  [5] = {
    [1] = { title = 'Corruption', class = 'Felony', id = 'PC501', months = 'HUT', fine = 'HUT', color = 'red', description =
    'The act of a Government Official, Fiduciary Person, or Law Enforcement Officer (i) who unlawfully and wrongfully uses their station or character to procure some benefit to themselves or for another person' },
    [2] = { title = 'Bribery', class = 'Felony', id = 'PC502', months = 15, fine = 3000, color = 'red', description =
    'Persuading someone to commit an illegal act (i) in exchange for a gift, money, service or other item (ii).' },
    [3] = { title = 'Embezzlement', class = 'Felony', id = 'PC503', months = 25, fine =
    'All of the money which they embezzled plus 10%', color = 'red', description =
    'Wrongfully obtaining anothers property through deception (i) by a person who is in a position of trust such as an employee or government official (ii).' },
    [4] = { title = 'Extortion', class = 'Felony', id = 'PC504', months = 30, fine = 3000, color = 'red', description =
    'Attempted to Directly or indirectly causing the death of another person (i)' },
    [5] = { title = 'Money Laundering', class = 'Felony', id = 'PC505', months = 20, fine = 25000, color = 'red', description =
    'The act of taking proceeds from an illegal operation and manipulating them to appear as if obtained legally.' },
    [6] = { title = 'Felony Malpractice', class = 'Felony', id = 'PC506', months = 30, fine = 7500, color = 'red', description =
    'Attempted to Directly or indirectly causing the death of another person (i)' },
    [7] = { title = 'Fraud', class = 'Felony', id = 'PC507', months = 20, fine = 2500, color = 'red', description =
    'Intentionally misleading or deceiving another person or group (i), with a deliberate statement or action (ii) including the false statement on any legal document (iii).' },
  },
  [6] = {
    [1] = { title = 'Stalking', class = 'Felony', id = 'PC601', months = 10, fine = 1000, color = 'red', description =
    'The deliberate following and spying on an individual (i) such acts are unwanted by the party (ii)' },
    [2] = { title = 'Harassment', class = 'Felony', id = 'PC602', months = 10, fine = 500, color = 'red', description =
    'The bullying or annoyance of a member of the public after repeated attempts by the party to tell you to stop' },
    [3] = { title = 'Indecent Exposure', class = 'Felony', id = 'PC603', months = 5, fine = 500, color = 'red', description =
    'The excesive exposure of ones own body (i) in a public setting (ii) exposure is being caused by a lack of sufficent clothing (iii)' },
  },
  [7] = {
    [1] = { title = 'Impersonation of a Government Official', class = 'Felony', id = 'PC701', months = 25, fine = 3000, color =
    'red', description = 'The act of pretending to be a Lawyer or Government Official (i).' },
    [2] = { title = 'Burglary', class = 'Felony', id = 'PC702', months = 15, fine = 1500, color = 'red', description =
    'The act of unlawfully entering another persons property (i), with the intention of committing an illegal act while on the property (ii).' },
    [3] = { title = 'Escaping Custody', class = 'Felony', id = 'PC703', months = 15, fine = 1500, color = 'red', description =
    'Escaping the custody of a LEO (i), after previously being detained by a LEO (ii).' },
    [4] = { title = 'Obstruction of Justice', class = 'Felony', id = 'PC704', months = 10, fine = 2000, color = 'red', description =
    'Hindering the discovery, apprehension, conviction, defense, or punishment (i) of anyone who has committed a crime (ii).' },
    [5] = { title = 'Perjury', class = 'Felony', id = 'PC705', months = 15, fine = 2000, color = 'red', description =
    'Submitting a false statement while under oath or affirmation (i).' },
    [6] = { title = 'Terroristic Threat', class = 'Felony', id = 'PC706', months = 30, fine = 5000, color = 'red', description =
    'A threat of violence, harm or destruction for a political aim (i).' },
    [7] = { title = 'Jailbreak', class = 'Felony', id = 'PC707', months = 150, fine = 10000, color = 'red', description =
    'The act of breaking out of a prison or jail (i), or breaking a convicted person out of a state prison or jail (ii).' },
    [8] = { title = 'Robbery', class = 'Felony', id = 'PC708', months = 25, fine = 3000, color = 'red', description =
    'Forcing another person to surrender possessions (i), either under duress or threat of harm.' },
    [9] = { title = 'Larceny', class = 'Felony', id = 'PC709', months = 10, fine = 1000, color = 'red', description =
    'Taking someones possessions (i) without their consent (ii), and without using any threat of harm or duress (iii)' },
    [10] = { title = 'Felony Tax/Fine Evasion', class = 'Felony', id = 'PC710', months = '2 months per $250', fine = 0, color =
    'red', description = 'Failure to pay any Fines (i) greater than $5,000 (ii) within a reasonable amount time (iii).' },
    [11] = { title = 'Resisting Arrest', class = 'Felony', id = 'PC711', months = 5, fine = 500, color = 'red', description =
    'The act of using force to prevent arrest or detaining of a person (i).' },
    [12] = { title = 'Fleeing & Eluding', class = 'Felony', id = 'PC712', months = 10, fine = 1000, color = 'red', description =
    'While on foot (i), intentionally fleeing from a LEO attempting to arrest or detain (ii).' },
  },
  [8] = {
    [1] = { title = 'Vehicular Manslaughter', class = 'Felony', id = 'a', months = 50, fine = 5000, color = 'red', description =
    'Causing the death of a person (i) with a vehicle (ii) due to recklessness (iii).' },
    [2] = { title = 'Reckless Driving', class = 'Felony', id = 'b', months = 10, fine = 1500, color = 'red', description =
    'While in a vehicle (i). driving in a manner which a reasonable person would view as reckless (ii) and with disregard for human life and safety (iii).' },
    [3] = { title = 'Grand Theft Auto', class = 'Felony', id = 'c', months = 10, fine = 1000, color = 'red', description =
    'Operation of a motor vehicle (i) without the consent of its registered owner (ii), and moving it from its point of origin (iii).' },
    [4] = { title = 'Violation of No-Fly Zone', class = 'Felony', id = 'd', months = 10, fine = 1000, color = 'red', description =
    'The act of operating an aircraft (i) within a no-fly zone (ii).' },
    [5] = { title = 'Felony Evading Arrest', class = 'Felony', id = 'e', months = 20, fine = 2000, color = 'red', description =
    'Operation of a motor vehicle (i). and intentionally fleeing from an LEO to avoid arrest or detainment (ii).' },
  },
  [9] = {
    [1] = { title = 'Class 2 CDS Possession Second Degree', class = 'Misdemeanor', id = 'MS101', months =
    '5 Months or $5,000 Fine', fine = 500, color = 'green', description =
    'Possession of less than 20 units (i) of Class 1 CDS (ii) without the intent to move or sell them (iii).' },
    [2] = { title = 'Possession of Contraband', class = 'Misdemeanor', id = 'MS102', months = 5, fine = 500, color =
    'green', description =
    'Possession of Illegal Items (i) with knowledge of their existence. (ii) i.e (un)processed uranium, ect (iii)' },
  },
  [10] = {
    [1] = { title = 'Assault', class = 'Misdemeanor', id = 'MS201', months = 5, fine = 500, color = 'green', description =
    'A threat of bodily harm (i) with an apparent, present ability to cause the harm (ii).' },
    [2] = { title = 'Battery', class = 'Misdemeanor', id = 'MS202', months = 20, fine = 1500, color = 'green', description =
    'The act of causing bodily harm (i) to another person (ii).' },
    [3] = { title = 'Trespassing on Restricted Government Soil', class = 'Misdemeanor', id = 'MS203', months =
    '"First Offense: 15 Months Further Offense // Loitering DOC: 45 Months"', fine = 1500, color = 'green', description =
    '"Unauthorized entry upon the soil of a restricted Government area (i) within 100 meters (ii) and failure to depart after being requested to (iii). Loitering DOC without any purpose especially during code RED & Above. (IV)"' },
    [4] = { title = 'Tresspassing', class = 'Misdemeanor', id = 'MS204', months = 10, fine = 1000, color = 'green', description =
    'The entering of another persons property without permission from someone with sufficent right to give permission' },
    [5] = { title = 'Possession of Stolen Goods', class = 'Misdemeanor', id = 'MS205', months = 10, fine = 500, color =
    'green', description =
    'Having bought, been given, or acquired stolen goods (i) which one knows, or any reasonable person would have realize have been stolen, extorted, embezzled or unlawfully taken in any manner (ii).' },
    [6] = { title = 'Failure to Identify', class = 'Misdemeanor', id = 'MS206', months = 5, fine = 500, color = 'green', description =
    'Failure to identify to a LEO (i) while being detained (ii) under reasonable suspicion (iii).' },
    [7] = { title = 'False Report', class = 'Misdemeanor', id = 'MS207', months = 5, fine = 1000, color = 'green', description =
    'Knowingly making a report to the police which the person knows to be false (i).' },
    [8] = { title = 'Failure to Inform', class = 'Misdemeanor', id = 'MS208', months = 'Weapon Seized', fine = 'N/A', color =
    'green', description = 'The failure to inform a LEO of a concealed weapon(s) (i) during a legal detainment (ii).' },
    [9] = { title = 'Harassment', class = 'Misdemeanor', id = 'MS209', months = 5, fine = 500, color = 'green', description =
    'Willfully, maliciously, and repeatedly (i) following or harassing a person (ii) to the point that person is reasonable to feel a substantial fear for their life (iii).' },
    [10] = { title = 'Brandishing a Firearm', class = 'Misdemeanor', id = 'MS210', months = 10, fine = 500, color =
    'green', description = 'Drawing or exhibiting a firearm (i) in a rude, threatening, or provocative manner (ii)' },
    [11] = { title = 'Disturbing the Peace', class = 'Misdemeanor', id = 'MS211', months = 5, fine = 500, color = 'green', description =
    'Engaging in some form of disorderly conduct, (i) such as fighting, threatening to fight in public or causing excessively loud noise (ii).' },
    [12] = { title = 'Loitering', class = 'Misdemeanor', id = 'MS212', months = 5, fine = 500, color = 'green', description =
    'Remaining in any one public place without an apparent purpose (i) while being given a lawful order to disperse by a LEO (ii).' },
    [13] = { title = 'Jaywalking', class = 'Misdemeanor', id = 'MS213', months = 0, fine = 500, color = 'green', description =
    'Failure to use crosswalk when crossing the street within the city (i)' },
  },
  --[6] = {
  --[1] = {title = 'Simple Assault', class = 'Misdemeanor', id = 'P.C. 1001', months = 7, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[2] = {title = 'Assault', class = 'Misdemeanor', id = 'P.C. 1001', months = 5, fine = 500, color = 'orange', description = 'A threat of bodily harm (i) with an apparent, present ability to cause the harm (ii).'},
  --[3] = {title = 'Aggravated Assault', class = 'Felony', id = 'P.C. 1003', months = 20, fine = 1250, color = 'orange', description = 'Insert Charge Description Here'},
  --[4] = {title = 'Assault with a Deadly Weapon', class = 'Felony', id = 'P.C. 1002', months = 30, fine = 2500, color = 'red', description = 'Threats of or actions of body harm were made, attempted or carried out (i) With the use of a deadly weapon or firearm (ii) with an apparent, present ability to cause the harm (iii)'},
  --[5] = {title = 'Involuntary Manslaughter', class = 'Felony', id = 'P.C. 1005', months = 60, fine = 7500, color = 'red', description = 'Insert Charge Description Here'},
  --[7] = {title = 'Attempted Murder of a Civilian', class = 'Felony', id = 'P.C. 1003', months = 70, fine = 4500, color = 'red', description = 'Attempted to Directly or indirectly causing the death of another person (i)'},
  --[9] = {title = 'Accessory to Second Degree Murder', class = 'Felony', id = 'P.C. 1009', months = 50, fine = 5000, color = 'red', description = 'Insert Charge Description Here'},
  --[11] = {title = 'Accessory to First Degree Murder', class = 'Felony', id = 'P.C. 1011', months = 0, fine = 0, color = 'red', description = 'Insert Charge Description Here'},
  --[12] = {title = 'Murder of a Public Servant or Peace Officer', class = 'Felony', id = 'P.C. 1012', months = 0, fine = 0, color = 'red', description = 'Insert Charge Description Here'},
  --[13] = {title = 'Attempted Murder of a Public Servant or Peace Officer', class = 'Felony', id = 'P.C. 1013', months = 65, fine = 10000, color = 'red', description = 'Insert Charge Description Here'},
  --[14] = {title = 'Accessory to the Murder of a Public Servant or Peace Officer', class = 'Felony', id = 'P.C. 1014', months = 0, fine = 0, color = 'red', description = 'Insert Charge Description Here'},
  --[15] = {title = 'Unlawful Imprisonment', class = 'Misdemeanor', id = 'P.C. 1015', months = 10, fine = 600, color = 'green', description = 'Insert Charge Description Here'},
  --[16] = {title = 'Kidnapping', class = 'Felony', id = 'P.C. 1006', months = 20, fine = 3000, color = 'orange', description = 'The act of taking a person captive (i) and moving that person without their consent (ii) with intention to use their captivity for a nefarious purpose (iii).'},
  --[17] = {title = 'Accessory to Kidnapping', class = 'Felony', id = 'P.C. 1017', months = 7, fine = 450, color = 'orange', description = 'Insert Charge Description Here'},
  --[18] = {title = 'Attempted Kidnapping', class = 'Felony', id = 'P.C. 1018', months = 10, fine = 450, color = 'orange', description = 'Insert Charge Description Here'},
  --[19] = {title = 'Hostage Taking', class = 'Felony', id = 'P.C. 1019', months = 20, fine = 1200, color = 'orange', description = 'Insert Charge Description Here'},
  --[20] = {title = 'Accessory to Hostage Taking', class = 'Felony', id = 'P.C. 1020', months = 10, fine = 600, color = 'orange', description = 'Insert Charge Description Here'},
  --[21] = {title = 'Unlawful Imprisonment of a Public Servant or Peace Officer.', class = 'Felony', id = 'P.C. 1021', months = 25, fine = 4000, color = 'orange', description = 'Insert Charge Description Here'},
  --[22] = {title = 'Criminal Threats', class = 'Misdemeanor', id = 'P.C. 1022', months = 5, fine = 500, color = 'orange', description = 'Insert Charge Description Here'},
  --[23] = {title = 'Reckless Endangerment', class = 'Misdemeanor', id = 'P.C. 1023', months = 10, fine = 1000, color = 'orange', description = 'Insert Charge Description Here'},
  --[24] = {title = 'Gang Related Shooting', class = 'Felony', id = 'P.C. 1024', months = 30, fine = 2500, color = 'red', description = 'Insert Charge Description Here'},
  --[25] = {title = 'Cannibalism', class = 'Felony', id = 'P.C. 1025', months = 0, fine = 0, color = 'red', description = 'Insert Charge Description Here'},
  --[26] = {title = 'Torture', class = 'Felony', id = 'P.C. 1026', months = 40, fine = 4500, color = 'red', description = 'Insert Charge Description Here'},
  --},

  --[7] = {
  --[1] = {title = 'Petty Theft', class = 'Infraction', id = 'P.C. 2001', months = 0, fine = 250, color = 'green', description = 'Insert Charge Description Here'},
  --[2] = {title = 'Grand Theft', class = 'Misdemeanor', id = 'P.C. 2002', months = 10, fine = 600, color = 'green', description = 'Insert Charge Description Here'},
  --[4] = {title = 'Grand Theft Auto B', class = 'Felony', id = 'P.C. 2004', months = 35, fine = 3500, color = 'green', description = 'Insert Charge Description Here'},
  --[5] = {title = 'Carjacking', class = 'Felony', id = 'P.C. 2005', months = 30, fine = 2000, color = 'orange', description = 'Insert Charge Description Here'},
  --[6] = {title = 'Burglary', class = 'Misdemeanor', id = 'P.C. 2002', months = 15, fine = 1500, color = 'green', description = 'The act of unlawfully entering another persons property (i), with the intention of committing an illegal act while on the property (ii).'},
  --[7] = {title = 'Robbery', class = 'Felony', id = 'P.C. 2003', months = 25, fine = 3000, color = 'green', description = 'Forcing another person to surrender possessions (i), either under duress or threat of harm.'},
  --[8] = {title = 'Accessory to Robbery', class = 'Felony', id = 'P.C. 2008', months = 12, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
  --[9] = {title = 'Attempted Robbery', class = 'Felony', id = 'P.C. 2009', months = 20, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
  --[10] = {title = 'Armed Robbery', class = 'Felony', id = 'P.C. 2004', months = 20, fine = 3000, color = 'orange', description = 'The taking of another persons property (i) without their permission (ii), through use of threats or violence (iii). (iv) A weapon or instrument was used'},
  --[11] = {title = 'Accessory to Armed Robbery', class = 'Felony', id = 'P.C. 2011', months = 15, fine = 1500, color = 'orange', description = 'Insert Charge Description Here'},
  --[12] = {title = 'Attempted Armed Robbery', class = 'Felony', id = 'P.C. 2012', months = 25, fine = 1500, color = 'orange', description = 'Insert Charge Description Here'},
  --[13] = {title = 'Larceny', class = 'Felony', id = 'P.C. 2005', months = 10, fine = 1000, color = 'orange', description = 'Taking someones possessions (i) without their consent (ii), and without using any threat of harm or duress (iii)'},
  --[14] = {title = 'Leaving Without Paying', class = 'Infraction', id = 'P.C. 2014', months = 0, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[15] = {title = 'Possession of Nonlegal Currency', class = 'Misdemeanor', id = 'P.C. 2015', months = 10, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[16] = {title = 'Possession of Government-Issued Items', class = 'Misdemeanor', id = 'P.C. 2016', months = 15, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
  --[17] = {title = 'Possession of Items Used in the Commission of a Crime', class = 'Misdemeanor', id = 'P.C. 2017', months = 10, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[18] = {title = 'Sale of Items Used in the Commission of a Crime', class = 'Felony', id = 'P.C. 2018', months = 15, fine = 1000, color = 'orange', description = 'Insert Charge Description Here'},
  --[19] = {title = 'Theft of an Aircraft', class = 'Felony', id = 'P.C. 2019', months = 20, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
  --[4] = {title = 'Possession of Stolen Goods', class = 'Misdemeanor', id = 'P.C. 2006', months = 10, fine = 500, color = 'green', description = 'Having bought, been given, or acquired stolen goods (i) which one knows, or any reasonable person would have realize have been stolen, extorted, embezzled or unlawfully taken in any manner (ii).'},

  --},
  --[8] = {
  --[1] = {title = 'Impersonating', class = 'Misdemeanor', id = 'P.C. 3001', months = 15, fine = 1250, color = 'green', description = 'Insert Charge Description Here'},
  --[2] = {title = 'Impersonation of a Government Official', class = 'Felony', id = 'P.C. 3001', months = 25, fine = 3000, color = 'green', description = 'The act of pretending to be a Lawyer or Government Official (i).'},
  --[3] = {title = 'Impersonating a Judge', class = 'Felony', id = 'P.C. 3003', months = 0, fine = 0, color = 'green', description = 'Insert Charge Description Here'},
  --[4] = {title = 'Possession of Stolen Identification', class = 'Misdemeanor', id = 'P.C. 3004', months = 10, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[5] = {title = 'Possession of Stolen Government Identification', class = 'Misdemeanor', id = 'P.C. 3005', months = 20, fine = 2000, color = 'green', description = 'Insert Charge Description Here'},
  --[6] = {title = 'Extortion', class = 'Felony', id = 'P.C. 3002', months = 30, fine = 3000, color = 'orange', description = 'The act of obtaining money from another person (i), through force of threats or harm (ii).'},
  --[7] = {title = 'Fraud', class = 'Misdemeanor', id = 'P.C. 3003', months = 20, fine = 2500, color = 'green', description = 'Intentionally misleading or deceiving another person or group (i), with a deliberate statement or action (ii) including the false statement on any legal document (iii).'},
  --[8] = {title = 'Forgery', class = 'Misdemeanor', id = 'P.C. 3008', months = 15, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[9] = {title = 'Money Laundering', class = 'Felony', id = 'P.C. 3004', months = 20, fine = 25000, color = 'red', description = 'The act of taking proceeds from an illegal operation and manipulating them to appear as if obtained legally.'},
  --},
  --[9] = {
  --[1] = {title = 'Trespassing on Restricted Government Soil', class = 'Misdemeanor', id = 'P.C. 4001', months = 10, fine = 450, color = 'green', description = '"Unauthorized entry upon the soil of a restricted Government area (i) within 100 meters (ii) and failure to depart after being requested to (iii).Loitering DOC without any purpose especially during code RED & Above. (IV)"'},
  --[2] = {title = 'Felony Trespassing', class = 'Felony', id = 'P.C. 4002', months = 15, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
  --[3] = {title = 'Arson', class = 'Felony', id = 'P.C. 4002', months = 10, fine = 1500, color = 'orange', description = 'The intentional destruction of property (i) resulting in explosion or fire (ii).'},
  --[4] = {title = 'Vandalism', class = 'Infraction', id = 'P.C. 4004', months = 0, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
  --[5] = {title = 'Vandalism of Government Property', class = 'Felony', id = 'P.C. 4005', months = 20, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
  --[6] = {title = 'Littering', class = 'Infraction', id = 'P.C. 4006', months = 0, fine = 200, color = 'green', description = 'Insert Charge Description Here'},
  --},
  --[10] = {
  --[1] = {title = 'Bribery', class = 'Felony', id = 'P.C. 5001', months = 15, fine = 3000, color = 'green', description = 'Persuading someone to commit an illegal act (i) in exchange for a gift, money, service or other item (ii).'},
  --[2] = {title = 'Anti-Mask Law', class = 'Infraction', id = 'P.C. 5002', months = 0, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[3] = {title = 'Possession of Contraband', class = 'Felony', id = 'P.C. 5002', months = 5, fine = 500, color = 'green', description = 'Possession of Illegal Items (i) with knowledge of their existence. (ii) i.e (un)processed uranium, ect (iii)'},
  --[4] = {title = 'Criminal Possession of Stolen Property', class = 'Misdemeanor', id = 'P.C. 5004', months = 10, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[5] = {title = 'Escaping Custody', class = 'Felony', id = 'P.C. 5003', months = 15, fine = 1500, color = 'green', description = 'Escaping the custody of a LEO (i), after previously being detained by a LEO (ii).'},
  --[6] = {title = 'Jailbreak', class = 'Felony', id = 'P.C. 5004', months = 150, fine = 10000, color = 'orange', description = 'The act of breaking out of a prison or jail (i), or breaking a convicted person out of a state prison or jail (ii).'},
  --[7] = {title = 'Accessory to Jailbreak', class = 'Felony', id = 'P.C. 5007', months = 25, fine = 2000, color = 'orange', description = 'Insert Charge Description Here'},
  --[8] = {title = 'Attempted Jailbreak', class = 'Felony', id = 'P.C. 5008', months = 20, fine = 1500, color = 'orange', description = 'Insert Charge Description Here'},
  --[9] = {title = 'Perjury', class = 'Felony', id = 'P.C. 5005', months = 15, fine = 2000, color = 'green', description = 'Submitting a false statement while under oath or affirmation (i).'},
  --[10] = {title = 'Violation of a Restraining Order', class = 'Felony', id = 'P.C. 5010', months = 20, fine = 2250, color = 'green', description = 'Insert Charge Description Here'},
  --[13] = {title = 'Misuse of Emergency Systems', class = 'Infraction', id = 'P.C. 5013', months = 0, fine = 600, color = 'orange', description = 'Insert Charge Description Here'},
  --[14] = {title = 'Conspiracy', class = 'Misdemeanor', id = 'P.C. 5014', months = 10, fine = 450, color = 'green', description = 'Insert Charge Description Here'},
  --[15] = {title = 'Violating a Court Order', class = 'Misdemeanor', id = 'P.C. 5015', months = 0, fine = 0, color = 'orange', description = 'Insert Charge Description Here'},
  --[16] = {title = 'Failure to Appear', class = 'Misdemeanor', id = 'P.C. 5016', months = 0, fine = 0, color = 'orange', description = 'Insert Charge Description Here'},
  --[17] = {title = 'Contempt of Court', class = 'Felony', id = 'P.C. 5017', months = 0, fine = 0, color = 'orange', description = 'Insert Charge Description Here'},
  --[18] = {title = 'Resisting Arrest', class = 'Misdemeanor', id = 'P.C. 5008', months = 5, fine = 500, color = 'orange', description = 'The act of using force to prevent arrest or detaining of a person (i).'},
  --},
  --[11] = {
  --[1] = {title = 'Disobeying a Peace Officer', class = 'infraction', id = 'P.C. 6001', months = 0, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[2] = {title = 'Disorderly Conduct', class = 'Infraction', id = 'P.C. 6002', months = 0, fine = 250, color = 'green', description = 'Insert Charge Description Here'},
  --[3] = {title = 'Disturbing the Peace', class = 'Misdemeanor', id = 'P.C. 6001', months = 5, fine = 500, color = 'green', description = 'Engaging in some form of disorderly conduct, (i) such as fighting, threatening to fight in public or causing excessively loud noise (ii).'},
  --[4] = {title = 'False Reporting', class = 'Misdemeanor', id = 'P.C. 6002', months = 5, fine = 1000, color = 'green', description = 'Knowingly making a report to the police which the person knows to be false (i).'},
  --[5] = {title = 'Harassment', class = 'Misdemeanor', id = 'P.C. 6003', months = 5, fine = 500, color = 'orange', description = 'Willfully, maliciously, and repeatedly (i) following or harassing a person (ii) to the point that person is reasonable to feel a substantial fear for their life (iii).'},
  --[6] = {title = 'Misdemeanor Obstruction of Justice', class = 'Misdemeanor', id = 'P.C. 6006', months = 10, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[7] = {title = 'Obstruction of Justice', class = 'Felony', id = 'P.C. 6004', months = 10, fine = 2000, color = 'green', description = 'Hindering the discovery, apprehension, conviction, defense, or punishment (i) of anyone who has committed a crime (ii).'},
  --[8] = {title = 'Inciting a Riot', class = 'Felony', id = 'P.C. 6008', months = 25, fine = 1000, color = 'orange', description = 'Insert Charge Description Here'},
  --[9] = {title = 'Loitering', class = 'Misdemeanor', id = 'P.C. 6005', months = 5, fine = 500, color = 'green', description = 'Remaining in any one public place without an apparent purpose (i) while being given a lawful order to disperse by a LEO (ii).'},
  --[10] = {title = 'Tampering', class = 'Misdemeanor', id = 'P.C. 6010', months = 10, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[11] = {title = 'Vehicle Tampering', class = 'Misdemeanor', id = 'P.C. 6011', months = 15, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[12] = {title = 'Evidence Tampering', class = 'Felony', id = 'P.C. 6012', months = 20, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
  --[13] = {title = 'Witness Tampering', class = 'Felony', id = 'P.C. 6013', months = 0, fine = 0, color = 'green', description = 'Insert Charge Description Here'},
  --[14] = {title = 'Failure to Identify', class = 'Misdemeanor', id = 'P.C. 6006', months = 5, fine = 500, color = 'green', description = 'Failure to identify to a LEO (i) while being detained (ii) under reasonable suspicion (iii).'},
  --[15] = {title = 'Vigilantism', class = 'Felony', id = 'P.C. 6015', months = 30, fine = 1500, color = 'orange', description = 'Insert Charge Description Here'},
  --[16] = {title = 'Unlawful Assembly', class = 'Misdemeanor', id = 'P.C. 6016', months = 10, fine = 750, color = 'orange', description = 'Insert Charge Description Here'},
  --[17] = {title = 'Corruption', class = 'Felony', id = 'P.C. 6007', months = 'HUT', fine = 'HUT', color = 'red', description = 'The act of a Government Official, Fiduciary Person, or Law Enforcement Officer (i) who unlawfully and wrongfully uses their station or character to procure some benefit to themselves or for another person'},
  --[18] = {title = 'Stalking', class = 'Felony', id = 'P.C. 6008', months = 10, fine = 1000, color = 'orange', description = 'The deliberate following and spying on an individual (i) such acts are unwanted by the party (ii)'},
  --[19] = {title = 'Aiding and Abetting', class = 'Misdemeanor', id = 'P.C. 6019', months = 15, fine = 450, color = 'orange', description = 'Insert Charge Description Here'},
  --[20] = {title = 'Harboring a Fugitive', class = 'Misdemeanor', id = 'P.C. 6020', months = 10, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
  --},

  --[12] = {
  --[1] = {title = 'Vehicular Manslaughter', class = 'Felony', id = 'P.C. 9001', months = 50, fine = 5000, color = 'red', description = 'Causing the death of a person (i) with a vehicle (ii) due to recklessness (iii).'},
  --[2] = {title = 'Reckless Driving', class = 'Felony', id = 'P.C. 9002', months = 10, fine = 1500, color = 'red', description = 'While in a vehicle (i). driving in a manner which a reasonable person would view as reckless (ii) and with disregard for human life and safety (iii).'},
  --[3] = {title = 'Grand Theft Auto', class = 'Felony', id = 'P.C. 9003', months = 10, fine = 1000, color = 'red', description = 'Operation of a motor vehicle (i) without the consent of its registered owner (ii), and moving it from its point of origin (iii).'},
  --[4] = {title = 'Violation of No-Fly Zone', class = 'Felony', id = 'P.C. 9004', months = 10, fine = 1000, color = 'red', description = 'The act of operating an aircraft (i) within a no-fly zone (ii).'},
  --[5] = {title = 'Felony Evading Arrest', class = 'Felony', id = 'P.C. 9005', months = 20, fine = 2000, color = 'red', description = 'Operation of a motor vehicle (i). and intentionally fleeing from an LEO to avoid arrest or detainment (ii).'},
  --[1] = {title = 'Driving While Intoxicated', class = 'Misdemeanor', id = 'P.C. 9001', months = 5, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
  --[2] = {title = 'Evading', class = 'Misdemeanor', id = 'P.C. 9002', months = 5, fine = 400, color = 'green', description = 'Insert Charge Description Here'},
  --[3] = {title = 'Reckless Evading', class = 'Felony', id = 'P.C. 9003', months = 10, fine = 800, color = 'orange', description = 'Insert Charge Description Here'},
  --[4] = {title = 'Failure to Yield to Emergency Vehicle', class = 'Infraction', id = 'P.C. 9004', months = 0, fine = 600, color = 'green', description = 'Insert Charge Description Here'},
  --[5] = {title = 'Failure to Obey Traffic Control Device', class = 'Infraction', id = 'P.C. 9005', months = 0, fine = 150, color = 'green', description = 'Insert Charge Description Here'},
  --[6] = {title = 'Nonfunctional Vehicle', class = 'Infraction', id = 'P.C. 9006', months = 0, fine = 75, color = 'green', description = 'Insert Charge Description Here'},
  --[7] = {title = 'Negligent Driving', class = 'Infraction', id = 'P.C. 9007', months = 0, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
  --[8] = {title = 'Reckless Driving', class = 'Misdemeanor', id = 'P.C. 9008', months = 10, fine = 750, color = 'orange', description = 'Insert Charge Description Here'},
  --[9] = {title = 'Third Degree Speeding', class = 'Infraction', id = 'P.C. 9009', months = 0, fine = 225, color = 'green', description = 'Insert Charge Description Here'},
  --[10] = {title = 'Second Degree Speeding', class = 'Infraction', id = 'P.C. 9010', months = 0, fine = 450, color = 'green', description = 'Insert Charge Description Here'},
  --[11] = {title = 'First Degree Speeding', class = 'Infraction', id = 'P.C. 9011', months = 0, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[12] = {title = 'Unlicensed Operation of Vehicle', class = 'Infraction', id = 'P.C. 9012', months = 0, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[13] = {title = 'Illegal U-Turn', class = 'Infraction', id = 'P.C. 9013', months = 0, fine = 75, color = 'green', description = 'Insert Charge Description Here'},
  --[14] = {title = 'Illegal Passing', class = 'Infraction', id = 'P.C. 9014', months = 0, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
  --[15] = {title = 'Failure to Maintain Lane', class = 'Infraction', id = 'P.C. 9015', months = 0, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
  --[16] = {title = 'Illegal Turn', class = 'Infraction', id = 'P.C. 9016', months = 0, fine = 150, color = 'green', description = 'Insert Charge Description Here'},
  --[17] = {title = 'Failure to Stop', class = 'Infraction', id = 'P.C. 9017', months = 0, fine = 600, color = 'green', description = 'Insert Charge Description Here'},
  --[18] = {title = 'Unauthorized Parking', class = 'Infraction', id = 'P.C. 9018', months = 0, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
  --[19] = {title = 'Hit and Run', class = 'Misdemeanor', id = 'P.C. 9019', months = 10, fine = 500, color = 'green', description = 'Insert Charge Description Here'},
  --[20] = {title = 'Driving without Headlights or Signals', class = 'Infraction', id = 'P.C. 9020', months = 0, fine = 300, color = 'green', description = 'Insert Charge Description Here'},
  --[21] = {title = 'Street Racing', class = 'Felony', id = 'P.C. 9021', months = 15, fine = 1500, color = 'green', description = 'Insert Charge Description Here'},
  --[22] = {title = 'Piloting without Proper Licensing', class = 'Felony', id = 'P.C. 9022', months = 20, fine = 1500, color = 'orange', description = 'Insert Charge Description Here'},
  --[23] = {title = 'Unlawful Use of a Motorvehicle', class = 'Misdemeanor', id = 'P.C. 9023', months = 10, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --},
  --[13] = {
  --[1] = {title = 'Hunting in Restricted Areas', class = 'Infraction', id = 'P.C. 10001', months = 0, fine = 450, color = 'green', description = 'Insert Charge Description Here'},
  --[2] = {title = 'Unlicensed Hunting', class = 'Infraction', id = 'P.C. 10002', months = 0, fine = 450, color = 'green', description = 'Insert Charge Description Here'},
  --[3] = {title = 'Animal Cruelty', class = 'Misdemeanor', id = 'P.C. 10003', months = 10, fine = 450, color = 'green', description = 'Insert Charge Description Here'},
  --[4] = {title = 'Hunting with a Non-Hunting Weapon', class = 'Misdemeanor', id = 'P.C. 10004', months = 10, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[5] = {title = 'Hunting outside of hunting hours', class = 'Infraction', id = 'P.C. 10005', months = 0, fine = 750, color = 'green', description = 'Insert Charge Description Here'},
  --[6] = {title = 'Overhunting', class = 'Misdemeanor', id = 'P.C. 10006', months = 10, fine = 1000, color = 'green', description = 'Insert Charge Description Here'},
  --[7] = {title = 'Poaching', class = 'Felony', id = 'P.C. 10007', months = 20, fine = 1250, color = 'red', description = 'Insert Charge Description Here'},
  --},
}

Config.PoliceJobs = {
  ['police'] = true,
  ['lspd'] = true,
  ['bcso'] = true,
  ['sast'] = true,
  ['sasp'] = true,
  ['doc'] = true,
  ['lssd'] = true,
  ['sapr'] = true,
  ['pa'] = true
}

Config.AmbulanceJobs = {
  ['ambulance'] = true,
  ['doctor'] = true
}

Config.DojJobs = {
  ['lawyer'] = true,
  ['judge'] = true
}

-- Leave my hacky code alone ya goblins
Config.AllowedJobs = {}
for index, value in pairs(Config.PoliceJobs) do
  Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.AmbulanceJobs) do
  Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.DojJobs) do
  Config.AllowedJobs[index] = value
end
-- Leave my hacky code alone ya goblins

Config.LogPerms = {
  ['ambulance'] = {
    [4] = true,
  },
  ['police'] = {
    [4] = true,
  },
  ['bcso'] = {
    [4] = true,
  },
  ['sast'] = {
    [4] = true,
  },
  ['sasp'] = {
    [4] = true,
  },
  ['sapr'] = {
    [4] = true,
  },
  ['doc'] = {
    [4] = true,
  },
  ['lssd'] = {
    [4] = true,
  },
}

Config.ColorNames = {
  [0] = "Metallic Black",
  [1] = "Metallic Graphite Black",
  [2] = "Metallic Black Steel",
  [3] = "Metallic Dark Silver",
  [4] = "Metallic Silver",
  [5] = "Metallic Blue Silver",
  [6] = "Metallic Steel Gray",
  [7] = "Metallic Shadow Silver",
  [8] = "Metallic Stone Silver",
  [9] = "Metallic Midnight Silver",
  [10] = "Metallic Gun Metal",
  [11] = "Metallic Anthracite Grey",
  [12] = "Matte Black",
  [13] = "Matte Gray",
  [14] = "Matte Light Grey",
  [15] = "Util Black",
  [16] = "Util Black Poly",
  [17] = "Util Dark silver",
  [18] = "Util Silver",
  [19] = "Util Gun Metal",
  [20] = "Util Shadow Silver",
  [21] = "Worn Black",
  [22] = "Worn Graphite",
  [23] = "Worn Silver Grey",
  [24] = "Worn Silver",
  [25] = "Worn Blue Silver",
  [26] = "Worn Shadow Silver",
  [27] = "Metallic Red",
  [28] = "Metallic Torino Red",
  [29] = "Metallic Formula Red",
  [30] = "Metallic Blaze Red",
  [31] = "Metallic Graceful Red",
  [32] = "Metallic Garnet Red",
  [33] = "Metallic Desert Red",
  [34] = "Metallic Cabernet Red",
  [35] = "Metallic Candy Red",
  [36] = "Metallic Sunrise Orange",
  [37] = "Metallic Classic Gold",
  [38] = "Metallic Orange",
  [39] = "Matte Red",
  [40] = "Matte Dark Red",
  [41] = "Matte Orange",
  [42] = "Matte Yellow",
  [43] = "Util Red",
  [44] = "Util Bright Red",
  [45] = "Util Garnet Red",
  [46] = "Worn Red",
  [47] = "Worn Golden Red",
  [48] = "Worn Dark Red",
  [49] = "Metallic Dark Green",
  [50] = "Metallic Racing Green",
  [51] = "Metallic Sea Green",
  [52] = "Metallic Olive Green",
  [53] = "Metallic Green",
  [54] = "Metallic Gasoline Blue Green",
  [55] = "Matte Lime Green",
  [56] = "Util Dark Green",
  [57] = "Util Green",
  [58] = "Worn Dark Green",
  [59] = "Worn Green",
  [60] = "Worn Sea Wash",
  [61] = "Metallic Midnight Blue",
  [62] = "Metallic Dark Blue",
  [63] = "Metallic Saxony Blue",
  [64] = "Metallic Blue",
  [65] = "Metallic Mariner Blue",
  [66] = "Metallic Harbor Blue",
  [67] = "Metallic Diamond Blue",
  [68] = "Metallic Surf Blue",
  [69] = "Metallic Nautical Blue",
  [70] = "Metallic Bright Blue",
  [71] = "Metallic Purple Blue",
  [72] = "Metallic Spinnaker Blue",
  [73] = "Metallic Ultra Blue",
  [74] = "Metallic Bright Blue",
  [75] = "Util Dark Blue",
  [76] = "Util Midnight Blue",
  [77] = "Util Blue",
  [78] = "Util Sea Foam Blue",
  [79] = "Uil Lightning blue",
  [80] = "Util Maui Blue Poly",
  [81] = "Util Bright Blue",
  [82] = "Matte Dark Blue",
  [83] = "Matte Blue",
  [84] = "Matte Midnight Blue",
  [85] = "Worn Dark blue",
  [86] = "Worn Blue",
  [87] = "Worn Light blue",
  [88] = "Metallic Taxi Yellow",
  [89] = "Metallic Race Yellow",
  [90] = "Metallic Bronze",
  [91] = "Metallic Yellow Bird",
  [92] = "Metallic Lime",
  [93] = "Metallic Champagne",
  [94] = "Metallic Pueblo Beige",
  [95] = "Metallic Dark Ivory",
  [96] = "Metallic Choco Brown",
  [97] = "Metallic Golden Brown",
  [98] = "Metallic Light Brown",
  [99] = "Metallic Straw Beige",
  [100] = "Metallic Moss Brown",
  [101] = "Metallic Biston Brown",
  [102] = "Metallic Beechwood",
  [103] = "Metallic Dark Beechwood",
  [104] = "Metallic Choco Orange",
  [105] = "Metallic Beach Sand",
  [106] = "Metallic Sun Bleeched Sand",
  [107] = "Metallic Cream",
  [108] = "Util Brown",
  [109] = "Util Medium Brown",
  [110] = "Util Light Brown",
  [111] = "Metallic White",
  [112] = "Metallic Frost White",
  [113] = "Worn Honey Beige",
  [114] = "Worn Brown",
  [115] = "Worn Dark Brown",
  [116] = "Worn straw beige",
  [117] = "Brushed Steel",
  [118] = "Brushed Black steel",
  [119] = "Brushed Aluminium",
  [120] = "Chrome",
  [121] = "Worn Off White",
  [122] = "Util Off White",
  [123] = "Worn Orange",
  [124] = "Worn Light Orange",
  [125] = "Metallic Securicor Green",
  [126] = "Worn Taxi Yellow",
  [127] = "police car blue",
  [128] = "Matte Green",
  [129] = "Matte Brown",
  [130] = "Worn Orange",
  [131] = "Matte White",
  [132] = "Worn White",
  [133] = "Worn Olive Army Green",
  [134] = "Pure White",
  [135] = "Hot Pink",
  [136] = "Salmon pink",
  [137] = "Metallic Vermillion Pink",
  [138] = "Orange",
  [139] = "Green",
  [140] = "Blue",
  [141] = "Mettalic Black Blue",
  [142] = "Metallic Black Purple",
  [143] = "Metallic Black Red",
  [144] = "Hunter Green",
  [145] = "Metallic Purple",
  [146] = "Metaillic V Dark Blue",
  [147] = "MODSHOP BLACK1",
  [148] = "Matte Purple",
  [149] = "Matte Dark Purple",
  [150] = "Metallic Lava Red",
  [151] = "Matte Forest Green",
  [152] = "Matte Olive Drab",
  [153] = "Matte Desert Brown",
  [154] = "Matte Desert Tan",
  [155] = "Matte Foilage Green",
  [156] = "DEFAULT ALLOY COLOR",
  [157] = "Epsilon Blue",
  [158] = "Unknown",
}

Config.ColorInformation = {
  [0] = "black",
  [1] = "black",
  [2] = "black",
  [3] = "darksilver",
  [4] = "silver",
  [5] = "bluesilver",
  [6] = "silver",
  [7] = "darksilver",
  [8] = "silver",
  [9] = "bluesilver",
  [10] = "darksilver",
  [11] = "darksilver",
  [12] = "matteblack",
  [13] = "gray",
  [14] = "lightgray",
  [15] = "black",
  [16] = "black",
  [17] = "darksilver",
  [18] = "silver",
  [19] = "utilgunmetal",
  [20] = "silver",
  [21] = "black",
  [22] = "black",
  [23] = "darksilver",
  [24] = "silver",
  [25] = "bluesilver",
  [26] = "darksilver",
  [27] = "red",
  [28] = "torinored",
  [29] = "formulared",
  [30] = "blazered",
  [31] = "gracefulred",
  [32] = "garnetred",
  [33] = "desertred",
  [34] = "cabernetred",
  [35] = "candyred",
  [36] = "orange",
  [37] = "gold",
  [38] = "orange",
  [39] = "red",
  [40] = "mattedarkred",
  [41] = "orange",
  [42] = "matteyellow",
  [43] = "red",
  [44] = "brightred",
  [45] = "garnetred",
  [46] = "red",
  [47] = "red",
  [48] = "darkred",
  [49] = "darkgreen",
  [50] = "racingreen",
  [51] = "seagreen",
  [52] = "olivegreen",
  [53] = "green",
  [54] = "gasolinebluegreen",
  [55] = "mattelimegreen",
  [56] = "darkgreen",
  [57] = "green",
  [58] = "darkgreen",
  [59] = "green",
  [60] = "seawash",
  [61] = "midnightblue",
  [62] = "darkblue",
  [63] = "saxonyblue",
  [64] = "blue",
  [65] = "blue",
  [66] = "blue",
  [67] = "diamondblue",
  [68] = "blue",
  [69] = "blue",
  [70] = "brightblue",
  [71] = "purpleblue",
  [72] = "blue",
  [73] = "ultrablue",
  [74] = "brightblue",
  [75] = "darkblue",
  [76] = "midnightblue",
  [77] = "blue",
  [78] = "blue",
  [79] = "lightningblue",
  [80] = "blue",
  [81] = "brightblue",
  [82] = "mattedarkblue",
  [83] = "matteblue",
  [84] = "matteblue",
  [85] = "darkblue",
  [86] = "blue",
  [87] = "lightningblue",
  [88] = "yellow",
  [89] = "yellow",
  [90] = "bronze",
  [91] = "yellow",
  [92] = "lime",
  [93] = "champagne",
  [94] = "beige",
  [95] = "darkivory",
  [96] = "brown",
  [97] = "brown",
  [98] = "lightbrown",
  [99] = "beige",
  [100] = "brown",
  [101] = "brown",
  [102] = "beechwood",
  [103] = "beechwood",
  [104] = "chocoorange",
  [105] = "yellow",
  [106] = "yellow",
  [107] = "cream",
  [108] = "brown",
  [109] = "brown",
  [110] = "brown",
  [111] = "white",
  [112] = "white",
  [113] = "beige",
  [114] = "brown",
  [115] = "brown",
  [116] = "beige",
  [117] = "steel",
  [118] = "blacksteel",
  [119] = "aluminium",
  [120] = "chrome",
  [121] = "wornwhite",
  [122] = "offwhite",
  [123] = "orange",
  [124] = "lightorange",
  [125] = "green",
  [126] = "yellow",
  [127] = "blue",
  [128] = "green",
  [129] = "brown",
  [130] = "orange",
  [131] = "white",
  [132] = "white",
  [133] = "darkgreen",
  [134] = "white",
  [135] = "pink",
  [136] = "pink",
  [137] = "pink",
  [138] = "orange",
  [139] = "green",
  [140] = "blue",
  [141] = "blackblue",
  [142] = "blackpurple",
  [143] = "blackred",
  [144] = "darkgreen",
  [145] = "purple",
  [146] = "darkblue",
  [147] = "black",
  [148] = "purple",
  [149] = "darkpurple",
  [150] = "red",
  [151] = "darkgreen",
  [152] = "olivedrab",
  [153] = "brown",
  [154] = "tan",
  [155] = "green",
  [156] = "silver",
  [157] = "blue",
  [158] = "black",
}

Config.ClassList = {
  [0] = "Compact",
  [1] = "Sedan",
  [2] = "SUV",
  [3] = "Coupe",
  [4] = "Muscle",
  [5] = "Sport Classic",
  [6] = "Sport",
  [7] = "Super",
  [8] = "Motorbike",
  [9] = "Off-Road",
  [10] = "Industrial",
  [11] = "Utility",
  [12] = "Van",
  [13] = "Bike",
  [14] = "Boat",
  [15] = "Helicopter",
  [16] = "Plane",
  [17] = "Service",
  [18] = "Emergency",
  [19] = "Military",
  [20] = "Commercial",
  [21] = "Train"
}

function GetJobType(job)
  if Config.PoliceJobs[job] then
    return 'police'
  elseif Config.AmbulanceJobs[job] then
    return 'ambulance'
  elseif Config.DojJobs[job] then
    return 'doj'
  else
    return nil
  end
end

-- this is a hack, because the qb-menu in qb-policejob populates an impound location and passed it through to the event.
-- if this impound locations are changed in qb-policejob, they must also be changed here.
Config.ImpoundLocations = {
  [1] = vector4(436.68, -1007.42, 27.32, 180.0),
  [2] = vector4(-436.14, 5982.63, 31.34, 136.0),
}
