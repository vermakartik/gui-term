require_relative 'guit'

Guit.clearScreen
# Guit.turnOffKeyboard
Guit.setWindowTitle(title: "Kartik Verma")
#while true
#Guit.moveToLast
#end
# Guit.drawStroke(1, 1, 10, 6)
# Guit.drawCircle(15, 30, 10)
# Guit.drawRect(2, 2, 5, 10)
# Guit.drawFilledCircle(15, 100, 5)
# Guit.drawFilledCircle(15, 70, 10, color: Guit.rgbBack(178, 164, 14))
xc, yc = 20, 100
x, y = 15, 20
#Guit.drawPixel(xc, yc, color: Guit.rgbBack(25, 255, 100)); printf("xc, yc")
#Guit.drawPixel(xc + x, yc + y, color: Guit.rgbBack(255, 0, 0)); printf("xc + x, yc + y")
#Guit.drawPixel(xc + y, yc + x, color: Guit.rgbBack(0, 255, 0)); printf("xc + y, yc + x")
#Guit.drawPixel(xc - x, yc - y, color: Guit.rgbBack(0, 0, 255)); printf("xc - x, yc - y")
#Guit.drawPixel(xc - y, yc - x, color: Guit.rgbBack(255, 255, 0)); printf("xc - y, yc - x")
#Guit.drawPixel(xc + x, yc - y, color: Guit.rgbBack(255, 0, 255)); printf("xc + x, yc - y")
#Guit.drawPixel(xc + y, yc - x, color: Guit.rgbBack(0, 255, 255)); printf("xc + y, yc - x")
#Guit.drawPixel(xc - x, yc + y, color: Guit.rgbBack(255, 255, 255)); printf("xc - x, yc + y")
#Guit.drawPixel(xc - y, yc + x, color: Guit.rgbBack(128, 128, 128)); printf("xc - y, yc + x")
while true
	Guit.drawBulk(5, 10, 40, 40)
#Guit.drawFilledRect(5, 10, 2, 10, color: Guit.rgbBack(12, 12, 12))
#Guit.drawArc(xc, yc, 10, 30, 270)
#Guit.printText(10, 10, "Kartik Verma", styles: Guit::STYLE_BOLD | Guit::STYLE_STRIKE_THROUGH, foreColor: Guit.rgbFront(134, 134, 255), backColor: Guit.rgbBack(100, 100, 100))
	sleep 0.1
end


