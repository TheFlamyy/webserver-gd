class_name ETagListHeader
extends Resource

var matches_any: bool = false
var tags: Array = []

func _init(http: String) -> void:
	if http == '*':
		matches_any = true
		return
	
	var list: PoolStringArray = http.split(',')
	for s in list:
		tags.append(ETagHeader.parse(s))

func _to_string() -> String:
	if matches_any:
		return '*'
	
	var http: String = ''
	for pair in tags:
		var tag: String = pair[0]
		var weak: bool = pair[1]
		if weak:
			http += "W/"
		http += "\"%s\", " % tag
		
	return http.trim_suffix(', ')
