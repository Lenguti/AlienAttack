class_name GameOver
extends Control

@onready var _score_label = $Panel/Score
@onready var _play_again_button = $Panel/PlayAgainButton

func _ready() -> void:
	_play_again_button.pressed.connect(_on_button_pressed)


func _process(_delta) -> void:
	_score_label.text = "FINAL SCORE: " + str(Enemy.enemy_deaths_score)


func _on_button_pressed() -> void:
	Enemy.enemy_deaths = 0
	Enemy.enemy_deaths_score = 0
	get_tree().reload_current_scene()

