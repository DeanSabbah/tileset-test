class_name Character extends CharacterBody2D

@export var speed:int
@export var maxHealth:int
@onready var currentHealth:int = maxHealth

@onready var animations = $AnimationPlayer

var direction

func updateMovement(delta):
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*(speed*delta*100)

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