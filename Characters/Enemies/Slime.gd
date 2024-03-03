extends Enemy

func attack():
	velocity = (player.position - position).normalized()*lungePower
	if(!animations.is_playing()):
		animations.play("attack_" + direction)
	await get_tree().create_timer(0.4).timeout
	move_and_slide()
	cooldownTimer.start()

func _physics_process(delta):
	if cooldownTimer.is_stopped() and inRange:
		animations.stop()
		attack()
	elif !animations.is_playing() or animations.current_animation != "attack_" + direction:
		updateMovment()
		updateAnimation()
		move_and_slide()
	else:
		pass
