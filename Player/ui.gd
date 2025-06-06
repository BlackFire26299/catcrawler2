extends Control

@onready var firstTooltip = $"Tutorial Tooltips/Movement Tooltip"
@onready var secondTooltip = $"Tutorial Tooltips/Navigate Tooltip"
@onready var thirdTooltip = $"Tutorial Tooltips/Combat Tooltip"

@onready var fullEnergy = $Bars/energy/fullenergy
@onready var energy6 = $"Bars/energy/6energy"
@onready var energy5 = $"Bars/energy/5energy"
@onready var energy4 = $"Bars/energy/4energy"
@onready var energy3 = $"Bars/energy/3energy"
@onready var energy2 = $"Bars/energy/2energy"
@onready var energy1 = $"Bars/energy/1energy"
@onready var energy0 = $Bars/energy/energy0

var activeHealth
var activeEnergy

func _ready() -> void:
	
	fullEnergy.visible = true
	activeEnergy = fullEnergy
	
func _physics_process(delta: float) -> void:
	pass

func update_health_bar(health):
	activeHealth.visible = false
	
	
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
		
