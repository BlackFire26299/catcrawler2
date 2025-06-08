extends Panel

@onready var quest_vbox = $VBoxContainer

func _process(delta):
	update_quest_log()
	
func update_quest_log():
	quest_vbox.clear_children()
	
	for quest in QuestManager.get_active_quests():
		var quest_label = Label.new()
		quest_label.text = "- " + quest.name
		quest_vbox.add_child(quest_label)
		
