-- insert��
-- ���̺� ���� Ȯ��
desc departments;
desc employees;

-- 1ST
insert into departments(department_id, department_name, manager_id, location_id) values (290, '����', 200, 1700);
insert into departments(department_id, department_name, location_id) values (300, '������', 1700);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (310, 'DBA');
INSERT INTO DEPARTMENTS(DEPARTMENT_NAME, DEPARTMENT_ID) VALUES ('��������', 320);

-- 2ND, VALUES �ڿ� �÷� ������� ���� �����ش�
INSERT INTO DEPARTMENTS VALUES(330, '�ۺ���', 200, 1700);
INSERT INTO DEPARTMENTS VALUES(340, '�����ͺм�', 200, 1800);

select * from departments order by department_id desc;

-- DML ������ Ʈ������� ���� DML �������� �ǵ��� �� �ִ�
ROLLBACK;

-- ���̺� ���� ����
CREATE TABLE MANAGERS AS (SELECT * FROM employees WHERE 1=2);

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 SELECT * FROM MANAGERS;
DESC MANAGERS;

-- 3ND - �ٸ� ���̺��� Ư�� ��, ���������� INSERT
INSERT INTO MANAGERS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
INSERT INTO MANAGERS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) 
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_dATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'FI_ACCOUNT');

-- UPDATE
DESC employees;

-- �纻 ���̺� ����
CREATE TABLE EMPS AS (SELECT *
                      FROM employees
                      WHERE 1 = 1);
                      
SELECT * FROM EMPS;

UPDATE EMPS 
SET SALARY = 30000; -- ���� �� �ٲ�

ROLLBACK;

-- UPDATE������ �������� �ݵ�� ����ؾ� �Ѵ�
SELECT *
FROM EMPS
WHERE EMPLOYEE_ID = 100;

UPDATE EMPS 
SET SALARY = SALARY * 1.1
WHERE EMPLOYEE_ID = 100;

-- �� ���� ���� �÷��� �ٲٷ��� ��ǥ�� ����ض�
UPDATE EMPS
SET PHONE_NUMBER = '511.123.1111', 
    HIRE_DATE = SYSDATE, 
    COMMISSION_PCT = 0.1
WHERE EMPLOYEE_ID = 100;

-- JOB_ID�� IT_PROG�� ����� Ŀ�̼��� 0.1�� ������Ʈ
SELECT * FROM EMPS WHERE JOB_ID = 'IT_PROG';

UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID = 'IT_PROG';

UPDATE EMPS
SET COMMISSION_PCT = 0.2
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPS
                       WHERE FIRST_NAME = 'Donald');

SELECT * FROM EMPS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                          FROM EMPS
                                          WHERE FIRST_NAME = 'Donald');
                                          
-- SET ���� ��������
-- UPDEATE EMPS SET (�÷����) = (��������), WHERE ����
SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
FROM EMPS
WHERE EMPLOYEE_ID IN (102, 103);

UPDATE EMPS
SET (JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) = 
    (SELECT JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
     FROM EMPS
     WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 102;

ROLLBACK;

-- DELETE
SELECT *  FROM DEPARTMENTS;

-- EMPLOYEE ���̺��� 50�� �μ��� �����ϰ� �ֱ� ������ ���� �߻�, ���� �̻�, ���� ���Ἲ ���� ���� ����
DELETE FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 50;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

-- EMPS
-- DELETE�� �����ϱ� �� SELECT������ �ݵ�� Ȯ��! ��
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 105;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 105;

-- WHERE ���� ��������
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping';
DELETE FROM EMPS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping');

DELETE FROM EMPS WHERE EMPLOYEE_ID = 1000;

ROLLBACK;