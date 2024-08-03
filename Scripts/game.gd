class_name Game
extends Node2D

@onready var GameOverScene = preload("res://Scenes/game_over.tscn")
@onready var _bg_music_player: AudioStreamPlayer = $BackgroundMusic
@onready var _explosion_player: AudioStreamPlayer = $Explosion
@onready var _canvas = $CanvasLayer
@onready var _hud = $CanvasLayer/HUD
@onready var _player_health_component = $Player/HelthComponent

func _ready() -> void:
	_player_health_component.on_death.connect(_on_player_death)
	_bg_music_player.play()


func _on_player_death() -> void:
	_explosion_player.play()
	var game_over_scene: GameOver = GameOverScene.instantiate()
	_hud.visible = false
	_canvas.add_child(game_over_scene)

