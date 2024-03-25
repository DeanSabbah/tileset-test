extends HBoxContainer

@onready var heartGuiClass = preload("res://Characters/Player/Health/heart_gui.tscn")
@onready var player = get_node("/root/World/TileMap/Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	setMaxHearts(player.maxHealth)
	updateHearts(player.currentHealth)
	player.healthChanged.connect(self.updateHearts)

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
