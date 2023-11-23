@tool
extends Node
class_name TextTransitionSettings


static var transitions = {}


static func register(rich_text_transition):
	transitions[rich_text_transition.id] = rich_text_transition


static func unregister(rich_text_transition):
	transitions.erase(rich_text_transition.id)
