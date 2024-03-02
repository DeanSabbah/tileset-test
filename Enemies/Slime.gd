extends CharacterBody2D

@onready var animations = $AnimationPlayer

@export var speed = 30
@export var limit = 0.5

@onready var player = get_node("../../Player")

var inside:bool

func updateMovment():
	if inside:
		velocity = (player.global_position - position).normalized()*speed
		if absf((player.global_position - position).x) < 10 and absf((player.global_position - position).y) < 10:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"

		animations.play("walk_" + direction)

func _physics_process(delta):
	updateMovment()
	move_and_slide()
	updateAnimation()


func on_viewRange_entered(body:Node2D):
	if body == player:
		inside = true

func on_viewRange_exited(body:Node2D):
	if body == player:
		inside = false
