-- USER2 ����

CREATE TABLE T_TEST2 (
    BNO NUMBER(3)
);

CREATE SEQUENCE T_TEST2_SEQ;

INSERT INTO T_TEST2 VALUES (T_TEST2_SEQ.NEXTVAL);

SELECT * FROM T_TEST2;

