-- ���� ����

-- 1. DEPTS ���̺� ������ ����
SELECT * FROM DEPTS ORDER BY DEPARTMENT_ID DESC;

INSERT INTO DEPTS VALUES (280, '����', NULL, 1800);
INSERT INTO DEPTS VALUES (290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS VALUES (300, '����', 301, 1800);
INSERT INTO DEPTS VALUES (310, '�λ�', 302, 1800);
INSERT INTO DEPTS VALUES (320, '����', 303, 1700);

-- 2. DEPTS ���̺� ������ ����
-- 1) department_name �� IT Support �� �������� department_name�� IT bank�� ����
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Support';

UPDATE DEPTS 
SET DEPARTMENT_NAME = 'IT Bank'
WHERE DEPARTMENT_NAME = 'IT Support';

-- 2) department_id�� 290�� �������� manager_id�� 301�� ����
SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 290; -- ���� MANAGER_ID�� NULL

UPDATE DEPTS 
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 290; -- 301�� UPDATE

-- 3)  department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵� 1800���� �����ϼ���
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Helpdesk'; -- IT Helpdesk, null, 17000

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';

SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Help'; -- IT Help, 303, 18000

-- 4) DEPARTMENT_ID�� 290,300,310,320���� ����� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
SELECT * FROM DEPTS WHERE DEPARTMENT_ID IN (290,300,310, 320);

UPDATE DEPTS
SET DEPARTMENT_ID = 301
WHERE DEPARTMENT_ID IN (290,300,310, 320);

SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 301;

--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1) �μ��� �����θ� ���� �ϼ���
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'Sales');

--2) �μ��� NOC�� �����ϼ���
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');

--����4
--1) Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE DEPARTMENT_ID > 200;

--2) Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
SELECT * FROM DEPTS;

UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;

--3) Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO DEPTS A
USING (SELECT * FROM DEPARTMENTS) B
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
WHEN MATCHED THEN 
    UPDATE SET A.DEPARTMENT_NAME = B.DEPARTMENT_NAME,
               A.MANAGER_ID = B.MANAGER_ID,
               A.LOCATION_ID = B.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES (B.DEPARTMENT_ID,
                   B.DEPARTMENT_NAME,
                   B.MANAGER_ID,
                   B.LOCATION_ID);

SELECT * FROM DEPTS ORDER BY DEPARTMENT_ID;

--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
SELECT * FROM JOBS;
CREATE TABLE JOBS_IT2 AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);
SELECT * FROM JOBS_IT2;
--2. jobs_it ���̺� ���� �����͸� �߰��ϼ���
INSERT INTO JOBS_IT2 VALUES ('IT_DEV','����Ƽ������',6000,20000);
INSERT INTO JOBS_IT2 VALUES ('NET_DEV','��Ʈ��ũ������',5000,20000);
INSERT INTO JOBS_IT2 VALUES ('SEC_DEV','���Ȱ�����',6000,19000);

--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���
MERGE INTO JOBS_IT2 A
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) B
ON (A.JOB_ID = B.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET A.MIN_SALARY = B.MIN_SALARY,
               A.MAX_SALARY = B.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES (B.JOB_ID,
                   B.JOB_TITLE,
                   B.MIN_SALARY,
                   B.MAX_SALARY);
                   
SELECT * FROM JOBS_IT2;

COMMIT; -- ������ Ŀ�� ������