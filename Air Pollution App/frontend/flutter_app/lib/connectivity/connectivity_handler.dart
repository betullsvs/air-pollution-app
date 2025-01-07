import 'package:flutter/material.dart';
import 'connectivity_service.dart';

class ConnectivityHandler extends StatefulWidget {
  final Widget onlineWidget;
  final Widget offlineWidget;

  const ConnectivityHandler({
    super.key,
    required this.onlineWidget,
    required this.offlineWidget,
  });

  @override
  _ConnectivityHandlerState createState() => _ConnectivityHandlerState();
}

class _ConnectivityHandlerState extends State<ConnectivityHandler> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _connectivityService.connectivityStream.listen((result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isOnline ? widget.onlineWidget : widget.offlineWidget;
  }
}