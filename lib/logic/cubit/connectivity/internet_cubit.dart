import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuel/core/constants/enums/connection_type.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_state.dart';

/// A Cubit that monitors and manages the application's internet connectivity state.
///
/// This Cubit uses a two-layered approach for robust connectivity checking:
/// 1.  It uses `connectivity_plus` to detect changes in the device's network
///     connection (e.g., switching between Wi-Fi and mobile data).
/// 2.  It uses `internet_connection_checker_plus` to verify if the active
///     network connection actually has internet access.
///
/// It emits states such as [InternetLoading], [InternetConnected], and
/// [InternetDisconnected] to which the UI can react.
class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  final InternetConnection internetConnection;
  StreamSubscription? connectivityStreamSubscription;
  StreamSubscription? internetAvailabilitySubscription;

  InternetCubit({required this.connectivity, required this.internetConnection}) : super(InternetLoading()) {
    monitorInternetConnectivity();
    monitorInternetConnection();
  }

  /// Performs an initial check of the internet connection.
  ///
  /// This should be called at app startup to determine the initial connectivity
  /// state rather than waiting for the first change event from the stream listeners.
  Future<void> initialize() async {
    await checkInternetConnection();
  }

  /// Checks the current network and internet status and emits the appropriate state.
  ///
  /// This method first determines the physical connection type (e.g., Wi-Fi, mobile).
  /// It then verifies if that connection has actual internet access. Based on the
  /// results, it emits an [InternetConnected] state with the connection details
  /// or an [InternetDisconnected] state.
  ///
  /// [connectivityResult] can be passed to avoid an unnecessary async call if
  /// the result is already available from a stream.
  Future<void> checkInternetConnection({
    List<ConnectivityResult>? connectivityResult,
  }) async {
    connectivityResult ??= await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emitInternetDisconnected();
    } else {
      InternetStatus internetStatus = await internetConnection.hasInternetAccess ? InternetStatus.connected : InternetStatus.disconnected;

      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        emitInternetConnected(
          connectionType: ConnectionType.mobile,
          internetStatus: internetStatus,
        );
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        emitInternetConnected(
          connectionType: ConnectionType.wifi,
          internetStatus: internetStatus,
        );
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        emitInternetConnected(
          connectionType: ConnectionType.ethernet,
          internetStatus: internetStatus,
        );
      } else {
        emitInternetDisconnected();
      }
    }
  }

  /// Sets up a listener to react to changes in the device's network connectivity.
  ///
  /// This method subscribes to the `onConnectivityChanged` stream from the
  /// `connectivity_plus` package. Whenever the network type changes (e.g., from
  /// Wi-Fi to mobile data), it triggers a new call to [checkInternetConnection].
  StreamSubscription<List<ConnectivityResult>> monitorInternetConnectivity() {
    return connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) async {
      await checkInternetConnection(connectivityResult: connectivityResult);
    });
  }

  /// Sets up a listener to react to changes in actual internet access.
  ///
  /// This method subscribes to the `onStatusChange` stream from the
  /// `internet_connection_checker_plus` package. It updates the [InternetConnected]
  /// state's `internetStatus` when access is gained or lost, which is useful for
  /// scenarios like connecting to a Wi-Fi network that has no internet uplink.
  StreamSubscription<InternetStatus> monitorInternetConnection() {
    return internetAvailabilitySubscription = internetConnection.onStatusChange.listen((status) {
      if (state is InternetConnected) {
        emitInternetConnected(internetStatus: status);
      }
    });
  }

  /// Emits an [InternetConnected] state with the latest connection details.
  ///
  /// If the current state is already [InternetConnected], this method intelligently
  /// updates it with the new [connectionType] or [internetStatus], preserving
  /// any existing values. If the state is not [InternetConnected], it creates a new
  /// instance.
  void emitInternetConnected({
    ConnectionType? connectionType,
    InternetStatus? internetStatus,
  }) {
    if (state is InternetConnected) {
      emit(
        (state as InternetConnected).copyWith(
          connectionType: connectionType,
          internetStatus: internetStatus,
        ),
      );
    } else {
      emit(
        InternetConnected(
          connectionType: connectionType,
          internetStatus: internetStatus,
        ),
      );
    }
  }

  /// Emits an [InternetDisconnected] state and shows a user-facing toast notification.
  ///
  /// This provides immediate visual feedback to the user that the internet
  /// connection has been lost, in addition to updating the application's state.
  void emitInternetDisconnected() {
    Fluttertoast.showToast(
      msg: "No internet connection",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    emit(InternetDisconnected());
  }

  /// Cleans up resources by canceling active stream subscriptions.
  ///
  /// This is crucial to prevent memory leaks when the Cubit is disposed.
  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    internetAvailabilitySubscription?.cancel();
    return super.close();
  }
}
