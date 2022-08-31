
--[[
	Cool example: The game to gues a number between 1 and 10 in 3 attempts.
]]--


---------------------------------------------------
--	Gues game model
---------------------------------------------------

GuesGame = {}

GuesGame.WIN = 1
GuesGame.LOSE = 2
GuesGame.GREATER = 3
GuesGame.LESS = 4

GuesGame.MIN = 1
GuesGame.MAX = 10

GuesGame.MAX_TRY = 3

function GuesGame:new()
	return setmetatable({
		_counter = GuesGame.MAX_TRY
	}, {
		__index = GuesGame
	})
end

function GuesGame:start()
	self._x = math.random(GuesGame.MIN, GuesGame.MAX)
	self._counter = 0
end
function GuesGame:play(a)
	if self._counter >= GuesGame.MAX_TRY then
		return GuesGame.LOSE
	end
	self._counter = self._counter + 1
	if a == self._x then
		return GuesGame.WIN
	else
		if self._counter >= GuesGame.MAX_TRY then
			return GuesGame.LOSE
		elseif self._x > a then
			return GuesGame.GREATER
		else
			return GuesGame.LESS
		end
	end
end


---------------------------------------------------
--	Initialization
---------------------------------------------------

-- init random generator by current time in seconds since 1970
math.randomseed(os.time()) -- but it's unique per second
-- several times touch this generator to avoid repeat on start
math.random()
math.random()
math.random()

game = GuesGame.new()


-- external interface

function gameStart()
	return game:start()
end
function gamePlay(a)
	return game:play(a)
end

