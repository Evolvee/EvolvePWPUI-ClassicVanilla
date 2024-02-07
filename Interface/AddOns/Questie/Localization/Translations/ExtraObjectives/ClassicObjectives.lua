---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

local classicObjectiveLocales = {
    ["Summon Dagun the Ravenous using an Enchanted Sea Kelp"] = { -- 735 736
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Verzauberten Seetang benutzen, um Dagun den Gefräßigen zu beschwören",
        ["koKR"] = "마법의 해조를 사용하여 포악한 다군을 소환",
        ["esMX"] = "Invoca a Dagun el Voraz utilizando un Kelp marino encantado",
        ["enUS"] = true,
        ["frFR"] = "Invoquez Dagun le Vorace en utilisant un Varech Énchanté",
        ["esES"] = "Invoca a Dagun el Voraz utilizando un Kelp marino encantado",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use a Fresh Carcass at the Flame of Uzel"] = { -- 1136
        ["ptBR"] = false,
        ["ruRU"] = "Используйте Свежую Тушу в Пламени Узеля",
        ["deDE"] = "Einen frischen Kadaver an der Flamme von Uzel verbrennen.",
        ["koKR"] = "우젤의 불꽃에서 방금 죽은 사자 시체를 사용하세요",
        ["esMX"] = "Deja el Cadáver fresco sobre la Llama de Uzel",
        ["enUS"] = true,
        ["frFR"] = "Utilisez une Carcasse Fraiche sur la Flamme d'Uzel",
        ["esES"] = "Deja el Cadáver fresco sobre la Llama de Uzel",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Fish for Darkshore Groupers"] = { -- 1141
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Dunkelküstenbarsche angeln",
        ["koKR"] = "낚시를 통해 어둠의해안 농어를 획득하세요",
        ["esMX"] = "Pesca Meros de Costa Oscura",
        ["enUS"] = true,
        ["frFR"] = "Pêchez des Mérous de Sombrerivage",
        ["esES"] = "Pesca Meros de Costa Oscura",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Slay Gelkis centaur to increase your reputation with the Magram Clan"] = { -- 1367
        ["ptBR"] = false,
        ["ruRU"] = "Убейте кентавра из племени Гелкис, чтобы поднять свою репутацию с племенем Маграм",
        ["deDE"] = "Töte Gelkis-Zentauren, um Ansehen beim Magram-Clan zu erhöhen.",
        ["koKR"] = "마그람일족의 평판 획득을 위해 겔키스 켄타우로스를 사냥하세요",
        ["esMX"] = "Mata al centauro Gelkis para aumentar tu reputación con el clan Magram",
        ["enUS"] = true,
        ["frFR"] = "Tuez des centaures Gelkis pour augmenter votre réputation auprès du Clan Magram",
        ["esES"] = "Mata al centauro Gelkis para aumentar tu reputación con el clan Magram",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Slay Magram centaur to increase your reputation with the Gelkis Clan"] = { -- 1368
        ["ptBR"] = false,
        ["ruRU"] = "Убейте кентавра из племени Маграм, чтобы поднять свою репутацию с племенем Гелкис",
        ["deDE"] = "Töte Magram-Zentauren, um dein Ansehen beim Gelkis-Clan zu erhöhen.",
        ["koKR"] = "겔키스일족의 평판 획득을 위해 마그람 켄타우로스를 사냥하세요",
        ["esMX"] = "Mata al centauro Magram para aumentar tu reputación con el Clan Gelkis",
        ["enUS"] = true,
        ["frFR"] = "Tuez des centaures Magram pour augmenter votre réputation auprès du Clan Gelkis",
        ["esES"] = "Mata al centauro Magram para aumentar tu reputación con el Clan Gelkis",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the War Horn Mouthpiece to summon Khan Hratha"] = { -- 1380 1381
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Kriegshornmundstück benutzen, um Khan Hratha zu rufen",
        ["koKR"] = "전쟁 뿔피리 파이프를 사용하여 칸 흐라사를 소환하세요",
        ["esMX"] = "Utiliza la Boquilla del cuerno de guerra para invocar a Khan Hratha",
        ["enUS"] = true,
        ["frFR"] = "Utilisez l'Embouchure de Cor de Guerre pour invoquer Khan Hratha",
        ["esES"] = "Utiliza la Boquilla del cuerno de guerra para invocar a Khan Hratha",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Fish for Gaffer Jacks"] = { -- 1579
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Klemm-Muffen angeln",
        ["koKR"] = "낚시로 개퍼 잭을 획득하세요",
        ["esMX"] = "Pesca Mecanismos eléctricos",
        ["enUS"] = true,
        ["frFR"] = "Pêchez des Rouages Électriques",
        ["esES"] = "Pesca Mecanismos eléctricos",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Fish for Electropellers"] = { -- 1580
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Elektropeller angeln",
        ["koKR"] = "낚시로 전력추진기를 획득하세요",
        ["esMX"] = "Pesca electromuelles",
        ["enUS"] = true,
        ["frFR"] = "Pêchez des Électropellers",
        ["esES"] = "Pesca electromuelles",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use Cantation of Manifestation to reveal Rift Spawn. Use Chest of Containment Coffers on stunned Rift Spawn"] = { -- 1920 & 1960
        ["ptBR"] = false,
        ["ruRU"] = "Используйте Свиток заклятия Проявления, чтобы увидеть Порождение Разлома. Используйте Ящик со шкатулками-духоловками на ошеломленное Порождение Разлома",
        ["deDE"] = "Benutze die Kantate der Manifestation, um den Rift-Spawn zu enthüllen. Verwende Truhe der Eindämmungskassen am betäubtem Rift-Spawn.",
        ["koKR"] = "현신의 주문서를 사용하여 균열의 정령을 찾으세요. 스턴 상태의 균열의 정령에게 속박의 상자를 사용하세요",
        ["esMX"] = "Utiliza Canto de Manifestación para revelar Cría del risco. Crea un arca de contención sobre una cría del risco aturdida",
        ["enUS"] = true,
        ["frFR"] = "Utilisez un Chant de Manifestation pour révéler le Rejeton de la Faille. Utilisez une Caisse de coffres de stockage sur le Rejeton de la Faille",
        ["esES"] = "Utiliza Canto de Manifestación para revelar Cría del risco. Crea un arca de contención sobre una cría del risco aturdida",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Step 1: obtain the Yellow Punch Card. You need the White Punch Card."] = { -- 2930
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Schritt 1: Erhalte die gelbe Lochkarte. Weiße Lochkarte wird benötigt.",
        ["koKR"] = "Step 1: 황색 천공 카드를 획득하세요. 백색 천공 카드가 필요합니다",
        ["esMX"] = "Paso 1: obtén la Tarjeta perforada amarilla. Necesitas la Tarjeta perforada blanca.",
        ["enUS"] = true,
        ["frFR"] = "Étape 1 : Obtenez la Carte Perforée Jaune. Vous aurez besoin de la Carte Perforée Blanche.",
        ["esES"] = "Paso 1: obtén la Tarjeta perforada amarilla. Necesitas la Tarjeta perforada blanca.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Step 2: obtain the Blue Punch Card. You need the Yellow Punch Card."] = { -- 2930
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Schritt 2: Erhalte die blaue Lochkarte. Gelbe Lochkarte wird benötigt.",
        ["koKR"] = "Step 2: 청색 천공 카드를 획득하세요. 황색 천공 카드가 필요합니다",
        ["esMX"] = "Paso 2: obtén la Tarjeta perforada azul. Necesitas la Tarjeta perforada amarilla.",
        ["enUS"] = true,
        ["frFR"] = "Étape 2 : Obtenez la Carte Perforée Bleue. Vous aurez besoin de la Carte Perforée Jaune.",
        ["esES"] = "Paso 2: obtén la Tarjeta perforada azul. Necesitas la Tarjeta perforada amarilla.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Step 3: obtain the Red Punch Card. You need the Blue Punch Card."] = { -- 2930
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Schritt 3: Erhalte die rote Stempelkarte. Blaue Lochkarte wird benötigt.",
        ["koKR"] = "Step 3: 적색 천공 카드를 획득하세요. 청색 천공 카드가 필요합니다",
        ["esMX"] = "Paso 3: obtén la Tarjeta perforada roja. Necesitas la Tarjeta perforada azul.",
        ["enUS"] = true,
        ["frFR"] = "Étape 3 : Obtenez la Carte Perforée Rouge. Vous aurez besoin de la Carte de Carte Perforée Bleue.",
        ["esES"] = "Paso 3: obtén la Tarjeta perforada roja. Necesitas la Tarjeta perforada azul.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Step 4: obtain the Prismatic Punch Card. You need the Red Punch Card."] = { -- 2930
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Schritt 4: Erhalte die prismatische Lochkarte. Rote Lochkarte wird benötigt.",
        ["koKR"] = "Step 4: 오색 천공 카드를 획득하세요. 적색 천공 카드가 필요합니다",
        ["esMX"] = "Paso 4: obtén la Tarjeta perforada prismática. Necesitas la Tarjeta perforada roja.",
        ["enUS"] = true,
        ["frFR"] = "Étape 4 : Obtenez la Carte Perforée Prismatique. Vous aurez besoin de la Carte Perforée Rouge.",
        ["esES"] = "Paso 4: obtén la Tarjeta perforada prismática. Necesitas la Tarjeta perforada roja.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Slay Vale Screechers and use Yeh'kinya's Bramble on their corpse."] = { -- 3520
        ["ptBR"] = false,
        ["ruRU"] = "Убейте Норовистого дольного крикуна, а затем используйте Колючку Йе'киньи на его трупе.",
        ["deDE"] = "Erschlagt Wilde Talkreischer und benutzt dann Yeh'kinyas Dornbusch auf ihren Körpern.",
        ["koKR"] = "계곡 천둥매 처치 후 예킨야의 나뭇가지를 천둥매 시체에 사용하세요",
        ["esMX"] = "Mata a Estridadores del valle y utiliza la Zarza de Yeh'kinya en su cadáver.",
        ["enUS"] = true,
        ["frFR"] = "Tuez les Hurleurs des Vallées et utilisez la Ronce de Yeh'kinya sur leurs corps.",
        ["esES"] = "Mata a Estridadores del valle y utiliza la Zarza de Yeh'kinya en su cadáver.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the Ward of the Defiler to summon Razelikh."] = { -- 3628
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Zauberschutz der Entweihten benutzen, um Razelikh zu beschwören",
        ["koKR"] = "파멸자의 수호물을 사용하여 파멸자 라젤리크를 소환하세요",
        ["esMX"] = "Utiliza el Amuleto del Rapiñador para invocar a Razelikh.",
        ["enUS"] = true,
        ["frFR"] = "Utilisez l'Amulette du Souilleur pour invoquer Razelikh.",
        ["esES"] = "Utiliza el Amuleto del Rapiñador para invocar a Razelikh.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Teleport to the top of the mountain."] = { -- 3628
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Zur Bergspitze teleportieren",
        ["koKR"] = "산 꼭대기로 텔레포트 하세요",
        ["esMX"] = "Teletransportarse a la cima de la montaña.",
        ["enUS"] = true,
        ["frFR"] = "Téléportez-vous en haut de la montagne.",
        ["esES"] = "Teletransportarse a la cima de la montaña.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Place the Bait in front of Miblon Snarltooth."] = { -- 3909
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Den Köder vor Miblon Fletschmaul legen",
        ["koKR"] = "미블론 스날투스 앞에 미끼를 두세요",
        ["esMX"] = "Deja el cebo cerca de Miblon Gruñidiente",
        ["enUS"] = true,
        ["frFR"] = "Placez l'appât devant Miblon Grondequenotte.",
        ["esES"] = "Deja el cebo cerca de Miblon Gruñidiente",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the Altered Black Dragonflight Molt on Bael'gar's corpse."] = { -- 4024
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Benutze die veränderte Haut des schwarzen Drachenschwarms mit Bael'Gar's Leichnam",
        ["koKR"] = "밸가르 시체 위에서 변형된 검은용군단 허물을 사용하세요",
        ["esMX"] = "Utiliza la Muda de piel de vuelo negro alterada en los restos de Bael'Gar.",
        ["enUS"] = true,
        ["frFR"] = "Utilisez le Cuir de dragon noir altéré sur le corps de Bael'gar.",
        ["esES"] = "Utiliza la Muda de piel de vuelo negro alterada en los restos de Bael'Gar.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the Gorishi Queen Lure."] = { -- 4507
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Benutze den Köder für die Gorishischwarmkönigin",
        ["koKR"] = "여왕 고리쉬 미끼를 사용하세요",
        ["esMX"] = "Utiliza el Cebo de reina Gorishi",
        ["enUS"] = true,
        ["frFR"] = "Utilisez l'Appât de Reine Gorish.",
        ["esES"] = "Utiliza el Cebo de reina Gorishi",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Collect eggs using the Collectronic Module."] = { -- 4735
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Sammle Eier mit dem Kollektronischen Modul",
        ["koKR"] = "수집전자 모듈을 사용하여 용의 알을 수집하세요",
        ["esMX"] = "Recoge huevos con el Módulo colectrónico",
        ["enUS"] = true,
        ["frFR"] = "Collectez les œufs en utilisant le Module Collectronique.",
        ["esES"] = "Recoge huevos con el Módulo colectrónico",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Summon Xabraxxis once you have the required items from the Blackwood Stores."] = { -- 4763
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Beschwöre Xabraxxis sobald Ihr die benötigten Gegenstände von den Lager der Schwarzfelle habt.",
        ["koKR"] = "검은나무일족 곡식 저장고에서 사브라시스 소환에 필요한 아이템을 모두 모았다면 소환 의식을 진행하세요",
        ["esMX"] = "Invoca a Xabraxxis una vez que tengas los objetos necesarios de las Provisiones del Bosque Negro.",
        ["enUS"] = true,
        ["frFR"] = "Invoquez Xabraxxis une fois que vous aurez les objets nécessaires des Réserves des Noirbois.",
        ["esES"] = "Invoca a Xabraxxis una vez que tengas los objetos necesarios de las Provisiones del Bosque Negro.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the Flames of the Black Flight over it to create the Seal."] = { -- 4743
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Flammen des schwarzen Drachenschwarms benutzen, um das Siegel zu erstellen",
        ["koKR"] = "인장을 만들기 위해 검은용군단의 불길을 시전하세요",
        ["esMX"] = "Utiliza las Llamas del Vuelo Negro sobre él para crear el Sello.",
        ["enUS"] = true,
        ["frFR"] = "Utilisez dessus les Flammes des Dragons Noirs pour créer le Sceau.",
        ["esES"] = "Utiliza las Llamas del Vuelo Negro sobre él para crear el Sello.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Beat Emberstrife till his will is broken, then place the Unforged Seal of Ascension before him and use the Orb of Draconic Energy."] = { -- 4743
        ["ptBR"] = false,
        ["ruRU"] = "Победите Огнебора, пока его воля не сломлена, затем поместите Заготовку печати Вознесения перед ним, после чего используйте Сферу энергии дракона.",
        ["deDE"] = "Kämpfe mit Aschenschwinge, bis sein Wille gebrochen ist, platziere dann das Ungeschmiedete Siegel des Aufstiegs vor ihm und benutze den Orb der Drakonischen Energie.",
        ["koKR"] = "엠버스트라이프를 의지가 꺾일 때 까지 때린 후, 벼려지지 않은 승천의 인장을 엠버스트라이프 앞에 놓으세요. 그 후, 용력의 보주를 사용하여 엠버스트라이프의 정신을 제압하세요",
        ["esMX"] = "Encuentra al anciano draco Brasaliza y derrótalo sin contemplaciones hasta doblegar su voluntad, entonces coloca el Sello de ascensión sin forjar ante la colosal bestia y usa el orbe de energía dracónica.",
        ["enUS"] = true,
        ["frFR"] = "Combattez Brandeguerre jusqu'à ce que sa volonté soit brisée, puis placez le Sceau d'Ascension Brut avant lui et utilisez l'Orbe d'Énergie Draconique.",
        ["esES"] = "Encuentra al anciano draco Brasaliza y derrótalo sin contemplaciones hasta doblegar su voluntad, entonces coloca el Sello de ascensión sin forjar ante la colosal bestia y usa el orbe de energía dracónica.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Lure the Kodos to Smeed Scrabblescrew."] = { -- 5561
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Führe die Kodos zu Smeed Scrabblescrew",
        ["koKR"] = "코도를 유인하여 스미드 스크래블스크류에게 데려가세요",
        ["esMX"] = "Atrae a los kodos a Smeed Mezclatornillos",
        ["enUS"] = true,
        ["frFR"] = "Apprivoisez les Kodos pour Smeed Scrabblescrew.",
        ["esES"] = "Atrae a los kodos a Smeed Mezclatornillos",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Summon Lord Kragaru"] = { -- 6027
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Lord Kragaru beschwören",
        ["koKR"] = "군주 크라가루를 소환하세요",
        ["esMX"] = "Invoca a Lord Kragaru",
        ["enUS"] = true,
        ["frFR"] = "Invoquez Seigneur Kragaru",
        ["esES"] = "Invoca a Lord Kragaru",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Place the Crate of Ghost Magnets"] = { -- 6134
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Platziere die Kiste mit Geistermagneten",
        ["koKR"] = "유령 유인기 상자를 설치하세요",
        ["esMX"] = "Deja el Cajón de imanes fantasmales",
        ["enUS"] = true,
        ["frFR"] = "Placez la Caisse d'Aimants Fantômes",
        ["esES"] = "Deja el Cajón de imanes fantasmales",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the Lovers' Hearts to summon an Incubus and slay it."] = { -- 65597
        ["ptBR"] = false,
        ["ruRU"] = "Используйте Сердца влюбленных, чтобы призвать Суккуба и убить его.",
        ["deDE"] = "Benutzt die Herzen der Liebenden um den Inkubus zu beschwören und zu erschlagen.",
        ["koKR"] = "연인의 심장을 사용하여 인큐버스를 소환한 후 죽이세요",
        ["esMX"] = "Utiliza los Corazones de amantes a invocar un íncubo y mátalo.",
        ["enUS"] = true,
        ["frFR"] = "Utlisez les Cœurs des Amants pour invoquer un Incubus et tuez-le.",
        ["esES"] = "Utiliza los Corazones de amantes a invocar un íncubo y mátalo.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Light the Unlit Torch near a fire and use the Burning Torch to set the Archaeologist's Cart on fire."] = { -- 65602
        ["ptBR"] = false,
        ["ruRU"] = "Зажгите Незажженный факел с помощью огня, затем используйте Зажженный Факел чтобы поджечь Телегу Археолога.",
        ["deDE"] = "Entzünde die Fackel an einem Feuer und nutze die brennende Fackel um die Lore des Archeologen Cart in brand zu stecken.",
        ["koKR"] = "불가 근처에서 불을 붙이지 않은 횃불에 불을 붙인 후, 불타는 횃불을 사용하여 고고학자의 수레에 불을 붙이세요",
        ["esMX"] = "Enciende la Antorcha apagada cerca del fuego y usa la Antorcha encendida para prender fuego al carretón del arqueólogo.",
        ["enUS"] = true,
        ["frFR"] = "Allumez la Torche Éteinte près d'un feu et utilisez la Torche Ardente pour mettre le feu à la Carte de l'Archéologue.",
        ["esES"] = "Enciende la Antorcha apagada cerca del fuego y usa la Antorcha encendida para prender fuego al carretón del arqueólogo.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the Withered Scarf to summon an Incubus and slay it."] = { -- 65603 & 65604
        ["ptBR"] = false,
        ["ruRU"] = "Используйте Истлевший платок, чтобы призвать Суккуба и убить его.",
        ["deDE"] = "Benutzt den abgetragener Schal um den Inkubus zu beschwören und erschlagt ihn.",
        ["koKR"] = "너덜너덜한 목도리를 사용하여 인큐버스를 소환 후 죽이세요",
        ["esMX"] = "Utiliza un Pañuelo deshilachado para invocar a un íncubo y mátalo.",
        ["enUS"] = true,
        ["frFR"] = "Utilisez l'Écharpe Flétrie pour invoquer un Incubus et combattez-le.",
        ["esES"] = "Utiliza un Pañuelo deshilachado para invocar a un íncubo y mátalo.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Slay ghouls to free Darrowshire spirits"] = { -- 5211
        ["ptBR"] = false,
        ["ruRU"] = "Убейте Вурдалаков, чтобы освободить Духов Дарроушира",
        ["deDE"] = "Erschlagt die Ghoule um die Geist von Darrowshire freizulassen.",
        ["koKR"] = "구울을 처치해 다로우샤이어 영혼에게 자유를 선사하세요",
        ["esMX"] = "Mata necrófagos para liberar a los Espíritus de Villa Darrow.",
        ["enUS"] = true,
        ["frFR"] = "Combattez les goules pour libérer les Esprits de Darrowshire.",
        ["esES"] = "Mata necrófagos para liberar a los Espíritus de Villa Darrow.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Exorcise the spirits"] = { -- 7640
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Vertreibe die Geister",
        ["koKR"] = "영혼을 퇴마하세요",
        ["esMX"] = "Utiliza el incensario de exorcismos para expulsar los espíritus",
        ["enUS"] = true,
        ["frFR"] = "Exorcisez les âmes",
        ["esES"] = "Utiliza el incensario de exorcismos para expulsar los espíritus",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Plant the Demon Summoning Torch"] = { -- 8481
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Platziere die Fackel zur Dämonenbeschwörung",
        ["koKR"] = "악마 소환의 횃불을 설치하세요",
        ["esMX"] = "Deja la Antorcha para invocar demonios",
        ["enUS"] = true,
        ["frFR"] = "Plantez la Torche d'Invocation de Démon",
        ["esES"] = "Deja la Antorcha para invocar demonios",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use Arcanite Buoy"] = { -- 8729
        ["ptBR"] = false,
        ["ruRU"] = "Используйте Арканитовый буй",
        ["deDE"] = "Benutze Arkanitboje",
        ["koKR"] = "아케이나이트 부표를 사용하세요",
        ["esMX"] = "Deja la Boya de arcanita",
        ["enUS"] = true,
        ["frFR"] = "Utilisez la Bouée en Arcanite",
        ["esES"] = "Deja la Boya de arcanita",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Talk to Silva Fil'naveth to fly back to Darnassus"] = { -- 5931
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Sprich mit Silva Fil'naveth, um zurück nach Darnassus zu fliegen.",
        ["koKR"] = "실비아 필나베스에게 말을 걸어 다르나서스로 이동하세요",
        ["esMX"] = "Habla con Silva Fil'naveth para volar de regreso a Darnassus.",
        ["enUS"] = true,
        ["frFR"] = "Parlez à Silva Fil'naveth pour revenir à Darnassus",
        ["esES"] = "Habla con Silva Fil'naveth para volar de regreso a Darnassus.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Talk to Bunthen Plainswind to fly back to Thunder Bluff"] = { -- 5932
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Sprich mit Bunthen Plainswind, um zurück nach Thunder Bluff zu fliegen.",
        ["koKR"] = "분덴 플레인즈윈드에게 말을 걸어 썬더블러프로 이동하세요",
        ["esMX"] = "Habla con Bunthen Ventollano para volar de regreso a Cima del Trueno.",
        ["enUS"] = true,
        ["frFR"] = "Parlez à Bunthen Plainswind pour revenir à Thunder Bluff",
        ["esES"] = "Habla con Bunthen Ventollano para volar de regreso a Cima del Trueno.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Release the kitten near the Jadefire Satyrs' corrupted moonwell."] = { -- quest 4506, text from item 12565
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Lass das Kätzchen in der Nähe des verderbten Mondbrunnens der Jadefeuersatyrn frei.",
        ["koKR"] = "비취불꽃의 사티로스의 오염된 달샘 근처의 고양이를 풀어주세요",
        ["esMX"] = "Libera al gatito cerca de la poza de la luna corrupta de los sátiros Fuego de Jade.",
        ["enUS"] = true,
        ["frFR"] = "Libérez le chaton au Puits de lune corrompu des satyres Jadefeu.",
        ["esES"] = "Libera al gatito cerca de la poza de la luna corrupta de los sátiros Fuego de Jade.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Summon a Templar using a full Twilight set."] = { -- 8332 8361
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Beschwöre einen Templer mit einem vollen Twilight-Set.",
        ["koKR"] = "황혼의 제복 세트를 모두 착용하여 기사단을 소환하세요",
        ["esMX"] = "Invoca a un Templario usando un conjunto Crepuscular.",
        ["enUS"] = true,
        ["frFR"] = "Invoquez un Templier en utilisant un ensemble complet de Sectateur du crépuscule.",
        ["esES"] = "Invoca a un Templario usando un conjunto Crepuscular.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Summon a Duke using a full Twilight set and neck."] = { -- 8341 8348
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Beschwöre einen Duke mit einem vollen Twilight-Set und einer Halskette.",
        ["koKR"] = "황혼의 제복 세트와 황혼의 신도 계급장을 착용하여 군주를 소환하세요",
        ["esMX"] = "Invoca a un Duque usando un conjunto Crepuscular y el Medallón.",
        ["enUS"] = true,
        ["frFR"] = "Invoquez un Duc en utilisant un ensemble complet et un équipement de cou de Sectateur du crépuscule.",
        ["esES"] = "Invoca a un Duque usando un conjunto Crepuscular y el Medallón.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Summon a Lord using a full Twilight set, neck and ring."] = { -- 8352 9248
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Beschwöre einen Lord mit einem vollen Twilight-Set, Halskette und Ring.",
        ["koKR"] = "황혼의 제복 세트, 황혼의 신도 계급장, 황혼의 신도 지휘관 반지를 착용하여 심연의 대의회 보스 몬스터를 소환하세요",
        ["esMX"] = "Invoca a un Señor usando un conjunto Crepuscular, Medallón y Anillo.",
        ["enUS"] = true,
        ["frFR"] = "Invoquez un Seigneur en utilisant un ensemble complet, un équipement de cou et une bague de Sectateur du crépuscule.",
        ["esES"] = "Invoca a un Señor usando un conjunto Crepuscular, Medallón y Anillo.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Ask to see the Captain."] = { -- 8507
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Frage nach dem Kapitän.",
        ["koKR"] = "선장을 뵙기를 요청하세요",
        ["esMX"] = "Pide ver al capitán.",
        ["enUS"] = true,
        ["frFR"] = "Demandez à voir le Capitaine.",
        ["esES"] = "Pide ver al capitán.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Draw the glyphs into the sand to summon the Qiraji Emissary."] = { -- 8315
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Zeichne die Glyphen in den Sand, um den Abgesandten der Qiraji zu rufen.",
        ["koKR"] = "부름의 상형문자를 사막에 가지고 간 후 퀴라지 밀사를 소환하세요",
        ["esMX"] = "Dibuja los glifos en la arena para invocar al emisario Qiraji.",
        ["enUS"] = true,
        ["frFR"] = "Dessinez les glyphes dans le sol pour invoquer un Émissaire des Qiraji.",
        ["esES"] = "Dibuja los glifos en la arena para invocar al emisario Qiraji.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Place the Relic Bundle in the Town Square."] = { -- 5721
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Lege das Reliquienbündel auf den Stadtplatz.",
        ["koKR"] = "마을 광장에 유물 더미를 놓으세요",
        ["esMX"] = "Coloca el Fardo de reliquias en la plaza de Villa Darrow.",
        ["enUS"] = true,
        ["frFR"] = "Placez l'Ensemble de Reliques sur la place centrale de Darrowshire.",
        ["esES"] = "Coloca el Fardo de reliquias en la plaza de Villa Darrow.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Search the false grave for the Taelan's Hammer."] = { -- 5781
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Durchsuche das falsche Grab nach dem Hammer des Taelan.",
        ["koKR"] = "지하 납골당 근처에서 탤런의 망치를 찾으세요",
        ["esMX"] = "Busca en el Túmulo de porquería el Martillo de Taelan.",
        ["enUS"] = true,
        ["frFR"] = "Cherchez le Marteau de Taelan dans la fausse tombe.",
        ["esES"] = "Busca en el Túmulo de porquería el Martillo de Taelan.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Plant the bomb!"] = { -- 6041
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Platziere die Bombe!",
        ["koKR"] = "폭탄을 설치하세요",
        ["esMX"] = "¡Planta la bomba!",
        ["enUS"] = true,
        ["frFR"] = "Posez la bombe !",
        ["esES"] = "¡Planta la bomba!",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use the Empty Worg Pup Cage to capture it."] = { -- 4729
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Benutze den leeren Worg-Welpen-Käfig, um ihn zu fangen.",
        ["koKR"] = "빈 검은늑대 우리 아이템을 사용하여 사로잡으세요",
        ["esMX"] = "Utiliza la Jaula de Mascolupo vacía para capturarlo.",
        ["enUS"] = true,
        ["frFR"] = "Utilisez la Cage de Jeune Worg Vide pour le capturer.",
        ["esES"] = "Utiliza la Jaula de Mascolupo vacía para capturarlo.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Combine Omokk's Head with the Roughshod Pike."] = { -- 4867
        ["ptBR"] = "Junte a Cabeça do Omokk com o Pique da Brutalidade.",
        ["ruRU"] = false,
        ["deDE"] = "Kombiniere Omokks Kopf mit der beschlagenen Pike.",
        ["koKR"] = "오모크의 머리 장식과 날카로운 장창을 조합하세요",
        ["esMX"] = "Combina la Cabeza de Omokk con la Pica despiadada.",
        ["enUS"] = true,
        ["frFR"] = "Combinez la Tête d'Omokk avec le Pique de Fortune.",
        ["esES"] = "Combina la Cabeza de Omokk con la Pica despiadada.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Use it to instantly kill one nearby ogre."] = { -- 4867
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Benutze es, um einen Oger in der Nähe sofort zu töten.",
        ["koKR"] = "근처 오우거를 즉시 사살하기 위해 사용하세요",
        ["esMX"] = "Úsalo para matar instantáneamente a un ogro cercano.",
        ["enUS"] = true,
        ["frFR"] = "Utilisez-le pour instantanément tuer un ogre proche.",
        ["esES"] = "Úsalo para matar instantáneamente a un ogro cercano.",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Place a tribute at Uther's Tomb"] = { -- 8149
        ["ptBR"] = "Coloca uma homenagem na tumba de Uther",
        ["ruRU"] = false,
        ["deDE"] = "Bringt einen Tribut an Uthers Grabmal an",
        ["koKR"] = "우서 경의 무덤에 공물을 두세요",
        ["esMX"] = "Ofrece un tributo en la tumba de Uther",
        ["enUS"] = true,
        ["frFR"] = "Placez un hommage sur le tombe d'Uther",
        ["esES"] = "Ofrece un tributo en la tumba de Uther",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Place a tribute at Grom's Monument"] = { -- 8150
        ["ptBR"] = "Oferece um tributo no monumento de Grom",
        ["ruRU"] = false,
        ["deDE"] = "Platziere ein Tribut am Grom-Denkmal",
        ["koKR"] = "그롬 헬스크림의 기념비에 공물을 두세요",
        ["esMX"] = "Ofrece un tributo en el monumento de Grom",
        ["enUS"] = true,
        ["frFR"] = "Placez un hommage sur le monument de Grom",
        ["esES"] = "Ofrece un tributo en el monumento de Grom",
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
    ["Combine the Pendant halves at the Shrine of Remulos."] = { -- 8150
        ["ptBR"] = false,
        ["ruRU"] = false,
        ["deDE"] = "Kombiniere die Anhängerhälften am Schrein von Remulos.",
        ["koKR"] = false,
        ["esMX"] = false,
        ["enUS"] = true,
        ["frFR"] = false,
        ["esES"] = false,
        ["zhTW"] = false,
        ["zhCN"] = false,
    },
}

for k, v in pairs(classicObjectiveLocales) do
    l10n.translations[k] = v
end
