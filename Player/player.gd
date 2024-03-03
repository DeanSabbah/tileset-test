class_name Player extends CharacterBody2D

signal healthChanged(curHealth:int)

@export var speed:int = 45
@export var maxHealth = 5

@onready var animations = $AnimationPlayer
@onready var effects = $Effects
@onready var currentHealth:int = maxHealth
@onready var hurtTimer = $HurtTimer

@export var knockbackPower = 300

var isHurt:bool = false
var enemyCols = []

func _ready():
	effects.play("RESET")

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed

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

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	if !isHurt:
		for enemyArea in enemyCols:
			hurtByEnemy(enemyArea)

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
