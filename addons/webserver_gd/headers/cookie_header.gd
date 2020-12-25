class_name CookieHeader
extends Resource

var cookies: Dictionary = {}

func _init(http: String) -> void:
	for pair in http.split(';'):
		var spliced: PoolStringArray = pair.split('=')
		var key: String = spliced[0]
		var value: String = spliced[1]
		cookies[key] = value


func _to_string() -> String:
	var http: String = ''
	for key in cookies:
		var value: String = cookies[key]
		http += "%s=%s;" % [key, value]
	return http.trim_suffix(';')
