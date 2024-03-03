class_name Player extends Character

signal healthChanged(curHealth:int)

@export var speed:int = 45
@export var maxHealth = 5
@onready var currentHealth:int = maxHealth

@onready var effects = $Effects
@onready var hurtTimer = $HurtTimer

@export var knockbackPower = 800

var isHurt:bool = false
var enemyCols = []

func _ready():
	effects.play("RESET")

func updateMovement():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth <= 0:
		currentHealth = maxHealth
	
	healthChanged.emit(currentHealth)
	isHurt = true

	knockBack(area.get_parent().position)
	hurtTimer.start()
	effects.play("Hurt")
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hurtbox_area_entered(area:Area2D):
	if area.name == "Hitbox":
		enemyCols.append(area)

func knockBack(enemyPosition):
	var knockbackDirection = (enemyPosition - position).normalized()*knockbackPower
	velocity = -knockbackDirection
	move_and_slide()

func _on_hurtbox_area_exited(area:Area2D):
	enemyCols.erase(area)

func _physics_process(delta):
	updateMovement()
	move_and_slide()
	updateAnimation()
	if !isHurt:
		for enemyArea in enemyCols:
			hurtByEnemy(enemyArea)