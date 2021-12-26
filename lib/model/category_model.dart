// To parse this JSON data, do
//
//     final projectCategoryResponse = projectCategoryResponseFromMap(jsonString);

import 'dart:convert';

class CategoryResponse {
  CategoryResponse({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  final List<CategoryInfo> data;
  final int errorCode;
  final String errorMsg;

  factory CategoryResponse.fromJson(String str) => CategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponse.fromMap(Map<String, dynamic> json) => CategoryResponse(
    data: List<CategoryInfo>.from(json["data"].map((x) => CategoryInfo.fromMap(x))),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class CategoryInfo {
  CategoryInfo({
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  });

  final List<dynamic> children;
  final int courseId;
  final int id;
  final String name;
  final int order;
  final int parentChapterId;
  final bool userControlSetTop;
  final int visible;

  factory CategoryInfo.fromJson(String str) => CategoryInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryInfo.fromMap(Map<String, dynamic> json) => CategoryInfo(
    children: List<CategoryInfo>.from(json["children"].map((it) => CategoryInfo.fromMap(it))),
    courseId: json["courseId"],
    id: json["id"],
    name: json["name"],
    order: json["order"],
    parentChapterId: json["parentChapterId"],
    userControlSetTop: json["userControlSetTop"],
    visible: json["visible"],
  );

  Map<String, dynamic> toMap() => {
    "children": List<dynamic>.from(children.map((x) => x)),
    "courseId": courseId,
    "id": id,
    "name": name,
    "order": order,
    "parentChapterId": parentChapterId,
    "userControlSetTop": userControlSetTop,
    "visible": visible,
  };
}
