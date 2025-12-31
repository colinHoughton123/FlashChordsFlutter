class RemoteVersionInfo {
  final String latestVersion;
  final int latestBuild;
  final String minVersion;
  final int minBuild;
  final bool forceUpdate;
  final String title;
  final String body;

  RemoteVersionInfo({
    required this.latestVersion,
    required this.latestBuild,
    required this.minVersion,
    required this.minBuild,
    required this.forceUpdate,
    required this.title,
    required this.body,
  });

  factory RemoteVersionInfo.fromJson(Map<String, dynamic> json) {
    return RemoteVersionInfo(
      latestVersion: json['latest']['version'],
      latestBuild: json['latest']['build'],
      minVersion: json['minimum_supported']['version'],
      minBuild: json['minimum_supported']['build'],
      forceUpdate: json['force_update'] ?? false,
      title: json['message']['title'],
      body: json['message']['body'],
    );
  }
}