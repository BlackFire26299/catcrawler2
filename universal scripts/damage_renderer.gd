extends Node

func display_number(value:int, position: Vector2, is_critical:bool = false):
	var number = Label.new() #Create a new label
	number.global_position = position #set the label to the pisition of the enemie and or player
	number.text = str(value) #sets the text on the label to the number provided
	number.z_index = 5 #puts it above stuff on the z axis
	number.label_settings = LabelSettings.new() #Creates a new label settings
	
	var colour = '#FFF' #base colour
	if is_critical:
		colour = '#B22' #red if critical
	if value == 0:
		colour = '#FFF8' # colour if 0 pretty sure its imposible but if i want to add something i could use this

	number.label_settings.font_color = colour #sets the font colour to the color
	number.label_settings.font_size = 10 # sets the font size
	number.label_settings.outline_color = '#000' #outline colour
	number.label_settings.outline_size = 1 # outline size
	
	call_deferred("add_child",number) # Adds the lable to the node this is attached to as a child
	
	await number.resized  #waits until the lable has been resized 
	number.pivot_offset = Vector2(number.size / 2) # changes the offset from the parent node
	
	var tween = get_tree().create_tween() #Creates a tween (something that does what it is coded to do until done and then deletes its self)
	tween.set_parallel(true) #runs at the same time as other things
	
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25	
	).set_ease(Tween.EASE_OUT) #Changes the y position over 1/4 a second
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25) # Similar changes y pos  happens at the start of the tween
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5) #changes the scale slowly then fast for .25 seconds
	
	await tween.finished #waits until the tween has finished its processes
	number.queue_free() #deletes the lable node
	
