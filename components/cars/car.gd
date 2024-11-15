class_name Car

extends Node2D

signal scored
signal blocked

@export var action_name:String;

var is_on_left:bool = false;
var is_clickable:bool = true;


func _process(delta: float) -> void:
	if Input.is_action_just_released(action_name) and is_clickable:
		is_clickable = false
		move_car()


func move_car() -> void:
	if (is_on_left):
		is_on_left = false
		$AnimationPlayer.play("move_right")
	else:
		is_on_left = true
		$AnimationPlayer.play("move_left")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_left" or anim_name == "move_right":
		is_clickable = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("points"):
		scored.emit()
	elif area.is_in_group("blocks"):
		blocked.emit()
	
	area.queue_free()
