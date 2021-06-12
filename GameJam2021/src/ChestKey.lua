--  ChestKey.lua

ChestKey = Class{}

function ChestKey:init(params)
    self.chest = params.chest

    self.key = params.key

    --self.chest_x = params.chest_x 
    --self.chest_y = params.chest_y

    --self.key_x = params.key_x
    --self.key_y = params.key_y

    self.chest_width = 16
    self.chest_height = 16

    self.key_width = 16
    self.key_height = 16

    self.has_key = false

    self.chest_opened = false
end

function ChestKey:hasKey(target) 
    if target.has_key == true then
        self.key.x = target.x 
        self.key.y = target.y
        return true 
    end
    if not (target.x > self.key.x + self.key.width or 
            self.key.x > target.x + target.width or
            target.y > self.key.y + self.key.height or 
            self.key.y > target.y + target.height) then
        if not target.has_key then
            gSounds['pick_up_key']:play()
        end
        target.has_key = true
        return true  
    else
        return false
    end
end

function ChestKey:openingChest(target)
    if not (target.x > self.chest.x + self.chest_width or
                self.chest.x > target.x + target.width or 
                target.y > self.chest.y + self.chest.height or 
                self.chest.y > target.y + target.height) then
                if not self.chest_opened then
                    gSounds['chest_unlocked']:play()
                end
                self.chest_opened = true
    end
end

function ChestKey:keyInChest(target)
    if target.has_key == false then
        return false
    end
    return not (self.key.x > self.chest.x + self.chest_width or
                self.chest.x > self.key.x + self.key_width or 
                self.key.y > self.chest.y + self.chest_height or 
                self.chest.y > self.key.y + self.key_height)
end

function ChestKey:render()
    if not self.chest_opened then
        love.graphics.draw(gTextures['chest'], self.chest.x, self.chest.y)
        love.graphics.draw(gTextures['key'], self.key.x, self.key.y)
    end
end

function ChestKey:isOpened()
    return chest_opened
end