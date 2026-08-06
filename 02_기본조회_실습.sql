-- 02. 단일 테이블 데이터 입력과 기본 조회
-- 실행 대상: culture_program_02.db
-- 시작 전제: participants 테이블에 P-001 ~ P-012가 저장되어 있습니다.
-- 이 파일에는 각 미션의 SQL을 직접 작성합니다. 정답 SQL은 강사용 파일에만 있습니다.

-- [1] 시작 상태 확인
-- P-001 ~ P-012까지 12건이 보이는지 확인합니다.
SELECT participant_id, name
FROM participants
ORDER BY participant_id;

-- P-009의 notice_agreed가 기본값 N인지 확인합니다.
SELECT participant_id, name, region, preferred_category, notice_agreed
FROM participants
ORDER BY participant_id;

-- [2] 기본 조회 미니 미션
-- 필수 2-1-1: 모든 참가자의 이름과 지역만 조회합니다.
SELECT name, region
FROM participants
ORDER BY participant_id;

-- 필수 2-1-2: 참가자 번호, 이름, 연락처만 조회합니다.
SELECT participant_id, name, phone
FROM participants
ORDER BY participant_id;

-- 선택 2-1-3: 이름 열 제목을 참가자명으로 바꾸어 조회합니다.
SELECT name AS 참가자명
FROM participants
ORDER BY participant_id;

-- 필수 2-2-1, 2-2-4: 지역 종류를 중복 없이 가나다순으로 조회합니다.
SELECT DISTINCT region
FROM participants
ORDER BY region;

-- 필수 2-3-1: 수원 참가자의 이름과 연락처를 조회합니다.
SELECT name, phone
FROM participants
WHERE region = '수원'
ORDER BY participant_id;

-- 필수 2-3-2: 건강 분야 관심자의 이름을 조회합니다.
SELECT name
FROM participants
WHERE preferred_category = '건강'
ORDER BY participant_id;

-- 필수 2-3-3: 안내 수신 동의자의 이름과 지역을 조회합니다.
SELECT name, region
FROM participants
WHERE notice_agreed = 'Y'
ORDER BY participant_id;

-- 필수 2-4-1: 전체 참가자 이름을 이름순으로 조회합니다.
SELECT name
FROM participants
ORDER BY name;

-- 필수 2-4-2: 전체 참가자를 등록일이 빠른 순서로 조회합니다.
SELECT *
FROM participants
ORDER BY joined_date;

-- 선택: 2-2의 관심 분야, DISTINCT 없이 지역 조회, 2-3의 나머지 요청,
--         2-4의 나머지 요청을 이 아래에 작성합니다.
SELECT preferred_category
FROM participants
ORDER BY preferred_category;

SELECT participant_id 
FROM participants
WHERE region = '수원'
ORDER BY participant_id;

-- [3] 8건 추가 입력
-- 표의 값을 보고 각 INSERT 문을 완성합니다.
-- INSERT 문에는 값을 넣을 열 이름을 먼저 작성합니다.
-- 열 이름과 VALUES의 값은 같은 순서로 작성합니다.
INSERT INTO participants 
    (participant_id, name, region, preferred_category, phone, joined_date, notice_agreed)
VALUES 
    ('P-013', '유나경', '화성', '요리', '010-4000-1001', '2026-08-09', 'Y'),
    ('P-014', '임현우', '안양', '공예', '010-4000-1002', '2026-08-09', 'N'),
    ('P-015', '조하린', '수원', '건강', '010-4000-1003', '2026-08-10', 'Y'),
    ('P-016', '신도윤', '성남', '디지털 생활', '010-4000-1004', '2026-08-10', 'N'),
    ('P-017', '권서아', '용인', '요리', '010-4000-1005', '2026-08-11', 'Y'),
    ('P-018', '차민준', '화성', '공예', '010-4000-1006', '2026-08-11', 'N'),
    ('P-019', '노지안', '안양', '디지털 생활', '010-4000-1007', '2026-08-12', 'Y'),
    ('P-020', '송예준', '수원', '건강', '010-4000-1008', '2026-08-12', 'N');
-- P-001부터 P-020까지 참가자 번호가 빠짐없이 보이는지 확인합니다.
SELECT participant_id, name, region, preferred_category, notice_agreed
FROM participants
ORDER BY participant_id;

-- [4] 20건 데이터로 조회 요청 해결

-- 라운드 1. 지역과 관심 분야의 조합을 중복 없이 조회합니다.
-- 열 제목: 지역, 관심분야
-- 정렬: 지역순, 같은 지역에서는 관심 분야순
SELECT DISTINCT region AS 지역, preferred_category AS 관심분야
FROM participants
ORDER BY region, preferred_category;

-- 라운드 2. 안내 수신 동의자의 등록번호, 참가자명, 지역, 관심분야를 조회합니다.
-- 정렬: 지역순, 같은 지역에서는 이름순
SELECT participant_id AS 등록번호, name AS 참가자명, region AS 지역, preferred_category AS 관심분야
FROM participants
WHERE notice_agreed = 'Y'
ORDER BY region, name;

-- 라운드 3. 전체 참가자의 등록번호, 참가자명, 지역, 등록일을 조회합니다.
-- 정렬: 지역순, 같은 지역에서는 등록일이 빠른 순서
SELECT participant_id AS 등록번호, name AS 참가자명, region AS 지역, joined_date AS 등록일
FROM participants
ORDER BY region, joined_date;

-- 라운드 4. 디지털 생활 관심자의 참가자 번호, 참가자명, 지역, 등록일을 조회합니다.
-- 정렬: 등록일이 빠른 순서
SELECT participant_id AS 참가자 번호, name AS 참가자명, region AS 지역, joined_date AS 등록일
FROM participants
where preferred_category = '디지털 생활'
ORDER BY joined_date;


-- [4] 오류 탐정
-- 필수 4-3: '공예수업' 조건을 실제 저장값에 맞게 고칩니다.
SELECT name
FROM participants
WHERE preferred_category = '공예수업';

-- 필수 4-4: 지역이 한 번씩만 보이도록 고칩니다.
SELECT region
FROM participants
ORDER BY region;

-- 필수 4-5: 이름순 정렬이 되도록 고칩니다.
SELECT name
FROM participants;

-- 선택: 4-1, 4-2, 4-6 활동을 이 아래에 작성합니다.


-- [5] P-013 ~ P-020 추가 입력
-- 모든 INSERT 문에 열 이름 목록을 씁니다. 두 사람이 네 건씩 나누어 작성합니다.
-- 표의 값을 그대로 사용하고, 이미 입력한 번호는 다시 INSERT하지 않습니다.
-- P-013 ~ P-016

-- P-017 ~ P-020

-- 첫 묶음과 둘째 묶음 각각을 입력한 뒤, 전체 목록에서 해당 번호 네 건이 보이는지 확인합니다.
SELECT participant_id, name
FROM participants
ORDER BY participant_id;


-- [6] 종료 검증
-- 필수 6-1: 안내 수신 동의자 이름을 이름순으로 조회합니다.

-- 필수 6-2: 관심 분야 종류를 중복 없이 가나다순으로 조회합니다.

-- 필수 6-4: 수원 참가자의 이름과 등록일을 등록일순으로 조회합니다.

-- 필수 6-8: P-020의 이름, 지역, 안내 수신 여부를 조회합니다.

-- 선택: 6-3, 6-5, 6-6, 6-7 요청을 이 아래에 작성합니다.

-- [7] 종료 확인: 아래 SQL은 모든 필수 실습이 끝난 뒤 실행합니다.
SELECT participant_id, name
FROM participants
ORDER BY participant_id;
