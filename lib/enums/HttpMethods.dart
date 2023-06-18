enum HttpMethodTypes {
  POST,
  GET,
  PUT,
  DELETE,
}

extension HttpMethodValues on HttpMethodTypes {
  String get value {
    switch (this) {
      case HttpMethodTypes.POST:
        return "POST";
      case HttpMethodTypes.GET:
        return "GET";
      case HttpMethodTypes.PUT:
        return "PUT";
      case HttpMethodTypes.DELETE:
        return "DELETE";
    }
  }
}
