extends Control

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

@onready var death = $Death
@onready var deathRed = $Death/ColorRect
@onready var deathAnimP = $Death/AnimationPlayer

var click_seen_num = 0

var heavyClick = false

var activeHealth
var activeEnergy

func _ready() -> void:
	health_bar.value = 100
	
	fullEnergy.visible = true
	activeEnergy = fullEnergy
	
	firstTooltip.visible = true
	
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

func update_health_bar(health):
	health_bar.value = health
	
	
func update_energy_bar(energy):
	activeEnergy.visible = false
	
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
		energy3.visible = true
		activeEnergy = energy3
		
	elif energy == 2:
		energy2.visible = true
		activeEnergy = energy2
		
	elif energy == 1:
		energy1.visible = true
		activeEnergy = energy1
		
	else:
		activeEnergy = energy0
		
func update_boss_bar(bhealth):
	pass
	
func deathAnim():
	deathAnimP.play("fade in")
