import 'package:flutter/material.dart';

import '../themes/theme_data.dart';

class InfoString {
  static String introduce = '''
##### Less, but Better

#### ๐ฆ block it

INFP ๊ฐ๋ฐ์ ์ง๋ง์์ด ๊ณต๋ถ์ ์น์ด๋ค ์ผ์ ๊ด๋ฆฌ ํจ ํด๋ณด๋ ค๊ณ  ToDo์ฑ์ ๋ค์ด๋ฐ์๋๋,

์จ๊ฐ ๊ธฐ๋ฅ์ ๋จธ๋ฆฌ๊ฐ ์ํ ๋ง๋ค๊ฒ ๋ ์ฑ์๋๋ค ๐

๋จ์ํ์ง๋ง ์์ ๋ฉ๋ชจ ์ฑ์ด ๋๊ณ ์ ํฉ๋๋ค.

#### Stack

**Flutter**: Frontend(Cross Platform)

**Git**

**Github**: Deploy

#### What's the point of this?

**Flutter**์๋ ์์ง stableํ Rich Text Editor Widget์ด ์๊ธฐ ๋๋ฌธ์ ์๋ํฐ๋ฅผ zero base๋ถํฐ ๊ฐ๋ฐ์ค์ด๋ผ๋ ๋ฐ์ ์์๊ฐ ์์ต๋๋ค.

๊ทธ๋ฆฌ๊ณ  ๋ฌด์๋ณด๋ค... ์ด์์์์!!

#### Contact Me

<custardcream@kakao.com>

[๋ธ๋ก์ ๊นํ๋ธ](https://github.com/custardcream98/block-it)

> ๋ธ๋ก์์ ์์ง ํ์ฐฝ ๊ฐ๋ฐ์ค์ธ ์ฑ์๋๋ค. ๊ฐ๋ฐ ์ํฉ์ ๋ฐ๋ผ ๋ฉ๋ชจ๊ฐ ๋ชจ๋ ์ง์์ง ์ ์์ผ๋ ์ฃผ์ํด์ฃผ์ธ์!

---

#### Changelog

* **22/6/25** ์๋ํฐ์ ์ฌ์ฉ์ฑ์ ๊ฐ์ ํ์ด์.
  * Hint Text ์ถ๊ฐ, ๊ณต๋ฐฑ๋ฌธ์ ์ฌ์ฉํ์ง ์๋ ๋ฐฉ๋ฒ์ผ๋ก ๋ณ๊ฒฝ
  * Box Text ๊ธฐ๋ฅ ์ถ๊ฐ
* **22/6/24** block it๋ง์ ํน๋ณํ ์๋ํฐ๋ฅผ ๋ง๋ค์์ด์.
* **22/6/23** Memo Modle ์ค๊ณ ์๋ฃ
  * ๋ฉ๋ชจ ์์  ๋ด์ญ๊น์ง ๋ณผ ์ ์๋๋ก ๋ชจ๋ธ์ ์ค๊ณํ์ด์. (์ถํ ๊ตฌํ ์์ )
* **22/6/22 ~ 32** Markdown ๋์  Custom Rich Text Editor ๊ฐ๋ฐ
  * ๋ฐ๊พผ ์ด์ ๋ ์ถํ ์์ธํ ๊ธฐ๋กํ๊ธฐ๋ก ํ์ด์!
* **22/6/21** ์์ ์ ์ค๋ฐ๊ฟ ๋ฌธ์๊ฐ ๊ณผ๋คํ๊ฒ ์ถ๊ฐ๋๋ ๋ฌธ์  ํด๊ฒฐ
* **22/6/20** Markdown ์ถ๊ฐ ๋ฐ ํธ์ง๊ธฐ ๊ฐ๋ฐ, ์์  ๊ธฐ๋ฅ ์ถ๊ฐ
* **22/6/19** Flutter Hive ์ด์ฉํด local IndexDB ์์ฑ ๋ฐ MemosModel ์ค๊ณ
* **22/6/18** ๋ฉ๋ชจ ํ๊ทธ ํ์์ ๋์์ธ ์ถ๊ฐ ๋ฐ ์ปฌ๋ฌ์ ํ๊ธฐ ์ถ๊ฐ, Web์ฑ ์์ด์ฝ ์ถ๊ฐ, Github Pages ์ด์ฉํด deploy
* **22/6/17** ๋ ํฌ์งํ ๋ฆฌ ์์ฑ ๋ฐ ๊ธฐ๋ณธ ํ๋ ์ ์ ์

#### ToDo

* ์๋ํฐ ๊ธฐ๋ฅ ์ถ๊ฐ
* ์ฌ์ง ์ ์ฅ ๊ธฐ๋ฅ ์ถ๊ฐ
* ์ค๊ฐ๊ฒฉ ์กฐ์ 
* ์์ ๋ด์ญ ์กฐํ ์ถ๊ฐ
* Bold Text, Italic Text ์ฒ๋ฆฌ ๊ธฐ๋ฅ ์ถ๊ฐ
* Multi Block Selection ์ถ๊ฐ

''';

  static List<Widget> copyright = [
    const SizedBox(
      height: 24.0,
    ),
    Text(
      "Copyrightโ2022 by custardcream98.",
      style: AppThemeData.textTheme.labelSmall,
    ),
    Text(
      "All Page content is property of custardcream98",
      style: AppThemeData.textTheme.labelSmall,
    )
  ];
}
