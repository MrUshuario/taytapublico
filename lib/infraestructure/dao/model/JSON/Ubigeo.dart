
 class Ubigeo {
	
	String? codigoImei;
	String? codigoUbigeo;
	String? nombreDepartamento;
	String? nombreProvincia;
	String? nombreDistrito;

	Ubigeo({this.codigoImei, this.codigoUbigeo, this.nombreDepartamento,
      this.nombreProvincia, this.nombreDistrito});

	factory Ubigeo.fromJson(dynamic json) => Ubigeo(
		codigoImei: json['codigoImei'] as String?,
		codigoUbigeo: json['codigoUbigeo'] as String?,
		nombreDepartamento: json['nombreDepartamento'] as String?,
		nombreProvincia: json['nombreProvincia'] as String?,
		nombreDistrito: json['nombreDistrito'] as String?,
	);

	static List<Ubigeo> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<Ubigeo> items =
		bienvenidaList.map((e) => Ubigeo.fromJson(e)).toList();
		return items ?? [];
	}


}
