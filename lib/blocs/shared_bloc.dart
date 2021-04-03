class SharedBloc {
  static String connectedDeviceIp = "0.0.0.0";

  static void setDevice(String ip) {
    connectedDeviceIp = ip;
  }
}
