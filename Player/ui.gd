extends Control

# Create a bunch of references for nodes 
@onready var firstTooltip = $"Tutorial Tooltips/Movement Tooltip"
@onready var secondTooltip = $"Tutorial Tooltips/Navigate Tooltip"
@onready var thirdTooltip = $"Tutorial Tooltips/Combat Tooltip"
@onready var heavyAttkTooltip = $"Tutorial Tooltips/Advanced Combat"
@onready var leaveCaveTooltip = $"Tutorial Tooltips/Leave cave"

@onready var fullEnergy = $Bars/energy/fullenergy
@onready var energy6 = $"Bars/energy/6energy"
@onready var energy5 = $"Bars/energy/5energy"
@onready var energy4 = $"Bars/energy/4energy"
@onready var energy3 = $"Bars/energy/3energy"
@onready var energy2 = $"Bars/energy/2energy"
@onready var energy1 = $"Bars/energy/1energy"
@onready var energy0 = $Bars/energy/energy0

@onready var health_bar = $Bars/health/ProgressBar

@onready var boss_bar = $"Boss Health bar"
@onready var boss_health_bar = $"Boss Health bar/ProgressBar"

@onready var death = $Death
@onready var deathRed = $Death/ColorRect
@onready var deathAnimP = $Death/AnimationPlayer
@onready var deathButtons = $Death/buttons

@onready var newAttackPopup = $newAttackPopup

signal respawn() # signal for respawning

var click_seen_num = 0 # number of time the player has left clicked while on the part of the tutorial

var heavyClick = false # if the player has used heavy clikc while on that part of tutorial

var activeEnergy # stores the active energy

func _ready() -> void:
	health_bar.value = 100 #sets healthbar value
	
	fullEnergy.visible = true #shows full energy
	activeEnergy = fullEnergy # sets energy to full
	
	firstTooltip.visible = true # starts wit hthis visible
	
func _physics_process(delta: float):
	if thirdTooltip.visible and click_seen_num < 5:
		# Logic for tutorial tooltips
		if Input.is_action_just_pressed("attack_light"):
			click_seen_num += 1
		if click_seen_num == 5:
			thirdTooltip.visible = false
			heavyAttkTooltip.visible = true
	if heavyClick == false:
		# Logic for tutorial tooltips
		if Input.is_action_just_pressed("attack_heavy"):
			heavyClick = true
			await get_tree().create_timer(2).timeout
			heavyAttkTooltip.visible = false

func update_health_bar(health):
	# Updates the value of the health bar
	health_bar.value = health
	
	
func update_energy_bar(energy):
	activeEnergy.visible = false # makes the old active energy invisible
	
	if energy == 7:
		# Changes the visible energy bar and sets the active one (same for the belowones)
		fullEnergy.visible = true
		activeEnergy = fullEnergy
	
	elif energy == 6:
		#if six energy
		energy6.visible = true
		activeEnergy = energy6
		
	elif energy == 5:
		#if five enrgy
		energy5.visible = true
		activeEnergy = energy5
		
	elif energy == 4:
		#if four energy
		energy4.visible = true
		activeEnergy = energy4
		
	elif energy == 3:
		#if three energy
		energy3.visible = true
		activeEnergy = energy3
		
	elif energy == 2:
		# if two energy
		energy2.visible = true
		activeEnergy = energy2
		
	elif energy == 1:
		# if one enrgy
		energy1.visible = true
		activeEnergy = energy1
		
	else:
		# If no energy
		activeEnergy = energy0
		
func update_boss_bar(bhealth):
	# updates the boss bars value
	boss_health_bar.value = bhealth
	
func deathAnim():
	# plas the death animation (ui)
	deathAnimP.play("fade in")


func _on_respawn_pressed():
	# Hides the death ui and sends the signal
	death.hide()
	emit_signal("respawn")
	


func _on_restart_pressed():
	# Opens the file for this level again (hard reset )
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)

func _on_rider_boss_boss_died() -> void:
	# Shows the endOfGame text
	await get_tree().create_timer(1).timeout
	$EndOFGame.show()
