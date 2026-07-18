--[[
	Animation Controller Script
	Controle de animações de personagens
]]

local AnimController = {}
AnimController.__index = AnimController

function AnimController.new(character)
	local self = setmetatable({}, AnimController)
	self.character = character
	self.humanoid = character:WaitForChild("Humanoid")
	self.humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	self.animations = {}
	return self
end

function AnimController:LoadAnimation(animationId)
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://" .. animationId
	
	local animTrack = self.humanoid:LoadAnimation(animation)
	self.animations[animationId] = animTrack
	
	return animTrack
end

function AnimController:PlayAnimation(animationId, speed, looped)
	local animTrack = self.animations[animationId]
	if animTrack then
		animTrack:Stop()
	else
		animTrack = self:LoadAnimation(animationId)
	end
	
	animTrack.Speed = speed or 1
	animTrack.Looped = looped or false
	animTrack:Play()
	
	return animTrack
end

function AnimController:StopAnimation(animationId)
	local animTrack = self.animations[animationId]
	if animTrack and animTrack.IsPlaying then
		animTrack:Stop()
	end
end

function AnimController:PlayIdleAnimation()
	-- Play default idle animation
	self.humanoid:SetStateEnabled(Enum.HumanoidStateType.Idle, true)
end

function AnimController:PlayWalkAnimation()
	-- Handled by humanoid automatically
end

function AnimController:PlayAttackAnimation(attackType)
	print("Attack animation: " .. attackType)
end

function AnimController:StopAllAnimations()
	for _, animTrack in pairs(self.animations) do
		if animTrack.IsPlaying then
			animTrack:Stop()
		end
	end
end

return AnimController
