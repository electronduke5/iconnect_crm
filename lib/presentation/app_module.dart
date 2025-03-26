import 'package:get_it/get_it.dart';
import 'package:iconnect_crm/data/repositories/category_repository_impl.dart';
import 'package:iconnect_crm/domain/repositories/category_repository.dart';

class AppModule {
  static bool _provided = false;

  void provideDependencies() {
    if (_provided) return;
    _provideCategoryRepository();
    _provided = true;
  }

  void _provideCategoryRepository(){
    GetIt.instance.registerSingleton(CategoryRepositoryImpl());
  }

  static CategoryRepository getCategoryRepository() {
    return GetIt.instance.get<CategoryRepositoryImpl>();
  }
}
