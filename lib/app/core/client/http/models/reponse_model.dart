class ResponseModelParse<T> {
  ResponseModel<T> execute(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ResponseModel<T>.fromJson(json, fromJson);
  }
}

class ResponseModel<T> {
  bool? erro;
  int? code;
  T? response;

  ResponseModel({this.erro, this.code, this.response});

  factory ResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ResponseModel(
      erro: json['erro'] as bool?,
      code: json['code'] as int?,
      response: fromJson(json['response'] as Map<String, dynamic>),
    );
  }

  factory ResponseModel.fromObjects(
      Map<String, dynamic> json, T Function(List<Map<String, dynamic>>) fromJson) {
    return ResponseModel(
      erro: json['erro'] as bool?,
      code: json['code'] as int?,
      response: fromJson(json['response'] as List<Map<String, dynamic>>),
    );
  }
}
