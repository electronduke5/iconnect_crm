import 'package:bloc/bloc.dart';
import 'package:iconnect_crm/data/models/category.dart';
import 'package:iconnect_crm/presentation/app_module.dart';
import 'package:iconnect_crm/presentation/cubits/model_state.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState());

  final _repository = AppModule.getCategoryRepository();

  Future loadAllCategories() async {
    emit(state.copyWith(getCategoriesState: ModelState.loading()));
    await _repository.getAllCategories().then(
      (result) => result.fold(
        (l) => emit(
          state.copyWith(getCategoriesState: ModelState.failed(l.error)),
        ),
        (r) => emit(state.copyWith(getCategoriesState: ModelState.loaded(r))),
      ),
    );
  }

  Future addCategory(String title) async {
    emit(state.copyWith(createCategoryState: ModelState.loading()));
    await _repository
        .createCategory(title: title)
        .then(
          (result) => result.fold(
            (l) =>
                state.copyWith(createCategoryState: ModelState.failed(l.error)),
            (r) =>
                emit(state.copyWith(createCategoryState: ModelState.loaded(r))),
          ),
        );
  }

  Future deleteCategory(int id) async {
    emit(state.copyWith(deleteCategoryState: ModelState.loading()));

    await _repository
        .deleteCategory(id)
        .then(
          (result) => result.fold(
            (l) => emit(
              state.copyWith(deleteCategoryState: ModelState.failed(l.error)),
            ),
            (r) =>
                emit(state.copyWith(deleteCategoryState: ModelState.loaded(r))),
          ),
        );
  }

  Future<void> editCategory({required int id, required String title}) async {
    emit(state.copyWith(updateCategoryState: ModelState.loading()));

    await _repository
        .updateCategory(id: id, title: title)
        .then(
          (result) => result.fold(
            (l) {
              emit(
                state.copyWith(updateCategoryState: ModelState.failed(l.error)),
              );
            },
            (r) {
              emit(state.copyWith(updateCategoryState: ModelState.loaded(r)));
            },
          ),
        );
  }
}
