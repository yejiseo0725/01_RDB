-- 01. 관계형 데이터베이스 시작: SQLite 환경과 단일 테이블
-- 작성한 SQL은 이 파일에 저장합니다.
-- sqlite

-- [1] SQLite 연결 확인
SELECT 'SQLite 연결 확인' AS 확인_메시지;
SELECT * FROM participants;
SELECT name
    FROM sqlite_master
    WHERE type='table';

-- [2] participants 테이블 생성
-- 학습자용 문서 3-1의 SQL을 이곳에 복사해 실행합니다.
CREATE TABLE participants (
    participant_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL CHECK (region IN ('수원', '성남', '용인', '안양', '화성')),
    preferred_category TEXT NOT NULL
        CHECK (preferred_category IN ('공예', '건강', '디지털 생활', '요리')),
    phone TEXT,
    joined_date TEXT NOT NULL,
    notice_agreed TEXT NOT NULL DEFAULT 'N'
        CHECK (notice_agreed IN ('Y', 'N'))
);

    SELECT name
        FROM sqlite_master
        WHERE type='table';

-- [3] 테이블 구조 확인
PRAGMA table_info(participants);

-- [4] 제공 데이터 8건 입력
-- 학습자용 문서 4-1의 SQL을 이곳에 복사해 실행합니다.
INSERT INTO participants (participant_id, name, region, preferred_category, phone, joined_date, notice_agreed)
VALUES
    ('P-001', '김서윤', '수원', '공예', '010-2468-1357', '2026-08-01', 'Y'),
    ('P-002', '박도윤', '성남', '건강', '010-9753-2468', '2026-08-01', 'N'),
    ('P-003', '이민지', '수원', '디지털 생활', '010-1357-8642', '2026-08-02', 'Y'),
    ('P-004', '최하준', '용인', '요리', '010-8642-7531', '2026-08-02', 'N'),
    ('P-005', '정다은', '안양', '건강', '010-5791-4682', '2026-08-03', 'Y'),
    ('P-006', '한지후', '화성', '공예', '010-4682-5791', '2026-08-03', 'N'),
    ('P-007', '윤채원', '성남', '디지털 생활', '010-7913-2468', '2026-08-04', 'Y'),
    ('P-008', '오민재', '수원', '요리', '010-2468-7913', '2026-08-04', 'N');

-- [5] 기본값 확인용 P-009 입력
-- 학습자용 문서 4-2의 SQL을 이곳에 복사해 실행합니다.


-- [6] P-010 ~ P-012 직접 입력


-- [7] 제약 오류 검증과 종료 확인 SQL
