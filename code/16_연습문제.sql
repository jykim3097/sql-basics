-- 연습 문제

-- 1. DEPTS 테이블에 데이터 삽입
SELECT * FROM DEPTS ORDER BY DEPARTMENT_ID DESC;

INSERT INTO DEPTS VALUES (280, '개발', NULL, 1800);
INSERT INTO DEPTS VALUES (290, '회계부', NULL, 1800);
INSERT INTO DEPTS VALUES (300, '재정', 301, 1800);
INSERT INTO DEPTS VALUES (310, '인사', 302, 1800);
INSERT INTO DEPTS VALUES (320, '영업', 303, 1700);

-- 2. DEPTS 테이블 데이터 수정
-- 1) department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Support';

UPDATE DEPTS 
SET DEPARTMENT_NAME = 'IT Bank'
WHERE DEPARTMENT_NAME = 'IT Support';

-- 2) department_id가 290인 데이터의 manager_id를 301로 변경
SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 290; -- 현재 MANAGER_ID는 NULL

UPDATE DEPTS 
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 290; -- 301로 UPDATE

-- 3)  department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를 1800으로 변경하세요
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Helpdesk'; -- IT Helpdesk, null, 17000

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';

SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Help'; -- IT Help, 303, 18000

-- 4) DEPARTMENT_ID가 290,300,310,320번인 사람의 매니저아이디를 301로 한번에 변경하세요.
SELECT * FROM DEPTS WHERE DEPARTMENT_ID IN (290,300,310, 320);

UPDATE DEPTS
SET DEPARTMENT_ID = 301
WHERE DEPARTMENT_ID IN (290,300,310, 320);

SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 301;

--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1) 부서명 영업부를 삭제 하세요
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'Sales');

--2) 부서명 NOC를 삭제하세요
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');

--문제4
--1) Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE DEPARTMENT_ID > 200;

--2) Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
SELECT * FROM DEPTS;

UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;

--3) Depts 테이블은 타겟 테이블 입니다.
--Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
--새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.
MERGE INTO DEPTS A
USING (SELECT * FROM DEPARTMENTS) B
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
WHEN MATCHED THEN 
    UPDATE SET A.DEPARTMENT_NAME = B.DEPARTMENT_NAME,
               A.MANAGER_ID = B.MANAGER_ID,
               A.LOCATION_ID = B.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES (B.DEPARTMENT_ID,
                   B.DEPARTMENT_NAME,
                   B.MANAGER_ID,
                   B.LOCATION_ID);

SELECT * FROM DEPTS ORDER BY DEPARTMENT_ID;

--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
SELECT * FROM JOBS;
CREATE TABLE JOBS_IT2 AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);
SELECT * FROM JOBS_IT2;
--2. jobs_it 테이블에 다음 데이터를 추가하세요
INSERT INTO JOBS_IT2 VALUES ('IT_DEV','아이티개발팀',6000,20000);
INSERT INTO JOBS_IT2 VALUES ('NET_DEV','네트워크개발팀',5000,20000);
INSERT INTO JOBS_IT2 VALUES ('SEC_DEV','보안개발팀',6000,19000);

--3. jobs_it은 타겟 테이블 입니다
--jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
--데이터는 그대로 추가해주는 merge문을 작성하세요
MERGE INTO JOBS_IT2 A
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) B
ON (A.JOB_ID = B.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET A.MIN_SALARY = B.MIN_SALARY,
               A.MAX_SALARY = B.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES (B.JOB_ID,
                   B.JOB_TITLE,
                   B.MIN_SALARY,
                   B.MAX_SALARY);
                   
SELECT * FROM JOBS_IT2;

COMMIT; -- 마지막 커밋 지점ㄴ