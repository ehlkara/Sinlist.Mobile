abstract class ResponseBase<T> {
  final int statusCode;
  final T result;
  final ResponseError error;
  final bool hasError;
  ResponseBase(this.result, this.error, this.hasError, this.statusCode);
}

class ResponseError {
  ResponseError(this.code, this.message, this.data);
  final int code;
  final String message;
  final dynamic data;
}

class Response<T> implements ResponseBase<T> {
  Response(this.result, this.error, this.hasError, this.statusCode);

  Response.fromJson(Map<String, dynamic> json)
      : result = json["result"],
        error = json["result"],
        statusCode = json["statusCode"],
        hasError = json["hasError"];

  @override
  // TODO: implement error
  final ResponseError error;

  @override
  // TODO: implement hasError
  final bool hasError;

  @override
  // TODO: implement result
  final T result;

  @override
  // TODO: implement result
  final int statusCode;
}
