

class BaseResponse<T> {
  final T? data;
  final bool? status;
  final int? code;
  final String? message;

  factory BaseResponse.fromJson({
    required dynamic data,
    T Function(dynamic json)? decoder,
  }) {
    return BaseResponse(
      data: decoder?.call(data['data']?['result'] ?? '{}'),
      status: data["status"] ?? false,
      code: data["code"] ?? 0,
      message: data["message"] ?? "",
    );
  }

  @override
  String toString() {
    return 'data: $data \nstatus:$status, \ncode:$code, \nmessage:$message,';
  }

  BaseResponse({
    required this.data,
    required this.status,
    required this.code,
    required this.message,
  });
}
