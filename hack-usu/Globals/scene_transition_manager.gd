extends Node


func transition_to( next_scene_path : String ) -> void:
	#$AnimationPlayer.play("fade_out")
	#await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(next_scene_path)
	#$AnimationPlayer.play("fade_in")
