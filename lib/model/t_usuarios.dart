import 'package:floor/floor.dart';
@entity
class usuarios {
	@PrimaryKey(autoGenerate: true)
	int? id;
	String? userId;
	String? userName;
	String? userClave;
	String? userRol;
	String? userDepartamento;
	String? userMenu;
	String? userCodigoRol;

	usuarios({this.id, this.userId, this.userName, this.userClave, this.userRol,
      this.userDepartamento, this.userMenu, this.userCodigoRol});

	factory usuarios.fromJson(dynamic json) {
		return usuarios(
				id: json['id'],
				userId: json['userId'],
				userName: json['userName'],
				userClave: json['userClave'],
				userRol: json['userRol'],
			userDepartamento: json['userDepartamento'],
			userMenu: json['userMenu'],
			userCodigoRol: json['userCodigoRol']
		);
	}

	static List<usuarios> listFromJson(dynamic json) {
		var bienvenidaList = json as List;
		List<usuarios> items =
		bienvenidaList.map((e) => usuarios.fromJson(e)).toList();
		return items ?? [];
	}

	Map<String, dynamic> toMap() {
		return {
			"id": id,
			"userId": userId,
			"userName": userName,
			"userClave": userClave,
			"userRol": userRol,
			"userDepartamento": userDepartamento,
			"userMenu": userMenu,
			"userCodigoRol": userCodigoRol
		};
	}
	
}
