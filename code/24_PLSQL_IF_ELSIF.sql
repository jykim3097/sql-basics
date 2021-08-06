-- DB에서 랜덤수 추출
-- 1 이상 11 미만
SELECT TRUNC(DBMS_RANDOM.VALUE(1,11)) FROM DUAL;

SET SERVEROUTPUT ON;

-- IF문 ( IF (조건) THEN ELSE END IF; )
DECLARE
    NUM1 NUMBER := 5;
    NUM2 NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,11));
BEGIN
    IF NUM1 >= NUM2 THEN 
        DBMS_OUTPUT.PUT_LINE('큰 수는 ' || NUM1);
    ELSE DBMS_OUTPUT.PUT_LINE('큰 수는 ' || NUM2);
    END IF;
END;

-- ELSEIF문
DECLARE
    RAN_NUM NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,101));
BEGIN
    IF RAN_NUM > 90 THEN 
        DBMS_OUTPUT.PUT_LINE('A');
    ELSIF RAN_NUM > 80 THEN
        DBMS_OUTPUT.PUT_LINE('B');    
    ELSIF RAN_NUM > 70 THEN
        DBMS_OUTPUT.PUT_LINE('C');
    ELSIF RAN_NUM > 60 THEN
        DBMS_OUTPUT.PUT_LINE('D');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F');
    END IF;
END;

/*
첫번째 값은 ROWNUM을 이용하면 된다
1~120 사이의 랜덤한 번호를 이용해서 랜덤 DEPARTMENT_ID의 첫번째 행만 SELECT합니다
뽑은 사람의 SALARY가 9000 이상이면 높음, 5000 이상이면 중간, 나머지는 낮음으로 출력
*/
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID;

DECLARE
    DEPT_ID NUMBER := ROUND(DBMS_RANDOM.VALUE(10,120),-1);
    SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY
    INTO SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = DEPT_ID AND ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE(SALARY);
    IF SALARY >= 9000 THEN
        DBMS_OUTPUT.PUT_LINE('높음');
    ELSIF SALARY >= 5000 THEN
        DBMS_OUTPUT.PUT_LINE('중간');
    ELSE
        DBMS_OUTPUT.PUT_LINE('낮음');
    END IF;
END;


-- 210416
-- CASE문
DECLARE
    SAL EMPLOYEES.SALARY%TYPE;
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(10,120), -1); -- 양의 자리수에서 반올림
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = RAN AND ROWNUM = 1;
    
    CASE WHEN SAL >= 9000 THEN -- WHEN절 뒤에 조건
            DBMS_OUTPUT.PUT_LINE('높음');
         WHEN SAL >= 5000 THEN
            DBMS_OUTPUT.PUT_LINE('중간');
        ELSE
            DBMS_OUTPUT.PUT_LINE('낮음');
    END CASE;
END;