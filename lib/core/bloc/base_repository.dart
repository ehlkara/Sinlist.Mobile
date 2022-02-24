import 'package:sinlist_app/core/http/api_provider.dart';

abstract class BaseRepository {
  BaseRepository(this.apiProvider);
  final ApiProvider apiProvider;
}
