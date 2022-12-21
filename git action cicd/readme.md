# Git Actions이란?
Git Actions는 GitHub에서 제공하는 CI/CD 를 위한 서비스이다. GitHub에서 코드를 관리하고
있는 프로젝트라면 사용할 수 있고, 대부분의 개발자들이 GitHub를 사용하고 있기 때문에 진입장벽이 낮은
편이다.
<br>
Git Actions를 사용하면 레포지토리에서 어떤 이벤트가 발생 했을 때 특정 작업을 일어나게 하거나,
주기적으로 어떤 작업을 반복해서 실행시킬 수 있다. 예를 들어, 누군가 PR을 생성했을 때 Git Actions를
통해 테스트를 진행한다던지, 코드가 푸시되었을때 빌드, 서버에 배포할 수도 있다. 또한 매일 특정 시간에
그날 하루에 대한 통계 데이터를 수집시킬 수도 있다.
<br>

# Git Actions 용어
## Workflow (워크플로우)
워크플로우란 쉽게 말해 자동화해놓은 작업 과정이라고 볼 수 있다. 워크플로우는 레포지토리 내에서 
``.github/workflows`` 폴더 아래에 YAML파일로 설정하며, 하나의 레포안에서 여러개의 워크플로우를
생성할 수도 있다.
<br>
워크플로우에는 크게 2가지를 정의해야 한다. 첫번째는 ``on`` 속성을 통해 해당 워크플로우가
언제 실행되는지를 정의해야 한다.
예를 들어 ``master`` 브랜치의 ``push`` 이벤트가 발생할 때마다 워크플로우를 실행하려면
다음과 같이 설정해주면 된다.

<br>

```.github/workflows/example.yaml```
```yaml
on:
  push:
    branches:
      - master
jobs:
  # 생략
```

두번째는 ``jobs`` 속성을 통해 어떤 작업을 수행할지 정의해야 한다.

## Jobs
작업(Job)이란 독립된 컨테이너에서 돌아가는 하나의 처리단위를 의미한다. 하나의 워크플로우엔 여러개의 
작업들로 구성되고 반드시 하나의 작업은 있어야 한다. 또한 모든 작업은 기본적으로 **동시에** 진행되며
필요 시 작업이 실행되는 순서를 제어할 수 있다.

작업은 yaml 파일에서 ``jobs`` 속성을 통해 정의하며 작업 ID를 통해 구분한다.
예를 들어 ``job1``, ``job2``, ``job3``라는 작업 ID를 가진 3개의 작업을 추가하려면 
다음과 같이 작성한다.

<br>

```.github/workflows/example.yaml```
```yaml
on:
  # 생략
jobs:
  job1:
    # job1의 세부내용
  job2:
    # job2의 세부내용
  job3:
    # job3의 세부내용
```

작업 세부내용엔 여러가지 내용을 명시할 수 있는데 ``runs-on``속성은 리눅스나 윈도우즈와 같은
실행환경을 지정해주는 필수 속성이다.
가장 널리 사용되는 우분투의 최신버전을 사용하고 싶다면 다음과 같이 작성한다

<br>

``.gitgub/workflows/example.yaml``
```yaml
on:
  # 생략
jobs:
  job1:
    runs-on: ubuntu-latest
    # job1의 세부내용
```

## Steps
하나의 작업은 일반적으로 여러 단계의 명령을 순차적으로 실행하는 경우가 많다. 그래서 Git Actions에서는
각 작업을 하나 이상의 step(단계)로 모델링한다. 단계는 단순한 커맨드부터 스크립트가 될수도 있고
action이라는 좀 더 복잡한 명령일 수도 있다. 커맨드나 스크립트를 실행할 때는 ``run``속성을 사용하며
액션을 사용할때는 ``uses``속성을 사용한다.

예를들어 파이썬 프로젝트에서 테스트를 돌리려면 레포지토리에서 코드를 내려받고 패키지를 설치한 테스트
스크립트를 실행해야 한다. 이 3단계 작업은 아래와 같이 steps 속성을 통해 정의할 수 있다.

<br>

``.gitgub/workflows/example.yaml``
```yaml
on:
  # 생략
jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: pip3 install -r requirements.txt
```
