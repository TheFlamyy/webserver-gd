class_name ETagHeader
extends Resource

var tag: String
var weak: bool

func _init(http: String) -> void:
	var parsed: Array = parse(http)
	tag = parsed.pop_front()
	weak = parsed.pop_front()

static func parse(http: String) -> Array:
	var weak: bool = false
	if http.begins_with("W/"):
		weak = true
		http = http.trim_prefix("W/")
	return [http.trim_prefix('\"').trim_suffix('\"'), weak]

func _to_string() -> String:
	var http: String = "W/" if weak else ''
	http += "\"%s\"" % tag
	return http
