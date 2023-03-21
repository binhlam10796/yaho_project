class BaseResponse<T> {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  T? data;

  BaseResponse({this.page, this.perPage, this.total, this.totalPages, this.data});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic) create) {
    return BaseResponse<T>(
      page: json["page"],
      perPage: json["per_page"],
      total: json["total"],
      totalPages: json["total_pages"],
      data: json["data"] != null ? create(json["data"]) : create({}),
    );
  }
}
