extends Enemy

@export var lungePower:int

func attack():
	velocity = (player.global_position - position).normalized()*lungePower
	if(!animations.is_playing()):
		animations.play("attack_" + direction)
	await get_tree().create_timer(0.4).timeout
	move_and_slide()
	cooldownTimer.start()

