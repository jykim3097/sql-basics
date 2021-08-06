-- 반복문(WHILE, FOR IN), 탈출문(EXIT, CONTINUE)

SET SERVEROUTPUT ON;

/*
WHILE문 구조

WHILE 조건
LOOP

END LOOP;
*/
DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I <= 9
    LOOP   
        DBMS_OUTPUT.PUT_LINE (I);
        I := I + 1;
    END LOOP;
END;

-- 구구단 3단
DECLARE
    DAN NUMBER := 3;
    I NUMBER := 1;
BEGIN
    WHILE I < 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || I || ' = ' || DAN*I);
        I := I + 1;
    END LOOP;
END;

-- 탈출문 EXIT WHEN 조건
-- 1~10바퀴 회전 5일 때 탈출
DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I <= 10
    LOOP 
        DBMS_OUTPUT.PUT_LINE(I);
        EXIT WHEN I =5; -- 탈출
        I := I + 1;
    END LOOP;
END;

-- CONTINUE문 (CONTINUE WHEN 조건)
-- 1~10까지 수 중에 짝수만 출력
DECLARE
    I NUMBER := 0;
BEGIN
    WHILE I < 11
    LOOP
        I := I + 1;
        CONTINUE WHEN MOD(I,2) <> 0;
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;

-- FOR문 FOR I IN 범위
DECLARE
BEGIN
    FOR I IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(3|| 'X' || I || ' = ' || 3*I);
    END LOOP;
END;

-- 연습문제
-- 1. 2단부터 9단까지 모든 구구단을 출력하세요

DECLARE
BEGIN
    FOR DAN IN 2..9
    LOOP
        FOR I IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || I || ' = ' || DAN*I); 
        END LOOP;
    END LOOP;
END;

-- 2.
-- 아래 테이블에 시퀀스를 이용해 300행의 더미데이터를 입력해주세요
CREATE TABLE TEST1 (
    BNO NUMBER(10) PRIMARY KEY,
    WRITER VARCHAR2(30),
    TITLE VARCHAR2(30)
);

CREATE SEQUENCE TEST1_SEQ
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

DECLARE
    I NUMBER := 0;
BEGIN
    WHILE I < 300
    LOOP
        INSERT INTO TEST1 VALUES (TEST1_SEQ.NEXTVAL, 'WRITER', 'TITLE');
        I := I + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('입력이 끝났습니다');
END;

SELECT * FROM TEST1;

-- 예외처리구문 (EXCEPTION WHEN 예외종류 THEN)
-- OTHERS : 모든 예외를 받아줄 수 있음
DECLARE
    V_NUM NUMBER := 0;
BEGIN
    V_NUM := 10 / 0;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다');
END;