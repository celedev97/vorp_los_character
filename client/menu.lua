---@diagnostic disable: undefined-global
MenuData = {}

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)


--* HELPER
-- todo  menu images
LifeStyleLabelLookup = {
    moles = {
        label = T.MenuLifeStyle.element.label,
        txt_id = "moles_tx_id",
        opacity = "moles_opacity",
        vis = "moles_visibility"
    },
    spots = {
        label = T.MenuLifeStyle.element2.label,
        txt_id = "spots_tx_id",
        opacity = "spots_opacity",
        vis = "spots_visibility"
    },
    complex = {
        label = T.MenuLifeStyle.element3.label,
        txt_id = "complex_tx_id",
        opacity = "complex_opacity",
        vis = "complex_visibility"
    },
    acne = {
        label = T.MenuLifeStyle.element4.label,
        txt_id = "acne_tx_id",
        opacity = "acne_opacity",
        vis = "acne_visibility"
    },
    freckles = {
        label = T.MenuLifeStyle.element5.label,
        txt_id = "freckles_tx_id",
        opacity = "freckles_opacity",
        vis = "freckles_visibility"
    },
    disc = {
        label = T.MenuLifeStyle.element6.label,
        txt_id = "disc_tx_id",
        opacity = "disc_opacity",
        vis = "disc_visibility"
    },
    scars = {
        label = T.MenuLifeStyle.element7.label,
        txt_id = "scars_tx_id",
        opacity = "scars_opacity",
        vis = "scars_visibility"
    },
    grime = {
        label = T.MenuLifeStyle.element8.label,
        txt_id = "grime_tx_id",
        opacity = "grime_opacity",
        vis = "grime_visibility"
    },
}


local height = 0
local heightIndex = 2
local heightLabel = T.MenuAppearance.element5.label

local heritageIndex = 1

function PrintTable(table)
    if type(table) == 'table' then
        local s = '{ '
        for k, v in pairs(table) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. PrintTable(v) .. ','
        end
        return s .. '} '
    else
        return tostring(table)
    end
end

--* Local functions
local currentFactionData

local function SetLifestyleOpacity(field_name, opacity)
    print("SETTING LIFESTYLE OPACITY FOR " .. field_name .. " TO " .. opacity)
    local field_texture_id = LifeStyleLabelLookup[field_name].txt_id
    local field_opacity_id = LifeStyleLabelLookup[field_name].opacity
    local field_visibility_id = LifeStyleLabelLookup[field_name].vis
    
    if opacity > 0 then
        PlayerSkin[field_visibility_id] = 1
        PlayerSkin[field_opacity_id] = opacity / 10
        toggleOverlayChange(field_name, PlayerSkin[field_visibility_id],
            PlayerSkin[field_texture_id], 0, 0, 1, 1.0, 0, 0, 0, 0,
            0, 1, PlayerSkin[field_opacity_id], PlayerSkin.albedo)
    else
        PlayerSkin[field_visibility_id] = 0
        PlayerSkin[field_opacity_id] = 0
        toggleOverlayChange(field_name, PlayerSkin[field_visibility_id],
            PlayerSkin[field_texture_id], 0, 0, 1, 1.0, 0, 0, 0, 0,
            0, 1, PlayerSkin[field_opacity_id], PlayerSkin.albedo)
    end
end

local function SetLifestyleTexture(field_name, textureIndex)
    print("SETTING LIFESTYLE TEXTURE FOR " .. field_name .. " TO " .. textureIndex)
    local field_texture_id = LifeStyleLabelLookup[field_name].txt_id
    local field_opacity_id = LifeStyleLabelLookup[field_name].opacity
    local field_visibility_id = LifeStyleLabelLookup[field_name].vis

    if textureIndex > 0 then
        PlayerSkin[field_texture_id] = textureIndex
        toggleOverlayChange(field_name, PlayerSkin[field_visibility_id],
            PlayerSkin[field_texture_id], 0, 0, 1,
            1.0, 0, 0, 0, 0, 0,
            1, PlayerSkin[field_opacity_id], PlayerSkin.albedo)
    else
        PlayerSkin[field_texture_id] = 0
        toggleOverlayChange(field_name, PlayerSkin[field_visibility_id],
            PlayerSkin[field_texture_id], 0, 0, 1,
            1.0, 0, 0, 0, 0, 0,
            1, PlayerSkin[field_opacity_id], PlayerSkin.albedo)
    end
end

local function SetHeight(selectedHeightIndex)
    heightIndex = selectedHeightIndex
    if heightIndex == 1 then
        height = 0.95
        heightLabel = T.MenuAppearance.short
    end
    if heightIndex == 2 then
        height = 1.0
        heightLabel = T.MenuAppearance.normal
    end
    if heightIndex == 3 then
        height = 1.05
        heightLabel = T.MenuAppearance.tall
    end
    if heightIndex == 4 then
        height = 1.1
        heightLabel = T.MenuAppearance.extraTall
    end
    SetPedScale(PlayerPedId(), height)
    PlayerSkin.Scale = height
end

local function SetHeritage(selectedHeritageIndex)
    heritageIndex = selectedHeritageIndex

    local __player      = PlayerPedId()
    local gender = GetGender()

    local index         = heritageIndex

    __SKINCOLOR         = index
    local SkinColor     = currentFactionData.appearance.heritages[gender][index]
    local heritage      = SkinColor.Heads[index]
    local legs          = SkinColor.Legs[index] or gender == "Male" and "887C4C70" or
        gender == "Female" and "EDE17D5F"
    local body          = SkinColor.Body[index] or gender == "Male" and "CD7F8895" or
        gender == "Female" and "C05A25AD"

    local headtexture   = joaat(SkinColor.HeadTexture[1])
    local Heads         = tonumber("0x" .. heritage)
    local Legs          = tonumber("0x" .. legs)
    local Body          = tonumber("0x" .. body)
    local Albedo        = Config.texture_types[gender].albedo

    PlayerSkin.HeadType = Heads
    PlayerSkin.BodyType = Body
    PlayerSkin.LegsType = Legs
    PlayerSkin.albedo   = headtexture

    print("HEADS: " .. Heads)
    print("HEADTEXTURE: ".. tostring(headtexture) .. " " .. SkinColor.HeadTexture[1])
    print("LEGS: " .. Legs)
    print("BODY: " .. Body)
    print("ALBEDO: " .. Albedo)

    ApplyComponentToPed(__player, Heads)
    ApplyComponentToPed(__player, Legs)
    ApplyComponentToPed(__player, Body)
    Citizen.InvokeNative(0xC5E7204F322E49EB, Albedo, headtexture, 0x7FC5B1E1)
    UpdateVariation(__player)
end

local function SetSelectedFaction(factionID)
    print("SETTING SELECTED FACTION..." .. factionID)
    PlayerFaction = factionID
    local gender = GetGender();


    for _, value in ipairs(Factions) do
        if value.value == factionID then
            currentFactionData = value
        end
    end
    print(PrintTable(currentFactionData))

    -- setting default height for this faction if the current height is not in the range
    if (heightIndex < currentFactionData.appearance.height.min or heightIndex > currentFactionData.appearance.height.max) then
        SetHeight(currentFactionData.appearance.height.value)
    end

    --setting default heritage for this faction if the current heritage is not in the range
    local foundHeritage = false	
    for i, heritage in ipairs(currentFactionData.appearance.heritages[gender]) do
        local headtexture = joaat(heritage.HeadTexture[1])
        if (headtexture == PlayerSkin.albedo) then
            print("FOUND VALID HERITAGE, index"..tostring(i))
            SetHeritage(i)
            foundHeritage = true
            break
        end
    end

    if (not foundHeritage) then
        print("HERITAGE NOT FOUND, SETTING DEFAULT FOR FACTION")
        SetHeritage(1)
    end

    --looping over Config.overlays_info
    for key, value in pairs(Config.overlays_info) do
        if (
                currentFactionData.appearance.lifeStyle ~= nil
                and currentFactionData.appearance.lifeStyle[key] ~= nil
                and currentFactionData.appearance.lifeStyle[key].texture ~= nil
                and currentFactionData.appearance.lifeStyle[key].texture.value ~= nil
            ) then
            --TODO: APPLY DEFAULT TEXTURE VALUE
            print("SETTING DEFAULT TEXTURE VALUE FOR "..key)
            SetLifestyleTexture(key, currentFactionData.appearance.lifeStyle[key].texture.value)
        end

        if (
                currentFactionData.appearance.lifeStyle ~= nil
                and currentFactionData.appearance.lifeStyle[key] ~= nil
                and currentFactionData.appearance.lifeStyle[key].opacity ~= nil
                and currentFactionData.appearance.lifeStyle[key].opacity.value ~= nil
            ) then
            --TODO SetLifestyleOpacity(searchKey)
            print("SETTING DEFAULT OPACITY VALUE FOR " .. key)
            SetLifestyleOpacity(key, currentFactionData.appearance.lifeStyle[key].opacity.value)
        end
    end

    -- setting default body type for this faction if the current body type is not in the range
end





local function RemoveTagFromMetaPed(category)
    local __player = PlayerPedId()


    if category == "Coat" then
        PlayerClothing.CoatClosed = -1
        Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList.CoatClosed, 0)
    end
    if category == "CoatClosed" then
        PlayerClothing.Coat = -1
        Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList.Coat, 0)
    end
    if category == "Pant" then
        if GetGender() == "female" then
            PlayerClothing.Skirt = -1
            Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList.Skirt, 0)
        end
        Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList.Boots, 0)
    end
    if category == "Skirt" and GetGender() == "female" then
        PlayerClothing.Pant = -1
        Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList.Pant, 0)
    end


    Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList[category], 0)
    UpdateVariation(__player)
    PlayerClothing[category] = -1
end

local function __ApplyShopItemToPed(comp, category)
    local __player = PlayerPedId()
    RemoveTagFromMetaPed(category)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, comp.hex, true, true, true)
    UpdateVariation(__player)
    PlayerClothing[category] = comp.hex
    if category == "Pant" then -- reaply boots so they don clip out when choosing pants
        Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, PlayerClothing.Boots, true, true, true)
        UpdateVariation(__player)
    end
end

local function __CloseAll()
    Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")
    Citizen.InvokeNative(0x5A8B01199C3E79C3)
    local __player = PlayerPedId()
    VORPcore.instancePlayers(0)
    FreezeEntityPosition(__player, false)
    ClearPedTasksImmediately(__player, true)
    DestroyAllCams(true)
    IsInCharCreation = false
    InCharacterCreator = false
    RemoveImaps()
    ClearTimecycleModifier()
    if not IsInSecondChance then
        TriggerEvent("vorp:initNewCharacter")
    end
    SetEntityInvincible(__player, false)
    SetEntityVisible(__player, true)
    NetworkEndTutorialSession()
end

local function __GetName(Result)
    local splitString = {}
    for i in string.gmatch(Result, "%S+") do
        splitString[#splitString + 1] = i
    end

    if splitString[1] == nil or splitString[2] == nil then
        return 'missingname'
    end

    for _, word in ipairs(Config.BannedNames) do
        if string.find(splitString[1], word) or string.find(splitString[2], word) then
            return nil
        end
    end

    return splitString[1], splitString[2]
end

local imgPath = "<img style='max-height:532px;max-width:344px;float: center;'src='nui://vorp_los_character/images/%s.png'>"
local imgPath1 = "<img style='max-height:20px;max-width:20px;margin-left: 10px;' src='nui://vorp_los_character/images/%s.png'>"
local __CHARNAME = nil
local __DESC = nil
local __VALUE = nil
local __VALUE1 = nil

--* FACTION MENU
function OpenFactionMenu(clothingtable)
    MenuData.CloseAll()
    local elements = {}

    for key, value in pairs(Factions) do
        elements[#elements + 1] = {
            label = value.label,
            value = value.value,
            desc = value.desc,
            img = value.img
        }
    end


    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuFaction.title,
            subtext = T.MenuFaction.subtitle,
            align = Config.Align,
            elements = elements,
        },

        function(data, menu)
            if (data.current.value) then
                SetSelectedFaction(data.current.value)
                OpenConfirmFactionMenu(clothingtable, data.current)
            end
        end,
        function(data, menu)

        end)
end

function OpenConfirmFactionMenu(clothingtable, factionData)
    MenuData.CloseAll()

    local elements = {
        {
            label = T.MenuFactionConfirm.yes.label,
            value = "confirm",
            desc = T.MenuFactionConfirm.yes.desc,
        },
        {
            label = T.MenuFactionConfirm.no.label,
            value = "cancel",
            desc = T.MenuFactionConfirm.no.desc,
        }
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuFactionConfirm.title,
            subtext = T.MenuFactionConfirm.subtitle ..' - '.. factionData.label,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenFactionMenu"
        },

        function(data, menu)
            -- if back
            if (data.current == "backup") then
                _G[data.trigger](clothingtable)
            end

            if (data.current.value == "confirm") then
                OpenCharCreationMenu(clothingtable)
            end

            if (data.current.value == "cancel") then
                OpenFactionMenu(clothingtable)
            end
        end,
        function(data, menu)

        end)
end

function OpenConfirmFactionChangeMenu(clothingtable)
    MenuData.CloseAll()

    local elements = {
        {
            label = T.MenuFactionChangeConfirm.yes.label,
            value = "confirm",
            desc = T.MenuFactionChangeConfirm.yes.desc,
        },
        {
            label = T.MenuFactionChangeConfirm.no.label,
            value = "cancel",
            desc = T.MenuFactionChangeConfirm.no.desc,
        }
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuFactionChangeConfirm.title,
            subtext = T.MenuFactionChangeConfirm.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenCharCreationMenu"
        },

        function(data, menu)
            -- if back
            if (data.current == "backup") then
                _G[data.trigger](clothingtable)
            end

            if (data.current.value == "confirm") then
                OpenFactionMenu(clothingtable)
            end

            if (data.current.value == "cancel") then
                OpenCharCreationMenu(clothingtable)
            end
        end,
        function(data, menu)

        end
    )
end

function OpenCharCreationMenu(clothingtable)
    PrepareMusicEvent("MP_CHARACTER_CREATION_START")
    TriggerMusicEvent("MP_CHARACTER_CREATION_START")
    MenuData.CloseAll()
    --* Menu images
    local img = "character_creator_head"
    local img1 = "clothing_generic_outfit"
    local img2 = "menu_icon_tick"
    local img3 = "generic_walk_style"
    local img4 = "emote_greet_hey_you"

    local selectedFaction = "";
    if PlayerFaction ~= nil then
        selectedFaction = ' - ' .. currentFactionData.label
        print("SELECTED FACTION LABEL" .. selectedFaction)
    end

    local elements = {
        {
            label = T.MenuCreation.element0.label,
            value = "faction",
            desc = T.MenuCreation.element0.desc
        },
        {
            label = T.MenuCreation.element.label,
            value = "appearance",
            desc = imgPath:format(img) .. "<br> " .. T.MenuCreation.element.desc
        },
    }

    if not IsInSecondChance then
        elements[#elements + 1] = {
            label = T.MenuCreation.element2.label,
            value = "clothing",
            desc = imgPath:format(img1) .. "<br> " .. T.MenuCreation.element2.desc,
        }
        elements[#elements + 1] = {
            label = __CHARNAME or T.MenuCreation.element3.label,
            value = __VALUE1 or "name",
            desc = __DESC or imgPath:format(img4) .. "<br> " .. T.MenuCreation.element3.desc,
        }
        elements[#elements + 1] = {
            label = __LABEL or ("<span style='color: Grey;'>" .. T.MenuCreation.element4.label .. "</span>"),
            value = __VALUE or "not",
            desc = imgPath:format(img3) .. "<br> " .. T.MenuCreation.element4.desc,
        }
    else
        -- enable clothing
        elements[#elements + 1] = {
            label = T.MenuCreation.element2.label,
            value = "clothing",
            desc = imgPath:format(img1) .. "<br> " .. T.MenuCreation.element2.desc,

        }
        -- enable save button
        elements[#elements + 1] = {
            label = T.MenuCreation.element4.label,
            value = "secondchance",
            desc = imgPath:format(img3) .. "<br> " .. T.MenuCreation.element4.desc,
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuCreation.title,
            subtext = T.MenuCreation.subtitle..selectedFaction,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenCharCreationMenu"
        },

        function(data, menu)
            if (data.current == "backup") then
            end
            
            if (data.current.value == "faction") then -- check if it has been built
                OpenConfirmFactionChangeMenu(clothingtable)
            end

            if (data.current.value == "clothing") then -- check if it has been built
                OpenClothingMenu(clothingtable)
            end

            if (data.current.value == "appearance") then -- check if it has been built
                OpenAppearanceMenu(clothingtable)
            end

            if data.current.value == "secondchance" then
                menu.close()
                --* name character
                TriggerServerEvent("vorp_character:Client:SecondChanceSave", PlayerSkin, PlayerClothing)
                CachedComponents = PlayerClothing
                CachedSkin = PlayerSkin
                __CloseAll()
            end

            if (data.current.value == "name") then -- check if it has been built
                local MyInput = {
                    type = "enableinput",
                    inputType = "input",
                    button = T.Inputs.confirm,
                    placeholder = T.Inputs.placeholder,
                    style = "block",
                    attributes = {
                        inputHeader = T.Inputs.inputHeader,
                        type = "text",
                        pattern = "[A-Za-z ]{5,20}",
                        title = T.Inputs.title,
                        style = "border-radius: 10px; background-color: ; border:none;"
                    }
                }
                TriggerEvent("vorpinputs:advancedInput", json.encode(MyInput), function(result)
                    local Result = tostring(result)
                    if Result ~= nil and Result ~= "" then
                        if not __GetName(Result) then
                            TriggerEvent("vorp:TipRight", T.Inputs.banned, 4000)
                            return
                        elseif __GetName(Result) == 'missingname' then
                            TriggerEvent("vorp:TipRight", T.Inputs.missingname, 4000)
                            return
                        end
                        FirstName, LastName = __GetName(Result)

                        __CHARNAME = FirstName .. " " .. LastName .. imgPath1:format(img2)
                        __DESC = T.MenuCreation.label .. "<br> " .. FirstName .. " " .. LastName
                        __VALUE = "save"
                        __VALUE1 = "not"
                        __LABEL = T.MenuCreation.element4.label

                        local elements1 = {
                            {
                                label = T.MenuCreation.element.label,
                                value = "appearance",
                                desc = string.format(imgPath, img) .. "<br> " .. T.MenuCreation.element.desc
                            },
                            {
                                label = T.MenuCreation.element2.label,
                                value = "clothing",
                                desc = string.format(imgPath, img1) .. "<br> " .. T.MenuCreation.element2.desc,
                            },
                            {
                                label = __CHARNAME,
                                value = __VALUE1,
                                desc = __DESC,
                            },
                            {
                                label = T.MenuCreation.element4.label,
                                value = __VALUE,
                                desc = string.format(imgPath, img3) .. "<br> " .. T.MenuCreation.element4.desc,
                            },

                        }
                        menu.setElements(elements1)
                        menu.refresh()
                    end
                end)
            end

            if (data.current.value == "save") then
                menu.close()
                --* name character
                TriggerServerEvent("vorpcharacter:saveCharacter", PlayerSkin, PlayerClothing, FirstName, LastName, PlayerFaction)
                CachedComponents = PlayerClothing
                CachedSkin = PlayerSkin
                __CloseAll()
            end
        end, function(data, menu)

        end)
end

--* CLOTHING MENU
function OpenClothingMenu(table)
    MenuData.CloseAll()
    local elements = {}
    local gender   = GetGender()
    for category, _ in pairs(table) do
        local ToLabel = T.MenuClothes
        if ToLabel[category] then
            if gender == "Female" then
                local path =
                "<img style='max-height:532px;max-width:344px;float: center;'src='nui://vorp_los_character/clothingfemale/%s.png'>"
                elements[#elements + 1] = {
                    label = ToLabel[category],
                    value = category,
                    desc = path:format(category)
                }
            else
                elements[#elements + 1] = {
                    label = ToLabel[category],
                    value = category,
                    desc = imgPath:format(category)
                }
            end
        end
    end
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuClothes.title,
            subtext = T.MenuClothes.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenCharCreationMenu"
        },

        function(data, menu)
            if (data.current == "backup") then -- go back
                _G[data.trigger](table)
            end

            if (data.current.value) then
                OpenComponentMenu(table, data.current.value, data.current.label)
            end
        end,
        function(data, menu)

        end)
end

--* Component menu
function OpenComponentMenu(table, category, label)
    MenuData.CloseAll()
    local elements = {}
    local imgPath =
    "<br><img style='max-height:532px;max-width:344px;float: center; ' src='nui://vorp_los_character/images/%s.png'>"

    elements[#elements + 1] = {
        label = label,
        type = "slider",
        value = 0,
        info = #table[category],
        min = 0,
        max = #table[category],
        desc = string.format(imgPath, category)
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuComponents.title,
            subtext = T.MenuComponents.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenClothingMenu"
        },

        function(data, menu)
            if (data.current == "backup") then -- go back
                _G[data.trigger](table)
            end

            if data.current.type == "slider" and data.current.value < 1 and not data.current.info then --* remove component variation
                RemoveTagFromMetaPed(category)
            end

            if data.current.type == "slider" and data.current.value > 0 and not data.current.info then -- * component varitaion
                __ApplyShopItemToPed(data.current.comp[data.current.value], category)
            end


            if data.current.type == "slider" and data.current.value < 1 and data.current.info then --* remove component type
                RemoveTagFromMetaPed(category)
            end

            if data.current.type == "slider" and data.current.value > 0 and data.current.info then -- * component type
                local COMP
                -- get right component
                for key, value in pairs(table[category][data.current.value]) do
                    if #table[category][data.current.value] == key then
                        COMP = value
                        break
                    end
                end

                local elements1 = {}
                -- update elements
                elements1[#elements1 + 1] = {
                    label = data.current.label,
                    type = "slider",
                    value = data.current.value,
                    info = #table[category], -- table of all components will need an index to get hex value
                    min = 0,
                    max = #table[category],  -- quantity of components
                    desc = string.format(imgPath .. '<br>' .. T.MenuComponents.element.desc .. " %d  %s", category,
                        #table[category], label)
                    -- load image same name as category
                }

                elements1[#elements1 + 1] = {
                    label = label .. T.MenuComponents.element2.label .. #table[category][data.current.value],
                    type = "slider",
                    value = 0,
                    info = nil,
                    comp = table[category][data.current.value],
                    min = 0,
                    max = #table[category][data.current.value], -- get color index and update when component changes
                    desc = string.format(imgPath .. "<br>%d<br>" .. T.MenuComponents.element2.desc, category,
                        #table[category][data.current.value])
                    -- load image same name as category
                }
                menu.setElements(elements1)
                menu.refresh()
                __ApplyShopItemToPed(COMP, category)
            end
        end, function(data, menu)

        end)
end

function OpenAppearanceMenu(clothingtable)
    MenuData.CloseAll()
    local gender = GetGender()

    local elements = {
        {
            label = T.MenuAppearance.element.label,
            value = "body",
            desc = imgPath:format("character_creator_build") .. "<br>" .. T.MenuAppearance.element.desc
        },
        {
            label = T.MenuAppearance.element2.label,
            value = "heritage",
            desc = imgPath:format("character_creator_heritage") .. "<br>" .. T.MenuAppearance.element2.desc
        },
        {
            label = T.MenuAppearance.element3.label,
            value = "hair",
            desc = imgPath:format("character_creator_hair") .. "<br>" .. T.MenuAppearance.element3.desc
        },
        {
            label = T.MenuAppearance.element4.label,
            value = "age",
            desc = imgPath:format("character_creator_appearance") .. "<br>" .. T.MenuAppearance.element4.desc
        },
        {
            label = heightLabel,
            tag = "height",
            type = "slider",
            min = currentFactionData.appearance.height.min,
            comp = nil,
            max = currentFactionData.appearance.height.max,
            value = heightIndex,
            short = 1,
            tall = 3,
            normal = 2,
            extraTall = 4;
            desc = imgPath:format("character_creator_appearance") .. "<br>" .. T.MenuAppearance.element5.desc
        },
        {
            label = T.MenuAppearance.element6.label,
            value = "face",
            desc = imgPath:format("character_creator_head") .. "<br>" .. T.MenuAppearance.element6.desc
        },
        {
            label = T.MenuAppearance.element7.label,
            value = "lifestyle",
            desc = imgPath:format("character_creator_lifestyle") .. "<br>" .. T.MenuAppearance.element7.desc
        },

    }
    --* female only ?
    -- if gender == "Female" then
    elements[#elements + 1] = {
        label = T.MenuAppearance.element8.label,
        value = "makeup",
        desc = imgPath:format("character_creator_makeup") .. "<br>" .. T.MenuAppearance.element8.desc
    }
    -- end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuAppearance.title,
            subtext = T.MenuAppearance.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenCharCreationMenu"
        },

        function(data, menu)
            if (data.current == "backup") then -- go back
                _G[data.trigger](clothingtable)
            end
            if (data.current.value == "body") then
                OpenBodyMenu(clothingtable)
            end
            if (data.current.value == "heritage") then
                OpenHerritageMenu(clothingtable)
            end
            if (data.current.value == "hair") then
                OpenHairMenu(clothingtable)
            end

            if (data.current.value == "age") then
                OpenAgeMenu(clothingtable)
            end
            if (data.current.type == "slider" and not data.current.info) then
                for key, value in pairs(menu.data.elements) do
                    if value.tag == data.current.tag then
                        SetHeight(data.current.value)
                        menu.setElement(key, "label", heightLabel)
                        menu.refresh()
                        break
                    end
                end
            end

            if (data.current.value == "face") then
                OpenFaceMenu(clothingtable)
            end

            if data.current.value == "lifestyle" then
                OpenLifeStyleMenu(clothingtable)
            end

            if (data.current.value == "makeup") then
                OpenMakeupMenu(clothingtable)
            end
        end,
        function(data, menu)

        end)
end

function OpenAgeMenu(table)
    MenuData.CloseAll()
    local elements = {
        {
            label = T.MenuAge.element.label,
            type = "slider",
            min = 0,
            info = Config.overlay_all_layers,
            comp = Config.overlay_all_layers,
            compname = Config.overlay_all_layers[9].name,
            max = #Config.overlays_info.ageing,
            value = 0,
            desc = T.MenuAge.element.desc
        },
        {
            label = T.MenuAge.element2.label,
            type = "slider",
            value = 0,
            info = nil,
            comp = Config.overlay_all_layers,
            min = 0,
            max = 10,
            desc = T.MenuAge.desc2
        },
    }




    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuAge.title,
            subtext = T.MenuAge.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenAppearanceMenu"
        },

        function(data, menu)
            if (data.current == "backup") then -- go back
                _G[data.trigger](table)
            end

            if data.current.type == "slider" and not data.current.info then -- * opacity
                if data.current.value > 0 then
                    PlayerSkin.ageing_opacity = data.current.value / 10
                    PlayerSkin.ageing_visibility = 1
                    toggleOverlayChange("ageing", 1, PlayerSkin.ageing_tx_id, 0, 0, 1, 1.0,
                        0, 0, 0, 0, 0, 1, PlayerSkin.ageing_opacity, PlayerSkin.albedo)
                else
                    PlayerSkin.ageing_visibility = 0
                    if PlayerSkin.ageing_tx_id == 1 then
                        PlayerSkin.ageing_tx_id = 0
                    end
                end
            end

            if data.current.type == "slider" and data.current.value > 0 and data.current.info then -- * texture id
                PlayerSkin.ageing_tx_id = data.current.value
                toggleOverlayChange("ageing", PlayerSkin.ageing_visibility, PlayerSkin.ageing_tx_id, 0, 0, 1, 1.0,
                    0, 0, 0, 0, 0, 1, PlayerSkin.ageing_opacity, PlayerSkin.albedo)
            end
        end, function(data, menu)

        end)
end

__SKINCOLOR = 1
--* Body Menu
-- todo add legs and body type
function OpenBodyMenu(table)
    MenuData.CloseAll()
    local gender = GetGender()
    local __player = PlayerPedId()
    local elements = {
        -- components
        {
            -- body type
            label = T.MenuBody.element.label,
            type = "slider",
            value = 0,
            tag = "body",                -- table of all components will need an index to get hex value
            min = -1,
            max = #Config.BodyType.Body, -- quantity of components
            desc = imgPath:format("character_creator_build") .. "<br>" .. T.MenuBody.element.desc ..
                #Config.BodyType.Body
        },

        {
            -- waist type
            label = T.MenuBody.element2.label,
            type = "slider",
            value = 0,
            tag = "waist",
            comp = Config.BodyType.Waist,
            min = -1,
            max = #Config.BodyType.Waist, -- get color index and update when component changes
            desc = imgPath:format("character_creator_build") .. "<br>" .. T.MenuBody.element2.desc ..
                #Config.BodyType.Waist .. ' ' .. T.MenuBody.element2.desc2
            -- load image same name as category
        },

        {
            -- body type
            label = T.MenuBody.element3.label,
            type = "slider",
            value = 0,
            comp = currentFactionData.appearance.heritages[gender],
            min = 0,
            max = #currentFactionData.appearance.heritages[gender][__SKINCOLOR].Body, -- get color index and update when component changes
            desc = imgPath:format("character_creator_build") .. "<br>" .. T.MenuBody.element3.desc ..
                #currentFactionData.appearance.heritages[gender][__SKINCOLOR].Body,
            tag = "Body",
            option = "type"
        },

        {
            -- leg type
            label = T.MenuBody.element4.label,
            type = "slider",
            value = 0,
            comp = currentFactionData.appearance.heritages[gender],
            min = 0,
            max = #currentFactionData.appearance.heritages[gender][__SKINCOLOR].Legs, -- get color index and update when component changes
            desc = imgPath:format("character_creator_build") .. "<br>" .. T.MenuBody.element4.desc ..
                #currentFactionData.appearance.heritages[gender][__SKINCOLOR].Legs,
            tag = "Legs",
            option = "type"
        },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuBody.title,
            subtext = T.MenuBody.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenAppearanceMenu"
        },

        function(data, menu)
            if (data.current == "backup") then -- go back
                _G[data.trigger](table)
            end

            if data.current.option == "type" then
                if data.current.value > 0 then
                    local index    = data.current.value
                    local Comp     = currentFactionData.appearance.heritages[gender][__SKINCOLOR]
                    local compType = tonumber("0x" .. Comp[data.current.tag][index])

                    if data.current.tag == "Body" then
                        PlayerSkin["Torso"] = compType
                    else
                        PlayerSkin[data.current.tag] = compType
                    end
                    ApplyComponentToPed(__player, compType)
                end
            end

            if data.current.tag == "waist" then --* remove component variation
                if data.current.value > 0 then
                    local Waist = data.current.comp[data.current.value]
                    Citizen.InvokeNative(0x1902C4CFCC5BE57C, __player, Waist)
                    UpdateVariation(__player)
                    PlayerSkin.Waist = Waist
                end
            end
            if data.current.tag == "body" then -- * component type
                if data.current.value > 0 then
                    local Body = Config.BodyType.Body[data.current.value]
                    Citizen.InvokeNative(0x1902C4CFCC5BE57C, __player, Body)
                    UpdateVariation(__player)
                    PlayerSkin.Body = Body
                end
            end
        end, function(data, menu)

        end)
end

-- * Heritage Menu
function OpenHerritageMenu(table)
    MenuData.CloseAll()
    local elements = {}
    local __player = PlayerPedId()
    local gender = GetGender()
    local selectedHeritageData = currentFactionData.appearance.heritages[gender][heritageIndex];

    elements[#elements + 1] = {
        -- heritage
        label = T.MenuHeritage.element.label .. ": " .. selectedHeritageData.label,
        type = "slider",
        value = heritageIndex,
        info = currentFactionData.appearance.heritages[gender],
        min = 1,
        max = #currentFactionData.appearance.heritages[gender],
        desc = T.MenuHeritage.element.desc .. #currentFactionData.appearance.heritages[gender] .. ' ' .. T.MenuHeritage.element.desc2,
        tag = "heritage"
    }

    elements[#elements + 1] = {
        -- face type
        label = T.MenuHeritage.element2.label .. #selectedHeritageData.Heads,
        type = "slider",
        value = 0,
        info = nil,
        comp = selectedHeritageData.Heads,
        min = 0,
        max = #selectedHeritageData.Heads, -- get color index and update when component changes
        desc = T.MenuHeritage.element3.desc ..
            #selectedHeritageData.Heads .. ' ' .. T.MenuHeritage.element3.desc2,
        tag = "color"
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuHeritage.title,
            subtext = T.MenuHeritage.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenAppearanceMenu"
        },

        function(data, menu)
            if (data.current == "backup") then
                _G[data.trigger](table)
            end

            --case for removing heritage, index 0/-1 this isn't used anymore since the heritages are obligatory now
            -- if data.current.tag == "heritage" and not data.current.info then --* remove component variation
            --     if data.current.value < 1 then
            --         if data.current.value ~= 0 then
            --             local Heads = tonumber("0x" .. data.current.comp[data.current.value])
            --             Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, Heads, true, true,
            --                 true)
            --             UpdateVariation(__player)
            --             PlayerSkin.HeadType = Heads
            --         end
            --     end
            -- end


            if data.current.tag == "color" and not data.current.info then -- * component varitaion
                if data.current.value > 0 then
                    local Heads = tonumber("0x" .. data.current.comp[data.current.value])
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, Heads, true, true,
                        true)
                    UpdateVariation(__player)
                    PlayerSkin.HeadType = Heads
                end
            end

            if data.current.tag == "color" then --* remove component type
                if data.current.value < 1 then
                    if data.current.value ~= 0 then
                        local Heads = tonumber("0x" .. data.current.comp[data.current.value])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, Heads, true, true,
                            true)
                        UpdateVariation(__player)
                        PlayerSkin.HeadType = Heads
                    end
                end
            end

            if data.current.tag == "heritage" and data.current.info then -- * component type
                if data.current.value > 0 then
                    -- change heritage and skin color
                    local index = data.current.value
                    selectedHeritageData = currentFactionData.appearance.heritages[gender][index]

                    SetHeritage(index)

                    -- update menu elements
                    local elements1           = {}
                    elements1[#elements1 + 1] = {
                        -- heritage
                        label = T.MenuHeritage.element.label .. ": " .. selectedHeritageData.label,
                        type = "slider",
                        value = data.current.value,
                        info = data.current.info,
                        min = 1,
                        max = #data.current.info,
                        desc = data.current.desc,
                        tag = "heritage"
                    }

                    elements1[#elements1 + 1] = {
                        -- skin color
                        label = T.MenuHeritage.element2.label .. #data.current.info[data.current.value].Heads,
                        type = "slider",
                        value = 0,
                        info = nil,
                        comp = data.current.info[data.current.value].Heads,
                        min = 0,
                        max = #data.current.info[data.current.value].Heads, -- get color index and update when component changes
                        desc = T.MenuHeritage.element3.desc ..
                            #data.current.info[data.current.value].Heads .. ' ' .. T.MenuHeritage.element3.desc2,
                        tag = "color"
                    }

                    menu.setElements(elements1)
                    menu.refresh()
                end
            end
        end, function(data, menu)

        end)
end

--* Hair menu
function OpenHairMenu(table)
    MenuData.CloseAll()

    local elements = {
        {
            label = T.MenuHair.element.label,
            value = "Hair",
            desc = imgPath:format("character_creator_hair") .. "<br>" .. T.MenuHair.element.desc,
        }
    }

    if GetGender() == "Male" then
        elements[#elements + 1] = {
            label = T.MenuHair.element2.label,
            value = "Beard",
            desc = imgPath:format("character_creator_facial_hair") .. "<br>" .. T.MenuHair.element2.desc
        }
        elements[#elements + 1] = {
            label = T.MenuHair.element3.label,
            value = "beardstabble",
            desc = imgPath:format("character_creator_facial_hair") .. "<br>" .. T.MenuHair.element3.desc
        }
    else
        elements[#elements + 1] = {
            label = T.MenuHair.element4.label,
            value = "bow",
            desc = T.MenuHair.element4.desc
        }
    end
    elements[#elements + 1] = {
        label = T.MenuHair.element5.label,
        value = "eyebrows",
        desc = imgPath:format("character_creator_eyebrows") .. "<br>" .. T.MenuHair.element5.desc
    }
    elements[#elements + 1] = {
        label = T.MenuHair.element6.label,
        value = "hair",
        desc = imgPath:format("character_creator_hair") .. "<br>" .. T.MenuHair.element6.desc
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuHair.title,
            subtext = T.MenuHair.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenAppearanceMenu"
        },

        function(data, menu)
            --* Go back
            if (data.current == "backup") then -- go back
                _G[data.trigger](table)
            end

            if (data.current.value == "Hair") then
                GetHair(GetGender(), "hair")
                Wait(100)
                local label = data.current.label
                OpenHairSelectionMenu(TableHair, table, label, data.current.value)
            end
            if (data.current.value == "bow") then
                GetHair(GetGender(), "bow")
                Wait(100)
                local label = data.current.label
                OpenHairSelectionMenu(TableHair, table, label, data.current.value)
            end
            if (data.current.value == "Beard") then
                GetHair("Male", "beard")
                local label = data.current.label
                Wait(100)
                OpenHairSelectionMenu(TableHair, table, label, data.current.value)
            end

            if (data.current.value == "eyebrows") then
                local label = data.current.label
                OpenBeardEyebrowMenu(table, "eyebrows_opacity", "eyebrows_tx_id", "eyebrows", 1,
                    label, "eyebrows_color")
            end

            if (data.current.value == "hair") then
                local label = data.current.label
                OpenBeardEyebrowMenu(table, "hair_opacity", "hair_tx_id", "hair", 4,
                    label, "hair_color_primary")
            end

            if (data.current.value == "beardstabble") then
                local label = data.current.label
                OpenBeardEyebrowMenu(table, "beardstabble_opacity", "beardstabble_tx_id", "beardstabble", 7,
                    label, "beardstabble_color_primary")
            end
        end,
        function(data, menu)

        end)
end

--* Hair menu
function OpenHairSelectionMenu(tablehair, table, label, category)
    MenuData.CloseAll()
    local __player = PlayerPedId()
    local elements = {
        {
            label = T.MenuHairSelection.element.label .. label,
            type = "slider",
            value = 0,
            info = tablehair, -- table of all components will need an index to get hex value
            min = 0,
            max = #tablehair, -- quantity of components
            desc = T.MenuHairSelection.element.desc .. #tablehair .. ' ' .. T.MenuHairSelection.element.desc2 .. label,
            tag = "component",
        },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuHairSelection.title,
            subtext = T.MenuHairSelection.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenHairMenu"
        },

        function(data, menu)
            --* Go back
            if (data.current == "backup") then -- go back
                _G[data.trigger](table)
            end

            if data.current.value then
                if data.current.value < 1 and data.current.tag == "color" then --* remove component variation
                    Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList[category], 0)
                    UpdateVariation(__player)
                    if category == "bow" then
                        PlayerClothing[category] = -1
                    else
                        PlayerSkin[category] = -1
                    end
                end

                if data.current.value > 0 and data.current.tag == "color" then -- * component varitaion
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, data.current.comp[data.current.value], true, true,
                        true)
                    UpdateVariation(__player)
                    if category == "bow" then
                        PlayerClothing[category] = data.current.comp[data.current.value]
                    else
                        PlayerSkin[category] = data.current.comp[data.current.value]
                    end
                end

                if data.current.tag == "component" and data.current.value < 1 then --* remove component type
                    Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList[category], 0)
                    UpdateVariation(__player)
                    if category == "bow" then
                        PlayerClothing[category] = -1
                    else
                        PlayerSkin[category] = -1
                    end
                end


                if data.current.tag == "component" and data.current.value > 0 and data.current.info then -- * component type
                    local __COMP
                    local elements1 = {}
                    -- get right component
                    for key, value in pairs(tablehair[data.current.value]) do
                        if #tablehair[data.current.value] == key then
                            __COMP = value
                            break
                        end
                    end

                    elements1[#elements1 + 1] = {
                        label = data.current.label,
                        type = "slider",
                        value = data.current.value,
                        info = tablehair,
                        min = 0,
                        max = #tablehair,
                        desc = data.current.desc,
                        tag = "component"
                    }

                    elements1[#elements1 + 1] = {
                        label = T.MenuHairSelection.element2.label .. #tablehair[data.current.value],
                        type = "slider",
                        value = 0,
                        info = nil,
                        comp = tablehair[data.current.value],
                        min = 0,
                        max = #tablehair[data.current.value],
                        desc = T.MenuHairSelection.element2.desc ..
                            #tablehair[data.current.value] .. ' ' .. T.MenuHairSelection.element2.desc2,
                        tag = "color"
                    }
                    menu.setElements(elements1)
                    menu.refresh()
                    if category == "bow" then
                        PlayerClothing[category] = __COMP
                        ApplyComponentToPed(__player, __COMP)
                    else
                        PlayerSkin[category] = __COMP
                        ApplyComponentToPed(__player, __COMP)
                    end
                end
            end
        end, function(data, menu)

        end)
end

--* Beard menu and eye brow
function OpenBeardEyebrowMenu(table, opacity, txt_id, category, index, label, color)
    MenuData.CloseAll()
    local elements = {
        {
            label = label,
            type = "slider",
            tag = "type",
            min = 0,
            value = 0,
            comp = Config.overlay_all_layers,
            compname = Config.overlay_all_layers[index].name,
            max = #Config.overlays_info[category],
            desc = T.MenuBeardEyeBrows.element.desc,
            color = color,
            txt_id = txt_id,
            opac = opacity,
            category = category
        },

        {
            label = T.MenuBeardEyeBrows.element2.label,
            type = "slider",
            tag = "color",
            value = 0,
            comp = Config.color_palettes[category],
            min = 0,
            max = #Config.color_palettes[category],
            desc = T.MenuBeardEyeBrows.element2.desc,
            color = color,
            txt_id = txt_id,
            opac = opacity,
            category = category
        },
        {
            label = T.MenuBeardEyeBrows.element3.label,
            type = "slider",
            tag = "opacity",
            value = 0,
            comp = Config.overlay_all_layers,
            min = 0,
            max = 10,
            desc = T.MenuBeardEyeBrows.element3.desc,
            color = color,
            txt_id = txt_id,
            opac = opacity,
            category = category
        }

    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuBeardEyeBrows.title,
            subtext = T.MenuBeardEyeBrows.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenHairMenu"
        },

        function(data, menu)
            --* Go back
            if (data.current == "backup") then
                _G[data.trigger](table)
            end

            if data.current.tag == "type" then
                --* texture id
                if category == "beardstabble" then
                    PlayerSkin.beardstabble_visibility = 1
                end
                if category == "eyebrows" then
                    PlayerSkin.eyebrows_visibility = 1
                end
                if category == "hair" then
                    PlayerSkin.hair_visibility = 1
                end
                PlayerSkin[data.current.txt_id] = data.current.value
                toggleOverlayChange(data.current.category, 1, PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], 0, 0, 1, PlayerSkin[data.current.opac], PlayerSkin.albedo)
            end

            if data.current.tag == "color" then
                --* color
                PlayerSkin[data.current.color] = data.current.comp[data.current.value]
                toggleOverlayChange(data.current.category, 1, PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], 0, 0, 1, PlayerSkin[data.current.opac], PlayerSkin.albedo)
            end

            if data.current.tag == "opacity" then
                if data.current.value > 0.2 then
                    if category == "beardstabble" then
                        PlayerSkin.beardstabble_visibility = 1
                    end
                    if category == "eyebrows" then
                        PlayerSkin.eyebrows_visibility = 1
                    end
                else
                    if category == "beardstabble" then
                        PlayerSkin.beardstabble_visibility = 0
                    end
                    if category == "eyebrows" then
                        PlayerSkin.eyebrows_visibility = 0
                    end
                    if category == "hair" then
                        PlayerSkin.hair_visibility = 0
                    end
                end
                --* opacity
                PlayerSkin[data.current.opac] = data.current.value / 10
                toggleOverlayChange(data.current.category, 1, PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], 0, 0, 1, PlayerSkin[data.current.opac], PlayerSkin.albedo)
            end
        end, function(data, menu)

        end)
end

--* animation open eyes open mouth
local function __StartAnimation(anim)
    local __player = PlayerPedId()
    while not HasAnimDictLoaded("FACE_HUMAN@GEN_MALE@BASE") do
        RequestAnimDict("FACE_HUMAN@GEN_MALE@BASE")
        Citizen.Wait(50)
    end

    if not IsEntityPlayingAnim(__player, "FACE_HUMAN@GEN_MALE@BASE", anim, 3) then
        TaskPlayAnim(__player, "FACE_HUMAN@GEN_MALE@BASE", anim, 1090519040,
            -4, -1, 17, 0, 0, 0, 0, 0, 0)
    end
    RemoveAnimDict("FACE_HUMAN@GEN_MALE@BASE")
end

--* Face features menu
function OpenFaceMenu(table)
    MenuData.CloseAll()

    local __player = PlayerPedId()
    local gender = GetGender()
    local elements = {
        {
            label = T.MenuFacial.element.label,
            value = 0,
            type = "slider",
            max = #Config.Eyes[gender],
            min = 0,
            tag = "eyes",
            desc = imgPath:format("character_creator_eyes") .. "<br>" .. T.MenuFacial.element.desc,
        },
        {
            label = T.MenuFacial.element2.label,
            value = 0,
            type = "slider",
            min = -1,
            max = #Config.Teeth[gender],
            tag = "teeth",
            desc = imgPath:format("character_creator_teeth") .. "<br>" .. T.MenuFacial.element2.desc,
        },

        {
            label = T.MenuFacial.element3.label,
            value = 0,
            tag = "jaw",
            desc = imgPath:format("character_creator_jaw") .. "<br>" .. T.MenuFacial.element3.desc,
            option = "facefeatures",
            img = "character_creator_jaw"
        },
        {
            label = T.MenuFacial.element4.label,
            value = 0,
            tag = "chin",
            desc = imgPath:format("character_creator_jaw") .. "<br>" .. T.MenuFacial.element4.desc,
            option = "facefeatures",
            img = "character_creator_jaw"
        },
        {
            label = T.MenuFacial.element5.label,
            value = "life",
            tag = "head",
            desc = imgPath:format("character_creator_cranial_proportions") .. "<br>" .. T.MenuFacial.element5.desc,
            option = "facefeatures",
            img = "character_creator_cranial_proportions"
        },

        {
            label = T.MenuFacial.element6.label,
            value = "life",
            tag = "nose",
            desc = imgPath:format("character_creator_nose") .. "<br>" .. T.MenuFacial.element6.desc,
            option = "facefeatures",
            img = "character_creator_nose"
        },
        {
            label = T.MenuFacial.element7.label,
            value = "life",
            tag = "ears",
            desc = imgPath:format("character_creator_ears") .. "<br>" .. T.MenuFacial.element7.desc,
            option = "facefeatures",
            img = "character_creator_ears"
        },
        {
            label = T.MenuFacial.element8.label,
            value = "life",
            tag = "mouthandlips",
            desc = imgPath:format("character_creator_mouth") .. "<br>" .. T.MenuFacial.element8.desc,
            option = "facefeatures",
            img = "character_creator_mouth"
        },

        {
            label = T.MenuFacial.element9.label,
            value = "life",
            tag = "cheek",
            desc = imgPath:format("character_creator_cheeks") .. "<br>" .. T.MenuFacial.element9.desc,
            option = "facefeatures",
            img = "character_creator_cheeks"
        },
        {
            label = T.MenuFacial.element10.label,
            value = "life",
            tag = "eyesandbrows",
            desc = imgPath:format("character_creator_eyebrows") .. "<br>" .. T.MenuFacial.element10.desc,
            option = "facefeatures",
            img = "character_creator_eyebrows"
        },

    }


    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuFacial.title,
            subtext = T.MenuFacial.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenAppearanceMenu"
        },

        function(data, menu)
            --*Go back
            if (data.current == "backup") then
                ClearPedTasks(__player, true)
                _G[data.trigger](table)
            end

            if data.current.tag == "eyes" then
                __StartAnimation("mood_normal_eyes_wide")

                PlayerSkin.Eyes = Config.Eyes[gender][data.current.value]
                Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, PlayerSkin.Eyes, true, true, true)
                UpdateVariation(__player)
            end

            if data.current.tag == "teeth" then
                if data.current.value > 0 then
                    __StartAnimation("Face_Dentistry_Loop")
                    PlayerClothing.Teeth = Config.Teeth[gender][data.current.value].hash
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, PlayerClothing.Teeth, true, true, true)
                    UpdateVariation(__player)
                else
                    ClearPedTasks(__player, true)
                    PlayerClothing.Teeth = -1
                    Citizen.InvokeNative(0xD710A5007C2AC539, __player, 0x96EDAE5C, 0)
                    UpdateVariation(__player)
                end
            end

            if data.current.option == "facefeatures" then
                OpenFaceModificationMenu(table, data.current.tag, data.current.img)
            end
        end, function(data, menu)

        end)
end

--todo menu images
--* Face modification menu
function OpenFaceModificationMenu(table, comp, img)
    MenuData.CloseAll()
    local elements = {}
    local __player = PlayerPedId()

    for key, value in pairs(Config.FaceFeatures[comp]) do
        -- *Face modifications
        elements[#elements + 1] = {
            label = key,
            value = PlayerSkin[value.comp],
            type = "slider",
            min = -0.9,
            max = 0.9,
            hop = 0.1,
            define = 1,
            comp = value.comp,
            hash = value.hash,
            desc = imgPath:format(img) .. "<br>" .. T.MenuFaceModify.element.desc .. PlayerSkin[value.comp],
            tag = key
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuFaceModify.title,
            subtext = T.MenuFaceModify.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenFaceMenu"
        },

        function(data, menu)
            --* Go back
            if (data.current == "backup") then
                _G[data.trigger](table)
            end
            -- *Face modifications
            if data.current.tag then
                PlayerSkin[data.current.comp] = data.current.value
                Citizen.InvokeNative(0x5653AB26C82938CF, __player, data.current.hash, PlayerSkin[data.current.comp])
                UpdateVariation(__player)
            end
        end, function(data, menu)

        end)
end

local function getLifeStyleTextureMinMax(searchKey)
    local min = 0
    local max = #Config.overlays_info[searchKey]

    if (
            currentFactionData.appearance.lifeStyle ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey] ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].texture ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].texture.min ~= nil
        ) then
        min = currentFactionData.appearance.lifeStyle[searchKey].texture.min
        print("LOCKING MIN TXT "..searchKey.." TO "..min)
    end

    if (
            currentFactionData.appearance.lifeStyle ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey] ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].texture ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].texture.max ~= nil
        ) then
        max = currentFactionData.appearance.lifeStyle[searchKey].texture.max
        print("LOCKING MAX TXT " .. searchKey .. " TO " .. max)
    end

    return min, max
end

local function getLifeStyleOpacityMinMax(searchKey)
    local min = 0
    local max = 10

    if (
            currentFactionData.appearance.lifeStyle ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey] ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].opacity ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].opacity.min ~= nil
        ) then
        min = currentFactionData.appearance.lifeStyle[searchKey].opacity.min
        print("LOCKING MIN OPACITY "..searchKey.." TO "..min)
    end

    if (
            currentFactionData.appearance.lifeStyle ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey] ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].opacity ~= nil
            and currentFactionData.appearance.lifeStyle[searchKey].opacity.max ~= nil
        ) then
        max = currentFactionData.appearance.lifeStyle[searchKey].opacity.max
        print("LOCKING MAX OPACITY " .. searchKey .. " TO " .. max)
    end

    return min, max
end

--* Life Style Menu
function OpenLifeStyleMenu(table)
    MenuData.CloseAll()
    local elements = {}

    for key, value in pairs(Config.overlays_info) do
        local minOpacity, maxOpacity = getLifeStyleOpacityMinMax(key)
        local minTexture, maxTexture = getLifeStyleTextureMinMax(key)
        if LifeStyleLabelLookup[key] then
            -- *texture
            elements[#elements + 1] = {
                label = LifeStyleLabelLookup[key].label,
                value = PlayerSkin[LifeStyleLabelLookup[key].txt_id],
                min = minTexture,
                max = maxTexture,
                type = "slider",
                txt_id = LifeStyleLabelLookup[key].txt_id,
                opac = LifeStyleLabelLookup[key].opacity,
                visibility = LifeStyleLabelLookup[key].vis,
                desc = T.MenuLifeStyle.element.desc,
                name = key,
                tag = "texture"
            }
            --* opacity
            elements[#elements + 1] = {
                label = LifeStyleLabelLookup[key].label .. " (" .. T.MenuLifeStyle.opacityLabel..")",
                value = PlayerSkin[LifeStyleLabelLookup[key].opacity]*10,
                min = minOpacity,
                max = maxOpacity,
                type = "slider",
                txt_id = LifeStyleLabelLookup[key].txt_id,
                opac = LifeStyleLabelLookup[key].opacity,
                visibility = LifeStyleLabelLookup[key].vis,
                desc = T.MenuLifeStyle.desc,
                name = key,
                tag = "opacity"
            }
        end
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuLifeStyle.title,
            subtext = T.MenuLifeStyle.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenAppearanceMenu"
        },

        function(data, menu)
            -- *Go back
            if (data.current == "backup") then
                _G[data.trigger](table)
            end

            --* Texture
            if data.current.tag == "texture" then
                SetLifestyleTexture(data.current.name, data.current.value)
            end

            --* Opacity
            if data.current.tag == "opacity" then
                SetLifestyleOpacity(data.current.name, data.current.value)
            end
        end, function(data, menu)

        end)
end

local overlayLookup = {
    lipsticks = {
        label = T.MenuMakeup.element.label,
        txt_id = "lipsticks_tx_id",
        color = "lipsticks_palette_color_primary",
        color2 = "lipsticks_palette_color_secondary",
        color3 = "lipsticks_palette_color_tertiary",
        variant = "lipsticks_palette_id",
        varvalue = 7,
        opacity = "lipsticks_opacity",
        visibility = "lipsticks_visibility"
    },
    blush = {
        label = T.MenuMakeup.element2.label,
        txt_id = "blush_tx_id",
        color = "blush_palette_color_primary",
        opacity = "blush_opacity",
        visibility = "blush_visibility"
    },
    eyeliners = {
        label = T.MenuMakeup.element3.label,
        txt_id = "eyeliner_tx_id",
        variant = "eyeliner_palette_id",
        varvalue = 15,
        color = "eyeliner_color_primary",
        opacity = "eyeliner_opacity",
        visibility = "eyeliner_visibility"
    },
    shadows = {
        label = T.MenuMakeup.element4.label,
        txt_id = "shadows_tx_id",
        color = "shadows_palette_color_primary",
        color2 = "shadows_palette_color_secondary",
        color3 = "shadows_palette_color_tertiary",
        variant = "shadows_palette_id",
        varvalue = 5,
        opacity = "shadows_opacity",
        visibility = "shadows_visibility"
    },
}

function OpenMakeupMenu(table)
    MenuData.CloseAll()
    local elements = {}

    for key, value in pairs(Config.overlays_info) do
        if overlayLookup[key] then
            -- *texture
            elements[#elements + 1] = {
                label = overlayLookup[key].label .. ' ' .. T.MenuMakeup.element5.label,
                value = PlayerSkin[overlayLookup[key].txt_id],
                min = 0,
                max = #value,
                type = "slider",
                txt_id = overlayLookup[key].txt_id,
                opac = overlayLookup[key].opacity,
                color = overlayLookup[key].color,
                variant = overlayLookup[key].variant,
                visibility = overlayLookup[key].visibility,
                desc = T.MenuMakeup.element5.desc,
                name = key,
                tag = "texture"
            }
            --*Color
            local ColorValue = 0
            for x, color in pairs(Config.color_palettes[key]) do
                if joaat(color) == PlayerSkin[overlayLookup[key].color] then
                    ColorValue = x
                end
            end

            elements[#elements + 1] = {
                label = overlayLookup[key].label .. ' ' .. T.MenuMakeup.element6.label,
                value = ColorValue,
                min = 0,
                max = 10,
                comp = Config.color_palettes[key],
                type = "slider",
                txt_id = overlayLookup[key].txt_id,
                opac = overlayLookup[key].opacity,
                color = overlayLookup[key].color,
                visibility = overlayLookup[key].visibility,
                variant = overlayLookup[key].variant,
                desc = T.MenuMakeup.element6.desc,
                name = key,
                tag = "color"
            }

            -- if key == "lipsticks" or key == "eyeliners" then
            if key == "lipsticks" then
                local Color2Value = 0
                for x, color in pairs(Config.color_palettes[key]) do
                    if joaat(color) == PlayerSkin[overlayLookup[key].color2] then
                        Color2Value = x
                    end
                end

                --*Color 2
                elements[#elements + 1] = {
                    label = overlayLookup[key].label .. ' ' .. T.MenuMakeup.element7.label,
                    value = Color2Value,
                    min = 0,
                    max = 10,
                    type = "slider",
                    comp = Config.color_palettes[key],
                    txt_id = overlayLookup[key].txt_id,
                    opac = overlayLookup[key].opacity,
                    color = overlayLookup[key].color,
                    color2 = overlayLookup[key].color2,
                    color3 = overlayLookup[key].color3,
                    variant = overlayLookup[key].variant,
                    visibility = overlayLookup[key].visibility,
                    desc = T.MenuMakeup.element7.desc,
                    name = key,
                    tag = "color2"
                }
            end

            if key == "lipsticks" or key == "shadows" or key == "eyeliners" then
                --*Variant
                elements[#elements + 1] = {
                    label = overlayLookup[key].label .. ' ' .. T.MenuMakeup.element8.label,
                    value = PlayerSkin[overlayLookup[key].variant] or 0,
                    min = 0,
                    max = overlayLookup[key].varvalue,
                    type = "slider",
                    comp = Config.color_palettes[key],
                    txt_id = overlayLookup[key].txt_id,
                    opac = overlayLookup[key].opacity,
                    color = overlayLookup[key].color,
                    color2 = overlayLookup[key].color2,
                    color3 = overlayLookup[key].color3,
                    variant = overlayLookup[key].variant,
                    visibility = overlayLookup[key].visibility,
                    desc = T.MenuMakeup.element8.desc,
                    name = key,
                    tag = "variant"
                }
            end

            --* opacity
            elements[#elements + 1] = {
                label = overlayLookup[key].label .. ' ' .. T.MenuMakeup.element9.label,
                value = PlayerSkin[overlayLookup[key].opacity],
                min = 0,
                max = 0.9,
                hop = 0.1,
                type = "slider",
                txt_id = overlayLookup[key].txt_id,
                opac = overlayLookup[key].opacity,
                color = overlayLookup[key].color,
                variant = overlayLookup[key].variant,
                visibility = overlayLookup[key].visibility,
                desc = T.MenuMakeup.element9.desc,
                name = key,
                tag = "opacity"
            }
        end
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = T.MenuMakeup.title,
            subtext = T.MenuMakeup.subtitle,
            align = Config.Align,
            elements = elements,
            lastmenu = "OpenAppearanceMenu"
        },

        function(data, menu)
            --* Go back
            if (data.current == "backup") then
                _G[data.trigger](table)
            end

            if data.current.tag == "texture" then
                --* texture id
                if data.current.value <= 0 then
                    PlayerSkin[data.current.visibility] = 0
                else
                    PlayerSkin[data.current.visibility] = 1
                end
                PlayerSkin[data.current.txt_id] = data.current.value
                toggleOverlayChange(data.current.name, PlayerSkin[data.current.visibility],
                    PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], PlayerSkin[data.current.color2] or 0,
                    PlayerSkin[data.current.color3] or 0, PlayerSkin[data.current.variant] or 1,
                    PlayerSkin[data.current.opac], PlayerSkin.albedo)
            end

            if data.current.tag == "color" then
                --* color
                PlayerSkin[data.current.color] = data.current.comp[data.current.value]
                toggleOverlayChange(data.current.name, PlayerSkin[data.current.visibility],
                    PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], PlayerSkin[data.current.color2] or 0,
                    PlayerSkin[data.current.color3] or 0, PlayerSkin[data.current.variant] or 1,
                    PlayerSkin[data.current.opac], PlayerSkin.albedo)
            end

            if data.current.tag == "color2" then
                --* color secondary
                PlayerSkin[data.current.color2] = data.current.comp[data.current.value]
                toggleOverlayChange(data.current.name, PlayerSkin[data.current.visibility],
                    PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], PlayerSkin[data.current.color2] or 0,
                    PlayerSkin[data.current.color3] or 0, PlayerSkin[data.current.variant] or 1, PlayerSkin
                    [data.current.opac], PlayerSkin.albedo)
            end

            if data.current.tag == "variant" then
                --* variant
                PlayerSkin[data.current.variant] = data.current.value
                toggleOverlayChange(data.current.name, PlayerSkin[data.current.visibility],
                    PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], PlayerSkin[data.current.color2] or 0,
                    PlayerSkin[data.current.color3] or 0, PlayerSkin[data.current.variant] or 1,
                    PlayerSkin[data.current.opac], PlayerSkin.albedo)
            end

            if data.current.tag == "opacity" then
                --* opacity
                if data.current.value <= 0 then
                    PlayerSkin[data.current.visibility] = 0
                else
                    PlayerSkin[data.current.visibility] = 1
                end

                PlayerSkin[data.current.opac] = data.current.value
                toggleOverlayChange(data.current.name, PlayerSkin[data.current.visibility],
                    PlayerSkin[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, PlayerSkin[data.current.color], PlayerSkin[data.current.color2] or 0,
                    PlayerSkin[data.current.color3] or 0, PlayerSkin[data.current.variant] or 1,
                    PlayerSkin[data.current.opac], PlayerSkin.albedo)
            end
        end, function(data, menu)

        end)
end
