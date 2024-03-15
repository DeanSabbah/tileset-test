extends VisibleOnScreenNotifier2D

signal enterRight()
signal enterLeft()
signal leaveRight(parent:TileSet)
signal leaveLeft(parent:TileSet)

func _on_screen_entered():
	print("Enter left")
	enterLeft.emit()

func _on_screen_entered_right():
	print("Enter Right")
	enterRight.emit()

func _on_screen_exited():
	print("Leave Left")
	leaveLeft.emit(get_parent())

func _on_screen_exited_right():
	print("Leave Right")
	leaveRight.emit(get_parent())
