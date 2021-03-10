class User {
  int id;
  String apiToken;
  int defaultWid;
  String email;
  String fullname;
  String jqueryTimeofdayFormat;
  String jqueryDateFormat;
  String timeofdayFormat;
  String dateFormat;
  bool storeStartAndStopTime;
  int beginningOfWeek;
  String language;
  String imageUrl;
  bool sidebarPiechart;
  String at;
  String createdAt;
  int retention;
  bool recordTimeline;
  bool renderTimeline;
  bool timelineEnabled;
  bool timelineExperiment;
  bool shouldUpgrade;
  bool achievementsEnabled;
  String timezone;
  bool openidEnabled;
  bool sendProductEmails;
  bool sendWeeklyReport;
  bool sendTimerNotifications;
  List<Workspaces> workspaces;
  String durationFormat;

  User(
      {this.id,
        this.apiToken,
        this.defaultWid,
        this.email,
        this.fullname,
        this.jqueryTimeofdayFormat,
        this.jqueryDateFormat,
        this.timeofdayFormat,
        this.dateFormat,
        this.storeStartAndStopTime,
        this.beginningOfWeek,
        this.language,
        this.imageUrl,
        this.sidebarPiechart,
        this.at,
        this.createdAt,
        this.retention,
        this.recordTimeline,
        this.renderTimeline,
        this.timelineEnabled,
        this.timelineExperiment,
        this.shouldUpgrade,
        this.achievementsEnabled,
        this.timezone,
        this.openidEnabled,
        this.sendProductEmails,
        this.sendWeeklyReport,
        this.sendTimerNotifications,
        this.workspaces,
        this.durationFormat});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apiToken = json['api_token'];
    defaultWid = json['default_wid'];
    email = json['email'];
    fullname = json['fullname'];
    jqueryTimeofdayFormat = json['jquery_timeofday_format'];
    jqueryDateFormat = json['jquery_date_format'];
    timeofdayFormat = json['timeofday_format'];
    dateFormat = json['date_format'];
    storeStartAndStopTime = json['store_start_and_stop_time'];
    beginningOfWeek = json['beginning_of_week'];
    language = json['language'];
    imageUrl = json['image_url'];
    sidebarPiechart = json['sidebar_piechart'];
    at = json['at'];
    createdAt = json['created_at'];
    retention = json['retention'];
    recordTimeline = json['record_timeline'];
    renderTimeline = json['render_timeline'];
    timelineEnabled = json['timeline_enabled'];
    timelineExperiment = json['timeline_experiment'];
    shouldUpgrade = json['should_upgrade'];
    achievementsEnabled = json['achievements_enabled'];
    timezone = json['timezone'];
    openidEnabled = json['openid_enabled'];
    sendProductEmails = json['send_product_emails'];
    sendWeeklyReport = json['send_weekly_report'];
    sendTimerNotifications = json['send_timer_notifications'];
    if (json['workspaces'] != null) {
      workspaces = new List<Workspaces>();
      json['workspaces'].forEach((v) {
        workspaces.add(new Workspaces.fromJson(v));
      });
    }
    durationFormat = json['duration_format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['api_token'] = this.apiToken;
    data['default_wid'] = this.defaultWid;
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['jquery_timeofday_format'] = this.jqueryTimeofdayFormat;
    data['jquery_date_format'] = this.jqueryDateFormat;
    data['timeofday_format'] = this.timeofdayFormat;
    data['date_format'] = this.dateFormat;
    data['store_start_and_stop_time'] = this.storeStartAndStopTime;
    data['beginning_of_week'] = this.beginningOfWeek;
    data['language'] = this.language;
    data['image_url'] = this.imageUrl;
    data['sidebar_piechart'] = this.sidebarPiechart;
    data['at'] = this.at;
    data['created_at'] = this.createdAt;
    data['retention'] = this.retention;
    data['record_timeline'] = this.recordTimeline;
    data['render_timeline'] = this.renderTimeline;
    data['timeline_enabled'] = this.timelineEnabled;
    data['timeline_experiment'] = this.timelineExperiment;
    data['should_upgrade'] = this.shouldUpgrade;
    data['achievements_enabled'] = this.achievementsEnabled;
    data['timezone'] = this.timezone;
    data['openid_enabled'] = this.openidEnabled;
    data['send_product_emails'] = this.sendProductEmails;
    data['send_weekly_report'] = this.sendWeeklyReport;
    data['send_timer_notifications'] = this.sendTimerNotifications;
    if (this.workspaces != null) {
      data['workspaces'] = this.workspaces.map((v) => v.toJson()).toList();
    }
    data['duration_format'] = this.durationFormat;
    return data;
  }
}

class Workspaces {
  int id;
  String name;
  int profile;
  bool premium;
  bool admin;
  int defaultHourlyRate;
  String defaultCurrency;
  bool onlyAdminsMayCreateProjects;
  bool onlyAdminsSeeBillableRates;
  bool onlyAdminsSeeTeamDashboard;
  bool projectsBillableByDefault;
  int rounding;
  int roundingMinutes;
  String apiToken;
  String at;
  bool icalEnabled;

  Workspaces(
      {this.id,
        this.name,
        this.profile,
        this.premium,
        this.admin,
        this.defaultHourlyRate,
        this.defaultCurrency,
        this.onlyAdminsMayCreateProjects,
        this.onlyAdminsSeeBillableRates,
        this.onlyAdminsSeeTeamDashboard,
        this.projectsBillableByDefault,
        this.rounding,
        this.roundingMinutes,
        this.apiToken,
        this.at,
        this.icalEnabled});

  Workspaces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profile = json['profile'];
    premium = json['premium'];
    admin = json['admin'];
    defaultHourlyRate = json['default_hourly_rate'];
    defaultCurrency = json['default_currency'];
    onlyAdminsMayCreateProjects = json['only_admins_may_create_projects'];
    onlyAdminsSeeBillableRates = json['only_admins_see_billable_rates'];
    onlyAdminsSeeTeamDashboard = json['only_admins_see_team_dashboard'];
    projectsBillableByDefault = json['projects_billable_by_default'];
    rounding = json['rounding'];
    roundingMinutes = json['rounding_minutes'];
    apiToken = json['api_token'];
    at = json['at'];
    icalEnabled = json['ical_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile'] = this.profile;
    data['premium'] = this.premium;
    data['admin'] = this.admin;
    data['default_hourly_rate'] = this.defaultHourlyRate;
    data['default_currency'] = this.defaultCurrency;
    data['only_admins_may_create_projects'] = this.onlyAdminsMayCreateProjects;
    data['only_admins_see_billable_rates'] = this.onlyAdminsSeeBillableRates;
    data['only_admins_see_team_dashboard'] = this.onlyAdminsSeeTeamDashboard;
    data['projects_billable_by_default'] = this.projectsBillableByDefault;
    data['rounding'] = this.rounding;
    data['rounding_minutes'] = this.roundingMinutes;
    data['api_token'] = this.apiToken;
    data['at'] = this.at;
    data['ical_enabled'] = this.icalEnabled;
    return data;
  }
}
