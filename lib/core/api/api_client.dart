import 'package:dio/dio.dart';

class ApiClient {
  final Dio client;

  ApiClient(this.client);

  Future<Response> postRequest(
      String endpoint, dynamic data, String? token, bool? multiPart) async {
    return await client.post(
      endpoint,
      data: data,
      options: Options(
        headers: {
          "Content-Type":
              multiPart == false ? "application/json" : "multipart/form-data",
          if (token != null) "Authorization": "Bearer $token",
        },
        validateStatus: (status) => status! < 500,
      ),
    );
  }

  Future<Response> getRequest(String endpoint, String? token) async {
    return await client.get(
      endpoint,
      options: Options(
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        validateStatus: (status) => status! < 500,
      ),
    );
  }

  Future<Response> patchRequest(
      String endpoint, Map<String, dynamic> data, String? token) async {
    return await client.patch(
      endpoint,
      data: data,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        validateStatus: (status) => status! < 500,
      ),
    );
  }

  Future<Response> deleteRequest(String endpoint, String? token) async {
    return await client.delete(
      endpoint,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        validateStatus: (status) => status! < 500,
      ),
    );
  }
}
