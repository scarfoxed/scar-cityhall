QBCore = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('scarcityhall:newid')
AddEventHandler('scarcityhall:newid', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ox_inventory = exports.ox_inventory
    local cancarry = ox_inventory:CanCarryItem(src, Config.IDCard, 1) -- here incase your id has weight for whatever reason
    local hasmoney = ox_inventory:Search(src, 'count', 'money')
    local metadata = {
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        dob = Player.PlayerData.charinfo.birthdate,
        gender = Player.PlayerData.charinfo.gender == 0 and 'Male' or 'Female',
        nationality = Player.PlayerData.charinfo.nationality,
    }

    if hasmoney > Config.IDCost then
        if cancarry then
            ox_inventory:RemoveItem(src, 'money', Config.IDCost)
            ox_inventory:AddItem(src, Config.IDCard, 1, {
                description = 
                'Name: '.. metadata.firstname .. ' ' .. metadata.lastname ..
                '\n\n Date of Birth: ' .. metadata.dob ..
                '\n\n Gender: ' .. metadata.gender ..
                '\n\n Nationality: ' .. metadata.nationality
            })
        elseif not cancarry then
            lib.notify(src,{ description = 'You cant carry this', type = 'error'})
        end
    elseif hasmoney < Config.IDCost then
        lib.notify(src,{ description = 'Not enough cash', type = 'error'})
    end
end)

RegisterServerEvent('scarcityhall:newlicense')
AddEventHandler('scarcityhall:newlicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ox_inventory = exports.ox_inventory
    local cancarry = ox_inventory:CanCarryItem(src, Config.DrivingLicense, 1)-- here incase your license has weight for whatever reason
    local hasmoney = ox_inventory:Search(src, 'count', 'money')
    local license = Player.PlayerData.metadata["licences"].driver -- license metadata qbcore
    local metadata = {
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        dob = Player.PlayerData.charinfo.birthdate,
        gender = Player.PlayerData.charinfo.gender == 0 and 'Male' or 'Female',
        id = Player.PlayerData.citizenid,
        nationality = Player.PlayerData.charinfo.nationality,
    }
    if hasmoney > Config.DrivingLicenseCost then
        if cancarry then
            if license then
                ox_inventory:RemoveItem(src, 'money', Config.DrivingLicenseCost)
                ox_inventory:AddItem(src, Config.DrivingLicense, 1, {
                    description = 'Name: '.. metadata.firstname .. ' ' .. metadata.lastname ..
                    '\n\n Date of Birth: ' .. metadata.dob .. 
                    '\n\n Gender: ' .. metadata.gender .. 
                    '\n\n Citizen ID: ' .. metadata.id ..  
                    '\n\n Nationality: ' .. metadata.nationality
                })
            elseif not license then
                lib.notify(src, { description = 'Your license is revoked or you dont have one', type = 'error'})
            end
        elseif not cancarry then
            lib.notify(src,{ description = 'You cant carry this', type = 'error'})
        end
    elseif hasmoney < Config.DrivingLicenseCost then
        lib.notify(src,{ description = 'Not enough cash', type = 'error'})
    end
end)

RegisterServerEvent('scarcityhall:newweaponlicense')
AddEventHandler('scarcityhall:newweaponlicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ox_inventory = exports.ox_inventory
    local cancarry = ox_inventory:CanCarryItem(src, Config.DrivingLicense, 1)-- here incase your license has weight for whatever reason
    local hasmoney = ox_inventory:Search(src, 'count', 'money')
    local license = Player.PlayerData.metadata["licences"].weaponr -- license metadata qbcore
    local metadata = {
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        dob = Player.PlayerData.charinfo.birthdate,
        gender = Player.PlayerData.charinfo.gender == 0 and 'Male' or 'Female',
        id = Player.PlayerData.citizenid,
    }
    if hasmoney > Config.WeaponLicenseCost then
        if cancarry then
            if license then
                ox_inventory:RemoveItem(src, 'money', Config.WeaponLicenseCost)
                ox_inventory:AddItem(src, Config.WeaponLicense, 1, {
                    description = 'Name: '.. metadata.firstname .. ' ' .. metadata.lastname ..
                    '\n\n Date of Birth: ' .. metadata.dob ..
                    '\n\n Gender: ' .. metadata.gender ..
                    '\n\n Citizen ID: ' .. metadata.id
                })
            elseif not license then
                lib.notify(src, { description = 'Your license is revoked or you need to request one from the police', type = 'error'})
            end
        elseif not cancarry then
            lib.notify(src,{ description = 'You cant carry this', type = 'error'})
        end
    elseif hasmoney < Config.WeaponLicenseCost then
        lib.notify(src,{ description = 'Not enough cash', type = 'error'})
    end
end)


RegisterNetEvent('scarcityhall:applytaxijob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        Player.Functions.SetJob("taxi", 0)
            if Config.RenewedPhone then
                exports['qb-phone']:hireUser("taxi", Player.PlayerData.citizenid, 0)
                Player.Functions.SetJob("taxi", 0)
            else
                Player.Functions.SetJob("taxi", 0)
            end
        lib.notify(src,{ description = 'You got the job!', type = 'success'})
    else
        lib.notify(src,{ description = 'You are not who you say you are', type = 'error'})
    end
end)

RegisterNetEvent('scarcityhall:applytowjob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        Player.Functions.SetJob("tow", 0)
            if Config.RenewedPhone then
                exports['qb-phone']:hireUser("tow", Player.PlayerData.citizenid, 0)
                Player.Functions.SetJob("tow", 0)
            else
                Player.Functions.SetJob("tow", 0)
            end
        lib.notify(src,{ description = 'You got the job!', type = 'success'})
    else
        lib.notify(src,{ description = 'You are not who you say you are', type = 'error'})
    end
end)

RegisterNetEvent('scarcityhall:applygarbagejob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        Player.Functions.SetJob("garbage", 0)
            if Config.RenewedPhone then
                exports['qb-phone']:hireUser("garbage", Player.PlayerData.citizenid, 0)
                Player.Functions.SetJob("garbage", 0)
            else
                Player.Functions.SetJob("garbage", 0)
            end
        lib.notify(src,{ description = 'You got the job!', type = 'success'})
    else
        lib.notify(src,{ description = 'You are not who you say you are', type = 'error'})
    end
end)