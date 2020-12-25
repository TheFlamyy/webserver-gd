class_name WebHeaders
extends Resource

const FIELD_MAP: Dictionary = {
	"Cache-Control": StringHeader, # todo
	"Connection": StringHeader,
	"Date": DateHeader,
	"Pragma": StringHeader,
	"Trailer": StringHeader,
	"Transfer-Encoding": StringHeader,
	"Upgrade": CSLHeader,
	"Via": CSLHeader,
	"Warning": WarningHeader,
	"Accept": ValueListHeader,
	"Accept-Charset": ValueListHeader,
	"Accept-Encoding": ValueListHeader,
	"Accept-Language": ValueListHeader,
	"Authorization": StringHeader,
	"Cookie": CookieHeader,
	"Expect": StringHeader,
	"From": StringHeader,
	"Host": StringHeader,
	"If-Match": ETagListHeader,
	"If-Modified-Since" : DateHeader,
	"If-None-Match": ETagListHeader,
	"If-Range": IfRangeHeader,
	"If-Unmodified-Since": DateHeader,
	"Max-Forwards": NumberHeader,
	"Proxy-Authorization": StringHeader,
	"Range": RangeHeader,
	"Referer": StringHeader,
	"TE": ValueListHeader,
	"User-Agent": StringHeader,
	"Accept-Ranges": StringHeader,
	"Age": NumberHeader,
	"ETag": ETagHeader,
	"Location": StringHeader,
	"Proxy-Authenticate": StringHeader,
	"Retry-After": RetryAfterHeader,
	"Server": StringHeader,
	"Set-Cookie": SetCookieHeader,
	"Vary": CSLHeader,
	"WWW-Authenticate": StringHeader,
	"Allow": CSLHeader,
	"Content-Encoding": StringHeader,
	"Content-Language": CSLHeader,
	"Content-Length": NumberHeader,
	"Content-Location": StringHeader,
	"Content-MD5": StringHeader,
	"Content-Range": ContentRangeHeader,
	"Content-Type": ContentTypeHeader,
	"Expires": DateHeader,
	"Last-Modified": DateHeader
}

var fields: Array = []

func add_field(name: String, header: Resource) -> void:
	fields.append([name, header])


func from_header(http: String) -> void:
	for line in http.split('\n'):
		var raw: PoolStringArray = line.split(':')
		var field: String = raw[0]
		raw.remove(0)
		var args: String = raw.join(':')
		if field in FIELD_MAP:
			var clazz: GDScript = FIELD_MAP[field]
			var instance: Resource = clazz.new(args)
			fields.append([field, instance])


func _to_string() -> String:
	var string: String = ""
	for field in fields:
		var msg: String = field[0]
		var instance: Resource = field[1]
		string += "%s : %s\n" % [msg, str(instance)]
	return string.trim_suffix('\n')
