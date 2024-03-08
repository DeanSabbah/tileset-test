class_name Player extends Character

signal healthChanged(curHealth:int)

@onready var effects = $Effects
@onready var hurtTimer = $HurtTimer

@export var knockbackPower:int

var isHurt:bool = false
var enemyCols = []

func _ready():
	effects.play("RESET")

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func hurtByEnemy(area, delta):
	currentHealth -= 1
	if currentHealth <= 0:
		currentHealth = maxHealth
	
	healthChanged.emit(currentHealth)
	isHurt = true

	knockBack(area.get_parent().position, delta)
	hurtTimer.start()
	effects.play("Hurt")
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hurtbox_area_entered(area:Area2D):
	if area.name == "Hitbox":
		enemyCols.append(area)

func knockBack(enemyPosition, delta):
	var tempPos = position
	tempPos.y += 3
	var knockbackDirection = (enemyPosition - tempPos).normalized()*(knockbackPower*delta*100)
	velocity = -knockbackDirection
	move_and_slide()

func _on_hurtbox_area_exited(area:Area2D):
	enemyCols.erase(area)

func _physics_process(delta):
	updateMovement(delta)
	move_and_slide()
	updateAnimation()
	if !isHurt:
		for enemyArea in enemyCols:
			hurtByEnemy(enemyArea, delta)
