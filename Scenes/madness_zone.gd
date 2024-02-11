extends Area2D

signal zoneGainMadness(amount)

@onready var buildup_timer = $BuildupTimer

func _on_buildup_timer_timeout():
	zoneGainMadness.emit(1)


func _on_body_entered(body):
	if body is Player:
		Globals.currentPlayer.madness_component.gainingMadness = true
		buildup_timer.start(1)

func _on_body_exited(body):
	if body is Player:
		Globals.currentPlayer.madness_component.gainingMadness = false
		buildup_timer.stop()
