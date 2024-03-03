class_name Enemy extends Character


@export var speed:int
@export var limit:float
@export var lungePower:int

@onready var player = get_node("/root/World/TileMap/Player")
@onready var cooldownTimer = $Cooldown

var inside:bool
var inRange:bool

func updateMovment():
	if inside and !inRange:
		velocity = (player.global_position - position).normalized()*speed
	else:
		velocity = Vector2.ZERO

func attack():
	pass

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