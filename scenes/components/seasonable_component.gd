extends Node
class_name SeasonableComponent

@export var replacement_object : PackedScene
@export var parent : RigidBody2D

func seasoned():
	Globals.replace(parent,replacement_object)
