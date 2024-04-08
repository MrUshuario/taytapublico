
class PruebaRegistro {

	int? id;
	String? tipo;
	String? fecha;
	String? titulo;

	PruebaRegistro({this.id, this.tipo, this.fecha, this.titulo});

	Map<String, dynamic> toMap() {
		return {
		'id': id,
		'tipo': tipo,
		'fecha': fecha,
		'titulo': titulo
		};
	}

	/*
	factory PruebaRegistro.fromJson(dynamic json)  =>
			PruebaRegistro(
				id: json['id'] as int?,
				tipo: json['tipo'] as String?,
				fecha: json['fecha'] as String?,
				titulo: json['titulo'] as String?,
			);

	static List<PruebaRegistro> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<PruebaRegistro> items =
		bienvenidaList.map((e) => PruebaRegistro.fromJson(e)).toList();
		return items ?? [];
	}
*/
}
