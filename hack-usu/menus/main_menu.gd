extends Control

func _ready():
	# Change scene based on the button the user presses
	$CanvasLayer/VBoxContainer/StartButton.pressed.connect("_on_StartButton_pressed")
	$CanvasLayer/VBoxContainer/QuitButton.pressed.connect("_on_QuitButton_pressed")

func _on_StartButton_pressed():
	# Change to your game scene
	get_tree().change_scene("res://World.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
