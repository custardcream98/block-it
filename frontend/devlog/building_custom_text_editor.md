> 깔끔하고 예쁜 텍스트 에디터를 만들려면 어떻게 해야 할까?

블록잇은 깔끔하고 예쁜 메모장을 추구하는 서비스입니다. 이를 위해 제가 처음으로 사용한 방법은 `flutter_markdown`을 이용해 마크다운 입력을 지원하는 것이었습니다.

그러나 마크다운 문법을 지키면서 사용자가 간편하게 텍스트를 입력하는 것을 구현하는 것은 아주 어려운 문제였습니다. 따라서, 직접 Rich Text Editor를 구현하기로 했습니다.

# 텍스트 에디터를 만들자

## 구조

각 텍스트별로 Rich Text를 저장할 객체를 생성해 저장합니다.

nested Object를 저장하게 되기 때문에 조금 복잡하겠지만, 가장 효과적인 방법으로 흔히 사용됩니다.

## Models

- `MemosModel`: 각 메모의 제목, 생성일시, 메모 등이 저장되는 모델
  - HiveList로 `BlockitRichTextModel`을 담음
- `BlockitRichTextModel`: Rich Text가 담기는 모델
  - 각 `BlockitRichTextModel`에는 `created`를 담아서 수정내역을 모두 저장하도록 함

### 실제 모델 코드

```Dart
@HiveType(typeId: 1)
@JsonSerializable()
class BlockitRichTextModel extends HiveObject {
  BlockitRichTextModel(
      {required this.created,
      required this.type,
      required this.text,
      required this.memoId});

  @HiveField(0)
  @JsonKey(name: BlockitRichTextModelKey.createdKey, required: true)
  DateTime created;

  @HiveField(1)
  @JsonKey(name: BlockitRichTextModelKey.typeIdKey, required: true)
  BlockitRichTextType type;

  @HiveField(2)
  @JsonKey(name: BlockitRichTextModelKey.textKey, required: true)
  String text;

  @HiveField(3)
  @JsonKey(name: BlockitRichTextModelKey.memoIdKey, required: true)
  String memoId;

  factory BlockitRichTextModel.fromJson(Map<String, dynamic> json) =>
      _$BlockitRichTextModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlockitRichTextModelToJson(this);

  bool compare(BlockitRichTextModel text) {
    return text.text == this.text && text.type == type;
  }
}

@HiveType(typeId: 2)
enum BlockitRichTextType {
  @JsonValue("p")
  @HiveField(0)
  p,
  @JsonValue("h1")
  @HiveField(1)
  h1,
  @JsonValue("quote")
  @HiveField(2)
  quote,
  @JsonValue("bullet")
  @HiveField(3)
  bullet
}

extension BlockitRichTextStyle on BlockitRichTextType {
  TextStyle get textStyle {
    switch (this) {
      case BlockitRichTextType.quote:
        return AppThemeData.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w800,
            color: AppThemeData.mainGrayColor,
            fontSize: AppThemeData.textTheme.bodySmall!.fontSize! * 0.9);
      case BlockitRichTextType.h1:
        return AppThemeData.textTheme.bodyLarge!;
      default:
        return AppThemeData.textTheme.bodySmall!;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case BlockitRichTextType.h1:
        return const EdgeInsets.fromLTRB(16, 24, 16, 8);
      case BlockitRichTextType.quote:
        return const EdgeInsets.fromLTRB(16, 16, 16, 16);
      case BlockitRichTextType.bullet:
        return const EdgeInsets.fromLTRB(24, 8, 16, 8);
      default:
        return const EdgeInsets.fromLTRB(16, 8, 16, 8);
    }
  }

  TextAlign get align {
    switch (this) {
      case BlockitRichTextType.quote:
        return TextAlign.center;
      default:
        return TextAlign.start;
    }
  }

  String get prefix {
    switch (this) {
      case BlockitRichTextType.bullet:
        return '\u2022 ';
      default:
        return '';
    }
  }
}
```

### 배운점

- `enum`의 사용법
- `JSON Serialize`의 유연한 사용법
