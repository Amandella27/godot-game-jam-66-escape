extends CanvasLayer

class_name HUD

@onready var madness_bar = %MadnessBar
@onready var player = $"../Player"

@onready var darkness_timer_display = $DarknessTimerDisplay

func updateMadnessBar(amount):
	madness_bar.value = amount
