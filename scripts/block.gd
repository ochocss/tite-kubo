extends Control

@export var resource : Resource
@onready var color_rect = $ColorRect
@onready var number = $Number


func _ready():
	if resource == null:
		return
	color_rect.color = resource.color
	number.text = resource.number


func set_resource(res : Resource):
	resource = res
	_ready()


func _on_area_2d_mouse_entered():
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	pass # Replace with function body.
