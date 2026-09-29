# 우리 아이 성장지도

일반 예시 프로필을 기본값으로 하는 모바일 중심 0~48개월 성장 로드맵입니다. 검정 헤더, 노랑 운동 영역, 하늘색 소통 영역을 사용합니다.

## 반영 기능

- 발달·생활 142개 항목과 접종·검진 16개 일정.
- 화면에 보이는 월령과 겹치는 행만 표시. 좌우 스크롤, 영역 필터, 현재 위치로 복귀.
- 식사·분유 전환·유아식·간식, 수면·배변, 치아 맹출·양치 추가.
- 키와 몸무게 두 개의 작은 카드. 발 크기 입력·표시 제거.
- WHO 성별·측정일 나이에 따른 추정 백분위. 기록 날짜의 생후 일수 / 30.4375를 월령으로 환산하고 월별 LMS를 선형 보간합니다. 주 단위 선택도 실제 일수로 계산합니다.
- Google OAuth PKCE, Supabase 사용자별 저장, 기기별 캐시, 네트워크 실패 보존, 동시 수정 충돌 감지.
- 기존 HTML의 JSON 기록 내보내기/가져오기. 로그인 전 기록을 온라인으로 가져올 때 명시적으로 선택합니다.

첫 접속의 이름과 생일은 예시입니다. 상단의 아이 정보 수정에서 실제 정보를 입력해 주세요. 개인 측정·관찰 기록은 공개 코드에 포함하지 않습니다.

## 배포 구성

GitHub Pages: https://yoonjintar0-commits.github.io/yuha-growth/
소스: https://github.com/yoonjintar0-commits/yuha-growth
온라인 기록: Supabase 전용 `public.yg_growth_records` 테이블, 계정 소유자별 RLS 적용.

## 수정 및 재배포

`index.html`은 화면 구조, `style.css`는 레이아웃, `data/content.js`는 발달 정보, `app.js`는 화면·백분위, `cloud.js`는 로그인·저장을 담당합니다.

GitHub 저장소 Settings > Pages에서 Deploy from a branch / main / root를 사용합니다. main의 파일을 수정하고 커밋하면 자동 재배포됩니다. 로컬 점검은 `npm run check`, 다른 정적 호스트용 빌드는 `npm run build`입니다.

`config.js`에는 브라우저 공개용 publishable key만 있습니다. 서비스 역할 키, Google client secret, 개인 기록 JSON을 저장소에 추가하지 마세요. 사이트는 공개되며 측정·관찰 기록은 로그인 계정별로 저장됩니다.

Supabase Authentication > URL Configuration > Redirect URLs에는 아래 주소를 등록합니다. 기존 앱의 Site URL과 Redirect URLs는 유지합니다.
- https://yoonjintar0-commits.github.io/yuha-growth/
- https://yoonjintar0-commits.github.io/yuha-growth/index.html

Google 제공자의 기존 callback: https://jiaqobfriamuxtvxhrls.supabase.co/auth/v1/callback

## 데이터 해석

CDC 점은 해당 나이에 살펴볼 항목이며 처음 나타나는 달이 아닙니다. 옅은 막대는 이전 CDC 확인 시점부터의 편집상 관찰 기간입니다. 실제 발현 범위로 해석하지 마세요. WHO 6개 운동 항목은 연구 관찰 구간입니다. 수면·식사·배변의 점선 구간은 안내 기간으로 개인의 마감일이 아닙니다.

백분위는 WHO 국제 기준이며 한국 아동 집단의 백분위나 건강 점수가 아닙니다. 24개월 미만은 누운 키, 이후는 선 키 기준입니다. 다른 자세로 잰 경우 0.7cm를 더하거나 뺍니다. 자세 미선택 시 키 백분위는 표시하지 않습니다. 조산아 교정연령은 자동 적용하지 않습니다. 극단값은 0.1 미만/99.9 초과로 표시합니다.

검진·예방접종은 주요 일정 요약이며 전체 개인별 접종 처방을 대신하지 않습니다. 이전 접종력·백신 종류에 따른 일정은 의료기관에서 확인합니다.

## 검증

158개 항목 및 49개 월령 열, 스크롤 범위에 따른 행 숨김/재표시, 생일과 월령 계산, WHO 중앙값 50백분위와 자세 보정, 측정·관찰 기록 저장, 메모 HTML 이스케이프를 확인했습니다. 계정별 캐시, 수정 충돌 및 네트워크 실패 때 기록 보존은 모의 테스트를 통과했습니다.

Supabase 테이블 RLS 및 소유자별 읽기/쓰기 정책 4개를 확인했고 비로그인 SELECT/INSERT 권한이 없음을 확인했습니다. Google 최종 인증과 다른 기기에서 실제 저장/조회는 로그인 복귀 주소 등록 후 확인해야 합니다.

## 공식 안내

- WHO 성장: https://www.who.int/tools/child-growth-standards
- CDC 발달: https://www.cdc.gov/act-early/milestones/
- NHS 식사: https://www.nhs.uk/best-start-in-life/baby/weaning/what-to-feed-your-baby/
- ADA 치아: https://www.mouthhealthy.org/all-topics-a-z/eruption-charts
- 보건복지부 검진: https://www.mohw.go.kr/menu.es?mid=a10706020200
- Supabase Redirect URLs: https://supabase.com/docs/guides/auth/redirect-urls
- GitHub Pages: https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages

정보 확인: 2026-09-29. 각 상세 항목의 원문 링크를 참고하세요.

## 기저귀·분유 단계 추가

기저귀·분유 필터에 7개 안내를 추가했습니다. 앱솔루트 명작 2FL(HMO)의 2단계(6~12개월), 3단계(12~24개월)는 제조사 표시의 예시입니다. 사용 제품을 지정한 개인별 처방이나 필수 전환 안내가 아닙니다. 팸퍼스 미국 공식 사이즈표를 kg로 환산해 표시하며 국내 판매 제품에 그대로 적용하지 않도록 구분했습니다. 기저귀는 현재 체중과 핏, 분유는 해당 제품의 연령 표시를 확인합니다. 최근 몸무게 기록도 기저귀 상세에 표시됩니다.
