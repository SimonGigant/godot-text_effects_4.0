@tool
extends "res://addons/teeb.text_transitions/transitions/TransitionBase.gd"

# Should have GlobalCharEffectSettings.fade_distance = 1

# Syntax: [console][/console]
var bbcode = "console"

var CURSOR = GlyphConverter.ord("█")
var CURSOR_COLOR = Color.GREEN_YELLOW

var last_char = -1

func _process_custom_fx(char_fx : CharFXTransform):
	var tween_data = get_tween_data(char_fx)
	var cursor_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, CURSOR)
	var space_as_glyph_index = GlyphConverter.char_to_glyph_index(char_fx.font, SPACE)
	
	if tween_data.reverse:
		# When fading out, just scroll all text up and fade.
		char_fx.offset.y -= 32 * (1.0 - tween_data.time)
		char_fx.color.a *= pow(tween_data.time, 8.0)
	else:
		if tween_data.time == 1.0:
			# When the transition is over, draw blinking cursor.
			if char_fx.range.x == last_char and sin(char_fx.elapsed_time * 16.0) > 0.0:
				char_fx.glyph_index = cursor_as_glyph_index
				char_fx.color = CURSOR_COLOR
		else:
			# Hacky way to find last character.
			if char_fx.relative_index == 0:
				last_char = -1
			# Effect length of 1, since consoles have one cursor.
			var t1 = tween_data.get_t(char_fx.range.x, false)
			var t2 = tween_data.get_t(char_fx.range.x+1, false)
			if t1 > 0.0 and char_fx.glyph_index != space_as_glyph_index:
				if t1 != t2:
					char_fx.glyph_index = cursor_as_glyph_index
					char_fx.color = CURSOR_COLOR
				else:
					char_fx.glyph_index = space_as_glyph_index
			
			if char_fx.range.x > last_char:
				last_char = char_fx.range.x
	return true
