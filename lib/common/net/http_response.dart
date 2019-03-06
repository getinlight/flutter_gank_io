
class HttpResponse {
  var data;
  bool isResult;
  int code;
  var headers;

  HttpResponse(this.data, this.isResult,this.code, {this.headers});
}