class DashboardStats {
  final int totalUsers;
  final int totalRevenue;
  final int totalOrders;
  final double growthRate;

  DashboardStats({
    this.totalUsers = 0,
    this.totalRevenue = 0,
    this.totalOrders = 0,
    this.growthRate = 0.0,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalUsers: json['total_users'] ?? 0,
      totalRevenue: json['total_revenue'] ?? 0,
      totalOrders: json['total_orders'] ?? 0,
      growthRate: (json['growth_rate'] ?? 0.0).toDouble(),
    );
  }
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData({
    required this.label,
    required this.value,
    required this.color,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      label: json['label'] ?? '',
      value: (json['value'] ?? 0.0).toDouble(),
      color: Color(json['color'] ?? 0xFF2196F3),
    );
  }
}

class DashboardWidget {
  final String id;
  final String type;
  final String title;
  final Map<String, dynamic> config;
  final int position;

  DashboardWidget({
    required this.id,
    required this.type,
    required this.title,
    required this.config,
    required this.position,
  });

  factory DashboardWidget.fromJson(Map<String, dynamic> json) {
    return DashboardWidget(
      id: json['id'] ?? '',
      type: json['type'] ?? 'card',
      title: json['title'] ?? '',
      config: Map<String, dynamic>.from(json['config'] ?? {}),
      position: json['position'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'config': config,
      'position': position,
    };
  }
}