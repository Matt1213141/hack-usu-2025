extends Control

func _ready():
	# Change scene based on the button the user presses
	$CanvasLayer/VBoxContainer/StartGame.pressed.connect(_on_StartButton_pressed)
	$CanvasLayer/VBoxContainer/QuitGame.pressed.connect(_on_QuitButton_pressed)

func _on_StartButton_pressed():
	# Change to your game scene
	SceneTransitionManager.transition_to("res://World.tscn")#"res://player1_input.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
