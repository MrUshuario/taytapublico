
class CharlaInclusion {
	
	int? codigoCharlaInclusion;
	String? descripcionCharlaInclusion;

	CharlaInclusion({this.codigoCharlaInclusion, this.descripcionCharlaInclusion});

	factory CharlaInclusion.fromJson(dynamic json)  =>
			CharlaInclusion(
				codigoCharlaInclusion: json['codigoCharlaInclusion'] as int?,
				descripcionCharlaInclusion: json['descripcionCharlaInclusion'] as String?,
			);

	static List<CharlaInclusion> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<CharlaInclusion> items =
		bienvenidaList.map((e) => CharlaInclusion.fromJson(e)).toList();
		return items ?? [];
	}

}
