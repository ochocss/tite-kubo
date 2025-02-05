extends Control

@onready var buff_label = $VBoxContainer/HBoxContainer2/BuffLabel
@onready var buff_tile = $VBoxContainer/HBoxContainer2/BuffTile

@onready var debuff_label = $VBoxContainer/HBoxContainer/DebuffLabel
@onready var debuff_tile = $VBoxContainer/HBoxContainer/DebuffTile


@onready var grid_container_preload = preload("res://scenes/grid_container.tscn")
@onready var block_node = preload("res://scenes/block.tscn")
@onready var tite_kubo_preload = preload("res://scenes/tite_kubo.tscn")
@onready var inimigo_preload = preload("res://scenes/inimigo.tscn")

var grid_container : GridContainer
var tite_kubo : Sprite2D
var inimigo : Sprite2D


func _ready():
	tite_kubo = tite_kubo_preload.instantiate()
	inimigo = inimigo_preload.instantiate()
	
	fill_grid()


func _process(_delta):
	if Input.is_action_just_pressed("tite_up") && tite_kubo.index > 8 && tite_kubo.index-9 != inimigo.index:
		change_index(tite_kubo, -9)
		change_buff()
		return
	
	if Input.is_action_just_pressed("tite_down") && tite_kubo.index < 71 && tite_kubo.index+9 != inimigo.index:
		change_index(tite_kubo, 9)
		change_buff()
		return
	
	if Input.is_action_just_pressed("tite_left") && tite_kubo.index % 9 != 0 && tite_kubo.index-1 != inimigo.index:
		change_index(tite_kubo, -1)
		change_buff()
		return
	
	if Input.is_action_just_pressed("tite_right") && tite_kubo.index % 9 != 8 && tite_kubo.index+1 != inimigo.index:
		change_index(tite_kubo, 1)
		change_buff()
		return
	
	
	if Input.is_action_just_pressed("inimigo_up") && inimigo.index > 8 && inimigo.index-9 != tite_kubo.index:
		change_index(inimigo, -9)
		change_debuff()
		return
	
	if Input.is_action_just_pressed("inimigo_down") && inimigo.index < 71 && inimigo.index+9 != tite_kubo.index:
		change_index(inimigo, 9)
		change_debuff()
		return
	
	if Input.is_action_just_pressed("inimigo_left") && inimigo.index % 9 != 0 && inimigo.index-1 != tite_kubo.index:
		change_index(inimigo, -1)
		change_debuff()
		return
	
	if Input.is_action_just_pressed("inimigo_right") && inimigo.index % 9 != 8 && inimigo.index+1 != tite_kubo.index:
		change_index(inimigo, 1)
		change_debuff()
		return


func fill_grid():
	grid_container = grid_container_preload.instantiate()
	add_child(grid_container)
	
	for i in range(81):
		var block = block_node.instantiate()
		var resource = load("res://resources/block" + str(RandomNumberGenerator.new().randi_range(1, 9)) + ".tres")
		block.set_resource(resource)
		
		grid_container.add_child(block)
	
	if tite_kubo.get_parent() == null:
		grid_container.get_child(tite_kubo.index).add_child(tite_kubo)
		grid_container.get_child(inimigo.index).add_child(inimigo)
	else:
		tite_kubo.reparent(grid_container.get_child(tite_kubo.index), false)
		inimigo.reparent(grid_container.get_child(inimigo.index), false)
	
	change_buff()
	change_debuff()


func change_index(entity : Sprite2D, value : int):
	entity.index += value
	entity.reparent(grid_container.get_child(entity.index), false)


func change_buff():
	var res : BlockResource = grid_container.get_child(tite_kubo.index).resource
	buff_label.text = res.buff
	buff_tile.set("theme_override_colors/font_color", res.color)
	buff_tile.text = "(Tile " + res.number + ")"


func change_debuff():
	var res : BlockResource = grid_container.get_child(inimigo.index).resource
	debuff_label.text = res.debuff
	debuff_tile.set("theme_override_colors/font_color", res.color)
	debuff_tile.text = "(Tile " + res.number + ")"


func _on_button_pressed():
	var children = grid_container.get_children()
	for child in children:
		child.queue_free()
	grid_container.reset_size()
	
	fill_grid()
