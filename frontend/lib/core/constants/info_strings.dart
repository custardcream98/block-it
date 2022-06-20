import 'package:Blockit/core/themes/theme_data.dart';
import 'package:flutter/material.dart';

class InfoString {
  static String introduce = '''
##### Less, but Better

#### 📦 block it

INFP 개발자 지망생이 공부에 치이다 일정관리 함 해보려고 ToDo앱을 다운받았더니,

온갖 기능에 머리가 아파 만들게 된 앱입니다 😂

단순하지만 이쁜걸 추구합니다.

#### Stack

**Flutter**: Frontend(Cross Platform)

**Git**

**Github**: Deploy

#### Contact Me

<custardcream@kakao.com>

[블록잇 깃허브](https://github.com/custardcream98/block-it)

---

#### Changelog

* **22/6/20** Markdown 추가 및 편집기 개발, 수정 기능 추가
* **22/6/19** Flutter Hive 이용해 local IndexDB 생성 및 MemosModel 설계
* **22/6/18** 메모 태그 형식의 디자인 추가 및 컬러선택기 추가, Web앱 아이콘 추가, Github Pages 이용해 deploy
* **22/6/17** 레포지토리 생성 및 기본 프레임 제작

#### ToDo

* MD 기능 추가
* 이모지 문제 해결
* 줄간격 

''';

  static List<Widget> copyright = [
    const SizedBox(
      height: 24.0,
    ),
    Text(
      "Copyrightⓒ2022 by custardcream98.",
      style: AppThemeData.textTheme.labelSmall,
    ),
    Text(
      "All Page content is property of custardcream98",
      style: AppThemeData.textTheme.labelSmall,
    )
  ];

  static const String howToUse = '''
> block it은 마크다운 입력을 지원합니다.

--------

### 사용법

마크다운을 이용하면 손가락을 키보드에서 떼지 않고도 글을 예쁘게 쓸 수 있습니다.

몇가지 간단한 심볼만 입력하면 됩니다.

#### 볼드체

```
**이렇게 쓰면 볼드체가 됩니다.**
```

**이렇게 쓰면 볼드체가 됩니다.**

#### 이텔릭체

```
*이렇게 쓰면 이텔릭체가 됩니다.*
```

*이렇게 쓰면 이텔릭체가 됩니다.*

#### 이텔릭 볼드체

```
***이렇게 쓰면 이텔릭 볼드체가 됩니다.***
```

***이렇게 쓰면 이텔릭 볼드체가 됩니다.***

이런 식으로 여러 문법을 중첩해서도 사용할 수 있습니다.

#### 큰 글씨

다섯 가지의 큰 글씨가 있습니다.

```
# 큰 글씨 1
## 큰 글씨 2
### 큰 글씨 3
#### 큰 글씨 4
##### 큰 글씨 5
```

# 큰 글씨 1
## 큰 글씨 2
### 큰 글씨 3
#### 큰 글씨 4
##### 큰 글씨 5

> 태그를 입력하고 한 칸을 꼭 띄워주세요.

#### 인용구

```
> 이렇게 쓰면 인용구가 됩니다.
```

> 이렇게 쓰면 인용구가 됩니다.

#### 글머리 번호 / 기호

```
* 한 칸을
* 꼭 띄워주세요.

1. 숫자만 쓰면
2. 됩니다.
```

* 한 칸을
* 꼭 띄워주세요.

1. 숫자만 쓰면
2. 됩니다.

#### 블록

```
~~~
검은색 상자에 들어가요!
~~~
```

~~~
검은색 상자에 들어가요!
~~~

#### 구분선

```
---
(- 혹은 *을 3개 이상 입력)
```
---

##### 더 많은 기능이 업데이트 될 예정입니다:smile:

''';
}
