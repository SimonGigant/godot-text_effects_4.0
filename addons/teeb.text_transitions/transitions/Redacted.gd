@tool
extends "res://addons/teeb.text_transitions/transitions/TransitionBase.gd"


# Syntax: [redacted freq wave][/redacted]
var bbcode = "redacted"


var BLOCK = GlyphConverter.ord("█")
var MID_BLOCK = GlyphConverter.ord("▓")


func _process_custom_fx(char_fx):
	var block_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, BLOCK)
	var mid_block_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, MID_BLOCK)
	var space_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, SPACE)

	var tween_data = get_tween_data(char_fx)
	var t1 = tween_data.get_t(char_fx.range.x, false)
	var t2 = tween_data.get_t(char_fx.range.x+1, false)
	if tween_data.reverse:
		char_fx.color.a = 1.0 - t1
		if t1 != t2:
			char_fx.glyph_index = mid_block_as_glyph_index
	else:
		if t1 > 0.0 and (char_fx.glyph_index != space_as_glyph_index or char_fx.relative_index % 2 == 0):
			var freq:float = char_fx.env.get("freq", 1.0)
			var scale:float = char_fx.env.get("scale", 1.0)
			char_fx.glyph_index = mid_block_as_glyph_index if t1 != t2 else block_as_glyph_index
			char_fx.color = Color.BLACK
			char_fx.offset.y -= sin(char_fx.range.x * freq) * scale
	return true
