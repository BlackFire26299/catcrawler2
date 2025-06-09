extends Panel

@onready var quest_vbox = $VBoxContainer

func _ready():
	QuestManager.quests_updated.connect(update_quest_log)
	update_quest_log()

func update_quest_log():
	# Clear existing children
	for child in quest_vbox.get_children():
		child.queue_free()
	
	for quest in QuestManager.get_active_quests():
		var container = VBoxContainer.new()
		container.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		var title = Label.new()
		title.label_settings = load("res://Player/player.res")
		title.text = "📜 " + quest.name
		title.add_theme_font_size_override("font_size", 20)
		
		var objective = Label.new()
		objective.label_settings = load("res://Player/player.res")
		objective.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		objective.text = "• " + quest.get_current_objective()
		
		container.add_child(title)
		container.add_child(objective)
		quest_vbox.add_child(container)
		
		# Add separator
		var separator = HSeparator.new()
		quest_vbox.add_child(separator)
