import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_impl.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_mock.dart';
import 'package:proxy_pattern_demo/the_app/the_app_.dart';
import 'package:proxy_pattern_demo/the_app/the_app_impl.dart';
import 'package:watch_it/watch_it.dart';

void initDi() {
  // Register the ApiClientMock as the ApiClient
  // we use an async singleton that allows the app to wait for the ApiClientMock to be initialized
  di.registerSingletonAsync<ApiClient>(() => ApiClientMock().init());

  /// we ensure that the ApiClient is registered before the PostManager
  di.registerSingletonWithDependencies<PostManager>(
      () => PostManagerImplementation(),
      dependsOn: [ApiClient]);
  di.registerSingletonWithDependencies<TheApp>(() => TheAppImplementation(),
      dependsOn: [PostManager]);
}
