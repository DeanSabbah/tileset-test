extends CharacterBody2D

var startPos
var endPos
@onready var animations = $AnimationPlayer

@export var speed = 30
@export var limit = 0.5
@export var endPoint:Marker2D

var playerPos
var targetPos
@onready var player = get_node("/root/Player")

func _ready():
	startPos = position
	endPos = endPoint.global_position

func updateVelocity():
	var moveDirection = endPos - position
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized()*speed

func changeDirection():
	var tempEnd = endPos
	endPos = startPos
	startPos = tempEnd

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
	updateVelocity()
	move_and_slide()
	updateAnimation()
