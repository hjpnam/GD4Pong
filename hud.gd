extends CanvasLayer

func reset_scores() -> void:
	$Player1Score.text = "0"
	$Player2Score.text = "0"

func set_score(side: int, score: int) -> void:
	if side == 1:
		$Player1Score.text = str(score)
	elif side == 2:
		$Player2Score.text = str(score)
