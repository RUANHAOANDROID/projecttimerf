class BasicResponse{
  final int code;
  final String msg;
  final Map<String, dynamic> data;

  BasicResponse.fromJson(
      Map<String, dynamic> json)
      : code = json['code'] as int,
        msg = json['msg'],
        data = json['data'];

}
