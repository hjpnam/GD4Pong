extends Control

func _ready() -> void:
	$MenuMusic.play()


func _on_start_pressed() -> void:
	$MenuMusic.stop()
	get_tree().change_scene_to_file("res://level.tscn")


func _on_exit_pressed() -> void:
	$MenuMusic.stop()
	get_tree().quit()
