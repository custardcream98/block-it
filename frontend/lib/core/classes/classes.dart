import 'package:hive/hive.dart';

// class BlockitArticle extends HiveObject {
//   BlockitArticle(
//       {
//       //required this.title,
//       required this.memo});

//   //String title;
//   String memo;

//   String getMemo() {
//     return memo;
//   }

//   /// 추후 API가 필요할 시 개발 용이성을 위해 MAP 사용
//   // Map<String, String> getArticle() {
//   //   return {'title': title, 'memo': memo};
//   // }
// }

@HiveType(
  typeId: 0,
)
class BlockitArticle extends HiveObject {
  @HiveField(0)
  late String memo;
}
