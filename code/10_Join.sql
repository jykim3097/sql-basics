---- �������̺� ���콺�� ~
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
--INSERT INTO "HR"."INFO" (BNO, TITLE, CONTENTS) VALUES ('7', '��', '��..')
--
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('1', 'ȫ�浿', '�����ֺ�')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('2', '�̼���', 'DBA')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('3', '������', 'designer')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('4', 'ȫ�浿', '������')
--INSERT INTO "HR"."AUTH" (ID, NAME, JOB) VALUES ('5', '��浿', '������')

------------------------------------����-------------------------------------------------------------
SELECT * FROM auth;
SELECT * FROM info;

-- inner join, ���� �� �ִ� �ָ� ���´�
SELECT * FROM info INNER JOIN auth ON info.ID = auth.ID;

SELECT *
FROM EMPLOYEES JOIN DEPARTMENTS
USING(DEPARTMENT_ID);

-- select���� ���� ������ �� id�� ���� �Ǹ� ���� ���̺� id�� �����ϱ� ������ 
-- ���̺��̸�.�÷��̸����� ���� ����������Ѵ�.
SELECT info.ID, bno, title, CONTENTS, NAME, JOB 
FROM info INNER JOIN auth 
ON info.ID = auth.ID;

-- ���̺� �̸��� ��� ��Ī�� ����Ѵ�
SELECT I.ID, bno, title, CONTENTS, NAME, JOB
FROM info I INNER JOIN auth A
ON I.ID = A.ID;

-- �������� ��� ����!
SELECT I.ID, bno, title, CONTENTS, NAME, JOB
FROM info I INNER JOIN auth A
ON I.ID = A.ID
WHERE JOB='�����ֺ�';

-- 103�� ����� �̸��� �μ��̸� �׸��� �ּҸ� ����Ѵ�
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT CONCAT(E.FIRST_NAME || ' ', E.LAST_NAME) AS �̸�, 
       D.DEPARTMENT_NAME AS �μ��̸�, 
       L.STREET_ADDRESS || ' ' || L.CITY || ', ' || L.STATE_PROVINCE AS �ּ�
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.EMPLOYEE_ID = 103;


-- 210402
-- OUTER JOIN
-- LEFT OUTER JOIN (���� ���� ���̺�)
SELECT *
FROM info I LEFT OUTER JOIN auth A
ON I.ID = A.ID;

-- ����� ���� ���� ��� ���
-- ���� ���� �̷��� ���� ����� ����ؾ��ϱ� ������ LEFT OUTER JOIN�� ����Ѵ�
SELECT *
FROM JOB_HISTORY
ORDER BY EMPLOYEE_ID;

SELECT *
FROM EMPLOYEES E LEFT OUTER JOIN JOB_HISTORY J
ON E.EMPLOYEE_ID = J.EMPLOYEE_ID;

-- RIGHT OUTER JOIN (������ ���� ���̺�)
SELECT * FROM info I RIGHT OUTER JOIN auth A ON I.ID=A.ID;

-- FULL OUTER JOIN (���� ���̺��� �� ����)
SELECT * FROM info I FULL OUTER JOIN auth A ON I.ID=A.ID;

-- CROSS JOIN (�߸��� ����)
SELECT * FROM info I CROSS JOIN auth A;

-- 3���� ���̺� ������ �ɱ�
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT E.first_name, D.department_name
FROM employees E LEFT OUTER JOIN departments D ON E.department_id = D.department_id
                 LEFT OUTER JOIN locations L ON D.location_id = L.location_id;