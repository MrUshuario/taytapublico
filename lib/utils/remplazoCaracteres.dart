class remplazoCaracteres {

  static String reemplazarCarateresEspeciales(String cadena) {

    String valor = cadena != null ? cadena : "";
    valor = valor.replaceAll("[á|à|Á|À]", "A");
    valor = valor.replaceAll("[é|è|É|È]", "E");
    valor = valor.replaceAll("[í|ì|Í|Ì]", "I");
    valor = valor.replaceAll("[ó|ò|Ó|Ò]", "O");
    valor = valor.replaceAll("[ú|ù|Ú|Ù]", "U");
    valor = valor.replaceAll("[ñ|Ñ]", "NN");
    //valor = valor.replaceAll("['|||°]", "");
    valor = valor.replaceAll("[^-a-zA-Z0-9\$]", "");
    //System.out.println("cadena : " + cadena);

    return valor;
  }
}