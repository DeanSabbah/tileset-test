extends Enemy

@export var lungePower:int

func attack(delta):
	var attackMove = player.position
	attackMove.y += 3
	velocity = (attackMove - position).normalized()*(lungePower*delta*100)
	if(!animations.is_playing()):
		animations.play("attack_" + direction)
	await get_tree().create_timer(0.4).timeout
	move_and_slide()
	cooldownTimer.start()

