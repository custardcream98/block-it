# Principle

- **CODE LIKE A PRO**: CLAP
- **LESS, BUT BETTER**: LeTTER

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
  - Google Maps API는 사용하지 않는다
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

## Flow

### App Bar

### Main Page

#### 꼭 들어가야 하는 요소

- 할 일 목록
  - 무한 리스트로 제시
- App Bar, Tab Bar는 있음
  - App Bar에 새 일정 추가 버튼
