-- SQL 기반 데이터 CRUD와 조건 검색: 학습자용 실습 파일
-- 실행 대상: culture_program_04.db
-- 이 파일에는 완성 쿼리를 제공하지 않습니다.
-- 각 요구 아래에 SQL을 직접 작성하고, 한 문장씩 실행해 결과를 확인합니다.

-- =========================================================
-- [1] 시작 상태 확인
-- =========================================================

-- 1-1. participants 테이블의 전체 행 수를 participant_count라는 이름으로 조회합니다.
SELECT COUNT(*) AS participant_count FROM participants;
SELECT *
FROM program_schedules;


-- 1-2. programs 테이블의 전체 행 수를 program_count라는 이름으로 조회합니다.
SELECT COUNT(*) AS program_count FROM programs;


-- 1-3. program_schedules 테이블의 전체 행 수를 schedule_count라는 이름으로 조회합니다.
SELECT COUNT(*) AS schedule_count FROM program_schedules;

-- 1-4. 현재 DB의 테이블 이름을 이름순으로 조회합니다.
SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

-- =========================================================
-- [2] 조건 검색 기본 연습
-- =========================================================

-- 2-1. 
-- programs의 모든 열을 조회합니다.


-- programs에서 program_id, program_name, category를 프로그램 번호순으로 조회합니다.


-- 2-2. 
-- 공예 분야 프로그램의 번호, 이름, 분야를 조회합니다.


-- 모집중인 일정의 번호, 프로그램 번호, 날짜, 시작 시각, 장소, 상태를 날짜·시각순으로 조회합니다.


-- 2-3.
-- 정원이 15명 이상인 일정의 번호, 프로그램 번호, 날짜, 장소, 정원을 정원 내림차순·날짜순으로 조회합니다.


-- 2-4. 
-- 모집중이면서 정원이 15명 이상인 일정의 번호, 프로그램 번호, 날짜, 장소, 정원, 상태를 날짜순으로 조회합니다.
SELECT schedule_id, program_id, schedule_date, venue, capacity, status
FROM program_schedules
WHERE status = '모집중' AND capacity >= 15
ORDER BY schedule_date;

-- 2-5. 
-- 수원 또는 성남 참가자의 번호, 이름, 지역을 지역·이름순으로 조회합니다. OR을 사용합니다.
SELECT participant_id, name, region
FROM participants
WHERE region = '수원' OR region = '성남'
ORDER BY region, name;

-- 위와 과 같은 결과를 IN으로 조회합니다.
SELECT participant_id, name, region
FROM participants
WHERE region IN ('수원', '성남')
ORDER BY region, name;

-- 2-6. 
-- 취소되지 않은 일정의 번호, 프로그램 번호, 날짜, 상태를 일정 번호순으로 조회합니다.
SELECT schedule_id, program_id, schedule_date, status
FROM program_schedules
WHERE NOT status = '취소'
ORDER BY schedule_id;

-- 2026-08-22부터 2026-08-29 사이 일정의 번호, 날짜, 정원을 날짜순으로 조회합니다.
SELECT schedule_id, schedule_date, capacity
FROM program_schedules
WHERE schedule_date BETWEEN '2026-08-22' AND '2026-08-29'
ORDER BY schedule_date;

-- 정원이 15명부터 18명 사이인 일정의 번호와 정원을 정원·일정 번호순으로 조회합니다.
SELECT schedule_id, capacity
FROM program_schedules
WHERE capacity BETWEEN 15 AND 18
ORDER BY capacity, schedule_id;

-- 연습 [1] 
SELECT schedule_date
FROM program_schedules
WHERE schedule_date BETWEEN '2026-08-22' AND '2026-08-29' AND status = '모집중'
ORDER BY schedule_date, status;

-- 연습 [2]
SELECT schedule_date
FROM program_schedules
WHERE capacity BETWEEN 15 AND 18 AND status = '마감'
ORDER BY capacity, schedule_date;

-- 연습 [3]
SELECT schedule_id, schedule_date, capacity, status
FROM program_schedules
WHERE status != '취소'
    AND schedule_date BETWEEN '2026-08-22' AND '2026-08-29'
    AND capacity BETWEEN 15 AND 18
ORDER BY schedule_date, capacity;

-- 2-7. 
-- 프로그램 이름에 생활이 포함된 프로그램의 번호와 이름을 조회합니다.
SELECT program_id, program_name
FROM programs
WHERE program_name LIKE '%생활%';

-- 2-8. 
-- 공예 또는 건강 분야이면서 현재 운영 중인 프로그램의 번호, 이름, 분야, 운영 여부를 분야·번호순으로 조회합니다.
SELECT schedule_id, schedule_date, capacity, status
FROM program_schedules
WHERE (status = '모집중' OR status = '마감')
  AND capacity >= 15
ORDER BY schedule_date;

-- =========================================================
-- [3] 운영 요청 라운드 1
-- =========================================================

-- 2-9. 
-- 건강 분야 프로그램의 번호와 이름을 조회합니다.


-- 상태가 마감인 일정의 번호, 날짜, 장소를 조회합니다.


-- 정원이 15명보다 작은 모집중 일정의 번호, 프로그램 번호, 정원을 조회합니다.


-- 지역이 안양 또는 화성인 참가자의 이름, 지역, 관심 분야(preferred_category)를 조회합니다.


-- 취소되지 않았고 정원이 15명 이상인 일정의 번호, 날짜, 상태, 정원을 조회합니다.


-- =========================================================
-- [4] 운영 요청 라운드 2
-- =========================================================

-- 2-10. 
-- 2026-08-23부터 2026-08-31 사이에 열리는 모집중 일정의 번호, 날짜, 장소를 조회합니다.


-- 수원 또는 성남 참가자 중 안내 수신에 동의한 사람의 번호, 이름, 지역을 조회합니다.


-- 프로그램 이름에 생활이 들어가거나 분야가 디지털 생활인 프로그램의 번호, 이름, 분야를 조회합니다. OR 조건을 괄호로 묶습니다.


-- 정원이 12명 또는 14명인 일정의 번호와 정원을 조회합니다. IN을 사용합니다.


-- =========================================================
-- [6] registrations 테이블 만들기
-- =========================================================

-- SQLite에서 외래 키 제약조건을 검사하도록 설정합니다.
PRAGMA foreign_keys = ON;

-- 결과가 1이면 외래 키 검사가 켜진 상태입니다.
PRAGMA foreign_keys;

CREATE TABLE registrations (
    registration_id TEXT PRIMARY KEY,
    participant_id TEXT NOT NULL,
    schedule_id TEXT NOT NULL,
    applied_at TEXT NOT NULL,
    registration_status TEXT NOT NULL DEFAULT '신청'
        CHECK (registration_status IN ('신청', '취소')),
    UNIQUE (participant_id, schedule_id),
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id),
    FOREIGN KEY (schedule_id) REFERENCES program_schedules(schedule_id)
);

PRAGMA table_info(registrations);
PRAGMA foreign_key_list(registrations);

-- 6-3. registrations의 열 정의와 외래 키 정의를 각각 확인합니다.


-- =========================================================
-- [7] 신청 등록
-- =========================================================

-- 7-1. R-001 / P-001 / S-001 / 2026-08-10 09:30 신청을 등록합니다.
--      registration_status는 입력하지 않고 기본값을 사용합니다.
PRAGMA foreign_keys = ON;
INSERT INTO registrations (registration_id, participant_id, schedule_id, applied_at)
VALUES ('R-001', 'P-001', 'S-001', '2026-08-10 09:30');

-- 7-2. R-001 한 건을 조회해 등록 결과와 기본 상태를 확인합니다.
SELECT registration_id, participant_id, schedule_id, applied_at, registration_status
FROM registrations
WHERE registration_id = 'R-001';

-- 7-3. R-002 / P-003 / S-005 / 2026-08-10 10:10 신청을 등록하고, R-002만 조회합니다.
INSERT INTO registrations (registration_id, participant_id, schedule_id, applied_at)
VALUES ('R-002', 'P-003', 'S-005', '2026-08-10 10:10');
SELECT * FROM registrations WHERE registration_id = 'R-002';

-- 7-4. R-003 / P-005 / S-003 / 2026-08-10 10:25 신청을 등록하고, R-003만 조회합니다.
INSERT INTO registrations (registration_id, participant_id, schedule_id, applied_at)
VALUES ('R-003', 'P-005', 'S-003', '2026-08-10 10:25');
SELECT * FROM registrations WHERE registration_id = 'R-003';

-- 7-5. R-004 / P-007 / S-009 / 2026-08-10 10:40 신청을 등록하고, R-004만 조회합니다.
INSERT INTO registrations (registration_id, participant_id, schedule_id, applied_at)
VALUES ('R-004', 'P-007', 'S-009', '2026-08-10 10:40');
SELECT * FROM registrations WHERE registration_id = 'R-004';

-- 7-6. 전체 신청을 신청 번호순으로 조회합니다.


-- =========================================================
-- [8] 등록할 수 없는 데이터 확인: 선택
-- 한 항목만 작성·실행한 뒤, R-001이 그대로 한 건인지 확인합니다.
-- =========================================================

-- 8-1. 없는 참가자 P-999로 R-090 신청을 시도합니다. 일정은 S-001, 시각은 2026-08-10 11:10입니다.


-- 8-2. 없는 일정 S-999로 R-091 신청을 시도합니다. 참가자는 P-001, 시각은 2026-08-10 11:15입니다.


-- 8-3. 이미 존재하는 신청 번호 R-001로 신청을 시도합니다. 참가자는 P-002, 일정은 S-002, 시각은 2026-08-10 11:20입니다.


-- 8-4. P-001이 S-001에 다시 신청하도록 R-092 신청을 시도합니다. 시각은 2026-08-10 11:25입니다.


-- 8-5. R-001 한 건을 조회합니다.


-- =========================================================
-- [9] 신청 수정
-- =========================================================

-- 9-1. R-003을 조회해 수정 전 상태를 확인합니다.
SELECT registration_id, participant_id, schedule_id, applied_at, registration_status
FROM registrations
WHERE registration_id = 'R-003';

-- 9-2. R-003의 registration_status를 취소로 수정합니다.
UPDATE registrations
SET registration_status = '취소'
WHERE registration_id = 'R-003';

-- 9-3. R-003을 다시 조회해 수정 결과를 확인합니다.
SELECT registration_id, participant_id, schedule_id, applied_at, registration_status
FROM registrations
WHERE registration_id = 'R-003';

-- 9-4. R-004를 조회해 수정 전 신청 시각을 확인합니다.
SELECT registration_id, participant_id, schedule_id, applied_at, registration_status
FROM registrations
WHERE registration_id = 'R-004';

-- 9-5. R-004의 applied_at을 2026-08-10 11:00으로 수정합니다.
UPDATE registrations
SET applied_at = '2026-08-10 11:00'
WHERE registration_id = 'R-004';

-- 9-6. R-004를 다시 조회해 수정 결과를 확인합니다.
SELECT registration_id, participant_id, schedule_id, applied_at, registration_status
FROM registrations
WHERE registration_id = 'R-004';

-- 9-7. [반복·응용] R-002의 신청 시각을 2026-08-10 10:30으로, 상태를 취소로 함께 수정합니다.
UPDATE registrations
SET applied_at = '2026-08-10 10:30', registration_status = '취소'
WHERE registration_id = 'R-002';

-- 9-7. 업데이트 확인 조회
SELECT registration_id, participant_id, schedule_id, applied_at, registration_status
FROM registrations
WHERE registration_id = 'R-002';

-- =========================================================
-- [10] 시험 신청 정보 삭제
-- =========================================================

-- 10-1. R-099 / P-020 / S-012 / 2026-08-10 11:30 시험 신청을 등록합니다.
INSERT INTO registrations (
    registration_id, participant_id, schedule_Id, applied_at
)
VALUES  (
    'R-099', 'P-020', 'S-012', '2026-08-10 11:30'
);

-- 10-2. R-099 한 건을 조회해 삭제 대상을 확인합니다.
SELECT registration_id, participant_id, schedule_id, applied_at
FROM registrations
WHERE registration_id = 'R-099';

-- 10-3. R-099 한 건만 삭제합니다.
DELETE FROM registrations
WHERE registration_id = 'R-099';

-- 10-4. R-099를 다시 조회합니다. 결과가 0행이면 정상입니다.
SELECT registration_id, participant_id, schedule_id, applied_at
FROM registrations
WHERE registration_id = 'R-099';

-- =========================================================
-- [11] 종합 미션
-- =========================================================

BEGIN;

UPDATE registrations
SET registration_status = '취소'
WHERE registration_id = 'R-004';

SELECT registration_id, registration_status
FROM registrations
WHERE registration_id = 'R-004';

ROLLBACK;

SELECT registration_id, registration_status
FROM registrations
WHERE registration_id = 'R-004';

UPDATE registrations
SET registration_status = '신청'
WHERE registration_id = 'R-004';

-- 11-1. 모집중이며 정원이 15명 이상인 일정의 번호, 날짜, 장소, 정원을 조회합니다.
SELECT schedule_id, schedule_date, venue, capacity
FROM program_schedules
WHERE status = '모집중' AND capacity >= 15
ORDER BY schedule_date;

-- 11-2. 수원, 성남, 안양 참가자 중 안내 수신에 동의한 참가자의 번호, 이름, 지역을 조회합니다.
SELECT participant_id, name, region
FROM participants
WHERE region IN ('수원', '성남', '안양') AND notice_agreed = 'Y'
ORDER BY region, name;

-- 11-3. 취소되지 않은 일정 중 2026-08-24 이후 열리는 일정의 번호, 날짜, 상태를 조회합니다.
SELECT schedule_id, schedule_date
FROM program_schedules
WHERE NOT status = '취소' AND schedule_date >= '2026-08-24'
ORDER BY schedule_id;

-- 11-4. 현재 신청 상태인 신청의 번호, 참가자 번호, 일정 번호, 신청 시각을 조회합니다.
SELECT registration_id, participant_id, schedule_id, applied_at
FROM registrations
WHERE registration_status = '신청'
ORDER BY registration_id;

-- 11-5. R-003의 상태와 R-004의 신청 시각을 각각 확인합니다.
SELECT registration_id, registration_status
FROM registrations
WHERE registration_id = 'R-003';
-- 결과: 취소

SELECT registration_id, applied_at
FROM registrations
WHERE registration_id = 'R-004';
-- 결과: 2026-08-10 11:00

-- =========================================================
-- [12] 종료 확인
-- =========================================================

-- 12-1. 전체 신청을 신청 번호순으로 조회합니다.


-- 12-2. 전체 신청 건수를 registration_count라는 이름으로 조회합니다.

