-- insert문
-- 테이블 구조 확인
desc departments;
desc employees;

-- 1ST
insert into departments(department_id, department_name, manager_id, location_id) values (290, '개발', 200, 1700);
insert into departments(department_id, department_name, location_id) values (300, '디자인', 1700);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (310, 'DBA');
INSERT INTO DEPARTMENTS(DEPARTMENT_NAME, DEPARTMENT_ID) VALUES ('서버관리', 320);

-- 2ND, VALUES 뒤에 컬럼 순서대로 값을 적어준다
INSERT INTO DEPARTMENTS VALUES(330, '퍼블리싱', 200, 1700);
INSERT INTO DEPARTMENTS VALUES(340, '데이터분석', 200, 1800);

select * from departments order by department_id desc;

-- DML 문장은 트랜잭션을 통해 DML 이전으로 되돌릴 수 있다
ROLLBACK;

-- 테이블 구조 복사
CREATE TABLE MANAGERS AS (SELECT * FROM employees WHERE 1=2);

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 SELECT * FROM MANAGERS;
DESC MANAGERS;

-- 3ND - 다른 테이블의 특정 행, 서버쿼리절 INSERT
INSERT INTO MANAGERS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
INSERT INTO MANAGERS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) 
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_dATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'FI_ACCOUNT');

-- UPDATE
DESC employees;

-- 사본 테이블 생성
CREATE TABLE EMPS AS (SELECT *
                      FROM employees
                      WHERE 1 = 1);
                      
SELECT * FROM EMPS;

UPDATE EMPS 
SET SALARY = 30000; -- 전부 다 바뀜

ROLLBACK;

-- UPDATE문에는 조건절을 반드시 명시해야 한다
SELECT *
FROM EMPS
WHERE EMPLOYEE_ID = 100;

UPDATE EMPS 
SET SALARY = SALARY * 1.1
WHERE EMPLOYEE_ID = 100;

-- 한 번에 여러 컬럼을 바꾸려면 쉼표를 사용해라
UPDATE EMPS
SET PHONE_NUMBER = '511.123.1111', 
    HIRE_DATE = SYSDATE, 
    COMMISSION_PCT = 0.1
WHERE EMPLOYEE_ID = 100;

-- JOB_ID가 IT_PROG인 사람의 커미션을 0.1로 업데이트
SELECT * FROM EMPS WHERE JOB_ID = 'IT_PROG';

UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID = 'IT_PROG';

UPDATE EMPS
SET COMMISSION_PCT = 0.2
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPS
                       WHERE FIRST_NAME = 'Donald');

SELECT * FROM EMPS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                          FROM EMPS
                                          WHERE FIRST_NAME = 'Donald');
                                          
-- SET 절에 서브쿼리
-- UPDEATE EMPS SET (컬럼대상) = (서브쿼리), WHERE 조건
SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
FROM EMPS
WHERE EMPLOYEE_ID IN (102, 103);

UPDATE EMPS
SET (JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) = 
    (SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
     FROM EMPS
     WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 102;

ROLLBACK;

-- DELETE
SELECT *  FROM DEPARTMENTS;

-- EMPLOYEE 테이블에서 50번 부서를 참조하고 있기 때문에 오류 발생, 삭제 이상, 참조 무결성 제약 조건 위배
DELETE FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 50;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

-- EMPS
-- DELETE를 수행하기 전 SELECT문으로 반드시 확인! ★
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 105;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 105;

-- WHERE 절의 서브쿼리
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping';
DELETE FROM EMPS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping');

DELETE FROM EMPS WHERE EMPLOYEE_ID = 1000;

ROLLBACK;