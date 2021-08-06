/*
210415

PL/SQL은 프로그램언어 SQL문이다.
쿼리문의 집합으로 어떤 동작을 일괄처리하기 위한 용도로 사용한다

절차형 SQL, '지정된 구문' 안에서 컴파일하는 형식으로 실행된다
-> ctrl + enter로 실행되는 것이 아니고 코드 범위를 지정하고 F5를 눌러서 실행한다
*/
-- 출력문 활성화
SET SERVEROUTPUT ON;

DECLARE --변수 선언 부
    VI_NUM NUMBER; -- 변수 선언 : 변수명 타입;
BEGIN -- 시작
    VI_NUM := 10; -- ':='은 변수의 대입
    DBMS_OUTPUT.PUT_LINE(VI_NUM); -- 출력문
END; -- 끝

-- 연산자 ( +, -, /, *, <>(같지 않다), =(같다), **(제곱)
DECLARE
    A NUMBER := (2 * 3 + 2) ** 2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('A=' || A);
END;

-- DML문과 혼용해서 사용
-- DDL문장은 사용할 수 없고 일반적으로 SELECT문을 사용한다
-- 특이한 점은 SELECT절 아래에 INTO절 사용
DECLARE
    EMP_NAME VARCHAR2(50);
    DEP_NAME VARCHAR2(50);
BEGIN
    SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
    INTO EMP_NAME, DEP_NAME
    FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.put_line(EMP_NAME || '의 부서는 ' || DEP_NAME);
END;

-- 선언한 변수와 SELECT로 조회한 결과의 데이터타입이 다르면 오류를 발생시키는데
-- 해당 테이블의 컬럼과 동일한 타입의 변수를 선언하려면 테이블.컬럼명%TYPE문을 사용한다
DECLARE
    EMP_NAME EMPLOYEES.FIRST_NAME%TYPE;
    EMP_HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE;
    EMP_SAL EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME, HIRE_DATE, SALARY
    INTO EMP_NAME, EMP_HIRE_DATE, EMP_SAL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    DBMS_OUTPUT.PUT_LINE(EMP_NAME || '의 입사일은 ' || EMP_HIRE_DATE || '이고, 급여는 ' || EMP_SAL || '이다.');
END;

/*
SELECT문과 INSERT문 DML문을 같이 사용할 수 있다
*/
CREATE TABLE EMP_SAL (
    EMP_YEARS VARCHAR2(50),
    EMP_SALARY NUMBER(10)
);

SELECT SUM(SALARY)
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2008;

DECLARE
    EMP_SUM EMPLOYEES.SALARY%TYPE;
    EMP_YEARS EMP_SAL.EMP_YEARS%TYPE := 2008;
BEGIN
    SELECT SUM(SALARY)
    INTO EMP_SUM
    FROM EMPLOYEES
    WHERE TO_CHAR(HIRE_DATE, 'YYYY') = EMP_YEARS;
    INSERT INTO EMP_SAL VALUES ( EMP_YEARS, EMP_SUM);
    COMMIT;
END;

SELECT * FROM EMP_sAL;