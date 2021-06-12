--  Portal.lua

Portal = Class {}

function Portal:init(params)
    self.left_x = params.left_x
    self.left_y = params.left_y
    self.right_x = params.right_x
    self.right_y = params.right_y

    self.width = 16
    self.height = 16

end

function Portal:collides(target)
    if target.portaled == false then
        if not (target.x > self.left_x + self.width or
                self.left_x > target.x + target.width or
                target.y > self.left_y + self.height or 
                self.left_y > target.y + target.height) then
                    print("collision left")
                    target.portaled = true
                    target.x = self.right_x
                    target.y = self.right_y
        elseif not (target.x > self.right_x + self.width or
                    self.right_x > target.x + target.width or
                    target.y > self.right_y + self.height or 
                    self.right_y > target.y + target.height) then
                        print("collision right")
                        target.portaled = true
                        print("target.x before: ", target.x)
                        print("target.y before: ", target.y)
                        target.x = self.left_x
                        target.y = self.left_y
                        print("target.x after: ", target.x)
                        print("target.y after: ", target.y)
        end
    end
end

function Portal:render()
    love.graphics.draw(gTextures['portal_tile'], self.left_x, self.left_y)
    love.graphics.draw(gTextures['portal_tile'], self.right_x, self.right_y)
end
