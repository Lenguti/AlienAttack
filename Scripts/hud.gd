class_name HUD
extends Control

@onready var _score_label: Label = $Score
@onready var _rocket_one: Sprite2D = $Rocket1
@onready var _rocket_two: Sprite2D = $Rocket2
@onready var _rocket_three: Sprite2D = $Rocket3
@onready var _rocket_four: Sprite2D = $Rocket4
@onready var rockets: Dictionary = {
	1: _rocket_one,
	2: _rocket_two,
	3: _rocket_three,
	4: _rocket_four,
}

func _ready() -> void:
	var _player: Player = get_parent().get_node("../Player")
	_player.rocket_did_fire.connect(_on_rocket_did_fire)
	_player.rocket_did_reload.connect(_on_rocket_did_reload)


func _process(_delta) -> void:
	if _score_label:
		_score_label.text = "SCORE: " + str(Enemy.enemy_deaths_score)


func _on_rocket_did_fire(rocket_fired: int) -> void:
	if rockets.has(rocket_fired):
		var rocket: Sprite2D = rockets[rocket_fired]
		if rocket:
			rocket.visible = false


func _on_rocket_did_reload(rocket_reloaded: int) -> void:
	if rockets.has(rocket_reloaded):
		var rocket: Sprite2D = rockets[rocket_reloaded]
		if rocket:
			rocket.visible = true

