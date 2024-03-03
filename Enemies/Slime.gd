extends CharacterBody2D

@onready var animations = $AnimationPlayer

@export var speed = 30
@export var limit = 0.5
@export var lungePower:int = 180
var inRange:bool
var direction

@onready var player = get_node("../../TileMap/Player")
@onready var cooldownTimer = $Cooldown

var inside:bool

func updateMovment():
	if inside and !inRange:
		velocity = (player.global_position - position).normalized()*speed
	else:
		velocity = Vector2.ZERO

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

func attack():
	velocity = (player.position - position).normalized()*lungePower
	if(!animations.is_playing()):
		animations.play("attack_" + direction)
	await get_tree().create_timer(0.4).timeout
	move_and_slide()
	cooldownTimer.start()

func on_viewRange_entered(body:Node2D):
	if body == player:
		inside = true

func on_viewRange_exited(body:Node2D):
	if body == player:
		inside = false

func _on_attack_range_body_entered(body:Node2D):
	if body == player:
		inRange = true

func _on_attack_range_body_exited(body:Node2D):
	if body == player:
		inRange = false

func _physics_process(delta):
	if cooldownTimer.is_stopped() and inRange:
		animations.stop()
		attack()
	elif !animations.is_playing() or animations.current_animation != "attack_" + direction:
		updateMovment()
		updateAnimation()
		move_and_slide()