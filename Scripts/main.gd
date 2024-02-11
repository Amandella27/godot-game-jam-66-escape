extends Node2D

@onready var hud: HUD = $HUD
@onready var darkness_timer = $DarknessTimer
@onready var player = $Player
@onready var madness_zones = $MadnessZones


func _ready():
	madness_zones.zoneGainMadness.connect(player.madness_component.gainMadness)
	player.madness_component.updateMadnessBar.connect(hud.updateMadnessBar)
	Globals.currentPlayer = player

func _physics_process(_delta):
	hud.darkness_timer_display.text = str(snapped(darkness_timer.time_left, 1))
