@tool
extends "res://addons/teeb.text_transitions/transitions/TransitionBase.gd"


# Syntax: [wfc][/wfc]
var bbcode = "wfc"


var ONE = GlyphConverter.ord("1")
var ZERO = GlyphConverter.ord("0")


func _process_custom_fx(char_fx):
	var zero_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, ZERO)
	var one_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, ONE)
	var space_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, SPACE)
	
	var t = 1.0 - get_t(char_fx)
	var r = get_rand(char_fx)
	var a = clamp(t * 2.0 - r * t, 0.0, 1.0)
	if a != 1.0 and char_fx.glyph_index != space_as_glyph_index:
		char_fx.glyph_index = zero_as_glyph_index if sin(get_rand_time(char_fx, 16.0)) > 0.0 else one_as_glyph_index
		char_fx.color.r = 0.0
		char_fx.color.g = 0.0
		char_fx.color.b = 0.0
		a *= .5
	char_fx.color.a = t
	return true
