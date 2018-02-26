require '../lib/guit'

class Pipe

	def initialize(x, y, maxHeight)
		@height = (2..maxHeight).to_a.sample
		@x = x + maxHeight - @height - 1
		@y = y
		@width = 10
	end

	def drawPipe
		obj = ""
		obj += Guit.drawStroke(@x, @y-1, @x, @y + @width, color: Guit.rgbBack(93, 175, 21))
		obj += Guit.drawPixel(@x, @y-1, color: Guit.rgbBack(27, 56, 1))
		obj += Guit.drawPixel(@x, @y, color: Guit.rgbBack(38, 76, 3))
		obj += Guit.drawPixel(@x, @y+@width-6, color: Guit.rgbBack(44, 86, 4))
		obj += Guit.drawPixel(@x, @y+@width-6, color: Guit.rgbBack(88, 170, 8))
		obj += Guit.drawPixel(@x, @y+@width-5, color: Guit.rgbBack(80, 160, 6))
		obj += Guit.drawPixel(@x, @y+@width-4, color: Guit.rgbBack(67, 132, 6))
		obj += Guit.drawPixel(@x, @y+@width-3, color: Guit.rgbBack(66, 119, 5))
		obj += Guit.drawPixel(@x, @y+@width-2, color: Guit.rgbBack(44, 86, 4))
		obj += Guit.drawPixel(@x, @y+@width-1, color: Guit.rgbBack(38, 76, 3))
		obj += Guit.drawPixel(@x, @y+@width, color: Guit.rgbBack(27, 56, 1))

		obj += Guit.drawStroke(@x+1, @y, @x + @height - 1, @y, color: Guit.rgbBack(27, 56, 1))
		obj += Guit.drawStroke(@x+1, @y+1, @x + @height - 1, @y + 1, color: Guit.rgbBack(38, 76, 3))
		obj += Guit.drawStroke(@x+1, @y+2, @x + @height - 1, @y + 2, color: Guit.rgbBack(100, 198, 7))
		obj += Guit.drawStroke(@x+1, @y+3, @x + @height - 1, @y + 3, color: Guit.rgbBack(88, 170, 8))
		obj += Guit.drawStroke(@x+1, @y+4, @x + @height - 1, @y + 4, color: Guit.rgbBack(80, 160, 6))
		obj += Guit.drawStroke(@x+1, @y+5, @x + @height - 1, @y + 5, color: Guit.rgbBack(67, 132, 6))
		obj += Guit.drawStroke(@x+1, @y+6, @x + @height - 1, @y + 6, color: Guit.rgbBack(66, 119, 5))
		obj += Guit.drawStroke(@x+1, @y+7, @x + @height - 1, @y + 7, color: Guit.rgbBack(44, 86, 4))
		obj += Guit.drawStroke(@x+1, @y+8, @x + @height - 1, @y + 8, color: Guit.rgbBack(38, 76, 3))
		obj += Guit.drawStroke(@x+1, @y+9, @x + @height - 1, @y + 9, color: Guit.rgbBack(27, 56, 1))
		# Guit.drawStroke(@x, @y+10, @x + @height - 1, @y+ 10, color: Guit.rgbBack(93, 175, 21))
		return obj
	end

	def getY
		return @y
	end

	def incrementY
		 @y += 1
	end

	def decrementY
		@y -= 1
	end
end

class GroundTile
	def initialize(x, y, tile_count)
		@x = x
		@y = y
		@tile_count = tile_count
	end

	def drawTile(disp)
		obj = ""
		obj += Guit.drawStroke(@x, @y + disp, @x, @y + disp + 4, color: Guit.rgbBack(32, 142, 22))
		# obj += Guit.drawPixel(@x, @y + disp, color: Guit.rgbBack(36, 173, 24))
		obj += Guit.drawRect(@x + 1 , @y + disp, 3, 5, color: Guit.rgbBack(145, 80, 15))
		obj += Guit.drawStroke(@x + 2, @y + disp + 1, @x + 2, @y + disp + 3, color: Guit.rgbBack(211, 110, 8))
	end

	def drawGround
		ground = ""
		(0..@tile_count).each do |i|
			ground += drawTile(i * 5)
		end
		return ground
	end
end

a = Array.new 
a << Pipe.new(29, 180, 10)
tm = Time.new.to_i
width = 8
diff = 5
tl = GroundTile.new(38, 1, 60)
Guit.run{
	Guit.clearScreen
	Guit.addToDraw(Guit.drawFilledRect(1, 1, 200, 40, color: Guit.rgbBack(211, 228, 237)))
	Guit.addToDraw(tl.drawGround)
	if Time.new.to_i - tm > diff
		a << Pipe.new(29, 180, 10)
		tm = Time.new.to_i
	end
	a.each do |p|
		Guit.addToDraw(p.drawPipe)
		p.decrementY
	end
	if a[0].getY < 0
		a.shift
	end
}
