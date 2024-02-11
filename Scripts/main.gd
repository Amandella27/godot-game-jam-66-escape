extends Node2D

@onready var hud: HUD = $HUD
@onready var darkness_timer = $DarknessTimer

func _physics_process(_delta):
	hud.darkness_timer_display.text = str(darkness_timer.wait_time)
