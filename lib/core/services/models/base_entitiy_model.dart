///Every models of entity should implements `[BaseEntityModel]` for API response.
///API services constraints generic methods with `[BaseEntityModel]`.
///
///Example:
///```dart
///class UserModel implements EntityModel<UserModel>
/// ```
abstract class BaseEntityModel<TModel> {
  Map<String, dynamic>? toJson();
  TModel fromJson(Map<String, dynamic> json);
}
