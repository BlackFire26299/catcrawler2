extends VBoxContainer

func clear_children():
	for child in get_children():
		remove_child(child)
		child.queue_free()
