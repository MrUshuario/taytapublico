import 'package:floor/floor.dart';
@entity
class TipoCondicion {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? codigoTipoCondicion;
	String? descripcionCondicion;
	String? indicaCambioCondicion;
	String? flagSolicitudSisfoh;
	String? noNecesitaInformacion;
	String? orden;

	TipoCondicion({
			this.id,
      this.codigoTipoCondicion,
      this.descripcionCondicion,
      this.indicaCambioCondicion,
      this.flagSolicitudSisfoh,
      this.noNecesitaInformacion,
			this.orden});

	factory TipoCondicion.fromJson(dynamic json) {
		return TipoCondicion(
				id: json['id'],
				codigoTipoCondicion: json['codigoTipoCondicion'],
				descripcionCondicion: json['descripcionCondicion'],
				indicaCambioCondicion: json['indicaCambioCondicion'],
				flagSolicitudSisfoh: json['flagSolicitudSisfoh'],
				noNecesitaInformacion: json['noNecesitaInformacion'],
				orden: json['orden']
		);
	}

	static List<TipoCondicion> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<TipoCondicion> items =
		bienvenidaList.map((e) => TipoCondicion.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"codigoTipoCondicion": codigoTipoCondicion,
			"descripcionCondicion": descripcionCondicion,
			"indicaCambioCondicion": indicaCambioCondicion,
			"flagSolicitudSisfoh": flagSolicitudSisfoh,
			"noNecesitaInformacion": noNecesitaInformacion,
			"orden": orden
		};
	}
	
}
