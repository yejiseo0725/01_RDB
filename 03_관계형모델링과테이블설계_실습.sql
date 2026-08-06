-- 03. 관계형 데이터 모델링과 SQL 테이블 설계
-- 실행 대상: culture_program_03.db
-- 시작 전제: participants 테이블에 P-001 ~ P-020이 저장되어 있습니다.
-- 이 파일의 [필수] SQL은 자료의 실행 순서와 같습니다.
-- [직접 작성] 부분은 학습자용 빈칸입니다. 정답은 강사용 파일에만 둡니다.

-- ================================================================
-- [1] 시작 상태 확인
-- ================================================================

SELECT participant_id, name, region, preferred_category
FROM participants
ORDER BY participant_id;

SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;


-- ================================================================
-- [2] programs 테이블 생성과 구조 확인
-- ================================================================
INSERT INTO programs (
    program_id, program_name, category, description, contact_phone
)
VALUES
    ('PG-001', '생활 공예 입문', '공예', '일상 소품을 만드는 기초 활동', '031-8000-1001'),
    ('PG-002', '건강한 일상', '건강', '가벼운 생활 운동과 건강 습관', '031-8000-1002'),
    ('PG-003', '스마트폰 생활 활용', '디지털 생활', '생활에 필요한 스마트폰 기능 연습', '031-8000-1003');

SELECT program_id, program_name, category, is_active
FROM programs
ORDER BY program_id;



-- ================================================================
-- [3] programs 6건 입력
-- ================================================================
INSERT INTO programs (
    program_id, program_name, category, description, contact_phone, is_active
)
VALUES
    ('PG-004', '함께 만드는 계절 요리', '요리', '제철 재료로 만드는 간단한 생활 요리', '031-8000-1004', 'Y'),
    ('PG-005', '동네 기록 사진', '생활예술', '휴대전화로 생활 장면을 기록하는 사진 활동', '031-8000-1005', 'Y'),
    ('PG-006', '기초 디지털 문서', '디지털 생활', '문서 작성과 파일 정리의 기초', '031-8000-1006', 'Y');

SELECT * FROM programs;

-- [반복·응용] 현재 운영 중인 프로그램의 번호와 이름을 직접 조회합니다.

-- [반복·응용] 디지털 생활 분야 프로그램의 이름과 담당 연락처를 직접 조회합니다.

-- [반복·응용] 프로그램 분야 종류를 중복 없이 가나다순으로 직접 조회합니다.


-- ================================================================
-- [4] 외래 키 검사 설정과 program_schedules 테이블 생성
-- ================================================================

-- 일정 테이블의 program_id에는 이미 등록된 프로그램 번호만 입력할 수 있어야 합니다.
-- 이후 일정 테이블의 외래 키 규칙을 검사하도록, 첫 INSERT 전에 설정합니다.
PRAGMA foreign_keys = ON;
PRAGMA foreign_keys;



-- ================================================================
-- [5] program_schedules 12건 입력
-- ================================================================
PRAGMA foreign_keys = ON;



-- [반복·응용] 모집중인 일정의 번호와 프로그램 번호를 직접 조회합니다.

-- [반복·응용] 수원 시민회관 2층에서 열리는 일정의 번호와 날짜를 직접 조회합니다.

-- [반복·응용] 일정 상태의 종류를 중복 없이 직접 조회합니다.


-- ================================================================
-- [6] 제약 조건 오류 확인: 오류가 나면 정상입니다.
-- 각 SQL은 한 번만 실행하고 오류 메시지를 확인합니다.
-- ================================================================

INSERT INTO programs (
    program_id, program_name, category, description, contact_phone
)
VALUES
    ('PG-001', '생활 공예 입문', '공예', '일상 소품을 만드는 기초 활동', '031-8000-1001'),
    ('PG-002', '건강한 일상', '건강', '가벼운 생활 운동과 건강 습관', '031-8000-1002'),
    ('PG-003', '스마트폰 생활 활용', '디지털 생활', '생활에 필요한 스마트폰 기능 연습', '031-8000-1003');

INSERT INTO programs (
    program_id, program_name, category, description, contact_phone, is_active
)
VALUES
    ('PG-004', '함께 만드는 계절 요리', '요리', '제철 재료로 만드는 간단한 생활 요리', '031-8000-1004', 'Y'),
    ('PG-005', '동네 기록 사진', '생활예술', '휴대전화로 생활 장면을 기록하는 사진 활동', '031-8000-1005', 'Y'),
    ('PG-006', '기초 디지털 문서', '디지털 생활', '문서 작성과 파일 정리의 기초', '031-8000-1006', 'Y');

CREATE TABLE programs (
    program_id TEXT PRIMARY KEY, 
    program_name TEXT NOT NULL, 
    category TEXT NOT NULL 
        CHECK (category IN ('공예', '건강', '디지털 생활', '요리', '생활예술')),
    description TEXT NOT NULL, 
    contact_phone TEXT NOT NULL, 
    is_active TEXT NOT NULL DEFAULT 'Y' 
        CHECK (is_active IN ('Y', 'N')) 
);

SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;

-- 구조 확인 (열, 타입, 제약조건 등)
PRAGMA table_info(programs);

-- 데이터가 몇 건 들어있는지 확인
SELECT * FROM programs;

-- 분야값 규칙 오류


-- 정원 규칙 오류


-- 외래 키 규칙 오류: FOREIGN KEY constraint failed가 예상됩니다.
-- 외래 키 검사 ON 
PRAGMA foreign_keys = ON;
PRAGMA foreign_keys;

CREATE TABLE program_schedules ( schedule_id TEXT PRIMARY KEY, program_id TEXT NOT NULL, schedule_date TEXT NOT NULL, start_time TEXT NOT NULL, venue TEXT NOT NULL, capacity INTEGER NOT NULL CHECK (capacity > 0), status TEXT NOT NULL DEFAULT '모집중' CHECK (status IN ('모집중', '마감', '취소')), FOREIGN KEY (program_id) REFERENCES programs(program_id) );

PRAGMA table_info(program_schedules);
PRAGMA foreign_key_list(program_schedules);

-- ================================================================
-- [7] 종료 검수
-- ================================================================


INSERT INTO program_schedules (
    schedule_id, program_id, schedule_date, start_time, venue, capacity
)
VALUES 
    ('S-001', 'PG-001', '2026-08-20', '10:00', '수원 시민회관 2층', 18),
    ('S-002', 'PG-002', '2026-08-27', '10:00', '수원 시민회관 2층', 18),
    ('S-003', 'PG-003', '2026-08-22', '14:00', '성남 생활문화센터', 20),
    ('S-004', 'PG-004', '2026-08-29', '14:00', '성남 생활문화센터', 20);

SELECT schedule_id, program_id, schedule_date, start_time, venue, capacity, status
FROM program_schedules
ORDER BY schedule_id;

--

INSERT INTO program_schedules (
    schedule_id, program_id, schedule_date, start_time, venue, capacity, status
)
VALUES 
    ('S-005', 'PG-003', '2026-08-21', '19:00', '용인 생활학습관', 16, '모집중'),
    ('S-006', 'PG-003', '2026-08-28', '19:00', '용인 생활학습관', 16, '마감'),
    ('S-007', 'PG-004', '2026-08-23', '11:00', '화성 공유부엌', 12, '모집중'),
    ('S-008', 'PG-004', '2026-08-30', '11:00', '화성 공유부엌', 12, '모집중');

INSERT INTO program_schedules ( 
    schedule_id, program_id, schedule_date, start_time, venue, capacity, status 
) 
VALUES 
    ('S-009', 'PG-005', '2026-08-24', '15:00', '안양 문화공간', 15, '모집중'), 
    ('S-010', 'PG-005', '2026-08-31', '15:00', '안양 문화공간', 15, '취소'), 
    ('S-011', 'PG-006', '2026-09-02', '18:30', '수원 시민회관 3층', 14, '모집중'), 
    ('S-012', 'PG-006', '2026-09-09', '18:30', '수원 시민회관 3층', 14, '모집중');

SELECT schedule_id, program_id, schedule_date, start_time, venue, capacity, status
FROM program_schedules
ORDER BY schedule_id;

UPDATE program_schedules
SET program_id = 'PG-001'
WHERE schedule_id = 'S-002';

UPDATE program_schedules
SET program_id = 'PG-002'
WHERE schedule_id = 'S-003';

UPDATE program_schedules
SET program_id = 'PG-002'
WHERE schedule_id = 'S-004';

SELECT schedule_id, program_id, schedule_date, start_time, venue, capacity, status
FROM program_schedules
ORDER BY schedule_id;

-- 1
SELECT schedule_id, schedule_date, venue 
FROM program_schedules
-- 8월만
WHERE schedule_date LIKE '2026-08%'
ORDER BY schedule_id;

-- 2
SELECT schedule_id, program_id
FROM program_schedules
WHERE status = '모집중'
ORDER BY schedule_id;

-- 3
SELECT schedule_id, schedule_date
FROM program_schedules
WHERE venue = '수원 시민회관 2층'
ORDER BY schedule_id;

-- 4
SELECT DISTINCT status
FROM program_schedules
ORDER BY status;

-- [8] 
INSERT INTO programs (
    program_id, program_name, category, description, contact_phone
)
VALUES (
    'PG-099', '테스트 프로그램', '디지털교육', '입력 규칙 확인용 데이터', '031-8000-1099'
);


SELECT program_id, program_name, category FROM programs WHERE program_id = 'PG-099';

INSERT INTO program_schedules (
    schedule_id, program_id, schedule_date, start_time, venue, capacity
) 
VALUES ( 
    'S-099', 'PG-001', '2026-09-15', '10:00', '수원 시민회관 2층', 0 
);

SELECT schedule_id, capacity FROM program_schedules WHERE schedule_id = 'S-099';

PRAGMA foreign_keys = ON;

INSERT INTO program_schedules (
    schedule_id, program_id, schedule_date, start_time, venue, capacity
)
VALUES (
    'S-100', 'PG-999', '2026-09-16', '13:00', '용인 생활학습관', 10
);

PRAGMA foreign_keys = ON;

DELETE FROM program_schedules 
WHERE schedule_id = 'S-100';

SELECT schedule_id, program_id
FROM program_schedules
WHERE schedule_id = 'S-100';

-- [9] 만든 구조 검수
SELECT name
FROM sqlite_master 
WHERE type = 'table'
ORDER BY name;

SELECT COUNT(*) AS participant_count FROM participants;
SELECT COUNT(*) AS program_count FROM programs;
SELECT COUNT(*) AS schedule_count FROM program_schedules;

SELECT schedule_id, program_id, schedule_date, venue FROM program_schedules WHERE program_id = 'PG-001' ORDER BY schedule_date;