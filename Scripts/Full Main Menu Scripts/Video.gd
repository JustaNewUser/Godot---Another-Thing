extends TabBar

func _ready():
	var screen_type = SaveSettings.config.get_value("Video", "fullscreen")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%FullScreen.button_pressed = true
	
	var borderless_type = SaveSettings.config.get_value("Video", "borderless")
	if borderless_type == true:
		%Borderless.button_pressed = true
	
	var vsync_index = SaveSettings.config.get_value("Video", "vsync")
	%VSync.selected = vsync_index
	
	
	
	



func _on_full_screen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		SaveSettings.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		SaveSettings.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
		
	SaveSettings.save_data()


func _on_borderless_toggled(button_pressed):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, button_pressed)
	SaveSettings.config.set_value("Video", "borderless", button_pressed)
	SaveSettings.save_data()


func _on_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	SaveSettings.config.set_value("Video", "vsync", index)
	SaveSettings.save_data()
