SET SERVEROUTPUT ON;

-- 1. 구구단 3단을 출력하는 익명블록
DECLARE
    NUM NUMBER(2) :=3;
BEGIN
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 1 = ' || NUM*1);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 2 = ' || NUM*2);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 3 = ' || NUM*3);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 4 = ' || NUM*4);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 5 = ' || NUM*5);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 6 = ' || NUM*6);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 7 = ' || NUM*7);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 8 = ' || NUM*8);
    DBMS_OUTPUT.PUT_LINE(NUM || ' * 9 = ' || NUM*9);
END;


-- 2. 사원테이블의 201번 사원의 이름과 이메일 주소
DECLARE
    ID EMPLOYEES.EMPLOYEE_ID%TYPE := 201;
    FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
    EMAIL EMPLOYEES.EMAIL%TYPE;
BEGIN
    SELECT FIRST_NAME, LAST_NAME, EMAIL
    INTO FIRST_NAME, LAST_NAME, EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = ID;
    
    DBMS_OUTPUT.put_line(ID || '번 사원의 이름은 ' || FIRST_NAME || ' ' || LAST_NAME || '이고, 이메일은 ' || EMAIL);
END;

-- 3. 사원테이블에서 사원번호가 가장 큰 사원을 찾아낸 후,
--    (이 번호 + 1)번으로 아래 EMPS테이블에 사원번호, 이름, 이메일, 입사일, JOB_ID만 INSERT
CREATE TABLE EMPS
AS (SELECT *
    FROM EMPLOYEES
    WHERE 1 = 2);

SELECT MAX(EMPLOYEE_ID)
FROM EMPLOYEES;

DECLARE
    RECRUIT_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
    SELECT MAX(EMPLOYEE_ID)
    INTO RECRUIT_ID
    FROM EMPLOYEES;
    
    INSERT INTO EMPS(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) 
    VALUES(RECRUIT_ID, 'ELFAVA', 'ELFAVA', 'ELFIE', SYSDATE, 'WICHED');
END;

SELECT * FROM EMPS;