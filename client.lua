Citizen.CreateThread(function()
    lib.requestModel(Config.Ped)
    local coords = Config.Coords
    local Cityhall = CreatePed(0, Config.Ped, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
    lib.requestAnimDict("amb@world_human_stand_guard@male@idle_a")
    TaskPlayAnim(Cityhall, "amb@world_human_stand_guard@male@idle_a", "idle_b", 8.0, 8.0, -1, 9, 0, false, false, false)
    FreezeEntityPosition(Cityhall, true)
    SetEntityInvincible(Cityhall, true)
    SetBlockingOfNonTemporaryEvents(Cityhall1, true)
    local options = {
        {
            name = 'cityhall',
            icon = 'fas fa-id-card',
            label = "City Hall",
            coords = coords,
            onSelect = function()
                TriggerEvent('scarcityhall:mainmenu')
            end,
        }
    }
    exports.ox_target:addLocalEntity(Cityhall, options)
end)

RegisterNetEvent('scarcityhall:mainmenu', function()
    lib.registerContext({
        id = 'mainmenu',
        title = 'City Hall',
        location = 'middle',
        options = {
            { 
                title = 'Licenses',
                icon = 'id-card',
                disabled = false,
                onSelect = function()
                    TriggerEvent('scarcityhall:licensemenu')
                end
            },
            { 
                title = 'Jobs',
                icon = 'briefcase',
                disabled = false,
                onSelect = function()
                    TriggerEvent('scarcityhall:jobmenu')
                end
            },
        }
    })
    lib.showContext('mainmenu')
end)

RegisterNetEvent('scarcityhall:licensemenu', function()
    lib.registerContext({
        id = 'licensemenu',
        title = 'Licenses',
        location = 'middle',
        options = {
            { 
                title = 'Purchase A New ID',
                icon = 'id-card', 
                disabled = false,
                onSelect = function()
                    TriggerServerEvent('scarcityhall:newid')
                end,
                metadata = { 
                    {label = '$', value = 25}
                }
            },
            { 
                title = 'Request Drivers License',
                icon = 'id-card',
                disabled = false,
                onSelect = function()
                    TriggerServerEvent('scarcityhall:newlicense')
                end,
                metadata = { 
                    {label = '$', value = 50}
                }
            },
            { 
                title = 'Request Weapon License',
                icon = 'id-card',
                disabled = false,
                onSelect = function()
                    TriggerServerEvent('scarcityhall:newweaponlicense')
                end,
                metadata = { 
                    {label = '$', value = 100}
                }
            },
            { 
                title = 'Return',
                icon = 'arrow-left',
                disabled = false,
                onSelect = function()
                    TriggerEvent('scarcityhall:mainmenu')
                end,
            },
		},
    })
    lib.showContext('licensemenu')
end)

RegisterNetEvent('scarcityhall:jobmenu', function()
    lib.registerContext({
        id = 'jobmenu',
        title = 'Jobs',
        location = 'middle',
        options = {
            { 
                title = 'Taxi Driver',
                icon = 'car',
                disabled = false,
                onSelect = function()
                    TriggerServerEvent('scarcityhall:applytaxijob')
                end,
                metadata = { 
                    {label = 'Hourly $', value = 1500}
                }
            },
            { 
                title = 'Tow Truck Driver',
                icon = 'truck',
                disabled = false,
                onSelect = function()
                    TriggerServerEvent('scarcityhall:applytowjob')
                end,
                metadata = { 
                    {label = 'Hourly $', value = 1500}
                }
            },
            { 
                title = 'Recycle Driver',
                icon = 'trash',
                disabled = false,
                onSelect = function()
                    TriggerServerEvent('scarcityhall:applygarbagejob')
                end,
                metadata = { 
                    {label = 'Hourly $', value = 1500}
                }
            },
            { 
                title = 'Return',
                icon = 'arrow-left',
                disabled = false,
                onSelect = function()
                    TriggerEvent('scarcityhall:mainmenu')
                end,
            },
        }
    })
    lib.showContext('jobmenu')
end)