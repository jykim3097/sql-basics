-- SEQUENCE ( 순차적으로 증가하는 값)
SELECT * FROM USER_SEQUENCES;

-- 시퀀스 생성문
-- CREATE SEQUENCE DEPT2_SEQ; -- 자동생성

CREATE SEQUENCE DEPT2_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCACHE
    NOCYCLE;

CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(5)   PRIMARY KEY,
    DEPT_NAME VARCHAR(20),
    LOCA NUMBER(4)
);

DESC DEPT2;

INSERT INTO DEPT2 VALUES(DEPT2_SEQ.NEXTVAL, 'TEST', 300);
INSERT INTO DEPT2 VALUES(DEPT2_SEQ.NEXTVAL, 'TEST', 300);
INSERT INTO DEPT2 VALUES(DEPT2_SEQ.NEXTVAL, 'TEST', 300);

SELECT * FROM DEPT2;
SELECT DEPT2_SEQ.CURRVAL FROM DUAL;
SELECT DEPT2_SEQ.NEXTVAL FROM DUAL;

-- 시퀀스 변경 ALTER
ALTER SEQUENCE DEPT2_SEQ MAXVALUE 100000;
ALTER SEQUENCE DEPT2_SEQ INCREMENT BY 100;
ALTER SEQUENCE DEPT2_SEQ MINVALUE 1;

-- 시퀀스 삭제 DROP
DROP SEQUENCE DEPT2_SEQ;

-- 시쿼스를 다시 처음으로 되돌리는 방법
-- DROP을 할 수는 없기 때문에!
CREATE SEQUENCE DEPT2_SEQ
    INCREMENT BY 10
    NOCACHE
    NOCYCLE;

SELECT DEPT2_SEQ.NEXTVAL FROM DUAL;

-- 1. 현재 시퀀스 확인
SELECT DEPT2_SEQ.CURRVAL FROM DUAL;
-- 2. 증가값을 (현재 시퀀스-1)만큼 MINUS
ALTER SEQUENCE DEPT2_SEQ INCREMENT BY -10;
-- 3. 한 번 NEXTVAL를 하고
SELECT DEPT2_SEQ.NEXTVAL FROM DUAL;
-- 4. 증가값을 1로 변경
ALTER SEQUENCE DEPT2_SEQ INCREMENT BY 1;

-- 시퀀스 활용 PK의 형식 : 20210408-시퀀스
CREATE TABLE DEPT3 (
    DEPT_NO VARCHAR2(30) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);

CREATE SEQUENCE DEPT3_SEQ
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

INSERT INTO DEPT3 VALUES( TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || LPAD(DEPT3_SEQ.NEXTVAL,5,0), 'TEST');

SELECT * FROM DEPT3;

-- INDEX
-- PRIMARY KEY, UNIQUE 제약 조건을 사용할 때 자동으로 생성되고, 또는 수동으로 직접 생성할 수 있다
-- INDEX를 저장하는 추가적인 공간을 갖고 생성되고, 조회를 빠르게 한다
-- 다만 수정, 삭제, 변경이 빈번하게 일어나는 컬럼에 적용하면 반대로 성능 부하를 일으킬 수 있다

-- F10 누르면 디버깅(?) 할 수 있다
SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy';

-- EMPS 테이블의 FIRST_NAME에 인덱스 부여
CREATE INDEX EMP_FIRST_NAME_IDX ON EMPS(FIRST_NAME);

-- INDEX 삭제 ( 인덱스를 지워도 테이블에 전혀 영향이 없다 )
DROP INDEX EMP_FIRST_NAME_IDX;

-- INDEX를 HINT로 사용하는 SQL문
CREATE TABLE T_BOARD (
    BNO NUMBER(10) PRIMARY KEY,
    WRITER VARCHAR2(20)
);

CREATE SEQUENCE T_BOARD_SEQ;
INSERT INTO T_BOARD VALUES (T_BOARD_SEQ.NEXTVAL, 'TEST'); -- *105

SELECT *
FROM (SELECT ROWNUM AS RN, BNO, WRITER
      FROM ( SELECT * 
             FROM T_BOARD 
             ORDER BY BNO DESC))
WHERE RN BETWEEN 40 AND 50;

-- INDEX 이름 변경
ALTER INDEX SYS_C008031 RENAME TO T_BOARD_IDX;

-- 주석이 아니라 HINT를 주는 것
-- HINT 주는 것만으로 위의 코드를 줄여줄 수 있다.
SELECT *
FROM (SELECT /*+INDEX_DESC(T_BOARD T_BOARD_IDX)*/
      ROWNUM RN,
      BNO,
      WRITER
      FROM T_BOARD)
WHERE RN > 40 AND RN <= 50;