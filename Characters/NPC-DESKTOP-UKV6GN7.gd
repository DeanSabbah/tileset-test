class_name NPC extends Character

@onready var player = get_node("/root/World/Player")
@onready var cooldownTimer = $Cooldown

@export var attackRange:int
@export var viewRange:int

var inside:bool
var inRange:bool

func _ready():
	$ViewRange/CollisionShape2D.shape.radius = viewRange
	$AttackRange/CollisionShape2D.shape.radius = attackRange
	direction = "down"

func updateMovment(delta):
	if inside and !inRange:
		velocity = (player.position - position).normalized()*(speed*delta*100)
	else:
		velocity = Vector2.ZERO

#Player must have 3 added to y pos for attacks to be acurate
func attack(delta):
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

func _physics_process(delta):
	if cooldownTimer.is_stopped() and inRange:
		animations.stop()
		attack(delta)
	elif animations.current_animation != "attack_" + direction:
		updateMovment(delta)
		updateAnimation()
		move_and_slide()
	else:
		pass
