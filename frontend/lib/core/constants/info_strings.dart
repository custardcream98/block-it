import 'package:flutter/material.dart';

import '../themes/theme_data.dart';

class InfoString {
  static String introduce = '''
##### Less, but Better

#### 📦 block it

INFP 개발자 지망생이 공부에 치이다 일정관리 함 해보려고 ToDo앱을 다운받았더니,

온갖 기능에 머리가 아파 만들게 된 앱입니다 😂

단순하지만 예쁜 메모 앱이 되고자 합니다.

#### Stack

**Flutter**: Frontend(Cross Platform)

**Git**

**Github**: Deploy

#### What's the point of this?

**Flutter**에는 아직 stable한 Rich Text Editor Widget이 없기 때문에 에디터를 zero base부터 개발중이라는 데에 의의가 있습니다.

그리고 무엇보다... 이쁘잖아요!!

#### Contact Me

<custardcream@kakao.com>

[블록잇 깃허브](https://github.com/custardcream98/block-it)

> 블록잇은 아직 한창 개발중인 앱입니다. 개발 상황에 따라 메모가 모두 지워질 수 있으니 주의해주세요!

---

#### Changelog

* **22/6/24** block it만의 특별한 에디터를 만들었어요.
* **22/6/23** Memo Modle 설계 완료
  * 메모 수정 내역까지 볼 수 있도록 모델을 설계했어요. (추후 구현 예정)
* **22/6/22 ~ 32** Markdown 대신 Custom Rich Text Editor 개발
  * 바꾼 이유는 추후 자세히 기록하기로 했어요!
* **22/6/21** 수정시 줄바꿈 문자가 과다하게 추가되는 문제 해결
* **22/6/20** Markdown 추가 및 편집기 개발, 수정 기능 추가
* **22/6/19** Flutter Hive 이용해 local IndexDB 생성 및 MemosModel 설계
* **22/6/18** 메모 태그 형식의 디자인 추가 및 컬러선택기 추가, Web앱 아이콘 추가, Github Pages 이용해 deploy
* **22/6/17** 레포지토리 생성 및 기본 프레임 제작

#### ToDo

* 에디터 기능 추가
* 사진 저장 기능 추가
* 줄간격 조절
* 수정내역 조회 추가
* Bold Text, Italic Text 처리 기능 추가
* Multi Block Selection 추가

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
}
