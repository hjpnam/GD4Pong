extends Node

@export var victory_score: int = 2

var player1_score: int = 0
var player2_score: int = 0
var ball_launch_direction: Vector2 = Vector2.LEFT if randi() % 2 else Vector2.RIGHT
var can_launch_ball: bool = false

func _ready() -> void:
	setup_game()


func setup_game() -> void:
	reset_scores()
	setup_round()


func setup_round() -> void:
	set_ball_in_center()
	$Ball.show()
	ball_launch_direction = Vector2(-ball_launch_direction.x, ball_launch_direction.y)
	can_launch_ball = true


func start_round() -> void:
	can_launch_ball = false
	$Ball.launch(ball_launch_direction)


func set_ball_in_center() -> void:
	var window_size := get_viewport().get_visible_rect().size

	# Ensure physics changes are applied before moving
	await get_tree().process_frame

	$Ball.set_linear_velocity(Vector2.ZERO)
	$Ball.set_position(window_size / 2)

	# Unfreeze AFTER repositioning
	$Ball.set_collision_disabled(false)
	$Ball.set_freeze_enabled(false)
	$Ball.set_sleeping(false)


func reset_scores() -> void:
	player1_score = 0
	player2_score = 0
	$HUD.reset_scores()


func check_winner() -> int:
	if player1_score >= victory_score:
		return 1
	elif player2_score >= victory_score:
		return 2
	else:
		return 0


func end_game(winner_id: int) -> void:
	$GameEndHUD.show()
	$GameEndHUD.display_winner(winner_id)


func _on_goal_area_entered(body: Node2D) -> void:
	if body.name != "Ball":
		return

	# Disable collisions BEFORE physics has a chance to re-trigger
	$Ball.set_collision_disabled(true)
	$Ball.set_freeze_enabled(true)
	$Ball.set_sleeping(true)

	$GoalCelebration.play()

	# Score update
	if $Ball.global_position.x < get_viewport().size.x / 2:
		player2_score += 1
		$HUD.set_score(2, player2_score)
	else:
		player1_score += 1
		$HUD.set_score(1, player1_score)

	await get_tree().create_timer(1.0).timeout
	var winner: int =  check_winner()
	if winner > 0:
		end_game(winner)
		
	self.call_deferred("setup_round")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("launch_ball") and can_launch_ball:
		can_launch_ball = false
		start_round()


func _on_game_end_hud_replay() -> void:
	setup_game()
