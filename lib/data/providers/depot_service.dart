import 'package:dio/dio.dart';

class DepotService {
  final Dio _authenticatedDio;

  const DepotService({
    required Dio authenticatedDio,
  }) : _authenticatedDio = authenticatedDio;

  Future<Response> getDepots() async {
    return _authenticatedDio.get("/qaapi/api/Api/GetDepots");
  }

  Future<Response> getPricing() async {
    return _authenticatedDio.get("/qaapi/api/Api/GetPricing");
  }
}
