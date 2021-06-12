--  ChestKey.lua

ChestKey = Class{}

function ChestKey:init(params)
    self.chest_x = params.chest_x 
    self.chest_y = params.chest_y

    self.key_x = params.key_x
    self.key_y = params.key_y

    self.chest_width = 16
    self.chest_height = 16

    self.key_width = 16
    self.key_height = 16

    self.has_key = false

    self.chest_opened = false
end

function ChestKey:hasKey(target) 
    if self.has_key == true then
        self.key_x = target.x 
        self.key_y = target.y
        return true 
    end
    if not (target.x > self.key_x + self.key_width or 
            self.key_x > target.x + target.width or
            target.y > self.key_y + self.key_height or 
            self.key_y > target.y + target.height) then
        if not self.has_key then
            gSounds['pick_up_key']:play()
        end
        self.has_key = true
        return true  
    else
        return false
    end
end

function ChestKey:openingChest(target)
    if not (target.x > self.chest_x + self.chest_width or
                self.chest_x > target.x + target.width or 
                target.y > self.chest_y + self.chest_height or 
                self.chest_y > target.y + target.height) then
                if not self.chest_opened then
                    gSounds['chest_unlocked']:play()
                end
                self.chest_opened = true
    end
end

function ChestKey:keyInChest()
    if has_key == false then
        return false
    end
    return not (self.key_x > self.chest_x + self.chest_width or
                self.chest_x > self.key_x + self.key_width or 
                self.key_y > self.chest_y + self.chest_height or 
                self.chest_y > self.key_y + self.key_height)
end

function ChestKey:render()
    if not chest_opened then
        love.graphics.draw(gTextures['chest'], self.chest_x, self.chest_y)
        love.graphics.draw(gTextures['key'], self.key_x, self.key_y)
    end
end

function ChestKey:isOpened()
    return chest_opened
end