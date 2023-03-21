class DeviceInfo {
  String name;
  String identifier;
  String version;
  String packageName;
  String buildVersion;
  String buildNumber;
  String? model;

  DeviceInfo(this.name, this.identifier, this.version, this.packageName,
      this.buildVersion, this.buildNumber,
      {this.model});
}
