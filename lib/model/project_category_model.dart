// To parse this JSON data, do
//
//     final projectCategoryResponse = projectCategoryResponseFromMap(jsonString);

import 'dart:convert';

class ProjectCategoryResponse {
  ProjectCategoryResponse({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  final List<ProjectCategoryInfo> data;
  final int errorCode;
  final String errorMsg;

  factory ProjectCategoryResponse.fromJson(String str) => ProjectCategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProjectCategoryResponse.fromMap(Map<String, dynamic> json) => ProjectCategoryResponse(
    data: List<ProjectCategoryInfo>.from(json["data"].map((x) => ProjectCategoryInfo.fromMap(x))),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class ProjectCategoryInfo {
  ProjectCategoryInfo({
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

  factory ProjectCategoryInfo.fromJson(String str) => ProjectCategoryInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProjectCategoryInfo.fromMap(Map<String, dynamic> json) => ProjectCategoryInfo(
    children: List<dynamic>.from(json["children"].map((x) => x)),
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
