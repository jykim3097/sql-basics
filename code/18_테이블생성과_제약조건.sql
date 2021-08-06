-- DDL�� (�����ͺ��̽� ���ǹ�)
-- Ʈ������� ������ �� ����.

-- ����Ŭ�� ���̺���� ��ҹ��ڸ� ������ �ʴ´�
CREATE TABLE DEPT2(
    DEPT_NO NUMBER(2,0), -- 2�ڸ���, �Ҽ����� ���X
    DEPT_NAME VARCHAR2(14), -- 14byte, ���� 14����, �ѱ� 7����
    LOCA VARCHAR2(10),
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10), -- 10�ڸ� ��, �Ҽ��� x
    DEL_YN CHAR(1) -- ��������
);

DESC DEPT2;

INSERT INTO DEPT2 VALUES (99, '����', '����', SYSDATE, 1000000000, 'Y');

-- ���̺� �� �߰�, ����, �̸� ����, ����
-- �� �߰�
ALTER TABLE DEPT2 ADD (DEPT_COUNT NUMBER(3));

-- �� �̸� ����
ALTER TABLE DEPT2 RENAME COLUMN DEPT_COUNT TO EMP_COUNT;

-- �� ����(Ÿ�� ����)
ALTER TABLE DEPT2 MODIFY (EMP_COUNT NUMBER(10));

-- �� ����
ALTER TABLE DEPT2 DROP COLUMN EMP_COUNT;

DESC DEPT2;

-- ���̺� ����
DROP TABLE DEPT2;
DROP TABLE EMPLOYEES /*CASCADE CONSTRAINTS �������Ǹ�*/; -- PK�� ��� ���� FK�� �ֱ� ������ ������ �ȵȴ�.

CREATE TABLE DEPT2(
    DEPT_NO NUMBER(2,0), -- 2�ڸ���, �Ҽ����� ���X
    DEPT_NAME VARCHAR2(14), -- 14byte, ���� 14����, �ѱ� 7����
    LOCA VARCHAR2(10),
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10), -- 10�ڸ� ��, �Ҽ��� x
    DEL_YN CHAR(1) -- ��������
);

INSERT INTO DEPT2 VALUES (99, '����', '����', SYSDATE, 1000000000, 'Y');
SELECT * FROM DEPT2;

TRUNCATE TABLE DEPT2; -- ������ ���� �ȵ�, ���̺� ������ ���ܵΰ� ������ ���� ����

-------- ���̺� ������ ���� ���� ----------
-- PRIMARY KEY : ���̺��� ���� Ű, �ߺ� X, NULL ���X
-- UNIQUE : ����Ű�� �ƴ����� �ߺ� X, �� �÷��� ������ ���� ���� �Ѵ� �� �� ���
-- NOT NULL : NULL �� ���X
-- FOREIGN KEY : ���� ���̺��� PRIMARY KEY�� �����ϴ� �÷�, ���� ���̺��� PK�� ���ٸ� ����� �� ����, �� NULL�� ����Ѵ�
-- CHECK : ���ǵ� ����(Ư�� ����)�� ����ǵ��� ����Ѵ�

DROP TABLE DEPT2;

-- ���̺� ����� + �� ���� ��������
CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2)       CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY, /*���������̸� : ���̺��_�÷���_PK*/
    DEPT_NAME VARCHAR2(15)  NOT NULL,
    LOCA NUMBER(4)          CONSTRAINT DEPT2_LOCA_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID), /*���������̸� : ���̺��_�÷���_�����ϴ����̺��_FK*/
    DEPT_DATE DATE          DEFAULT SYSDATE, -- �ƹ��͵� �Է� �ȵǸ� �ڵ����� DEFAULT ���� ����ȴ�
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE,
    DEPT_GENDER CHAR(1)     CONSTRAINT DEPT2_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('M', 'F'))
);

-- ���̺� ����� + �� ���� �������� + ���� ���� �̸� ����
CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2)       PRIMARY KEY, /*���������̸� : ���̺��_�÷���_PK*/
    DEPT_NAME VARCHAR2(15)  NOT NULL,
    LOCA NUMBER(4)          REFERENCES LOCATIONS(LOCATION_ID), /*���������̸� : ���̺��_�÷���_�����ϴ����̺��_FK*/
    DEPT_DATE DATE          DEFAULT SYSDATE, -- �ƹ��͵� �Է� �ȵǸ� �ڵ����� DEFAULT ���� ����ȴ�
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL UNIQUE,
    DEPT_GENDER CHAR(1)     CHECK(DEPT_GENDER IN ('M', 'F'))
);

-- ���̺� ����� + ���̺� ���� ��������, NOT NULL�� ���Խ�Ų��
CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(15)  NOT NULL,
    LOCA NUMBER(4),
    DEPT_DATE DATE DEFAULT SYSDATE, -- �ƹ��͵� �Է� �ȵǸ� �ڵ����� DEFAULT ���� ����ȴ�
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20) NOT NULL,
    DEPT_GENDER CHAR(1),
    -- ����Ű�� ���̺� �����θ� �ۼ� �����ϴ�
    CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY(DEPT_NO /*, DEPT_NAME */),
    CONSTRAINT DEPT2_LOCA_LOCID_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(LOCATION_ID),
    CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE(DEPT_PHONE),
    CONSTRAINT DEPT2_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('M', 'F'))
);


-- 210408
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

-- ��ü ���Ἲ ���� ���� ���� ( NULL�� �ߺ��� ������� �ʴ´ٴ� ���� )
INSERT INTO EMPLOYEES(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (100, 'TEST', 'TEST', SYSDATE, 'TEST');

-- ���� ���Ἲ ���� ���� ���� ( ���� ���̺� PK�� �����ؾ� FK�� �� �� �ִٴ� ����)
INSERT INTO EMPLOYEES(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, DEPARTMENT_ID)
VALUES (501, 'TEST', 'TEST', SYSDATE, 'TEST', 5);

-- ������ ���Ἲ ���� ���� ���� ( CHECK ���� ���� ����, ������ ������ �߸� ����־���)
INSERT INTO EMPLOYEES (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY)
VALUES (501, 'TEST', 'TEST', SYSDATE, 'TEST', -10);

-- ���� ���� �߰�, ����
DROP TABLE DEPT2;

CREATE TABLE DEPT2 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(15),
    LOCA NUMBER(4),
    DEPT_DATE DATE DEFAULT SYSDATE, -- �ƹ��͵� �Է� �ȵǸ� �ڵ����� DEFAULT ���� ����ȴ�
    DEPT_BONUS NUMBER(10),
    DEPT_PHONE VARCHAR2(20),
    DEPT_GENDER CHAR(1)
);

-- ���̺� ���� ���� ���ǰ� �Ȱ���
-- PK �߰�
ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPT_NO_PK PRIMARY KEY (DEPT_NO);
-- FK �߰�
ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPT_NO_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS(LOCATION_ID);
-- CHECK �߰�
ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPT_GENDER_CK CHECK (DEPT_GENDER IN ('M', 'F'));
-- UNIQUE �߰�
ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);
-- NOT NULL �߰�( MODIFY������ �߰�) - �Ϲ������� �������� ����
ALTER TABLE DEPT2 MODIFY DEPT_PHONE VARCHAR(20) NOT NULL;

-- ���� ���� ����
-- ���� ������ ���� Ȯ���� �ؾ� ��
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT2';

-- ��¥ ����(�̸����� ����)
ALTER TABLE DEPT2 DROP CONSTRAINT DEPT2_DEPT_NO_PK;

DROP TABLE DEPT2; -- �������ǵ� �� ���� ������

-- ���� ����
--���� 1. ������ ���� ���̺��� �����ϰ� �����͸� insert�ϼ��� (Ŀ��)
--����) M_NAME �� ����������, �ΰ��� ������� ����
--����) M_NUM �� ������, �̸�(mem_memnum_pk) primary key
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, �̸�:(mem_regdate_uk) UNIQUEŰ
--����) GENDER ����������
--����) LOCA ������, �̸�:(mem_loca_loc_locid_fk) foreign key ? ���� locations���̺�(location_id)

CREATE TABLE MEM (
    M_NAME VARCHAR2(5)  NOT NULL,
    M_NUM NUMBER(3)     CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE       NOT NULL CONSTRAINT MEM_REGDATE_UK UNIQUE,
    GENDER VARCHAR2(1)  CHECK(GENDER IN ('M', 'F')),
    LOCA NUMBER(5)      CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

DESC MEM;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'MEM';

INSERT INTO MEM VALUES('AAA', 1, TO_DATE('2018-07-01', 'YYYY-MM-DD'), 'M', 1800);
INSERT INTO MEM VALUES('BBB', 2, TO_DATE('2018-07-02', 'YYYY-MM-DD'), 'F', 1900);
INSERT INTO MEM VALUES('CCC', 3, TO_DATE('2018-07-03', 'YYYY-MM-DD'), 'M', 2000);
INSERT INTO MEM VALUES('DDD', 4, SYSDATE, 'M', 2000);

COMMIT;

--���� 2.
--MEMBERS���̺�� LOCATIONS���̺��� INNER JOIN �ϰ� m_name, m_mum, street_address, location_id
--�÷��� ��ȸ
--m_num�������� �������� ��ȸ
SELECT M.M_NUM, M.M_NAME, M.LOCA, L.STREET_ADDRESS
FROM MEM M INNER JOIN LOCATIONS L ON M.LOCA = L.LOCATION_ID
ORDER BY M_NUM ASC;
