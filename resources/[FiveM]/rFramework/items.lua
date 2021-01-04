
-- All items with there weight and event
items = {
    {name="Bread", label="Pain", weight=0.7, event="rF:Eat_bread"},
    {name="Apple", label="Pomme", weight=0.5, event="rF:Eat_apple"},
    {name="CB", label="Carte bancaire", weight=0.1, event="core:UseCreditCard"}, -- Not used in the framework but in my core
    {name="metal", label="Pièce métalique cassé", weight=1.5, event=""},
    {name="metal2", label="Morceau de carrosserie", weight=1.5, event=""},
    {name="medicament1", label="Medicament sous scellé", weight=10.0, event=""},
    {name="medikit", label="Kit de soin", weight=10.0, event="core:UseMedikit"},
    {name="permisChasse", label="Permis de chasse", weight=1.0, event="core:ShowPermisChasse"},
    {name="permisConduire", label="Permis de conduire", weight=1.0, event=""},

    {name="chips", label="Chips", weight=6.0, event="core:EatChips"},
    {name="coca", label="Canette de coca", weight=6.0, event="core:DringCoka"},
    {name="eau", label="Bouteille d'eau", weight=5.0, event="core:DringWater"},

    {name="phone", label="Téléphone portable", weight=2.0, event=""},

    {name="viande1", label="Viande de basse qualité", weight=1.0, event=""},
    {name="viande2", label="Viande de qualité normal", weight=2.5, event=""},
    {name="viande3", label="Viande de bonne qualité", weight=3.5, event=""},
    {name="viande4", label="Viande de qualité incroyable", weight=5.0, event=""},

    {name="weedseed", label="Graine de chanvre", weight=0.5, event="core:PlantWeed"},
    {name="weed", label="Canabis non traitée", weight=1.0, event=""},
    {name="weed2", label="Canabis de bonne qualité", weight=2.0, event="core:UseWeed"}, 
    {name="weedak47", label="Canabis type AK47", weight=2.0, event="core:UseWeedAk47"}, 
    {name="whitewidow", label="Canabis type WhiteWidow", weight=2.0, event="core:UseWeedWhiteWidow"}, 
    {name="ogkush", label="Canabis type Og Kush", weight=2.0, event="core:UseWeedOgKush"}, 

    {name="pain", label="Pain de cuisine", weight=4.0, event=""},
    {name="patte", label="Patte de cuisine", weight=4.0, event=""},
    {name="viande", label="Viande de cuisine", weight=4.0, event=""},


    -- Drusillas
    {name="pizza", label="Pizza simple", weight=10.0, event="core:EatPizza"},
    {name="pizzafromage", label="Pizza 3 fromages", weight=10.0, event="core:EatPizzaFromage"},
    {name="patepizza", label="Pâte à pizza", weight=1.0, event=""},
    {name="coulisTomate", label="Coulis de tomate", weight=1.0, event=""},
    {name="fromage", label="Fromage", weight=1.0, event=""},
    {name="patteBolo", label="Pasta Bolognese", weight=1.0, event="core:EatPatte"},
    {name="cafe", label="Nespresso", weight=1.0, event="core:EatCafe"},
    {name="vin", label="Vin", weight=1.0, event="core:EatVin"},
    {name="tiramisu", label="Tiramisù", weight=1.0, event="core:EatTiramisu"},
    {name="pannacotta", label="Panna Cotta", weight=1.0, event="core:EatPannacotta"},

    -- Crucial
    {name="sandwich", label="Sandwich simple", weight=10.0, event="core:EatSandwichSimple"},
    {name="sandwich2", label="Sandwich poulet: César (halal)", weight=10.0, event="core:EatSandwichPoulet"},
    {name="sandwich3", label="Sandwich Thon (Le pécheur)", weight=10.0, event="core:EatSandwichThon"},
    {name="sandwich4", label="Sandwich vegan (Veggie)", weight=10.0, event="core:EatSandwichVegan"},
    {name="sandwich5", label="Sandwich saucisson: (Le frenchie)", weight=10.0, event="core:EatSandwichSaucisson"},
    {name="jambon", label="Tranche de jambon", weight=1.0, event=""},
    {name="tomate", label="Tomate", weight=1.0, event=""},
    {name="thon", label="Thon", weight=1.0, event=""},
    {name="parmesan", label="Parmasan", weight=1.0, event=""},
    {name="poulet", label="Poulet", weight=1.0, event=""},
    {name="pain2", label="Pain à sandwich", weight=1.0, event=""},
    {name="quinoa", label="Quinoa", weight=1.0, event=""},
    {name="salade", label="Salade", weight=1.0, event=""},
    {name="avocat", label="Avocat", weight=1.0, event=""},
    {name="saucisson", label="Saucisson", weight=1.0, event=""}, 

    -- Hotdog
    {name="hotdog", label="Hotdog simple", weight=6.0, event="core:EatHotDog"},
    {name="tacos", label="Tacos", weight=10.0, event="core:EatTacos"},
    {name="kebab", label="Kebab", weight=10.0, event="core:EatKebab"},
    {name="sauce", label="Sauce", weight=1.0, event=""},
    {name="tortilla", label="Tortilla", weight=1.0, event=""},
    {name="saucisse", label="Saucisse", weight=1.0, event=""}, 

    {name="bouteille", label="Bouteille vide", weight=1.0, event=""},

    -- Weapons
    {name="matraque", label="Matraque force de l'ordre", weight=1.0, event="core:GetMattraque"},
    {name="pistolet", label="Pistolet", weight=1.0, event="core:GetPistol"},
    {name="tazer", label="Tazer", weight=10.0, event="core:GetTazer"},
    {name="pistoletmk2", label="Pistolet nouvelle génération", weight=10.0, event="core:GetPistolmk2"},
    {name="pistoletlspd", label="Arme de poing force de l'ordre", weight=5.0, event="core:GetPistollspd"}, 
    {name="m4", label="Fusils d'assault force de l'ordre", weight=10.0, event="core:GetM4"},
    {name="musket", label="Fusils de chasse", weight=25.0, event="core:GetMusket"}, -- chasse
    {name="huntrifle", label="Fusils de précision de chasseur", weight=30.0, event="core:GetHuntSniper"}, -- chasse

    {name="batte", label="Batte De Baseball", weight=10.0, event="core:GetBat"}, -- Armurie
    {name="knife", label="Couteau de poche", weight=5.0, event="core:GetKnife"}, -- Armurie
    {name="knifeVip", label="Couteau de poche à cran", weight=5.0, event="core:GetKnifeVip"}, -- Armurie
    {name="golf", label="Club de golf", weight=13.0, event="core:weapon_golfclub"}, -- Armurie
    {name="machette", label="Machette", weight=8.0, event="core:weapon_machete"}, -- Armurie
    {name="hache", label="Hache", weight=9.0, event="core:weapon_battleaxe"}, -- Armurie


    {name="coke", label="Coke non traité", weight=1.0, event=""},
    {name="coke2", label="Coke traité", weight=1.0, event=""},
} 




Citizen.CreateThread(function()
    for k,v in pairs(items) do
        items[k].id = math.random(1000001,99999999)
    end
end) 

function CheckItemId(item, id, source)
    if id == nil then id = "" end
    for k,v in pairs(items) do
        if v.name == item then
            if v.id == id then
                return true
            else
                AddPlayerLog(source, "Mauvais item id\nId envoyé: "..id.."\nId de l'item: "..v.id.."\nItem: "..item, 3)
                DropPlayer(source, "Desync serveur, merci de te reco.")
                return false
            end
        end
    end
end

function GetItems()
    return items
end 