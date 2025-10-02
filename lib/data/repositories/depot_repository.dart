import 'package:dio/dio.dart';
import 'package:fuel/core/exceptions/exceptions.dart';
import 'package:fuel/data/models/depot/account_balance_model.dart';
import 'package:fuel/data/models/depot/depot_model.dart';
import 'package:fuel/data/models/depot/depot_price_model.dart';
import 'package:fuel/data/providers/depot_service.dart';
import 'package:general_utilities/general_utilities.dart';

class DepotRepository {
  final DepotService _depotService;

  DepotRepository({
    required DepotService depotService,
  }) : _depotService = depotService;

  Future<List<DepotModel>> getDepots() async {
    try {
      final Response response = await _depotService.getDepots();
      final List<dynamic> resultList = response.data['result'] as List<dynamic>;
      return resultList.map((json) => DepotModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      PrintColor.red(e);
      PrintColor.red(st);
      throw const ServerException(message: "We're having trouble fetching the depots. Please try again later.");
    }
  }

  Future<List<DepotPriceModel>> getPricing() async {
    try {
      final Response response = await _depotService.getPricing();
      final List<dynamic> prices = response.data['result']['prices'] as List<dynamic>;
      return prices.map((json) => DepotPriceModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      PrintColor.red(e);
      PrintColor.red(st);
      throw const ServerException(message: "We're having trouble fetching the depots pricing. Please try again later.");
    }
  }

  Future<AccountBalanceModel> getAccountBalance() async {
    try {
      final Response response = await _depotService.getAccountBalance();
      return AccountBalanceModel.fromJson(response.data['result']);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      PrintColor.red(e);
      PrintColor.red(st);
      throw const ServerException(message: "We're having trouble fetching your account balance. Please try again later.");
    }
  }
}
