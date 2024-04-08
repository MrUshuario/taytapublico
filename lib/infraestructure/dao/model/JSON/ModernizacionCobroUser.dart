//https://www.youtube.com/watch?v=y2uQ7XTgne8

/*

{
  "DNI": 72421364
}

{
  "DNI": 72421365
}

{
"Nombres":  "Maria",
"Apellidos": "Gabriela",
"Condicion": 1,
"DNITERCERO": 72421363,
"NombreTECERO": "Alan",
"ApellidosTECERO": "Zavala",
"nombre_departamento": "LIMA",
 "nombre_provincia": "LIMA",
 "nombre_distrito": "CHORRILLOS",
"edad": 20,
"sexo": "HOMBRE",
}

{
"Nombres":  "Gabriel",
"Apellidos": "mauro",
"Condicion": 0,
"DNITERCERO": 00000000,
"NombreTECERO": "",
"ApellidosTECERO": "",
"nombre_departamento": "",
 "nombre_provincia": "",
 "nombre_distrito": "",
"edad": 0,
"sexo": "",
}

 */

class ModernizacionCobro {

  String? Nombres;
  String? Apellidos;
  int? Condicion;
  int? DNITERCERO;
  String? NombreTECERO;
  String? ApellidosTECERO;
  String? nombre_departamento;
  String? nombre_provincia;
  String? nombre_distrito;
  int? edad;
  String? sexo;


  ModernizacionCobro({
    this.Nombres,
    this.Apellidos,
    this.Condicion,
    this.DNITERCERO,
    this.NombreTECERO,
    this.ApellidosTECERO,
    this.nombre_departamento,
    this.nombre_provincia,
    this.nombre_distrito,
    this.edad,
    this.sexo,
  });





  factory ModernizacionCobro.fromJson(dynamic json) {
    return ModernizacionCobro(
        Nombres: (json['Nombres'].toString()),
        Apellidos: (json['Apellidos'].toString()),
        Condicion: int.parse(json['Condicion'].toString()),
        DNITERCERO: int.parse(json['DNITERCERO'].toString()),
        NombreTECERO: (json['NombreTECERO'].toString()),
        ApellidosTECERO: (json['ApellidosTECERO'].toString()),
        nombre_departamento: (json['nombre_departamento'].toString()),
        nombre_provincia: (json['nombre_provincia'].toString()),
        nombre_distrito: (json['nombre_distrito'].toString()),
        edad: int.parse(json['Condicion'].toString()),
        sexo: (json['sexo'].toString()));
  }

  static List<ModernizacionCobro> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<ModernizacionCobro> items =
    bienvenidaList.map((e) => ModernizacionCobro.fromJson(e)).toList();
    return items ?? [];
  }
}