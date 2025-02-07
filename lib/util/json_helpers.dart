import 'package:intl/intl.dart';

final _githubApiDateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

DateTime githubApiDateFromJson(String date) =>
    _githubApiDateFormatter.parseUtc(date);

String githubApiDateToJson(DateTime date) =>
    _githubApiDateFormatter.format(date.toUtc());
