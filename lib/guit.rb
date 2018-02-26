# require 'terminfo'
require 'io/console'
require 'mathn'
# require 'mini_mag'
# require 

#TODO and ISSUES
# arc function not working properly


# printf("\e[?12l")
# sync with stdout
STDOUT.sync = true

module Guit

	PI = 3.141592653589793238
	STYLE_NORMAL = 0x1
	STYLE_BOLD = 0x1 << 1
	STYLE_ITALIC = 0x1 << 2
	STYLE_UNDERLINED = 0x1 << 3
	STYLE_STRIKE_THROUGH = 0x1 << 4

    def Guit.setFrames(frames)
        @frames = frames
    end

    def Guit.run
        durationPerFrame = 1 / (5 * @frames) 
        while true
            yield
            drawScene
            sleep durationPerFrame
        end
    end

    def Guit.addToDraw(string)
        @string += string
    end

    def Guit.refresh
        @string = "\e[0m"
    end

    def Guit.drawScene(persist: true)
        printf(@string)
        if persist.eql?false
            @string = "\e[0m"
        end
    end

	def Guit.turnOffKeyboard
		STDIN.echo = false
	end

	def Guit.turnOnKeyboard
		STDIN.echo = true
	end

	def Guit.clearScreen
		@string = "\e[2J\e[0m"
	end

    def Guit.setWindowTitle(title: "GUI")
        return "\e]2;#{title}\x07"
    end
    
    def Guit.rgbFront(r, g, b)
        return "\e[38;2;#{r};#{g};#{b}m"
    end

    def Guit.rgbBack(r, g, b)
        return "\e[48;2;#{r};#{g};#{b}m"
    end

    def Guit.endStyles
        return "\e[0m"
    end
    
    def Guit.moveTo(x, y)
        return "\e[#{x};#{y}H"
    end

    def Guit.drawPixel(x, y, color: nil)
    	if color.nil?
    		color = rgbBack(255, 255, 255)
    	end
        return "\e[#{x};#{y}H#{color} \e[0m"
    end

    # Bresenham's line drawing algorithm
    def Guit.drawStroke(x0, y0, x1, y1, color: nil)
    	color = setDefaultOnEmpty(color)
    	if (y1 - y0).to_i.abs < (x1 - x0).to_i.abs
    		if x0 > x1
    			return lowStroke(x1, y1, x0, y0, color)
    		else
    			return lowStroke(x0, y0, x1, y1, color)
    		end
    	else
    		if y0 > y1
    			return highStroke(x1, y1, x0, y0, color)
    		else
    			return highStroke(x0, y0, x1, y1, color)
    		end
    	end
    end

    def Guit.setDefaultOnEmpty(color)
    	if color.nil?
    		return rgbBack(200, 200, 200)
    	else
    		return color
    	end
    end

    # simple uses strokeDraw
    def Guit.drawRect(x, y, width, height, color: nil)
    	color = setDefaultOnEmpty(color)
        string = ""
    	string += drawStroke(x, y, x + width - 1, y, color: color)
		string += drawStroke(x, y, x, y + height - 1, color: color)
		string += drawStroke(x + width - 1, y, x + width -1, y + height - 1, color: color)
		string += drawStroke(x, y + height - 1, x + width - 1, y + height - 1, color: color)
        return string
    end

    def Guit.drawFilledRect(x, y, width, height, color: nil)
    	color = setDefaultOnEmpty(color)	
        string = ""
    	for i in (0..width-1)
    		string += drawStroke(x, y+i, x + height-1, y+i, color: color)
		end
        return string
    end

    # def drawBulkAny(string)
    #     printf(string)
    # end

    # def getPosition(x, y)
    #     return "\e[#{x};#{y}H"
    # end

    def Guit.drawFilledCircle(xc, yc, radius, color: nil)
    	color = setDefaultOnEmpty(color)
    	# color = rgbBack(102, 100, 200)
    	x = 0
    	y = radius
    	d = 3 - 2 * radius
        string = ""
    	while y >= x
    		string += recursion8(xc, yc, x, y, color, line: true)
    		x+=1
    		if d > 0
    			y-=1
    			d += 4 * (x - y) + 10
    		else
    			d += 4 * x + 6
    		end
    		string += recursion8(xc, yc, x, y, color, line: true)
    	end
        return string
    end

    # Bresenham's circle drawing algorithm
    def Guit.drawCircle(xc, yc, radius, color: nil)
    	color = setDefaultOnEmpty(color)
    	x = 0
    	y = radius
    	d = 3 - 2 * radius
        string = ""
    	while y >= x
    		string += recursion8(xc, yc, x, y, color)
    		x+=1
    		if d > 0
    			y-=1
    			d += 4 * (x - y) + 10
    		else
    			d += 4 * x + 6
    		end
    		string += recursion8(xc, yc, x, y, color)
    	end
        return string
    end

	# modified version of the bresenham's line algorithm
	# Issue not working as desired 
    def Guit.drawArc(xc, yc, radius, start_angle, end_angle, color: nil)
    	color = setDefaultOnEmpty(color)
    	x = 0
    	y = radius
    	d = 3 - 2 * radius
        string = ""
    	while y >= x
    		string += recursion8Condition(xc, yc, x, y, start_angle, end_angle, color)
    		x+=1
    		if d > 0
    			y-=1
    			d += 4 * (x - y) + 10
    		else
    			d += 4 * x + 6
    		end
    		string += recursion8Condition(xc, yc, x, y, start_angle, end_angle, color)
    	end
        return string
    end

    def Guit.printText(x, y, text, foreColor: nil, backColor: nil, styles: nil)
    	if foreColor.nil?
    		foreColor = rgbFront(255, 255, 255)
    	end
    	if backColor.nil?
    		backColor = rgbBack(0, 0, 0)
    	end    
    	if styles.nil?
    		styles = STYLE_NORMAL
    	end
        string = ""
    	string += addTextStyles(styles)
    	string += foreColor
    	string += backColor
    	string += text
    	string += endStyles
        return string
    end

    # def Guit.drawBulk(x, y, width, height, color: nil)
    # 	if color.nil?
    # 		color = rgbBack(255, 255, 255)
    # 	end
    # 	string = "#{color}"
    # 	(y..y+height).each do |i|
	   #  	(x..(x+width)).each do |j|
	   #  		string += " "
	   #  	end
	   #  	string += "\n"
    # 	end
    # 	printf(string) 
    # end

    # -----------------------------private methods------------------------------------
   	private

    @string = "\e[0m"
    @frames = 1

   	def Guit.addTextStyles(styles)
        string = ""
   		if (styles & STYLE_NORMAL).eql?STYLE_NORMAL
   			string += "\e[0m"
   			return string
   		end
   		# printf("..........")
		if (styles & STYLE_BOLD).eql?STYLE_BOLD
		string += "\e[1m"
		# stl_strin += "1;"
   		end
   		if (styles & STYLE_UNDERLINED).eql?STYLE_UNDERLINED
   			string += "\e[4m"
   			# stl_strin += "4;"
   		end
   		if (styles & STYLE_ITALIC).eql?STYLE_ITALIC
   			string += "\e[3m"
   			# stl_strin += "3;"
   		end
   		if (styles & STYLE_STRIKE_THROUGH).eql?STYLE_STRIKE_THROUGH
   			string += "\e[9m"
   		end
        return string
   	end

   	def Guit.lowStroke(x0, y0, x1, y1, color)
   		dx = x1 - x0
   		dy = y1 - y0
   		yi = 1
   		if dy < 0
   			yi = -1
   			dy = -dy
   		end

   		nD = 2 * dy - dx
   		y = y0

        string = ""
   		for x in (x0..x1)
   			string += drawPixel(x, y, color: color)
   			if nD > 0
   				y = y + yi
   				nD = nD - 2 * dx
   			end
   			nD = nD + 2 * dy
   		end
        return string
    end

    def Guit.highStroke(x0, y0, x1, y1, color)
        string = ""
    	dx = x1 - x0
    	dy = y1 - y0
    	xi = 1
    	if dx < 0
    		xi = -1
    		dx = -dx
    	end
    	nD = 2 * dx - dy
    	x = x0
    	for y in (y0..y1)
    		string += drawPixel(x, y, color: color)
    		if nD > 0
    			x = x + xi
    			nD = nD - 2 * dy
    		end
    		nD = nD + 2 * dx
    	end
        return string
    end

    def Guit.recursion8(xc, yc, x, y, color, line: false)
        string = ""
    	if line.eql?false
	    	string += drawPixel(xc+x, yc+y, color: color); 
		    string += drawPixel(xc-x, yc+y, color: color); 
		    string += drawPixel(xc+x, yc-y, color: color);
		    string += drawPixel(xc-x, yc-y, color: color);
		    string += drawPixel(xc+y, yc+x, color: color);
		    string += drawPixel(xc-y, yc+x, color: color);
		    string += drawPixel(xc+y, yc-x, color: color);
		    string += drawPixel(xc-y, yc-x, color: color);
	    else
	    	string += drawStroke(xc-x, yc - y, xc - x, yc + y, color: color)
	    	string += drawStroke(xc+x, yc - y, xc + x, yc + y, color: color)
	    	string += drawStroke(xc-y, yc - x, xc + y, yc - x, color: color)
	    	string += drawStroke(xc-y, yc + x, xc + y, yc + x, color: color)
	    end
        return string
    end

    def Guit.recursion8Condition(xc, yc, x, y, start_angle, end_angle, color)
        string = ""
    	angle = rad2Deg(Math.atan2(y.to_f, x.to_f)) - 45
    	if angle < 0
    		 angle = 0
    	end

    	# to check for 0 to 45deg
    	if start_angle <= angle and angle <= end_angle
    		string += drawPixel(xc-x, yc + y, color: color)
    	end

    	# to check for 45 to 90deg
    	if start_angle <= (angle+45) and (angle+45) <= end_angle
    		string += drawPixel(xc-y, yc + x, color: color)
    	end

    	# to check for 90 to 135deg
    	if start_angle <= (angle+90) and (angle+90) <= end_angle
    		string += drawPixel(xc-y, yc - x, color: color)
    	end

    	# to check for 135 to 180deg
    	if start_angle <= (angle+135) and (angle+135) <= end_angle
    		string += drawPixel(xc-x, yc - y, color: color)
    	end

    	# to check for 180 to 225deg
    	if start_angle <= (angle+180) and (angle+180) <= end_angle
    		string += drawPixel(xc+x, yc - y, color: color)
    	end

    	# to check for 225 to 270deg
    	if start_angle <= (angle+225) and (angle+225) <= end_angle
    		string += drawPixel(xc+y, yc - x, color: color)
    	end

    	# to check for 270 to 315deg
    	if start_angle <= (angle+270) and (angle+270) <= end_angle
    		string += drawPixel(xc+y, yc + x, color: color)
    	end

    	# to check for 315 to 360deg
    	if start_angle <= (angle+315) and (angle+315) <= end_angle
    		string += drawPixel(xc+x, yc + y, color: color)
    	end

        return string
    end

    def Guit.rad2Deg(value)
    	return (value.to_f * (180))/PI
    end
end
