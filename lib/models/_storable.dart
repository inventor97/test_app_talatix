abstract class Storable<T> {
  Map<String, dynamic> toStoreJson();

  T fromStoreJson(Map<String, dynamic> json);
}
