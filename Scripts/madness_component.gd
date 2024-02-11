extends Node2D

signal updateMadnessBar(number)

@onready var lose_madness_timer = $LoseMadnessTimer

@export var madnessMax: int
@export var madnessCurrent: int

var gainingMadness: bool = false

func gainMadness(amount):
	gainingMadness = true
	madnessCurrent += amount
	updateMadnessBar.emit(madnessCurrent)

func loseMadness(amount):
	if madnessCurrent > 0:
		madnessCurrent -= amount
		updateMadnessBar.emit(madnessCurrent)

func _on_lose_madness_timer_timeout():
	if gainingMadness == false:
		loseMadness(1)
