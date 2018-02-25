# require 'io/console'

ESC = "\033["

# styles 
NORMAL = 0x1
BOLD = 0x1 << 1
ITALIC = 0x1 << 2
UNDERLINED = 0x1 << 3

# colors
FORE_DEFAULT = 39
FORE_BLACK = 30
FORE_RED = 31
FORE_GREEN = 32
FORE_YELLOW = 33
FORE_BLUE = 34
FORE_MAGENTA = 35
FORE_CYAN = 36
FORE_LIGHT_GRAY = 37
FORE_DARK_GRAY = 90
FORE_LIGHT_RED = 91
FORE_LIGHT_GREEN = 92
FORE_LIGHT_YELLOW = 93
FORE_LIGHT_BLUE = 94
FORE_LIGHT_MAGENTA = 95
FORE_LIGHT_CYAN = 96
FORE_WHITE = 97

BACK_DEFAULT = 49
BACK_BLACK = 40
BACK_RED = 41
BACK_GREEN = 42
BACK_YELLOW = 43
BACK_BLUE = 44
BACK_MAGENTA = 45
BACK_CYAN = 46
BACK_LIGHT_GRAY = 47
BACK_DARK_GRAY = 100
BACK_LIGHT_RED = 101
BACK_LIGHT_GREEN = 102
BACK_LIGHT_YELLOW = 103
BACK_LIGHT_BLUE = 104
BACK_LIGHT_MAGENTA = 105
BACK_LIGHT_CYAN = 106
BACK_WHITE = 107

def clearScreen
	printf(ESC + "2J")
	moveTo(1, 1)
end

def moveTo(x, y)
	printf(ESC + "#{x};#{y}H")
end

def applyTextStyles(styles: NORMAL)
	if (styles & NORMAL) != 0
		# printf("")	
		# may be doing nothing will be a better option for now
	end	
	if (styles & BOLD) != 0
		printf(ESC + "1m")
	end
	if (styles & UNDERLINED) != 0
		printf(ESC + "4m")
	end
	if (styles & ITALIC) != 0
		printf(ESC + "3m")
	end
	# moveTo(1, 1)
end

def applyTextColor(foreColor: BACK_BLACK, backColor: BACK_BLACK)
	printf(ESC + "#{foreColor}m" + ESC + "#{backColor}m")
	# moveTo(1, 1)
end

def endStyles
	printf(ESC + "0m")
	# moveTo(1, 1)
end

def drawPixel(x, y, backColor: BACK_RED, foreColor: FORE_BLACK, character: " ")
	printf(ESC + "#{x};#{y}H" + ESC + "#{1};#{foreColor};#{backColor}m#{character}" + ESC + "0m")
	# moveTo(1, 1)
end

def drawPixelAtCurrent(backColor: BACK_RED, foreColor: FORE_BLACK, character: " ")
	printf(ESC + "#{1};#{foreColor};#{backColor}m#{character}" + ESC + "0m")
	# moveTo(1, 1)
end

def drawStrokeAtCurrent(length: 1, ver_hor: 0, backColor: BACK_RED, foreColor: FORE_BLACK, character: " ")
	if ver_hor.eql?0
		(0..length-1).each do |i|
			drawPixelAtCurrent(backColor: backColor, foreColor: foreColor, character: character)
		end
	elsif ver_hor.eql?1
		(0..length-1).each do |i|
			drawPixelAtCurrent(backColor: backColor, foreColor: foreColor, character: character)
		end
	end
	# moveTo(1, 1)
end

# def run_sample
# 	while true
# 		clearScreen
# 		drawPixel(1, 1)
# 		drawPixel(2, 1, backColor: BACK_GREEN, character: "_")
# 		drawPixel(3, 1, backColor: BACK_CYAN)
# 		drawPixel(4, 1, backColor: BACK_LIGHT_YELLOW)
# 		drawPixel(5, 1, backColor: BACK_LIGHT_MAGENTA)
# 		sleep(1)
# 	end
# end


def drawStroke(x, y, length: 1, width: 2, ver_hor: 0, backColor: BACK_RED, foreColor: FORE_BLACK, character: " ")
	if ver_hor.eql?0
		(0..length-1).each do |i|
			(0..width-1).each do |j|
				drawPixel(x+i, y+j, backColor: backColor, foreColor: foreColor, character: character)
			end
		end
	elsif ver_hor.eql?1
		(0..length-1).each do |i|
			(0..width-1).each do |j|
				drawPixel(x+j, y+i, backColor: backColor, foreColor: foreColor, character: character)
			end
		end
	end
	# moveTo(1, 1)
end

def drawCircle(x, y, radius, color: BACK_RED, cutoff: 2)
	drawPixel(x, y, backColor: color)
	if radius > cutoff
		drawCircle(x-1, y, radius-1, color: color)
		drawCircle(x+1, y, radius-1, color: color)
	end
	if radius > (cutoff-1)
		drawCircle(x, y-1, radius-1, color: color)
		drawCircle(x, y+1, radius-1, color: color)
	end
end

def drawCircleHollow(x, y, radius, color: BACK_RED)
	drawCircle(x, y, radius, color: color) 
	drawCircle(x, y, radius-1, color: BACK_BLACK) 
	# moveTo(1, 1)
end	

def drawRect(x, y, width, height, color: BACK_RED, hollow: false)
	drawStroke(x, y, length: width, width: height, backColor: color)
	if hollow.eql?true
		drawStroke(x+1, y+2, length: width-2, width: height-4, backColor: BACK_BLACK)
	end
	# moveTo(1, 1)
end


def drawText(x, y, text, foreColor: FORE_BLACK, backColor: BACK_RED, styles: NORMAL, padding: 1)
	moveTo(x, y)
	applyTextStyles(styles: styles)
	drawStroke(x, y, length: padding, width: 1, ver_hor: 0, foreColor: foreColor, backColor: backColor)
	applyTextColor(foreColor: foreColor, backColor: backColor)	
	printf(text)
	drawStrokeAtCurrent(length: padding, ver_hor: 0, foreColor: foreColor, backColor: backColor)
	endStyles
	# moveTo(1, 1)
end

clearScreen

# drawStroke(1, 1, length: 200, width: 1, ver_hor: 1)
# drawStroke(1, 1, length: 10, width: 2, ver_hor: 0)
# drawStroke(10, 1, length: 200, width: 1, ver_hor: 1)
# drawStroke(1, 40, length: 10, width: 2, ver_hor: 0)
drawCircle(10, 40, 4)

# drawCircleHollow(10, 40, 5)
# drawCircleHollow(10, 40, )
# drawRect(1, 10, 10, 5, hollow: false)
