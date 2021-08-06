-- 210407
-- ����
SELECT * FROM EMPLOYEES;

-- Ű ���谡 �ֱ� ������ ( ���� ���Ἲ ���� ) ���� ���� �ʴ´�
DELETE FROM EMPLOYEES
WHERE EMPLOYEE_ID = 100;

-- MERGE
-- �纻 ���̺� ����
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1 = 2);
DESC EMPS_IT;

-- INSERT DATE
INSERT INTO EMPS_IT(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_dATE, JOB_ID)
VALUES (103, 'Gildong', 'KKK', SYSDATE, 'IT_PROG');

SELECT * FROM EMPS_IT;

--MERGE INTO /*Ÿ�� ���̺� ����� */
--USING (/*���ս�ų ���̺��� ������*/)
--ON (/*�� ���̺��� ���� ����*/)
--WHEN MATCH THEN (/*��ġ�� ��� ������ �۾�*/)
--WHEN NOT MATCH THEN (/*��ġ���� ���� ��� ������ �۾�*/)

MERGE INTO EMPS_IT a
USING (SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, MANAGER_ID, DEPARTMENT_ID, JOB_ID, HIRE_DATE
       FROM EMPLOYEES
       WHERE JOB_ID = 'IT_PROG') b
ON (a.EMPLOYEE_ID = b.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        a.FIRST_NAME = b.FIRST_NAME,
        a.LAST_NAME = b.LAST_NAME,
        a.EMAIL = b.EMAIL,
        a.PHONE_NUMBER = b.PHONE_NUMBER,
        a.MANAGER_ID = b.MANAGER_ID,
        a.DEPARTMENT_ID = b.DEPARTMENT_ID,
        a.JOB_ID = b.JOB_ID,
        a.HIRE_DATE = b.HIRE_DATE
WHEN NOT MATCHED THEN
    INSERT (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, MANAGER_ID, DEPARTMENT_ID, JOB_ID, HIRE_DATE)
    VALUES 
        (b.EMPLOYEE_ID,
         b.FIRST_NAME,
         b.LAST_NAME,
         b.EMAIL,
         b.PHONE_NUMBER,
         b.MANAGER_ID,
         b.DEPARTMENT_ID,
         b.JOB_ID,
         b.HIRE_DATE);
         
-- �ǽ�
INSERT INTO EMPS_IT (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (102, 'ȫ', '�浿', 'HONG', '01/04/06', 'AD_VP');

INSERT INTO EMPS_IT (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (101, '��', '�ϳ�', 'KIM', '20/03/04', 'AD_VP');

SELECT * FROM EMPS_IT;

-- EMPLOYEES ���̺��� �Ź� �����Ǵ� ���̺��̶�� �����ϰ� �ָ��� EMPS_IT�� ������Ʈ ��Ų��
-- ������ �����ʹ� EMAIL, PHONE_NUMBER, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID�� ������Ʈ�ǵ��� ó��
-- ���� ���Ե� �����ʹ� ��� �÷��� �״�� �߰�
MERGE INTO EMPS_IT A
USING (SELECT * FROM EMPLOYEES) B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.SALARY = B.SALARY,
        A.COMMISSION_PCT = B.COMMISSION_PCT,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHEN NOT MATCHED THEN
    INSERT VALUES (B.EMPLOYEE_ID,
                   B.FIRST_NAME,
                   B.LAST_NAME,
                   B.EMAIL,
                   B.PHONE_NUMBER,
                   B.HIRE_DATE,
                   B.JOB_ID,
                   B.SALARY,
                   B.COMMISSION_PCT,
                   B.MANAGER_ID,
                   B.DEPARTMENT_ID);

SELECT * FROM EMPS;

-- CTAS (�纻 ���̺�)
-- PK, FK�� �������� �ʴ´�. (NULL�� ���θ� ����)
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS /* WHERE 1=2 */);

SELECT * FROM DEPTS;