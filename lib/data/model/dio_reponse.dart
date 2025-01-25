class DioResponse {
  final bool isSuccess;
  final dynamic data;
  final String message;

  DioResponse({
    required this.isSuccess,
    this.data,
    this.message = '',
  });

  factory DioResponse.success(dynamic data) {
    return DioResponse(isSuccess: true, data: data);
  }

  factory DioResponse.failure(String message) {
    return DioResponse(isSuccess: false, message: message);
  }
}