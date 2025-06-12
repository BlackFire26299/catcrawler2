extends VBoxContainer

func clear_children():
	# I just googled how to kill children on public wifi, then i figured out i hade to specify in godot. 
	# The below is what it gave me
	for child in get_children():
		remove_child(child)
		child.queue_free()
