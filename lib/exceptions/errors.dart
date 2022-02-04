class ReachError implements Exception{
  String errMsg() => 'Servidor no alcanzado';
}

class EmptyError implements Exception{
  String errMsg() => 'Vacio';
}

class NotANumber implements Exception{
  String errMsg() => 'Ingrese solo números en el Documento...';
}

class OfertNull implements Exception{
  String errMsg() => 'Selecciona una oferta';
}