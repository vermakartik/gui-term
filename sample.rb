require_relative "prompt"


car_cur_pos = [12, 10]
car_width = 40
car_height = 6

car_windows = [[13, 12], [13, 22], [13, 32], [13, 42]]
car_window_width = 6
car_window_height = 2
tyre1_pos = [17, 15]
tyre2_pos = [17, 44]
tyre_radius = 3
while true
	clearScreen
	drawStroke(20, 1, length: 200, width: 1, foreColor: FORE_BLACK, backColor: BACK_LIGHT_RED, ver_hor: 1, character: " ")
	drawStroke(19, 1, length: 200, width: 1, foreColor: FORE_BLACK, backColor: BACK_GREEN, ver_hor: 1, character: "|")
	drawRect(car_cur_pos[0], car_cur_pos[1], car_height, car_width, color: BACK_YELLOW)
	car_windows.each do |x, y| 
		drawRect(x, y, car_window_height, car_window_width, color: BACK_WHITE)
	end
	drawCircle(tyre1_pos[0], tyre1_pos[1], tyre_radius, color: BACK_LIGHT_GRAY) 
	drawCircle(tyre2_pos[0], tyre2_pos[1], tyre_radius, color: BACK_LIGHT_GRAY) 
	sleep 0.1
	# pacman_cur_pos[1] += 1
	# pacman_cur_pos[1] += 1
	car_cur_pos[1] += 1
	(0..car_windows.length-1).each do |i|
		car_windows[i][1] += 1
	end
	tyre1_pos[1] += 1
	tyre2_pos[1] += 1
end