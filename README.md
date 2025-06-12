# Defence of Thornvail

## **Table Of Contents**

- [How to Play](#how-to-play)  
  - [Controls](#controls)

- [Preplanning](#preplanning)  
  - [What Made the Original Game Great](#what-made-the-original-game-great)  
  - [How My Game is Different](#how-my-game-is-different)  
  - [Story and Gameplay Plan](#story-and-gameplay-plan)  
    - [Background](#background)  
    - [First Level – Ashroot Glade](#first-level--ashroot-glade)  
    - [Level Map – Ashroot Glade](#level-map--ashroot-glade)  
    - [Second Level – Runestone Vale (Planned)](#second-level--runestone-vale-planned)  
    - [Level Map – Runestone Vale](#level-map--runestone-vale)  
    - [Player Progression](#player-progression)  
  - [Flowcharts (Production Plan)](#flowcharts-production-plan)  
  - [Assets](#assets)

- [Prototyping and Development](#prototyping-and-development)  
  - [Prototype 1 – Core Systems](#prototype-1--core-systems)  
  - [Prototype 2 – Enemies, World Layout, UI](#prototype-2--enemies-world-layout-ui)  
  - [Prototype 3 – Tutorial, Damage Popups, New Attacks](#prototype-3--tutorial-damage-popups-new-attacks)  
  - [Prototype 4 – Interactions, Puzzles, UI Updates](#prototype-4--interactions-puzzles-ui-updates)  
  - [Prototype 5 – More Enemy Attacks, Lighting, Health Regen](#prototype-5--more-enemy-attacks-lighting-health-regen)  
  - [Prototype 6 – Quest System, Final Abilities, Level Finalisation](#prototype-6--quest-system-final-abilities-level-finalisation)  

- [Reflection](#reflection)  
  - [How is the Overall Design](#how-is-the-overall-design)  
  - [How Far Through My Plan Did I Get](#how-far-through-my-plan-did-i-get)  
  - [What Changes Could I Make and What Would I Do Differently](#what-changes-could-i-make-and-what-would-i-do-differently)  
  - [What Issues Did I Encounter](#what-issues-did-i-encounter)  
  - [What Have I Learnt](#what-have-i-learnt)

## **How to Play**

### **Controls**

W, A, S, D for movement. <br>
Left Click is your basic attack. <br>
Right Click is your heavy attack. <br>
Middle Click is your fire attack <br>
E Interact <br>
Left shift for dash. <br>
ESC to enter the menu <br>


## **Preplanning**

### **What Made the Original a Game Great**

The Legend of Zelda revolutionised video game design with its expansive open world, non-linear exploration, and blend of action and puzzle-solving. Players controlled Link through the vast land of Hyrule, navigating forests, mountains, and hidden dungeons while collecting items, solving puzzles, and defeating enemies. Unlike most games of the time, Zelda encouraged free exploration, allowing players to tackle challenges in nearly any order and rewarding curiosity with secrets and upgrades. It also introduced a persistent inventory system that reworked the game for added challenge after completion.

Zelda was groundbreaking. It was the first console game to use battery-backed memory, allowing players to save their progress without passwords. This, along with clever use of memory management, enabled a world much larger and deeper than what was typical for the NES. Critically acclaimed and commercially successful, The Legend of Zelda sold over 6.5 million copies worldwide and set the standard for action-adventure games. Its influence is still seen today in open-world design, and it remains one of gaming’s most iconic and celebrated titles.

### **How My Game is Different**

My game takes the top-down style of the original Legend of Zelda but changes a lot to make the experience more modern and structured. The original game had minimal guidance and dropped players into the world to figure things out themselves. In contrast, mine starts with a tutorial that teaches movement, combat, interaction, and UI step by step.

Movement is also more dynamic. In Zelda, the player could only move in four directions and was locked to a grid. My game allows full eight-directional movement with smoother control and no grid constraints, which makes exploration and combat feel faster and more responsive.

Combat has been expanded a lot, the player can use light, heavy, and fire attacks. Enemies aren’t just random walkers, they have patrol routes, attack phases, and even elite versions with variations. I’ve also included respawn points (instead of restarting at the beginning), a quest system to track objectives, a health and energy bar, and damage popups for better feedback.

The overall structure is more narrative-driven too. There’s an actual questline with objectives, interactions, and boss battles that use mechanics across multiple phases. While the game keeps the top-down exploration vibe, it’s built with modern design features that make it feel more complete and player-friendly.

### **Story and Gameplay Plan**

#### Background

Thornvail a vast magical forest that once served as a natural barrier between human and ork lands, until some ancient force was lost. The forest is ancient and full of secrets, ruins, puzzles and mysteries. It is now under siege by an army of Orks. 
 
The orks are led by the warlord Brokil the Flame-Eater, who broke the forest's magical barrier. In doing so they’ve unleashed wild magic, warping the environment and awakening dangerous creatures. Their goal, to conquer and claim the Heart of the Forest, a source of immense power. 

Brokil has sent his General, Blazetooth an ork beast warden to scout and raise the forest allowing the orks to advance into the heartland of thornvail. Your kigndom has sent you to stop his incersion and push back the ork threat. 

#### First level - Ashroot Glade 

📜 Awakening in the Ash <br>
Objective: You arrive in a grove scarred by flame. The air is thick with smoke, and the earth is charred. <br> 
You Must: <br>
* Move through the grove learning basic movement. <br>
* Explore the enviroment. <br>
* Meet a dying guardian spirit.

📜 First Blood on Burning Leaves <br>
Objective: Ork scouts are patrolling the outer grove. A test of steel and courage. <br>
You Must: <br>
* Engage in your first combat encounter and learn its mechanics. <br>
* Survive two short fights: one vs a lone ork, then a group with a ranged attacker. <br>

📜 Embers in the Roots <br>
Objective: The grove’s ancient trees are aflame. If not stopped, the warding magic here will collapse completely. <br>
You Must: <br>
* Redirect the nearby stream to put out the fire. <br>
* Activate an ancient ward node after extinguishing the fire. <br>

📜 The Beastmaster’s Trail <br>
Objective: A hulking ork known as Blazetooth is capturing corrupted beasts and razing key glades.
You Must: <br>
* Track Blazetooth by following claw marks and broken trees.
* Defeat any encountered patrols of orks.

📜 Trial by Flame – Blazetooth <br>
Objective: Defeat Blazetooth, the ork beastmaster, and save the forest from complete destruction.
You Must: <br>
* Enter the burning grove to face Blazetooth and his warped pets.
* Use what you learned through the tutorial to defeat him.
* Unlock the way to Runestone Vale.
  
#### Level Map - Ashroot Glade

![screenshot](documentation_images/Ashroot_Glade_Map.png)

#### Second level - Runestone Vale

📜 Behind Enemy Vines <br>
Objective: You've breached the perimeter of Runestone Vale, a newly constructed ork fortresss. <br>
You Must: <br>
* Infiltrate the ork camp's perimeter.
* Disable two watchtowers to prevent reinforcments.
* Question a captured guardian to learn what the orks are doing in the vale.

📜 Chains Beneath the Stones <br>
Objective: Discover the source of corrupted magical surges. <br>
You Must: <br>
* Explore the lower mining pit where the orks are unearthing ancient wards.
* Navigate the mines to reach the inner prison vault.
* Witness the source of the magical surges.

📜 The Warden's Remains <br>
Objective: To weaken Bjarni's bindings, you must reclaim shards of his spirit to help free his mind.
* Recover pieces of Bjarni's spirit (It is not required to recover all shards but it will make the boss fight easier)
* Desecrated Grove - defend a guardians last stand to recieve shard
* Ork Ritual Pit - Interrupt a dark ritual and steal back a shard.
* Broken Shrine - Repair the shrine to collect a shard.

📜 Camp of Iron and Flame <br>
Objective: Strike at the heart of the ork operation, a forge where they're creating twisted weapons powered by stolen magic. <br>
You Must: <br>
* Destroy enchanted forges
* Free prisoners
* Collect runeblade fragments

📜 The Corrupted Warden - Bjarni <br>
Objective: Bjarni has been chained, tortured, and twisted by the orks. You now face him in a corrupted arena to stop his release. <br>
You Must: <br>
* Enter the central prison. Solve puzzles in combat and break his chains.
* Phase 1: Bjarni in his corrupted state rampages through the room.
* Phase 2: step on rune sigils and align lights to weaken him.
* Phase 3: Use the runeblade and the spirite shards to either - Cleanse his corruption (if all shards were collected) or 'end' his corruption 

#### Level Map - Runestone Vale

![screenshot](documentation_images/Runestone_Vale_map.png)

#### Player Progression

You start as a knight in the kingdom of Thornvail, during the tutorial you learn basic movement and your base attack, later you learn two special abilitys one slash heavy attack and a heavy fire attack you get after defeating the first boss. 

### **Flowcharts (Production plan)**

![screenshot](documentation_images/Flowchart.png)

### **Assets**

Below are the links to all the itch.io pages where i found my assets. <br>
Used for the game enviroment and terrain on the first level, https://aamatniekss.itch.io/topdown-fantasy-forest <br>
The Player and Enemie sprites can be found here, https://zerie.itch.io/tiny-rpg-character-asset-pack <br>
GUI for health bar, https://mounirtohami.itch.io/pixel-art-gui-elements <br>
The font used in the game, https://mounirtohami.itch.io/minimalpixel-font <br>
Fire textures, https://tekilor.itch.io/2d-fires-pack-2 <br>
Texture for lighting, https://pixelfranek.itch.io/free-textures-of-light <br>
Candles in level one and main terrain pack for level two, https://szadiart.itch.io/rogue-fantasy-catacombs <br>
Some of the objects in level two, https://cainos.itch.io/pixel-art-top-down-basic <br>
Main background music, https://alkakrab.itch.io/free-25-fantasy-rpg-game-tracks-no-copyright-vol-2 <br>
Background music for the boss battles, https://alkakrab.itch.io/fantasy-boss-battle-music-pack-vol-2 <br>
SFX for the ork enemies, https://johncarroll.itch.io/orc-voice-pack <br>
SFX for player movement, https://nebula-audio.itch.io/character-footsteps-rock-grass-pack-1 <br>

## **Prototypes**

### **Prototype 1 - Core Systems**

#### Important Additions - Player Controller, Base combat (player and enemie), Enemie patrol (basic)

Player Movement
```gd
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Back") - Input.get_action_strength("Forward")
	direction = direction.normalized()
```
 
Dashing
```gd
if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0:
	is_dashing = true
	dash_timer = dash_duration
	dash_cooldown_timer = dash_cooldown
	velocity = direction * dash_speed 
  
  	if direction.y < 0:
		sprite.rotation_degrees = flip_adjusted_angle(-simulate_updown_angle)
	elif direction.y > 0:
		sprite.rotation_degrees = flip_adjusted_angle(simulate_updown_angle)
	else:
		sprite.rotation_degrees = 0
```

Light Attack
```gd
if Input.is_action_just_pressed("attack_light") and can_attack:
	light_attack()
	print("Light Attack")

func light_attack():
	can_attack = false
	base_attack_shape.disabled = false  # Enable hitbox
	
	sprite.play("Attack1")

	await get_tree().create_timer(0.1).timeout  # Small delay for hit detection

	for body in base_attack.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			body.take_damage(5)

	base_attack_shape.disabled = true  # Disable hitbox again

	await get_tree().create_timer(0.6).timeout  # Cooldown delay
	can_attack = true
```

Enemy Attack
```gd
if distance <= attack_range and can_attack:
	attack()
func _on_attack_cooldown_timeout():
	can_attack = true

func attack(): 
	can_attack = false
	attack_cooldown_timer.start(attack_cooldown)
	
	player.take_damage(attack_damage)
	print("Enemy attacked player")
```

Enemy Aggro and Patrol
```gd
if is_aggroed:
	
	face_player()
	
	var distance = player.global_position.distance_to(global_position)
	
	if distance <= attack_range and can_attack:
		attack()
	else:
		navigation_agent.set_target_position(player.global_position)
		if not navigation_agent.is_navigation_finished():
			var next_path = navigation_agent.get_next_path_position()
			move_towards(next_path, delta)

	
elif is_returning_to_patrol:
	var return_target = patrol_path_follow.global_position
	if global_position.distance_to(return_target) < 10:
		is_returning_to_patrol = false
	else:
		move_towards(return_target, delta)

	
else:
	var patrol_target = patrol_path_follow.global_position
	if global_position.distance_to(patrol_target) < 10:
		
		patrol_path_follow.progress += speed * delta
	else:
		move_towards(patrol_target, delta)
```

#### Video of Functionality (link to youtube)

[![Prototype 1 26 May](https://img.youtube.com/vi/DqD7hDQ_Xno/0.jpg)](https://www.youtube.com/watch?v=DqD7hDQ_Xno)

#### Issues
Enemies would sometimes get stuck on terrain while patrolling because the navigation wasn’t perfect. Dashing could let the player clip through walls, which broke some areas. Attacking also locked movement, and if you pressed a button during an animation it would sometimes just ignore the input, which made combat feel a bit clunky.

### **Prototype 2 - Enemies, world layout, ui**

#### Important Additions 

This prototype focused mostly on visual additions such as level design and ui, with small amounts of code when implementing new enemies such as undoing some hard coded features. 

Ui - Energy System
```gd
func update_energy_bar(energy):
	activeEnergy.visivle = false
	
	if energy == 7:
		fullEnergy.visible = true
		activeEnergy = fullEnergy
	
	elif energy == 6:
		energy6.visible = true
		activeEnergy = energy6
		
	elif energy == 5:
		energy5.visible = true
		activeEnergy = energy5
		
	elif energy == 4:
		energy4.visible = true
		activeEnergy = energy4
		
	elif energy == 3:
		energy3.visivle = true
		activeEnergy = energy3
		
	elif energy == 2:
		energy2.visible = true
		activeEnergy = energy2
		
	elif energy == 1:
		energy1.visible = true
		activeEnergy = energy1
		
	else:
		activeEnergy = energy0
```

#### Video of Functionality (link to youtube)

[![Prototype 2 7 June](https://img.youtube.com/vi/eBECJ2ZKu4k/0.jpg)](https://www.youtube.com/watch?v=eBECJ2ZKu4k)

#### Issues 
Some of the new UI elements didn’t scale properly with different screen sizes, so things like the health and energy bars ended up in the wrong spots. I also never fixed sprite layering, so sometimes characters show up behind trees or rocks when they shouldn’t, which makes things look a bit off.


### **Prototype 3 - Tutorial, damage popups and new attacks**

#### Important Additions 

Damage Popups
```gd
extends Node

func display_number(value:int, position: Vector2, is_critical:bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var colour = '#FFF'
	if is_critical:
		colour = '#B22'
	if value == 0:
		colour = '#FFF8'

	number.label_settings.font_color = colour
	number.label_settings.font_size = 10
	number.label_settings.outline_color = '#000'
	number.label_settings.outline_size = 1
	
	call_deferred("add_child",number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25	
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
```

Tutorial triggers
```gd
func _physics_process(delta: float):
	if thirdTooltip.visible and click_seen_num < 5:
		if Input.is_action_just_pressed("attack_light"):
			click_seen_num += 1
		if click_seen_num == 5:
			thirdTooltip.visible = false
			heavyAttkTooltip.visible = true
	if heavyClick == false:
		if Input.is_action_just_pressed("attack_heavy"):
			heavyClick = true
			await get_tree().create_timer(2).timeout
			heavyAttkTooltip.visible = false
```

New attack - Heavy
```gd
func use_heavy_attack():
	can_attack = false
	
	var facing_left = sprite.flip_h
	hitbox_left_H.disabled = not facing_left
	hitbox_right_H.disabled = facing_left
	
	sprite.play("Attack2")
	
	await get_tree().create_timer(0.15).timeout
	
	for body in heavy_attack.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var dmg = rng.randi_range(7,10)
			body.take_damage(dmg)
	
	hitbox_left_H.disabled = true
	hitbox_right_H.disabled = true
	
	await get_tree().create_timer(0.6).timeout
	can_attack = true
```

#### Video of Functionality (link to youtube)

[![Prototype 3 8 June](https://img.youtube.com/vi/au8M1duLbQ8/0.jpg)](https://www.youtube.com/watch?v=au8M1duLbQ8)

#### Issues 
Some tutorial prompts could trigger more than once if the player backtracked through the area, which sometimes caused them to overlap or progress out of order. This could break the flow or softlock the tutorial if triggers got hit in the wrong sequence.	

### **Prototype 4 - Interactions, Puzzels and Ui updates**

#### Important Additions 

Interaction Manager
```gd
extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[E] to "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		#label.global_position.y -= 20
		#label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
```

Interaction Area
```gd
class_name InteractionArea
extends Area2D

@export var action_name: String = "Interact"

var interact: Callable = func():
	pass


func _on_body_entered(body):
	if body is Player:
		InteractionManager.register_area(self)


func _on_body_exited(body):
	if body is Player:
		InteractionManager.unregister_area(self)

```

Lily Pad Puzzles
```gd
extends Node2D

var lilyOrder = []

@onready var single_lily: InteractionArea = $"single lily"
@onready var double_lily: InteractionArea = $"double lily"
signal waterPuzzle

func _ready():
	single_lily.interact = Callable(self, "on_interact_s")
	double_lily.interact = Callable(self, "on_interact_d")
	

	
func on_interact_s():
	lilyOrder.append("s")
	if lilyOrder.size() == 5:
		checkOrder()
	
func on_interact_d():
	lilyOrder.append("d")
	if lilyOrder.size() == 5:
		checkOrder()
		
func checkOrder():
	if lilyOrder == ["s","d","s","d","d"]:
		emit_signal("waterPuzzle")
	else:
		lilyOrder = []
```

#### Video of Functionality (link to youtube)

[![Prototype 4 8 June](https://img.youtube.com/vi/4y8tH9JwVWE/0.jpg)](https://www.youtube.com/watch?v=4y8tH9JwVWE)

#### Issues 
When multiple interactables overlapped, the system sometimes picked the wrong one, even if it was further away which made interactions feel inconsistent. The lily pad puzzle also didn’t reset its visuals properly after a wrong input, so players couldn’t tell if their progress had been wiped or not.

### **Prototype 5 - More Enemie Attacks, Lighting and health regen**

#### Important Additions 

Attack Selection System - Elite and Boss 
```gd
func perform_attack():
	can_attack = false
	is_attacking = true
	attack_cooldown_timer.start(attack_cooldown)

	# Enrage check
	if not enraged and health <= 25:
		enraged = true
		attack_cooldown *= 0.75 # Faster attacks when enraged
		$PointLight2D.show()

	# Pick attack phase based on enraged or not
	if enraged:
		# Higher chance of sweep or heavy
		var roll = rng.randi_range(0, 100)
		if roll < 40:
			attack_phase = 0 # base
		elif roll < 70:
			attack_phase = 1 # heavy
		else:
			attack_phase = 2 # sweep
	else:
		# Normal chance
		attack_phase = rng.randi_range(0, 2)

	# Perform attack phase
	if attack_phase == 0:
		# Base attack
		var damage = attack_damage * rng.randf_range(.75, 1.25)
		player.take_damage(damage, true)
		animated_sprite.play("Attack1")
	elif attack_phase == 1:
		# Heavy attack
		animated_sprite.play("Attack2")
		await heavy_attack_phase()
	elif attack_phase == 2:
		# Sweep attack
		animated_sprite.play("Attack3")
		await sweep_attack_phase()
```

Heavy Attack - Elite and Boss
```gd
func heavy_attack_phase():
	# Enable correct hitbox based on facing
	var facing_left = animated_sprite.flip_h
	heavy_hitbox_left.disabled = not facing_left
	heavy_hitbox_right.disabled = facing_left

	await get_tree().create_timer(0.15).timeout

	for body in heavy_attack.get_overlapping_bodies():
		if body == player:
			player.take_damage(attack_damage * 1.75, true) # Heavy hits harder

	# Disable hitboxes
	heavy_hitbox_left.disabled = true
	heavy_hitbox_right.disabled = true
```

Sweep Attack - Elite and Boss
```gd
func sweep_attack_phase():
	sweep_hitbox.disabled = false

	await get_tree().create_timer(0.2).timeout

	for body in sweep_attack.get_overlapping_bodies():
		if body == player:
			player.take_damage(attack_damage * 1.5, true) 
			
	sweep_hitbox.disabled = true
```

Player - Health Regen
```gd
# Passive health regen
if time_since_last_damage > regen_delay and health < max_health and !is_dead:
	health += regen_rate * delta
	if health > max_health:
		health = max_health
	ui.update_health_bar(int(health))
```

#### Video of Functionality (link to youtube)

[![Prototype 5 9 June](https://img.youtube.com/vi/SzGvsq4UhoA/0.jpg)](https://www.youtube.com/watch?v=SzGvsq4UhoA)

#### Issues 
The health bar updated in big jumps instead of smoothly, but I fixed it by ticking a setting checkbox in the UI options. The sweep attack hitboxes also stayed active after the animation ended, which caused damage even when it looked like the attack was over.


### **Prototype 6 - Quest System, Last Player Abilitie, Finalise Level**

#### Important Additions 

Quest Manager
```gd
extends Node

# List of current active quests
var active_quests: Array[Quest] = [] # list of active quests

# List of completed quests
var completed_quests: Array[Quest] = [] #list of completed quests

signal quests_updated # signal for when a quest is updated (so the visual component can update)

func add_quest(quest: Quest):
	if not _has_quest(quest.name): # checks if the quest isn't already active
		active_quests.append(quest) # adds the quest to active questss
		print("Quest added: ", quest.name)
		quests_updated.emit() # sends signal

func complete_quest(quest: Quest):
	if quest in active_quests:  # Checks all quests
		quest.is_complete = true # sets it to completed
		active_quests.erase(quest) # removes it from active quests
		completed_quests.append(quest) # adds quest to completed quests
		print("Quest completed: ", quest.name)
		quests_updated.emit() # senf signal

func advance_quest_objective(quest: Quest):
	if quest in active_quests: # checks if the quest is in active quests
		quest.current_objective_index += 1 # chnages the current objective
		if quest.current_objective_index >= quest.objectives.size():
			complete_quest(quest) # if completed all objectives complete the quest
		else:
			print("Advanced quest: ", quest.name, " → ", quest.get_current_objective())
			quests_updated.emit() # send signal

func get_active_quests() -> Array[Quest]:
	return active_quests # Just returns active quest (helper func )

func get_quest_by_name(quest_name: String) -> Quest:
	for q in active_quests:
		if q.name == quest_name:
			return q
	for q in completed_quests:
		if q.name == quest_name:
			return q
	return null

func _has_quest(quest_name: String) -> bool: # just checks if the quest exists in the manager either in 
	return get_quest_by_name(quest_name) != null

```

Quest Resource
```gd
class_name Quest
extends Resource

@export var name: String
@export var description: String
@export var objectives: Array[String] = []
var current_objective_index: int = 0
var is_complete: bool = false

func get_current_objective() -> String:
	if current_objective_index < objectives.size():
		return objectives[current_objective_index]
	return ""

var objective_progress: Dictionary = {}

func update_progress(key: String, amount: int = 1) -> bool:
	if current_objective_index >= objectives.size():
		return false
		
	if not objective_progress.has(key):
		objective_progress[key] = 0
		
	objective_progress[key] += amount
	return true

func get_progress(key: String) -> int:
	return objective_progress.get(key, 0)

```

Last Player Ability - Fire Attack
```gd
func use_fire_attack():
	can_attack = false
	
	var facing_left = sprite.flip_h
	hitbox_left_f.disabled = not facing_left
	hitbox_right_f.disabled = facing_left
	
	sprite.play("Attack3")
	
	await get_tree().create_timer(0.20).timeout
	
	for body in fire_attack.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var dmg = rng.randi_range(9,12)
			body.take_damage(dmg)
			
	hitbox_left_f.disabled = true
	hitbox_right_f.disabled = true
	
	await get_tree().create_timer(0.6).timeout
	can_attack = true
```

#### Video of Functionality (link to youtube)

[![Prototype 6 10 June](https://img.youtube.com/vi/sr4IiLtbKJ0/0.jpg)](https://www.youtube.com/watch?v=sr4IiLtbKJ0)


#### Issues 
Players could break the intended story sequence by slipping through terrain gaps near the boss arena, letting them reach the fight early without completing the required objectives.


## **Reflection**

### **How is the overall design**
I think the overall design works well. The structure and flow of the game feels solid and plays how I wanted it to. The tutorial cave at the start is probably my favourite part. That said, the combat system still needs some polish to feel smoother and more responsive. 

### **How far through my plan did i get**
I finished pretty much all of the first level and the core systems I wanted: movement, the three player attacks, enemy AI with patrol and attacks, terrain and level layout, UI for health and energy, a basic quest system, the tutorial section with on-screen text and interactables, and the first boss fight (plus an elite enemy with the same attacks but less damage). I also added sound effects, puzzles, a death screen, and checkpoints that update your respawn point.

I didn’t end up starting level two, so none of the stuff I planned for that made it in. That includes the Bjarni boss fight, which was going to have multiple phases and a system where collecting spirit shards made the fight easier. It would’ve been a big moment in the game, but i had to prioritise the polishing of the game and other assignments.

#### Flowchart Comparison
![Flowchart Comparison](<documentation_images/Screenshot 2025-06-12 143323wfwfw.png>)
The crosses out ones are completed. 

#### Map Comparison
![screenshot](documentation_images/Screenshot%202025-06-11%20003709.png)

### **What changes could i make and what would i do diffirently**
If I had more time, I would’ve liked to finish level two and get the full story in. Combat and puzzle systems definitely still need some work and both could be more clear and better balanced. The tutorial is solid and teaches the basics well, so I’d keep that mostly the same.

### **What issues did i encounter**
A few annoying problems came up. When I added respawning, enemies would stay aggroed after the player died, which broke things. I couldn’t get hitbox rotation working properly either, so I just made separate left and right hitboxes. I also lost a full lesson of work because of a merge error. The UI, especially the quest part, still feels rough and a bit buggy. I fixed most stuff by trial and error or just worked around it if I couldn’t find a clean solution.

### **What have I learnt**
This was my first time making a game this big in Godot, so I learnt a lot. Signals ended up being super useful. I also figured out how to manage files properly and use global scripts. The flowchart and questlines I planned out early made everything easier to build later on. If I did this again, I might try to start earlier, I don’t think time management was a big issue.