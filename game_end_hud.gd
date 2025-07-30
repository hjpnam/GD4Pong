extends CanvasLayer

signal replay

func display_winner(player_id: int) -> void:
	var victory_string := "Player {player_id} Victory!"
	%VictoryLabel.set_text(victory_string.format({"player_id": str(player_id)}))


func _on_replay_btn_pressed() -> void:
	hide()
	replay.emit()


func _on_return_2_main_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://start_screen.tscn")
