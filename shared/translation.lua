Translation = {}

Translation.Langs = {
    Italian = {
        MainMenu = {
            NewChar = "Crea un nuovo personaggio",
            NewCharDesc = "Cambia personaggio premendo Invio",
            Name = "Nome: ",
            Money = "Soldi: $",
            NameDesc = "Seleziona il personaggio premendo Invio",
            CreateNewCharT = "Crea un nuovo personaggio",
            CreateNewCharDesc = "Cambia personaggio premendo Invio",
            Choose = "Conferma",
            ChooseDesc = "Seleziona questo personaggio per iniziare",
            Delete = "Elimina",
            DeleteDesc = "Elimina questo personaggio",
            ReturnMenu = "Torna indietro",
            ReturnMenuDesc = "Torna alla selezione del personaggio",
        },
        PromptLabels = {
            promptselect = "| Personaggio selezionato:  ~o~",
            promptselect2 = "~q~ | Soldi: ~o~",
            promptlabel_select = " seleziona il genere",
            promptlabel_female = "Personaggio femminile",
            promptlabel_male = "Personaggio maschile",
            promptcreateNew = "Crea nuovo",
            promptdeleteCurrent = "Elimina corrente",
            promptswapChar = "Scambia personaggio",
            promptselectChar = "Seleziona personaggio",
            promptsexMale = "Maschio",
            promptsexFemale = "Femmina",
            promptselectConfirm = "~q~Seleziona",
            promptUpDownCam = "su/giù",
            promptrotateCam = "ruota",
            promptzoomCam = "zoom",
            CamAdjustments = "Impostazioni della fotocamera",
        },
        Inputs = {
            confirm = "Conferma",
            placeholder = "Nome e Cognome",
            inputHeader = "Come si chiamerà il tuo personaggio?",
            title = "Solo lettere, minimo 5 massimo 20",
            banned = "Non puoi utilizzare quei nomi, sono considerati vietati in questo server",
            notify = "Premi Canc per eliminare questo personaggio, o premi Backspace per annullare",
            missingname = "Hai fornito un nome o cognome incorretto"
        },
        MenuCreation = {
            title = "Menu personaggio",
            subtitle = "Creazione personaggio",
            label = "Nome scelto",
            element0 = { label = "Cambia Fazione", desc = "Cambia fazione, questo potrebbe resettare alcune delle caratteristiche di aspetto del personaggio, usare solo se necessario." },
            element = { label = "Aspetto", desc = "Scegli l'aspetto del tuo personaggio" },
            element2 = { label = "Abbigliamento", desc = "Scegli l'abbigliamento del personaggio" },
            element3 = {
                label = "Scegli un Nome",
                desc =
                "Scegli un nome per il tuo personaggio assicurati di leggere le regole per la scelta del nome del personaggio,<br> se non segui le regole questo personaggio verrà eliminato senza preavviso"
            },
            element4 = { label = "Inizia l'Avventura", desc = "Inizia la tua avventura premendo Invio" },
        },
        MenuFaction = {
            title = "Fazione",
            subtitle = "Scegli la fazione del tuo personaggio",
        },
        MenuFactionConfirm = {
            title = "Conferma",
            subtitle = "Conferma la scelta della fazione",
            yes = { label = "Conferma", desc = "Conferma la tua scelta, scegliere una fazione impone limitazioni all'aspetto, e conseguenze in gioco, leggere il regolamento per informazioni sulle fazioni." },
            no = { label = "Annulla", desc = "Torna alla selezione della fazione del personaggio" },
        },
        MenuFactionChangeConfirm = {
            title = "Conferma",
            subtitle = "Conferma il cambio della fazione",
            yes = { label = "Conferma", desc = "Vuoi davvero tornare alla selezione della fazione?<br><b>NOTA: Potresti perdere alcune delle peronalizzazioni fatte al tuo personaggio!</b>" },
            no = { label = "Annulla", desc = "Torna alla personalizzazione personaggio" },
        },
        MenuClothes = {
            title       = "Abbigliamento",
            subtitle    = "Sottomenu",
            CoatClosed  = "Cappotti Chiusi",
            Coat        = "Cappotti",
            Hat         = "Cappelli",
            EyeWear     = "Occhiali",
            Mask        = "Maschere",
            NeckWear    = "Accessori per il Collo",
            NeckTies    = "Cravatte",
            Shirt       = "Camicie",
            Suspender   = "Bretelle",
            Vest        = "Gilet",
            Poncho      = "Poncho",
            Cloak       = "Mantelli",
            Glove       = "Guanti",
            Belt        = "Cinture",
            Pant        = "Pantaloni",
            Boots       = "Stivali",
            Spurs       = "Accessori per Stivali",
            Bracelet    = "Braccialetti",
            Buckle      = "Fibbie per Cinture",
            Skirt       = "Gonne",
            Chap        = "Chaps",
            Spats       = "Gambali",
            GunbeltAccs = "Accessori per Fondine",
            Gauntlets   = "Guanti Lunghi",
            Loadouts    = "Equipaggiamenti",
            Accessories = "Accessori",
            Satchels    = "Borse",
            Dress       = "Vestiti",
            Holster     = "Fondina Sinistra",
            Gunbelt     = "Fondine",
            RingRh      = "Anelli Destra",
            RingLh      = "Anelli Sinistra",
        },
        MenuComponents = {
            title = "Componenti",
            subtitle = "Sottomenu",
            element = { label = "Componente ", desc = "ce ne sono " },
            element2 = { label = " Colore  #", desc = "Scegli il colore del componente" },
        },
        MenuAppearance = {
            title = "Aspetto",
            subtitle = "Sottomenu",
            element = { label = "Corpo", desc = "Scegli il tipo di corpo del tuo personaggio" },
            element2 = { label = "Eredità", desc = "Scegli l'eredità del tuo personaggio" },
            element3 = { label = "Capelli", desc = "Scegli il tipo di capelli del tuo personaggio" },
            element4 = { label = "Invecchiamento", desc = "Età del personaggio" },
            element5 = { label = "Altezza", desc = "Scegli l'altezza del tuo personaggio" },
            element6 = { label = "Viso", desc = "Scegli le caratteristiche del viso" },
            element7 = { label = "Stile di vita", desc = "Scegli lo stile di vita del tuo personaggio" },
            element8 = { label = "Trucco", desc = "Scegli il trucco" },
            short = "Basso",
            normal = "Normale",
            tall = "Alto",
            extraTall = "Altissimo",
        },

        MenuAge = {
            title = "Età",
            subtitle = "Sotto-menu",
            element = { label = "Età", desc = "Scegli l'età del tuo personaggio" },
            element2 = { label = "Opacità", desc = "Ci sono " .. "Scegli l'opacità dell'età del tuo personaggio" },
            label3 = "Non visibile",
            label4 = "Visibile",
        },
        MenuBody = {
            title = "Corpo",
            subtitle = "Sotto-menu",
            element = { label = "Tipo di corpo", desc = "Ci sono " },
            element2 = { label = "Vita", desc = "Ci sono #", desc2 = "tipi di vita" },
            element3 = { label = "Torso", desc = "Ci sono " },
            element4 = { label = "Gambe", desc = "Ci sono " },
        },
        MenuHeritage = {
            title = "Eredità",
            subtitle = "Sotto-menu",
            element = { label = "Colore della pelle", desc = "Ci sono ", desc2 = "tipi di colore della pelle" },
            element2 = { label = "Tipi", desc = "Scegli il tipo di viso del tuo personaggio" },
            element3 = { label = "Eredità #", desc = "Ci sono #", desc2 = "tipi di eredità" },
        },
        MenuHair = {
            title = "Capelli",
            subtitle = "Sotto-menu",
            element = { label = "Capelli", desc = "Scegli i capelli del personaggio" },
            element2 = { label = "Barba", desc = "Scegli la barba del personaggio" },
            element3 = { label = "Stubble della barba", desc = "Scegli lo stubble della barba del personaggio" },
            element4 = { label = "Accessori per capelli", desc = "Scegli gli accessori per capelli del personaggio" },
            element5 = { label = "Sopracciglia", desc = "Scegli le sopracciglia del personaggio" },
            element6 = { label = "Sovrapposizione", desc = "Scegli la sovrapposizione dei capelli del personaggio" },
        },
        MenuHairSelection = {
            title = "Capelli",
            subtitle = "Sotto-menu",
            element = { label = "Componente", desc = "Ci sono ", desc2 = "tipi di componenti " },
            element2 = { label = "Colore", desc = "Ci sono ", desc2 = "tipi di colori " },
        },
        MenuBeardEyeBrows = {
            title = "Aspetto",
            subtitle = "Sotto-menu",
            element = { label = "", desc = "scegli un tipo" },
            element2 = { label = "Colore", desc = "Scegli il colore" },
            element3 = { label = "Opacità", desc = "Scegli l'opacità" },
        },
        MenuFacial = {
            title = "Caratteristiche del viso",
            subtitle = "Sotto-menu",
            element = { label = "Colore degli occhi", desc = "colore degli occhi" },
            element2 = { label = "Denti", desc = "tipo di denti" },
            element3 = { label = "Mandibola", desc = "regola la mandibola" },
            element4 = { label = "Mento", desc = "regola il mento" },
            element5 = { label = "Dimensione della testa", desc = "regola la dimensione della testa" },
            element6 = { label = "Naso", desc = "regola il naso" },
            element7 = { label = "Orecchie", desc = "regola la dimensione delle orecchie" },
            element8 = { label = "Bocca e labbra", desc = "regola la bocca e le labbra" },
            element9 = { label = "Zigomi", desc = "regola l'opacità della barba" },
            element10 = { label = "Occhi e sopracciglia", desc = "regola gli zigomi" },
        },
        MenuFaceModify = {
            title = "Caratteristiche del viso",
            subtitle = "Sotto-menu",
            element = { label = "", desc = "selezione corrente: " },
        },
        MenuLifeStyle = {
            title = "Stile di vita",
            subtitle = "Sotto-menu",
            opacityLabel = "Opacità",
            desc = "Scegli l'opacità",
            element = { label = "Nei", desc = "Scegli lo stile di vita del tuo personaggio" },
            element2 = { label = "Macchie", desc = "Scegli l'opacità dello stile di vita del tuo personaggio" },
            element3 = { label = "Canagione", desc = "Scegli l'opacità dello stile di vita del tuo personaggio" },
            element4 = { label = "Acne", desc = "Scegli l'opacità dello stile di vita del tuo personaggio" },
            element5 = { label = "Lentiggini", desc = "Scegli l'opacità dello stile di vita del tuo personaggio" },
            element6 = { label = "Decolorazione", desc = "Scegli l'opacità dello stile di vita del tuo personaggio" },
            element7 = { label = "Sfregio", desc = "Scegli l'opacità dello stile di vita del tuo personaggio" },
            element8 = { label = "Sporco", desc = "Scegli l'opacità dello stile di vita del tuo personaggio" },
        },
        MenuMakeup = {
            title = "Trucco",
            subtitle = "Sotto-menu",
            element = { label = "Rossetto", desc = "Scegli il trucco del tuo personaggio" },
            element2 = { label = "Blush", desc = "Scegli il trucco del tuo personaggio" },
            element3 = { label = "Eyeliner", desc = "Scegli il trucco del tuo personaggio" },
            element4 = { label = "Ombretto", desc = "Scegli il trucco del tuo personaggio" },
            element5 = { label = "Texture", desc = "Scegli il trucco del tuo personaggio" },
            element6 = { label = "Colore", desc = "Scegli il trucco del tuo personaggio" },
            element7 = { label = "Colore secondario", desc = "Scegli il trucco del tuo personaggio" },
            element8 = { label = "Variante", desc = "Scegli la variante del trucco" },
            element9 = { label = "Opacità", desc = "Scegli il trucco del tuo personaggio" },
        },
    },
}
