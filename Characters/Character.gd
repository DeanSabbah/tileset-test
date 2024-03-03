class_name Character extends CharacterBody2D

@onready var animations = $AnimationPlayer

var direction

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"

		animations.play("walk_" + direction)