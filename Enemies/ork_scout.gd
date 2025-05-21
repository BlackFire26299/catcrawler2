extends CharacterBody2D


@onready var nav_agent = $NavigationAgent2D
@export var speed = 50.0
@export var aggro_range = 150
var target = null

func _physics_process(delta):
	if target and global_position.distance_to(target.global_position) < aggro_range:
		nav_agent.target_position = target.global_position
		velocity = (nav_agent.get_next_path_position() - global_position).normalized() * speed
		move_and_slide()
	else:
		pass
