extends Control

@onready var grid_container_preload = preload("res://grid_container.tscn")
@onready var block_node = preload("res://block.tscn")
@onready var tite_kubo_preload = preload("res://tite_kubo.tscn")
@onready var inimigo_preload = preload("res://inimigo.tscn")

var grid_container : GridContainer
var tite_kubo : Sprite2D
var inimigo : Sprite2D


func _ready():
	grid_container = grid_container_preload.instantiate()
	add_child(grid_container)
	var stt : String
	
	for i in range(81):
		var block = block_node.instantiate()
		var resource = load("res://resources/block" + str(RandomNumberGenerator.new().randi_range(1, 9)) + ".tres")
		block.set_resource(resource)
		
		if i % 9 == 0 || i == 80: 
			print(stt)
			stt = ""
		
		stt = stt + " " + str(i)
		grid_container.add_child(block)
	
	tite_kubo = tite_kubo_preload.instantiate()
	inimigo = inimigo_preload.instantiate()
	
	grid_container.get_child(tite_kubo.index).add_child(tite_kubo)
	grid_container.get_child(inimigo.index).add_child(inimigo)


func _process(_delta):
	if Input.is_action_just_pressed("tite_up") && tite_kubo.index > 8 && tite_kubo.index-9 != inimigo.index:
		change_index(tite_kubo, -9)
		return
	
	if Input.is_action_just_pressed("tite_down") && tite_kubo.index < 71 && tite_kubo.index+9 != inimigo.index:
		change_index(tite_kubo, 9)
		return
	
	if Input.is_action_just_pressed("tite_left") && tite_kubo.index % 9 != 0 && tite_kubo.index-1 != inimigo.index:
		change_index(tite_kubo, -1)
		return
	
	if Input.is_action_just_pressed("tite_right") && tite_kubo.index % 9 != 8 && tite_kubo.index+1 != inimigo.index:
		change_index(tite_kubo, 1)
		return
	
	
	if Input.is_action_just_pressed("inimigo_up") && inimigo.index > 8 && inimigo.index-9 != tite_kubo.index:
		change_index(inimigo, -9)
		return
	
	if Input.is_action_just_pressed("inimigo_down") && inimigo.index < 71 && inimigo.index+9 != tite_kubo.index:
		change_index(inimigo, 9)
		return
	
	if Input.is_action_just_pressed("inimigo_left") && inimigo.index % 9 != 0 && inimigo.index-1 != tite_kubo.index:
		change_index(inimigo, -1)
		return
	
	if Input.is_action_just_pressed("inimigo_right") && inimigo.index % 9 != 8 && inimigo.index+1 != tite_kubo.index:
		change_index(inimigo, 1)
		return


func change_index(entity : Sprite2D, value : int):
	entity.index += value
	entity.reparent(grid_container.get_child(entity.index), false)


func change_buff():
	pass


func change_debuff():
	pass


func _on_button_pressed():
	var children = grid_container.get_children()
	for child in children:
		child.queue_free()
	grid_container.reset_size()
	
	_ready()
