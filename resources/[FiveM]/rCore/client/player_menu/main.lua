local open = false

function SetInventoryOpen()
    open = false
end

rUtils = {}

RMenu.Add('core', 'main', RageUI.CreateMenu("Menu personnel", "~b~Menu personnel de votre personnage"))
RMenu:Get('core', 'main').Closed = function()
    open = false
end
RMenu.Add('core', 'inventory', RageUI.CreateSubMenu(RMenu:Get('core', 'main'), "Inventaire", "~b~Inventaire de votre personnage"))
RMenu:Get('core', 'inventory').Closed = function()end

RMenu.Add('core', 'inventory_use', RageUI.CreateSubMenu(RMenu:Get('core', 'inventory'), "Inventaire", "~b~Inventaire de votre personnage"))
RMenu:Get('core', 'inventory_use').Closed = function()
    open = false
end

RMenu.Add('core', 'vip_main', RageUI.CreateSubMenu(RMenu:Get('core', 'main'), "VIP", "~b~Option VIP"))
RMenu:Get('core', 'vip_main').Closed = function()end

RMenu.Add('core', 'vip_weapon_tint', RageUI.CreateSubMenu(RMenu:Get('core', 'vip_main'), "VIP TINT", "~b~Couleur d'arme de VIP"))
RMenu:Get('core', 'vip_weapon_tint').Closed = function()end

RMenu.Add('core', 'vip_weapon_aim', RageUI.CreateSubMenu(RMenu:Get('core', 'vip_main'), "Aim", "~b~Changer son type d'aim"))
RMenu:Get('core', 'vip_weapon_aim').Closed = function()end

RMenu.Add('core', 'vip_peds', RageUI.CreateSubMenu(RMenu:Get('core', 'vip_main'), "Ped", "~b~Changer son type de ped"))
RMenu:Get('core', 'vip_peds').Closed = function()end

RMenu.Add('core', 'vip_peds_animals', RageUI.CreateSubMenu(RMenu:Get('core', 'vip_peds'), "Animals", "~b~Changer son animals"))
RMenu:Get('core', 'vip_peds_animals').Closed = function()end

RMenu.Add('core', 'vip_peds_peds', RageUI.CreateSubMenu(RMenu:Get('core', 'vip_peds'), "Peds", "~b~Changer son peds"))
RMenu:Get('core', 'vip_peds_peds').Closed = function()end

RMenu.Add('core', 'portefeuille', RageUI.CreateSubMenu(RMenu:Get('core', 'main'), "portefeuille", "~b~Inventaire de votre personnage"))
RMenu:Get('core', 'portefeuille').Closed = function()end
RMenu.Add('core', 'portefeuille_usage', RageUI.CreateSubMenu(RMenu:Get('core', 'main'), "Inventaire", "~b~Inventaire de votre personnage"))
RMenu:Get('core', 'portefeuille_usage').Closed = function()end

RMenu.Add('core', 'accessoire', RageUI.CreateSubMenu(RMenu:Get('core', 'main'), "accessoire", "~b~Inventaire de votre personnage"))
RMenu:Get('core', 'accessoire').Closed = function()end

RMenu.Add('core', 'divers', RageUI.CreateSubMenu(RMenu:Get('core', 'main'), "divers", "~b~Inventaire de votre personnage"))
RMenu:Get('core', 'divers').Closed = function()end
RMenu.Add('core', 'divers_editor', RageUI.CreateSubMenu(RMenu:Get('core', 'divers'), "Inventaire", "~b~Inventaire de votre personnage"))
RMenu:Get('core', 'divers_editor').Closed = function()end

RMenu.Add('core', 'divers_color', RageUI.CreateSubMenu(RMenu:Get('core', 'divers'), "Couleur", "~b~Couleur du menu"))
RMenu:Get('core', 'divers_color').Closed = function()end

RMenu.Add('core', 'divers_radio', RageUI.CreateSubMenu(RMenu:Get('core', 'divers'), "Couleur", "~b~Couleur du menu"))
RMenu:Get('core', 'divers_radio').Closed = function()end

RMenu.Add('core', 'admin', RageUI.CreateSubMenu(RMenu:Get('core', 'main'), "Admin Menu", nil))
RMenu:Get('core', 'admin').Closed = function()end

RMenu.Add('core', 'admin_remb', RageUI.CreateSubMenu(RMenu:Get('core', 'admin'), "Admin Menu", nil))
RMenu:Get('core', 'admin_remb').Closed = function()end

RMenu.Add('core', 'admin_item', RageUI.CreateSubMenu(RMenu:Get('core', 'admin_remb'), "Admin Menu", nil))
RMenu:Get('core', 'admin_item').Closed = function()end

RMenu.Add('core', 'admin_veh', RageUI.CreateSubMenu(RMenu:Get('core', 'admin'), "Admin Menu", nil))
RMenu:Get('core', 'admin_veh').Closed = function()end

RMenu.Add('core', 'admin_joueur', RageUI.CreateSubMenu(RMenu:Get('core', 'admin'), "Admin Menu", nil))
RMenu:Get('core', 'admin_joueur').Closed = function()end

RMenu.Add('core', 'admin_divers', RageUI.CreateSubMenu(RMenu:Get('core', 'admin'), "Admin Menu", nil))
RMenu:Get('core', 'admin_divers').Closed = function()end

RMenu.Add('core', 'admin_pList', RageUI.CreateSubMenu(RMenu:Get('core', 'admin'), "Admin Menu", nil))
RMenu:Get('core', 'admin_pList').Closed = function()end

RMenu.Add('core', 'admin_jAction', RageUI.CreateSubMenu(RMenu:Get('core', 'admin_pList'), "Admin Menu", nil))
RMenu:Get('core', 'admin_jAction').Closed = function()end

RMenu.Add('core', 'admin_JobList', RageUI.CreateSubMenu(RMenu:Get('core', 'admin_jAction'), "Admin Menu", nil))
RMenu:Get('core', 'admin_JobList').Closed = function()end

RMenu.Add('core', 'admin_GroupList', RageUI.CreateSubMenu(RMenu:Get('core', 'admin_jAction'), "Admin Menu", nil))
RMenu:Get('core', 'admin_GroupList').Closed = function()end

RMenu.Add('core', 'admin_ban', RageUI.CreateSubMenu(RMenu:Get('core', 'admin_joueur'), "Admin Menu", nil))
RMenu:Get('core', 'admin_ban').Closed = function()end

local selected = {
    event = nil,
    name = nil,
    label = nil,
    count = nil,
    newLabel = nil,
}
local moneySelected = {
    type = nil,
    count = nil,
}
local accessoire = {
    casque = true,
    lunette = true,
    mask = true,
}
local menuColor = {66, 173, 245}

local radio = {
    [1] = {job = "police", label = "Dispatch"},
    [2] = {job = "police", label = "Secteur 1"},
    [3] = {job = "police", label = "Secteur 2"},
    [4] = {job = "police", label = "Secteur 3"},
    [5] = {job = "police", label = "Secteur 4"},
    [6] = {job = "police", label = "Secteur 1/2"},
    [7] = {job = "police", label = "Secteur 3/4"},
    [8] = {job = "police", label = "TAC 1"},
    [9] = {job = "police", label = "TAC 2"},
    [10] = {job = "police", label = "TAC 3"},
    [11] = {job = "police", label = "TAC 4"},
    [12] = {job = "police", label = "TAC 5"},
    [13] = {job = "medecin", label = "Exemple EMS"},
    [14] = {job = "medecin", label = "Exemple EMS"},
    [15] = {job = "medecin", label = "Exemple EMS"},
    [16] = {job = "sheriff", label = "Sheriff #1"},
    [17] = {job = "sheriff", label = "Sheriff #3"},
    [18] = {job = "sheriff", label = "Sheriff #4"},
    [19] = {job = "sheriff", label = "Sheriff #5"},
    [20] = {job = "sheriff", label = "Sheriff #6"},
}

Citizen.CreateThread(function()
    Wait(1000)
    menuColor[1] = GetResourceKvpInt("menuR")
    menuColor[2] = GetResourceKvpInt("menuG")
    menuColor[3] = GetResourceKvpInt("menuB")
    ReloadColor()
end)



local players = {}
RegisterNetEvent("core:pList")
AddEventHandler("core:pList", function(list)
    players = list
    print("Players list loaded")
end)


local peds = {
    normal = {
        {label = "GangSter", model = "g_m_y_armgoon_02", vip = true},
        {label = "GangSter2", model = "a_m_m_soucent_01", vip = true},
        {label = "GangSter3", model = "g_m_y_strpunk_02", vip = true},
        {label = "GangSter4", model = "g_m_y_strpunk_01", vip = true},
        {label = "Tatoo", model = "u_m_y_tattoo_01", vip = true},
        {label = "Pretre", model = "ig_priest", vip = true},
        {label = "Jesus", model = "u_m_m_jesus_01", vip = true},
        {label = "Dealer", model = "s_m_y_dealer_01", vip = true},
        {label = "David", model = "g_m_m_armgoon_01", vip = true},
        {label = "Gros Tony", model = "g_m_m_armboss_01", vip = true},
        {label = "Coka", model = "a_m_o_acult_02", vip = true},
        {label = "Cletus", model = "ig_cletus", vip = true},
        {label = "Boucher", model = "s_m_m_migrant_01", vip = true},
        {label = "Biggy", model = "a_m_m_afriamer_01", vip = true},
        {label = "Clochard1", model = "a_m_o_soucent_02", vip = true},
        {label = "Clochard2", model = "a_m_o_soucent_03", vip = true},
        {label = "Clochard3", model = "a_m_m_trampbeac_01", vip = true},
        {label = "Clochard4", model = "a_m_o_tramp_01", vip = true},
    
        {label = "Mecano1", model = "s_m_m_autoshop_01", vip = true},
        {label = "Mecano2", model = "s_m_m_autoshop_02", vip = true},
        {label = "Mecano3", model = "s_m_y_xmech_02", vip = true},
        {label = "Bloods", model = "ig_claypain", vip = true},
        {label = "Ballas1", model = "g_m_y_ballaeast_01", vip = true},
        {label = "Ballas2", model = "g_m_y_ballaorig_01", vip = true},
        {label = "Ballas3", model = "g_f_y_ballas_01", vip = true},
        {label = "OG Ballas", model = "ig_ballasog", vip = true},
        {label = "Famillies", model = "g_m_y_famca_01", vip = true},
        {label = "Famillies2", model = "g_m_y_famdnf_01", vip = true},
        {label = "Famillies3", model = "g_m_y_famfor_01", vip = true},
        {label = "Famillies4", model = "g_f_y_families_01", vip = true},
        {label = "Famillies5", model = "g_f_y_families_01", vip = true},
        {label = "Famillies6", model = "csb_g", vip = true},
        {label = "OG Famillies", model = "ig_lamardavis", vip = true},
        {label = "OG Gang", model = "a_m_m_og_boss_01", vip = true},
    
        {label = "Fermier1", model = "ig_old_man1a", vip = true},
        {label = "Fermier2", model = "ig_old_man2", vip = true},
        {label = "Fermier3", model = "ig_omega", vip = true},
        {label = "Fermier4", model = "ig_oneil", vip = true},
    
        {label = "Aztecas1", model = "ig_ortega", vip = true},
        {label = "Aztecas2", model = "csb_oscar", vip = true},
        {label = "Madrazo", model = "g_m_y_pologoon_01", vip = true},
        {label = "Madrazo2", model = "u_m_m_partytarget", vip = true},
    
        {label = "Marabunta Boss", model = "g_m_y_salvaboss_01", vip = true},
        {label = "Marabunta1", model = "g_m_y_salvagoon_01", vip = true},
        {label = "Marabunta2", model = "g_m_y_salvagoon_02", vip = true},
        {label = "Marabunta3", model = "g_m_y_salvagoon_03", vip = true},
        {label = "Marabunta Boss", model = "g_m_y_salvaboss_01", vip = true},
    
        {label = "Crips", model = "a_m_m_soucent_03", vip = true},
    
        {label = "Lost1", model = "g_f_y_lost_01", vip = true},
        {label = "Lost2", model = "g_m_y_lost_01", vip = true},
        {label = "Lost3", model = "g_m_y_lost_02", vip = true},
        {label = "Lost4", model = "g_m_y_lost_03", vip = true},
    
        {label = "Hao", model = "ig_hao", vip = true},
        {label = "Korean1", model = "g_m_m_korboss_01", vip = true},
        {label = "Korean2", model = "g_m_y_korean_01", vip = true},
        {label = "Korean3", model = "g_m_y_korean_02", vip = true},
        {label = "Korean4", model = "g_m_y_korlieut_01", vip = true},
        {label = "Korean5", model = "a_m_o_ktown_01", vip = true},
        {label = "Korean6", model = "a_m_y_ktown_01", vip = true},
        {label = "Korean7", model = "ig_chengsr", vip = true},
    
        {label = "Vagos1", model = "a_m_y_hiker_01", vip = true},
        {label = "Vagos Boss", model = "g_m_m_mexboss_01", vip = true},
        {label = "Vagos2", model = "g_m_m_mexboss_02", vip = true},
        {label = "Vagos3", model = "g_m_y_mexgang_01", vip = true},
        {label = "Vagos4", model = "g_m_y_mexgoon_01", vip = true},
        {label = "Vagos5", model = "g_m_y_mexgoon_02", vip = true},
        {label = "Vagos6", model = "g_m_y_mexgoon_03", vip = true},
        {label = "Vagos7", model = "a_m_y_mexthug_01", vip = true},
        {label = "Vagos8", model = "mp_m_g_vagfun_01", vip = true},
        {label = "Vagos9", model = "ig_vagspeak", vip = true},
    },

    animals =  {
        {label = "Chien1", model = "a_c_poodle", vip = true},
        {label = "Chien2", model = "a_c_husky", vip = true},
        {label = "Poule", model = "a_c_hen", vip = true},
        {label = "Chien3", model = "a_c_chop", vip = true},
        {label = "Chat", model = "a_c_cat_01", vip = true},
        {label = "Coyotte", model = "a_c_coyote", vip = true},
        {label = "Chien4", model = "a_c_retriever", vip = true},
        {label = "Chien5", model = "a_c_shepherd", vip = true},
        {label = "Chien6", model = "a_c_westy", vip = true},
    },
    
}

local SelectedPlayer = {}
local InStaff = false
local zoneOnly = false
local VeloDePoche = nil
function OpenPlayerMenu()
    if open then return end
    open = true
    Citizen.CreateThread(function()
        while open do
            Wait(1)
            RageUI.IsVisible(RMenu:Get('core', 'main'), true, true, true, function()
                RageUI.ButtonWithStyle("Inventaire", nil, { RightLabel = "→→" }, true, function()
                end, RMenu:Get('core', 'inventory'))
                RageUI.ButtonWithStyle("Portefeuille", nil, { RightLabel = "→→" }, true, function()
                end, RMenu:Get('core', 'portefeuille'))
                RageUI.ButtonWithStyle("Gestion accessoire", nil, { RightLabel = "→→" }, true, function()
                end, RMenu:Get('core', 'accessoire'))
                RageUI.ButtonWithStyle("Divers", nil, { RightLabel = "→→" }, true, function()
                end, RMenu:Get('core', 'divers'))
                RageUI.ButtonWithStyle("VIP menu", nil, { RightLabel = "→→" }, pVip ~= 0, function()
                end, RMenu:Get('core', 'vip_main'))
                RageUI.ButtonWithStyle("Staff menu", nil, { RightLabel = "→→" }, pGroup ~= "user", function()
                end, RMenu:Get('core', 'admin'))

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'inventory'), true, true, true, function()
                RageUI.Separator("Poid: ~b~"..pWeight.."/50.0")
                for k,v in pairs(pInventory) do
                    if v.olabel == v.label then
                        RageUI.ButtonWithStyle(v.olabel.." ~b~("..rUtils.Math.GroupDigits(v.count)..")", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                selected.event = v.event
                                selected.name = v.name
                                selected.olabel = v.olabel
                                selected.label = v.label
                                selected.count = v.count
                            end
                        end, RMenu:Get('core', 'inventory_use'))
                    else
                        RageUI.ButtonWithStyle(v.olabel.." ["..v.label.."] ~b~("..rUtils.Math.GroupDigits(v.count)..")", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                selected.event = v.event
                                selected.name = v.name
                                selected.olabel = v.olabel
                                selected.label = v.label
                                selected.count = v.count
                            end
                        end, RMenu:Get('core', 'inventory_use'))
                    end
                end

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'inventory_use'), true, true, true, function()
                RageUI.Separator(selected.label.." ~b~("..rUtils.Math.GroupDigits(selected.count)..")")
                RageUI.ButtonWithStyle("Utiliser", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerEvent("rF:UseItem", selected.name, items)
                    end
                end, RMenu:Get('core', 'inventory'))
                RageUI.ButtonWithStyle("Donner", nil, {RightLabel = "📦"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local ClosetPlayer, dst = rUtils.GetClosestPlayer()
                        local idJoueur = GetPlayerServerId(ClosetPlayer)
                        if ClosetPlayer ~= -1 then
                            local amount = CustomAmount() 
                            if amount ~= nil and amount <= selected.count and dst <= 2.0 and amount > 0  then
                                TriggerServerEvent(events.Transfer, token, idJoueur, selected.name, amount, selected.label, selected.count)
                                TriggerServerEvent(events.GetInv, token)
                                RageUI.Visible(RMenu:Get('core', 'inventory'), true)
                            else
                                RageUI.Popup({message = "Aucune personne proche."})
                            end
                        else
                            RageUI.Popup({message = "Aucune personne proche."})
                        end
                    end
                    if Active then
                        rUtils.DisplayClosetPlayer()
                    end
                end, RMenu:Get('core', 'inventory'))
                if selected.label == selected.olabel then
                    RageUI.ButtonWithStyle("Renommer", nil, { RightLabel = "✍"  }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RenameAnItem()
                            TriggerServerEvent(events.rename, token, selected.name, selected.newLabel, selected.label)
                            TriggerServerEvent(events.GetInv, token)
                            RageUI.Visible(RMenu:Get('core', 'inventory'), true)
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("Réinitialiser ", "~r~Tu ne peu pas rename un item déja rename, tu doit le réinitialiser avant.", { RightLabel = "🛠" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            TriggerServerEvent(events.resetRename, token, selected.name, selected.olabel, selected.label)
                            TriggerServerEvent(events.GetInv, token)
                            RageUI.Visible(RMenu:Get('core', 'inventory'), true)
                        end
                    end)
                end
                RageUI.ButtonWithStyle("Raccourcie #1", nil, {RightLabel = "~g~"..itemFastControl[1].label}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        itemFastControl[1].label = selected.label
                        itemFastControl[1].item = selected.name
                    end
                end)
                RageUI.ButtonWithStyle("Raccourcie #2", nil, {RightLabel = "~g~"..itemFastControl[2].label}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        itemFastControl[2].label = selected.label
                        itemFastControl[2].item = selected.name
                    end
                end)
                RageUI.ButtonWithStyle("Raccourcie #3", nil, {RightLabel = "~g~"..itemFastControl[3].label}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        itemFastControl[3].label = selected.label
                        itemFastControl[3].item = selected.name
                    end
                end)
                RageUI.ButtonWithStyle("Raccourcie #4", nil, {RightLabel = "~g~"..itemFastControl[4].label}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        itemFastControl[4].label = selected.label
                        itemFastControl[4].item = selected.name
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'portefeuille'), true, true, true, function()
                RageUI.Separator(pJob.." - "..GetGradeLabel(pJob, pJob_Grade))
                RageUI.ButtonWithStyle("Poche: ~g~"..rUtils.Math.GroupDigits(pMoney).."$", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        moneySelected.type = "Poche: ~g~"
                        moneySelected.count = pMoney
                    end
                end, RMenu:Get('core', 'portefeuille_usage'))
                RageUI.ButtonWithStyle("Banque: ~b~"..rUtils.Math.GroupDigits(pBank).."$", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        moneySelected.type = "Banque: ~b~"
                        moneySelected.count = pBank
                    end
                end)
                RageUI.ButtonWithStyle("Source inconnu: ~c~"..rUtils.Math.GroupDigits(pDirty).."$", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        moneySelected.type = "Source inconnu: ~c~"
                        moneySelected.count = pDirty
                    end
                end, RMenu:Get('core', 'portefeuille_usage'))

                if IsPatron(pJob, pJob_Grade) then
                    RageUI.ButtonWithStyle("Ouvrire le menu patron: ~c~"..pJob, nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            OpenBossMenu(pJob)
                        end
                    end)
                end

                RageUI.ButtonWithStyle("Regarder sa carte d'identité", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        ShowIdentityCard()
                    end
                end)

                RageUI.ButtonWithStyle("Montrer sa carte d'identité", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ShowIdentityCardToOther()
                    end
                    if Active then
                        rUtils.DisplayClosetPlayer()
                    end
                end)

                RageUI.ButtonWithStyle("ID Boutique: ["..pUniqueID.."]", nil, {}, true, function(Hovered, Active, Selected)
                end)
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'portefeuille_usage'), true, true, true, function()
                RageUI.Separator(moneySelected.type.." "..rUtils.Math.GroupDigits(moneySelected.count).."$")
                RageUI.ButtonWithStyle("Donner", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local amount = CustomAmount()
                        if amount ~= nil and amount <= moneySelected.count and amount > 0 then
                            local closet, dst = rUtils.GetClosestPlayer(GetEntityCoords(pPed))
                            if dst ~= nil and dst < 2.0 then
                                local sID = GetPlayerServerId(closet)
                                if moneySelected.type == "Source inconnu: ~c~" then
                                    TriggerServerEvent(events.GiveDirtyMtoplayer, token, sID, amount)
                                    pDirty = pDirty - amount
                                else
                                    TriggerServerEvent(events.GiveMtoPlayer, token, sID, amount)
                                    pMoney = pMoney - amount
                                end
                            end
                        end
                    end
                    if Active then
                        rUtils.DisplayClosetPlayer()
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'accessoire'), true, true, true, function()
                RageUI.ButtonWithStyle("Chapeau", nil, { RightLabel = "→"..MettreOuEnleverDisplay(accessoire.casque) }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if accessoire.casque then
                            accessoire.casque = false
                            ClearPedProp(GetPlayerPed(-1), 0)
                            rUtils.PlayAnim("veh@bike@common@front@base", "take_off_helmet_stand", 11, 1.0, 1.0, 1.0, 850)
                        else
                            accessoire.casque = true
                            local key = exports.rFramework:GetKeyValue("helmet_1")
                            local key2 = exports.rFramework:GetKeyValue("helmet_2")
                            SetPedPropIndex(GetPlayerPed(-1), 0, key, key2, 2)
                        end
                    end
                end)

                RageUI.ButtonWithStyle("Lunette", nil, { RightLabel = "→"..MettreOuEnleverDisplay(accessoire.lunette) }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if accessoire.lunette then
                            accessoire.lunette = false
                            ClearPedProp(GetPlayerPed(-1), 1)
                            rUtils.PlayAnim("veh@bike@common@front@base", "take_off_helmet_stand", 11, 1.0, 1.0, 1.0, 850)
                        else
                            accessoire.lunette = true
                            local key = exports.rFramework:GetKeyValue("glasses_1")
                            local key2 = exports.rFramework:GetKeyValue("glasses_2")
                            SetPedPropIndex(GetPlayerPed(-1), 1, key, key2, 2)
                        end
                    end
                end)


                RageUI.ButtonWithStyle("Masque", nil, { RightLabel = "→"..MettreOuEnleverDisplay(accessoire.mask) }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if accessoire.mask then
                            accessoire.mask = false
                            local key2 = exports.rFramework:GetKeyValue("mask_2")
                            SetPedComponentVariation(GetPlayerPed(-1), 1, 0, key2, 2)	
                            rUtils.PlayAnim("missfbi4", "takeoff_mask", 51, 1.0, 1.0, 1.0, 850)
                        else
                            accessoire.mask = true
                            local key = exports.rFramework:GetKeyValue("mask_1")
                            local key2 = exports.rFramework:GetKeyValue("mask_2")
                            SetPedComponentVariation(GetPlayerPed(-1), 1, key, key2, 2)
                            rUtils.PlayAnim("mp_masks@on_foot", "put_on_mask", 51, 1.0, 1.0, 1.0, 850)
                        end
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'divers_editor'), true, true, true, function()

                RageUI.ButtonWithStyle("Stopper le record + save", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        StopRecordingAndSaveClip()
                    end
                end)

                RageUI.ButtonWithStyle("Stopper le record", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        StopRecordingAndDiscardClip()
                    end
                end)

                RageUI.ButtonWithStyle("Start le record", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        StartRecording(1)
                    end
                end)


            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'divers_color'), true, true, true, function()

                local self = RMenu:Get('core', 'divers_color')
                self.EnableMouse = true
            
                RageUI.Progress("Rouge", menuColor[1], 255, nil, true, true,function(Hovered, Active, Selected,Color)
                    menuColor[1] = Color
                    ReloadColor()
                end)
            
                RageUI.Progress("Vert", menuColor[2], 255, nil, true, true,function(Hovered, Active, Selected,Color)
                    menuColor[2] = Color
                    ReloadColor()
                end)
            
                RageUI.Progress("Bleu", menuColor[3], 255, nil, true, true,function(Hovered, Active, Selected,Color)
                    menuColor[3] = Color
                    ReloadColor()
                end)
            
                RageUI.Separator("")
            
                RageUI.ButtonWithStyle("Appliquer la couleur", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SetResourceKvpInt("menuR", menuColor[1])
                        SetResourceKvpInt("menuG", menuColor[2])
                        SetResourceKvpInt("menuB", menuColor[3])
                        ReloadColor()
                    end
                end)
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'divers_radio'), true, true, true, function()
                RageUI.Button("Stopper la radio", "", true, function(Hovered, Active, Selected)
                    if (Selected) then
                        exports.saltychat:SetRadioChannel("", true)
                        inRadio = false
                    end
                end) 

                for k,v in ipairs(radio) do
                    if pJob == v.job then
                        RageUI.Button("Radio: "..v.label, "Radio réservé au job "..v.job, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                exports.saltychat:SetRadioChannel(tostring(v.label.."_jobs"), true)
                                inRadio = true
                            end
                        end) 
                    end
                end

                RageUI.Button("Entrez une fréquence", "Entrez un nom de radio, vous y serez automatiquement connecté.", true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local radio = CustomString()
                        if radio ~= nil then
                            exports.saltychat:SetRadioChannel(tostring(radio), true)
                            inRadio = true
                        end
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'divers'), true, true, true, function()
                RageUI.ButtonWithStyle("Rockstar éditor", nil, { RightLabel = "→→" }, true, function()
                end, RMenu:Get('core', 'divers_editor'))
                RageUI.ButtonWithStyle("Couleur du menu", nil, { RightLabel = "→→" }, true, function()
                end, RMenu:Get('core', 'divers_color'))
                RageUI.ButtonWithStyle("Radio", nil, { RightLabel = "→→" }, true, function()
                end, RMenu:Get('core', 'divers_radio'))

                RageUI.Button("Activer/Desactiver l'HUD", nil, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerEvent("rF:HudToogle")
                    end
                end)

                if VeloDePoche == nil then
                    RageUI.Button("Sortir son vélo de poche", nil, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local co = GetEntityCoords(pPed)
                            rUtils.SpawnVehicle(GetHashKey("bmx"), vector3(co.x+1.5, co.y, co.z), GetEntityHeading(pPed), nil, function(veh)
                                VeloDePoche = VehToNet(veh)
                            end)
                            SendActionTxt(" sort son vélo de poche")
                        end
                    end)
                else
                    RageUI.Button("Ranger son vélo de poche", nil, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            TriggerServerEvent(events.DelEntity, token, VeloDePoche)
                            VeloDePoche = nil
                            SendActionTxt(" range son vélo de poche")
                        end
                    end)
                end

                RageUI.ButtonWithStyle("Props", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    if s then RageUI.Visible(RMenu:Get('core', 'props'), true) OpenPropsMenu() end
                end)
                RageUI.Button("Porter la personne la plus proche", nil, true, function(_,_,s)
                    if s then 
                        CarryNearest() 
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_veh'), true, true, true, function()

                RageUI.ButtonWithStyle("Spawn un véhicule", nil, { RightBadge = RageUI.BadgeStyle.Car }, InStaff, function(Hovered, Active, Selected)
                    if Selected then
                        local veh = CustomString()
                        if veh ~= nil then
                            rUtils.LoadModel(GetHashKey(veh))
                            rUtils.SpawnVehicle(GetHashKey(veh), GetOffsetFromEntityInWorldCoords(pPed, 1.0, 0.0, 0.0), GetEntityHeading(pPed), nil, function()
                            
                            end)
                        end
                    end
                end)

                RageUI.ButtonWithStyle("Réparer le véhicule", "Permet de réparer le véhicule le plus proche.", { RightBadge = RageUI.BadgeStyle.Car }, InStaff, function(Hovered, Active, Selected)
                    if Active then 
                        ClosetVehWithDisplay() 
                    end
                    if Selected then
                        local veh = rUtils.GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        local ServerID = GetPlayerServerId(NetworkGetEntityOwner(veh))
                        TriggerServerEvent(events.repair, token, VehToNet(veh), ServerID)
                    end
                end)

                RageUI.ButtonWithStyle("Mettre le véhicule en fourrière", "Permet de Mettre le véhicule le plus proche en fourrière.", { RightBadge = RageUI.BadgeStyle.Car }, InStaff, function(Hovered, Active, Selected)
                    if Active then 
                        ClosetVehWithDisplay() 
                    end
                    if Selected then
                        local veh = rUtils.GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        TriggerServerEvent(events.DelEntity, token, VehToNet(veh))
                    end
                end)

                RageUI.ButtonWithStyle("[DEBUG] Fix coffre", "Si un coffre de véhicule est bug, cette option permet de le fix.", { RightBadge = RageUI.BadgeStyle.Car }, InStaff, function(Hovered, Active, Selected)
                    if Active then 
                        ClosetVehWithDisplay() 
                    end
                    if Selected then
                        local veh = rUtils.GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        local plate = GetVehicleNumberPlateText(veh)
                        TriggerServerEvent(events.rmvVehInvStatus, token, plate)
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_joueur'), true, true, true, function()

                RageUI.ButtonWithStyle("Liste des joueurs", "Permet de faire des actions sur les joueurs en lignes.", { RightLabel = "→" }, InStaff, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.GetPlayersList, token)
                    end
                end, RMenu:Get('core', 'admin_pList'))

                RageUI.Button("~r~Bannir un ID", "Entrez l'ID", true, function(_,_,s)
                    if s then
                        local id = CustomAmount()
                        if id ~= nil then
                            reason = ""
                            SelectedPlayer.id = tonumber(id)
                            
                        end
                    end
                end, RMenu:Get('core', 'admin_ban'))

                RageUI.Button("~b~Kick un ID", "Permet de kick avec une raison.", true, function(_,_,s)
                    if s then
                        local id = CustomAmount()
                        if id ~= nil then
                            local msg = CustomStringStaff()
                            if msg ~= nil then
                                TriggerServerEvent(events.kick, token, tonumber(id), msg) 
                            end
                        end
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_ban'), true, true, true, function()
                RageUI.Button("Raison:", reason, true, function(_,_,s)
                    if s then
                        reason = CustomStringStaff()
                    end
                end) 

                RageUI.Button("Ban perma", reason, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.ban, token, SelectedPlayer.id, 0, reason)
                    end
                end)

                RageUI.Button("Ban 1j", reason, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.ban, token, SelectedPlayer.id, 1, reason)
                    end
                end)

                RageUI.Button("Ban 2j", reason, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.ban, token, SelectedPlayer.id, 2, reason)
                    end
                end)

                RageUI.Button("Ban 3j", reason, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.ban, token, SelectedPlayer.id, 3, reason)
                    end
                end)

                RageUI.Button("Ban 4j", reason, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.ban, token, SelectedPlayer.id, 4, reason)
                    end
                end)

                RageUI.Button("Ban 5j", reason, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.ban, token, SelectedPlayer.id, 5, reason)
                    end
                end)
            end, function()
            end)


            RageUI.IsVisible(RMenu:Get('core', 'admin_divers'), true, true, true, function()


                RageUI.Button("TP Sur marker", nil, InStaff, function(_,_,s)
                    if s then
                        GoToBlip()
                    end
                end)

                RageUI.Button("Nettoyer la rue", nil, InStaff, function(_,_,s)
                    if s then
                        local players = rUtils.GetPlayersInScope()
                        TriggerServerEvent(events.clearObjects, token, GetEntityCoords(pPed), players)
                    end
                end)

                RageUI.Button("Clear les props de la zone", nil, InStaff, function(_,_,s)
                    if s then
                        local props = {}
                        for v in EnumerateObjects() do
                            if NetworkGetEntityIsNetworked(v) then
                                table.insert(props, ObjToNet(v))
                            else
                                DeleteEntity(v)
                            end
                        end
                        TriggerServerEvent(events.DelEntityTable, token, props)
                    end
                end)

                RageUI.Button("Clear les PNJ de la zone", nil, InStaff, function(_,_,s)
                    if s then
                        local props = {}
                        for v in EnumeratePeds() do
                            if not IsPedAPlayer(v) then
                                if NetworkGetEntityIsNetworked(v) then
                                    table.insert(props, ObjToNet(v))
                                    if IsPedInAnyVehicle(v, false) then
                                        table.insert(props, ObjToNet(GetVehiclePedIsIn(v, false)))
                                    end
                                else
                                    DeleteEntity(v)
                                end
                            end
                        end
                        TriggerServerEvent(events.DelEntityTable, token, props)
                    end
                end)

                RageUI.Button("Activer les nom", nil, InStaff, function(_,_,s)
                    if s then
                        ShowNames()
                    end
                end)

                RageUI.Button("NoClip", nil, InStaff, function(_,_,s)
                    if s then
                        NoClip()
                    end
                end)

 
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin'), true, true, true, function()
                RageUI.Separator("~b~Menu staff")

                RageUI.Checkbox("Activer le mod staff", nil, InStaff, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    InStaff = Checked;
                end, function()
                    TriggerServerEvent(events.Service, token, "staff")
                    TriggerServerEvent(events.staffmod, token, true)
                end, function()
                    ShowNames(false)
                    TriggerServerEvent(events.Service, token, "staff")
                    TriggerServerEvent(events.staffmod, token, false)
                end)

                RageUI.ButtonWithStyle("Action staff sur joueur", nil, { RightLabel = "→" }, InStaff, function(_,_,s)
                end, RMenu:Get('core', 'admin_joueur'))

                RageUI.ButtonWithStyle("Action staff sur véhicule", nil, { RightLabel = "→" }, InStaff, function(_,_,s)
                end, RMenu:Get('core', 'admin_veh'))

                RageUI.ButtonWithStyle("Action staff divers", nil, { RightLabel = "→" }, InStaff, function(_,_,s)
                end, RMenu:Get('core', 'admin_divers'))


            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_pList'), true, true, true, function()
                RageUI.Checkbox("Zone uniquement", "Afficher uniquement les joueurs de votre zone", zoneOnly, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    zoneOnly = Checked;
                end, function()
                end, function()
                end)
                if not zoneOnly then
                    for k,v in ipairs(players) do
                        RageUI.Button("["..v.id.."] - "..v.name, nil, true, function(_,_,s)
                            if s then
                                SelectedPlayer = v
                            end
                        end, RMenu:Get('core', 'admin_jAction'))
                    end
                else
                    for k,v in ipairs(GetActivePlayers()) do
                        RageUI.Button("["..GetPlayerServerId(v).."] - "..GetPlayerName(v), nil, true, function(_,_,s)
                            if s then
                                SelectedPlayer = {id = GetPlayerServerId(v), name = GetPlayerName(v)}
                            end
                        end, RMenu:Get('core', 'admin_jAction'))
                    end
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_jAction'), true, true, true, function()
                RageUI.Separator("Joueur ["..SelectedPlayer.id.."] - "..SelectedPlayer.name)
                RageUI.Button("Envoyer un message", nil, true, function(_,_,s)
                    if s then
                        local msg = CustomStringStaff()
                        if msg ~= nil then
                            TriggerServerEvent(events.sendMsg, token, SelectedPlayer.id, msg)
                        end
                    end
                end)

                RageUI.Button("Goto", nil, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.gotop, token, SelectedPlayer.id)
                    end
                end)

                RageUI.Button("Bring", nil, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.bring, token, SelectedPlayer.id)
                    end
                end)

                RageUI.Button("~r~Bannir", "En premier la durée en jours, ensuite la raison.", true, function(_,_,s)
                    if s then
                        local duree = CustomAmount()
                        if duree ~= nil then
                            local msg = CustomStringStaff()
                            if msg ~= nil then
                                TriggerServerEvent(events.ban, token, SelectedPlayer.id, duree, msg)
                            end
                        end
                    end
                end)

                RageUI.Button("~b~Kick", "Permet de kick avec une raison.", true, function(_,_,s)
                    if s then
                        local msg = CustomStringStaff()
                        if msg ~= nil then
                            TriggerServerEvent(events.kick, token, SelectedPlayer.id, msg)
                        end
                    end
                end)

                RageUI.Button("Revive", nil, true, function(_,_,s)
                    if s then
                        TriggerServerEvent(events.ResetDeath, token, tonumber(SelectedPlayer.id))
                    end
                end)

                RageUI.Button("Changer le job", nil, true, function(_,_,s)
                end, RMenu:Get('core', 'admin_JobList'))

                RageUI.Button("Changer le groupe", nil, pGroup == "dev" or pGroup == "fonda", function(_,_,s)
                end, RMenu:Get('core', 'admin_GroupList'))

                RageUI.Button("Remboursement", nil, pGroup == "dev" or pGroup == "fonda" or pGroup == "remb", function()
                end, RMenu:Get('core', 'admin_remb'))

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_remb'), true, true, true, function()
                RageUI.Button("Donner de l'argent", nil, true, function(_,_,s)
                    if s then
                        local amount = CustomAmount()
                        if amount ~= nil and amount > 0 then
                            TriggerServerEvent(events.StaffGiveMoney, token, tonumber(amount), tonumber(SelectedPlayer.id))
                        end
                    end
                end)

                RageUI.Button("Donner de l'argent en banque", nil, true, function(_,_,s)
                    if s then
                        local amount = CustomAmount()
                        if amount ~= nil and amount > 0 then
                            TriggerServerEvent(events.StaffGiveBanque, token, tonumber(amount), tonumber(SelectedPlayer.id))
                        end
                    end
                end)

                RageUI.Button("Donner de l'argent sale", nil, true, function(_,_,s)
                    if s then
                        local amount = CustomAmount()
                        if amount ~= nil and amount > 0 then
                            TriggerServerEvent(events.GiveDirtyToId, token, tonumber(amount), tonumber(SelectedPlayer.id))
                        end
                    end
                end)

                RageUI.ButtonWithStyle("Give un item", nil, { RightLabel = "→→" }, pGroup ~= "user", function(_,_,s)
                end, RMenu:Get('core', 'admin_item'))
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_item'), true, true, true, function()
                for _,v in pairs(items) do
                    RageUI.Button(v.label.."", nil, true, function(_,_,s)
                        if s then
                            local amount = CustomAmount()
                            if tonumber(amount) ~= nil and tonumber(amount) > 0 then
                                TriggerServerEvent(events.give, token, v.name, tonumber(amount), GetItemId(v.name))
                            end
                        end
                    end)
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_JobList'), true, true, true, function()
                for _,v in pairs(societyList) do
                    for k,i in pairs(v.grade) do
                        RageUI.Button(v.name.." - ~c~["..k.."] "..i.label, nil, true, function(_,_,s)
                            if s then
                                TriggerServerEvent(events.changeJob, token, SelectedPlayer.id, v.name, k)
                            end
                        end)
                    end
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'admin_GroupList'), true, true, true, function()
                for k,v in pairs(JobsData.staff) do
                    RageUI.Button(v.label, nil, true, function(_,_,s)
                        if s then
                            TriggerServerEvent(events.group, token, SelectedPlayer.id, v.group)
                        end
                    end)
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'vip_main'), true, true, true, function()
                RageUI.ButtonWithStyle("Teinture d'arme", nil, { RightLabel = "→" }, pVip ~= 0, function()
                end, RMenu:Get('core', 'vip_weapon_tint'))
                RageUI.ButtonWithStyle("Animation d'arme", nil, { RightLabel = "→" }, pVip ~= 0, function()
                end, RMenu:Get('core', 'vip_weapon_aim'))
                RageUI.ButtonWithStyle("Peds - Personnnage OneShot", nil, { RightLabel = "→" }, pVip ~= 0, function()
                end, RMenu:Get('core', 'vip_peds'))
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'vip_peds'), true, true, true, function()
                RageUI.ButtonWithStyle("Nom OneShot: ", pNom, { RightLabel = "~g~"..pNom }, pVip ~= 0, function(_,_,s)
                    if s then
                        if GetEntityModel(pPed) ~= GetHashKey("mp_f_freemode_01") and GetEntityModel(pPed) ~= GetHashKey("mp_m_freemode_01") then
                            local name = CustomString()
                            if name ~= nil then
                                pNom = name
                            end
                        else
                            rUtils.ImportantNotif("Interdit de faire une identité OneShot avec ton vrais personnage.")
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Prénom OneShot: ", pPrenom, { RightLabel = "~g~"..pPrenom }, pVip ~= 0, function(_,_,s)
                    if s then
                        if GetEntityModel(pPed) ~= GetHashKey("mp_f_freemode_01") and GetEntityModel(pPed) ~= GetHashKey("mp_m_freemode_01") then
                            local name = CustomString()
                            if name ~= nil then
                                pPrenom = name
                            end
                        else
                            rUtils.ImportantNotif("Interdit de faire une identité OneShot avec ton vrais personnage.")
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Animals - Personnnage OneShot", nil, { RightLabel = "→" }, pVip ~= 0, function()
                end, RMenu:Get('core', 'vip_peds_animals'))
                RageUI.ButtonWithStyle("Peds - Personnnage OneShot", nil, { RightLabel = "→" }, pVip ~= 0, function()
                end, RMenu:Get('core', 'vip_peds_peds'))


                RageUI.ButtonWithStyle("Peds - Personnnage définitif ( Soon )", nil, { RightLabel = "→" }, pVip ~= 0, function()
                end)
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'vip_peds_animals'), true, true, true, function(_,_,s)
                RageUI.Button("Reprendre son personnage.", nil, true, function(_,h,s)
                    if s then
                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerEvent("skinchanger:LoadForTheFirsTime", skin)
                        end)
                        ResetIdentity()
                    end
                end)
                for k,v in pairs(peds.animals) do
                    RageUI.Button(v.label, nil, true, function(_,h,s)
                        if s then
                            rUtils.LoadModel(GetHashKey(v.model))
                            SetPlayerModel(GetPlayerIndex(), v.model)
                            SetPedRandomComponentVariation(GetPlayerPed(-1), 0)
                            rUtils.ImportantNotif("~r~Rappel! ~s~Un animal ne parle pas! Tout abus sera sanctionné!")
                            rUtils.ImportantNotif("~r~Rappel! ~s~En tant qu'animal certaine animation peuvent être bug, merci *de ne pas les utiliser*")
                        end
                    end)
                end

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'vip_peds_peds'), true, true, true, function(_,_,s)
                RageUI.Button("Reprendre son personnage.", nil, true, function(_,h,s)
                    if s then
                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerEvent("skinchanger:LoadForTheFirsTime", skin)
                        end)
                        ResetIdentity()
                    end
                end)
                for k,v in pairs(peds.normal) do
                    RageUI.Button(v.label, "Interdiction de prendre des ped de gang si vous n'en faite pas partie!", true, function(_,h,s)
                        if s then
                            rUtils.LoadModel(GetHashKey(v.model))
                            SetPlayerModel(GetPlayerIndex(), v.model)
                            SetPedRandomComponentVariation(GetPlayerPed(-1), 0)
                            rUtils.ImportantNotif("~r~Rappel! ~s~Votre personnnage est un perso OneShot!")
                            rUtils.ImportantNotif("~r~Rappel! ~s~Interdiction de prendre des ped de gang si vous n'en faite pas partie!")
                        end
                    end)
                end

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('core', 'vip_weapon_tint'), true, true, true, function()
                if IsPedArmed(pPed, 7) then
                    local _,pWeapon = GetCurrentPedWeapon(pPed, 0)
                    local count = GetWeaponTintCount(pWeapon)
                   
                    for i = 0, count - 1 do
                        RageUI.Button("Teinture d'arme: "..GetTintName(i), nil, true, function(_,h,s)
                            if s then
                                SetPedWeaponTintIndex(pPed, pWeapon, i)
                            end
                            if h then
                                if GetPedWeaponTintIndex(pPed, pWeapon) ~= i then
                                    SetPedWeaponTintIndex(pPed, pWeapon, i)
                                end
                            end
                        end)
                    end
                else
                    RageUI.Button("~r~Tu a besoin d'une arme.", nil, pVip ~= 0, function()
                    end)
                end
            end, function()
            end)


            RageUI.IsVisible(RMenu:Get('core', 'vip_weapon_aim'), true, true, true, function()
                if IsPedArmed(pPed, 7) then
                    for k,v in pairs(JobsData.general.AimAnim) do
                        RageUI.Button(v.label, nil, true, function(_,h,s)
                            if s then
                                print("Aim changé en "..v.anim)
                                SetWeaponAnimationOverride(pPed, GetHashKey(v.anim))
                                DecorSetInt(pPed, "aim", v.int)
                            end
                        end)
                    end
                else
                    RageUI.Button("~r~Tu a besoin d'une arme.", nil, pVip ~= 0, function()
                    end)
                end
            end, function()
            end)

        end
    end)
end

function GetTintName(num)
    local tint = {
        [0] = {name = "Normal"},
        [1] = {name = "Vert"},
        [2] = {name = "Or"},
        [3] = {name = "Rose"},
        [4] = {name = "Armée"},
        [5] = {name = "LSPD"},
        [6] = {name = "Orange"},
        [7] = {name = "Platine"},
    }
    return tint[num].name
end

function CustomStringStaff()
    local txt = nil
    AddTextEntry("CREATOR_TXT", "Entrez votre texte.")
    DisplayOnscreenKeyboard(1, "CREATOR_TXT", '', "", '', '', '', 255)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        txt = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return txt
end

function MettreOuEnleverDisplay(status)
    if status then
        return " Enlever"
    else
        return " Mettre"
    end
end

local AllMenuToChange = nil
function ReloadColor()
    Citizen.CreateThread(function()
        if AllMenuToChange == nil then
            AllMenuToChange = {}
            for Name, Menu in pairs(RMenu['core']) do
                if Menu.Menu.Sprite.Dictionary == "commonmenu" then
                    table.insert(AllMenuToChange, Name)
                end
            end
        end
        for k,v in pairs(AllMenuToChange) do
            RMenu:Get('core', v):SetRectangleBanner(menuColor[1], menuColor[2], menuColor[3], 255)
        end
    end)
end

function CustomAmount()
    local montant = nil
    AddTextEntry("BANK_CUSTOM_AMOUNT", "Entrez le montant")
    DisplayOnscreenKeyboard(1, "BANK_CUSTOM_AMOUNT", '', "", '', '', '', 15)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        montant = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return tonumber(montant)
end

function RenameAnItem()
    AddTextEntry("ITEM_CUSTOM_LABEL", "Entrez le nouveau nom de l'item")
    DisplayOnscreenKeyboard(1, "ITEM_CUSTOM_LABEL", '', "", '', '', '', 35)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        selected.newLabel = GetOnscreenKeyboardResult()
        if selected.newLabel == nil then
            selected.newLabel = ""
        end
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
end


function ShowIdentityCard()
    local mug, txd = rUtils.GetPedMugshot(GetPlayerPed(-1))
    rUtils.ShowAdvancedNotification("IDENTITY", "~g~Carte d'identité", "Prénom: ~o~"..pPrenom.."~w~\nNom: ~o~"..pNom.."~w~\nAge:~o~ "..pAge.."~w~\nVIP: ~o~"..pVip.."~w~\nsID: ~o~"..GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPlayerPed(-1))), txd, 7, false, false)
    UnregisterPedheadshot(mug)
end

function ShowIdentityCardToOther()
    local player, dst = rUtils.GetClosestPlayer(GetEntityCoords(GetPlayerPed(-1)))
    if dst == nil then return end
    if dst <= 2.0 then
        local sID = GetPlayerServerId(player)
        TriggerServerEvent(events.ShowIdCardToOther, token, sID, PedToNet(GetPlayerPed(player)), pPrenom, pNom, pAge, pVip)
    else
        RageUI.Popup({message = "~r~Action impossible\n~w~Aucun joueur proche."})
    end
end

RegisterNetEvent("core:AskForIdentity")
AddEventHandler("core:AskForIdentity", function(id)
    TriggerServerEvent(events.ShowIdCardToOther, token, id, 0, pPrenom, pNom, pAge, pVip)
end)


RegisterNetEvent("core:ShowIdentityCardToOther")
AddEventHandler("core:ShowIdentityCardToOther", function(net, source, Prenom, Nom, Age, Vip)
    local ped = GetPlayerPed(GetPlayerFromServerId(source))
    local mug, txd = rUtils.GetPedMugshot(ped)
    rUtils.ShowAdvancedNotification("IDENTITY", "~g~Carte d'identité", "Prénom: ~o~"..Prenom.."~w~\nNom: ~o~"..Nom.."~w~\nAge:~o~ "..Age.."~w~\nVIP: ~o~"..Vip.."~w~\nsID: ~o~"..GetPlayerServerId(GetPlayerFromServerId(source)), txd, 7, false, false)
    UnregisterPedheadshot(mug)
end)