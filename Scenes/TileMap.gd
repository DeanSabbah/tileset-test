extends TileMap

#ENTER LEFT
func _on_visible_on_screen_notifier_2d_enter_left():
	var newTile = self.duplicate()
	newTile.position.x = position.x - 784
	get_parent().add_child(newTile)
	print("adding left")

#ENTER RIGHT
func _on_visible_on_screen_notifier_2d_2_enter_right():
	var newTile = self.duplicate()
	newTile.position.x = position.x + 784
	get_parent().add_child(newTile)
	print("adding right")

#LEAVE LEFT
func _on_visible_on_screen_notifier_2d_leave_left(parent):
	parent.queue_free()
	print("freeing left")

#LEAVE RIGHT
func _on_visible_on_screen_notifier_2d_2_leave_right(parent):
	parent.queue_free()
	print("freeing right")

