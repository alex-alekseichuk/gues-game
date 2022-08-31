
--[[
	Cool example: The game to gues a number between 1 and 10 in 3 attempts.
    Run:
        lua GuesGame.lua
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



---------------------------------------------------
--	UI
---------------------------------------------------

print("q - quit, s - start new game, 1-10 - gues")

game:start()
print("Try to gues a number between 1 and 10?")

while true do
	line = io.read()
	if line == 'q' then
		break
	elseif line == 's' then
		game:start()
		print("Try to gues a number between 1 and 10?")
	elseif nil ~= tonumber(line) then
		n = tonumber(line)
		result = game:play(n)
		if result == GuesGame.WIN then
			print("Win! :-)")
		elseif result == GuesGame.LOSE then
			print("Lose :-(")
		elseif result == GuesGame.GREATER then
			print("Greater")
		elseif result == GuesGame.LESS then
			print("Less")
		end
   	else
   		print("Error")
	end
end

