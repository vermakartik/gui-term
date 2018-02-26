require '../lib/guit'

x1, y1 = 10, 10
x2, y2 = 10, 40
radius = 5
Guit.setFrames 10
Guit.run{
	#Guit.refresh
	Guit.clearScreen
	Guit.addToDraw(Guit.drawFilledRect(1, 1, 200, 60, color: Guit.rgbBack(120, 0, 120)))
	Guit.addToDraw(Guit.drawCircle(x1, y1, radius))
	Guit.addToDraw(Guit.drawCircle(x2, y2, radius))
	y1 += 1
	y2 += 1
}

