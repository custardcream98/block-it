# Principle

- **CODE LIKE A PRO**
- **LESS, BUT BETTER**

## Code Like a PRO

- OOP 지키기
  - 항상 계획하고 진행하자
  - 추상화를 소홀히 하지 말자
- 읽기 쉽게 만들기
  - 코드의 쓸데없는 축약보다는 가독성이 중요하다

## LESS, but BETTER

- 기능은 무조건 간결하게 구성하자
  - 흰색 배경의 깔끔한 UI
  - 로그인은 불필요하다
- 주요 기능의 구현은 빠르고 정확하게 하자
  - 무거운 기능은 최대한 사용을 자제한다
- 사용성은 포기하지 않는다
  - 애니메이션을 적극적으로 사용한다

# 설계

## Overall

- `Provider`는 필요한 위젯의 부모 위젯에서 부여
  - `watch()`보다는 `read()`를 사용해서 앱의 refresh 빈도를 줄인다
  - `watch()`를 사용할 때는 꼭 신중하게
  - `Provider`를 사용하므로 왠만하면 `Stateless Widget`으로 통일하자
  - 하나의 `Provider Container`에 모든 변수를 담아 관리하지 않는다!!
    - 페이지당 하나 혹은 기능당 하나씩 사용한다
- Design Property는 main의 `MaterialApp`에서 `ThemeData`로 부여하기
- 디렉터리의 이름은 복수형으로 한다
- Local에 저장돼야 하는 변수는 `hive`를 이용한다

## 디자인 컨셉

**미니멀 디자인**, 감성적인 요소를 추가

- 안내 문구는 구어체로
- 아이콘의 사용은 나쁘지 않지만 너무 잦은 사용은 자제

# 주요 명령어 모음

- `flutter build web --web-renderer canvaskit`
  - 모바일에서도 `canvaskit`으로 렌더링하도록 `auto`가 아닌 이 명령어를 사용해 빌드
  - 모바일에서 `html`로 렌더링하면 이모지 폰트 관련 문제가 발생했음

# ToDo

- [ ] Markdown 기능 추가
  - Highlighter, checkbox, indent, ...
- [ ] 사진 저장 기능 추가
- [ ] 줄간격 조절
- [ ] 자동저장으로 저장 방식 변경 (혹은 옵션 추가)
  - Buffer 이용하기 (자동저장시 아이콘 출력)
- [ ] 단축키 추가
- [ ] Tab 입력시 indent 대신 다음 element로 focus 이동하는 문제 해결
- [ ] code box 문제 해결
- [ ] 이전버전, 최신버전 비교 메커니즘 추가
- [ ] 줄글 / 메모 구분지어 표시하고, 탭으로 나누기
- [ ] 메모 작성 페이지에서 하단 padding 늘리기
- [ ] 메모 작성시 미리보기 부분 자동 스크롤 기능 추가
- [ ] 일정 이상 사이즈가 되면 폰트 크기 조절해야 함
