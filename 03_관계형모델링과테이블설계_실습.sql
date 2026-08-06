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
PRAGMA foreign_keys = ON;


-- ================================================================
-- [7] 종료 검수
-- ================================================================


