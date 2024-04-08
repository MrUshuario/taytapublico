import 'package:floor/floor.dart';
@entity
class SaberesDetalle {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? idVisita;
	String? datos;

	SaberesDetalle({this.id, this.idVisita, this.datos});


	factory SaberesDetalle.fromJson(dynamic json) {
		return SaberesDetalle(
				id: json['id'],
				idVisita: json['idVisita'],
				datos: json['datos']);
	}

	static List<SaberesDetalle> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<SaberesDetalle> items =
		bienvenidaList.map((e) => SaberesDetalle.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"idVisita": idVisita,
			"datos": datos,
		};
	}
	
}
