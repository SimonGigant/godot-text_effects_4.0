@tool
class_name GlyphConverter

static func get_text_server():
	return TextServerManager.get_primary_interface()

static func ord(c : String) -> int:
	return c.unicode_at(0)

static func char_to_glyph_index(font : RID, c : int) -> int:
	return get_text_server().font_get_glyph_index(font, 1, c, 0)

static func glyph_index_to_char(char_fx : CharFXTransform) -> int:
	return get_text_server().font_get_char_from_glyph_index(char_fx.font, 1, char_fx.glyph_index)
