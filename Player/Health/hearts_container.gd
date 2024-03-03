extends HBoxContainer

@onready var heartGuiClass = preload("res://Player/Health/heart_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setMaxHearts(maxIn:int):
	for i in range(maxIn):
		var heart = heartGuiClass.instantiate()
		add_child(heart)

func updateHearts(curHealth:int):
	var hearts = get_children()

	for i in range(curHealth):
		hearts[i].update(true)
	for i in range(curHealth, hearts.size()):
		hearts[i].update(false)