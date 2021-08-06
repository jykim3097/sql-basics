---- 연습테이블 마우스로 ~
--CREATE TABLE AUTH 
--(
--  ID VARCHAR2(30 BYTE) NOT NULL 
--, NAME VARCHAR2(30 BYTE) 
--, JOB VARCHAR2(30 BYTE) 
--, CONSTRAINT AUTH_PK PRIMARY KEY 
--  (
--    ID 
--  )
--);
--
--CREATE TABLE INFO 
--(
--  BNO NUMBER(10, 0) NOT NULL 
--, TITLE VARCHAR2(30 BYTE) 
--, CONTENT VARCHAR2(30 BYTE) 
--, ID VARCHAR2(30 BYTE) 
--, CONSTRAINT INFO_PK PRIMARY KEY 
--  (
--    BNO 
--  )
--
--) ;

--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS, ID) VALUES ('1', 'java', 'java is..', '1')
--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS, ID) VALUES ('2', 'js', 'js is..', '1')
--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS, ID) VALUES ('3', 'oracle', 'oracle is..', '1')
--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS, ID) VALUES ('4', 'spring ', 'spring..', '2')
--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS, ID) VALUES ('5', 'mysql', 'mysql..', '3')
--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS, ID) VALUES ('6', 'c', 'c...', '4')
--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS) VALUES ('7', '음', '음..')
--
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('1', '홍길동', '전업주부')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('2', '이순신', 'DBA')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('3', '김지영', 'designer')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('4', '홍길동', '선생님')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('5', '고길동', '과학자')

------------------------------------조인-------------------------------------------------------------
SELECT * FROM auth;
SELECT * FROM info;

-- inner join, 붙일 수 있는 애만 나온다
SELECT * FROM info INNER JOIN auth ON info.ID = auth.ID;

SELECT *
FROM EMPLOYEES JOIN DEPARTMENTS
USING(DEPARTMENT_ID);

-- select문의 열을 선택할 때 id만 쓰게 되면 양쪽 테이블에 id가 존재하기 때문에 
-- 테이블이름.컬럼이름으로 직접 지정해줘야한다.
SELECT info.ID, bno, title, CONTENTS, NAME, JOB 
FROM info INNER JOIN auth 
ON info.ID = auth.ID;

-- 테이블 이름이 길면 별칭을 사용한다
SELECT I.ID, bno, title, CONTENTS, NAME, JOB
FROM info I INNER JOIN auth A
ON I.ID = A.ID;

-- 조건절도 사용 가능!
SELECT I.ID, bno, title, CONTENTS, NAME, JOB
FROM info I INNER JOIN auth A
ON I.ID = A.ID
WHERE JOB='전업주부';

-- 103번 사원의 이름과 부서이름 그리고 주소를 출력한다
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT CONCAT(E.FIRST_NAME || ' ', E.LAST_NAME) AS 이름, 
       D.DEPARTMENT_NAME AS 부서이름, 
       L.STREET_ADDRESS || ' ' || L.CITY || ', ' || L.STATE_PROVINCE AS 주소
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.EMPLOYEE_ID = 103;


-- 210402
-- OUTER JOIN
-- LEFT OUTER JOIN (왼쪽 기준 테이블)
SELECT *
FROM info I LEFT OUTER JOIN auth A
ON I.ID = A.ID;

-- 사원의 직무 변동 기록 출력
-- 직무 변동 이력이 없는 사원도 출력해야하기 때문에 LEFT OUTER JOIN을 사용한다
SELECT *
FROM JOB_HISTORY
ORDER BY EMPLOYEE_ID;

SELECT *
FROM EMPLOYEES E LEFT OUTER JOIN JOB_HISTORY J
ON E.EMPLOYEE_ID = J.EMPLOYEE_ID;

-- RIGHT OUTER JOIN (오른쪽 기준 테이블)
SELECT * FROM info I RIGHT OUTER JOIN auth A ON I.ID=A.ID;

-- FULL OUTER JOIN (양쪽 테이블이 다 나옴)
SELECT * FROM info I FULL OUTER JOIN auth A ON I.ID=A.ID;

-- CROSS JOIN (잘못된 조인)
SELECT * FROM info I CROSS JOIN auth A;

-- 3개의 테이블도 조인이 될까
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT E.first_name, D.department_name
FROM employees E LEFT OUTER JOIN departments D ON E.department_id = D.department_id
                 LEFT OUTER JOIN locations L ON D.location_id = L.location_id;