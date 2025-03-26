part of 'category_cubit.dart';

@immutable
class CategoryState {
  final ModelState<List<Category>> getCategoriesState;
  final ModelState<Category> createCategoryState;
  final ModelState<Category> updateCategoryState;
  final ModelState<bool> deleteCategoryState;

  CategoryState copyWith({
    ModelState<List<Category>>? getCategoriesState,
    ModelState<Category>? createCategoryState,
    ModelState<Category>? updateCategoryState,
    ModelState<bool>? deleteCategoryState,
  }) => CategoryState(
    getCategoriesState: getCategoriesState ?? this.getCategoriesState,
    createCategoryState: createCategoryState ?? this.createCategoryState,
    updateCategoryState: updateCategoryState ?? this.updateCategoryState,
    deleteCategoryState: deleteCategoryState ?? this.deleteCategoryState,
  );

  const CategoryState({
    this.getCategoriesState = const IdleState(),
    this.createCategoryState = const IdleState(),
    this.updateCategoryState = const IdleState(),
    this.deleteCategoryState = const IdleState(),
  });
}
