-- 03_�Լ� ����

-- ���� �Լ�
-- ���� ���̺�
select 'hello world', 'happy' from dual;
select lower('hello WORLD'), upper('hello WORLD'), initcap('hello WORLD') from dual;

select first_name, lower(first_name), upper(first_name), initcap(first_name) from employees;
select last_name, lower(last_name), initcap(last_name), upper(last_name) from employees;

-- �Լ��� ���������� �� �� �ִ�.
-- ��ҹ��� ������ ��Ȯ���� ���� ��� where ���������� �����ϰ� ���� �� �ִ�
select *
from employees
where lower(last_name) = 'austin';

-- length : ���ڿ��� ���� ��ȯ
-- instr : ������ ��ġ ��ȯ, ������ 0 ��ȯ
select first_name, length(first_name), instr(first_name, 'a')
from employees;

-- substr : �־��� ���ڿ����� �־��� ���� ��ġ�������� ������ ������ŭ �κ� ���ڿ� ��ȯ
-- concat : �� ���ڿ� ����
select first_name, substr(first_name,1,3), concat(first_name, last_name)
from employees;

select concat(concat('hello',' '),'world') from dual; -- ��ø�� �����ϴ�
select 'hello ' || 'world' from dual; -- ||�ε� ���ڸ� ������ �� �ִ�

-- lpad�� ����, rpad�� �����ʿ� ���� �ڸ� ���� �־��� ���ڷ� ä���
SELECT RPAD(FIRST_NAME, 10, '-') AS NAME, LPAD(SALARY, 10, '*') AS SAL
FROM employees;

-- LTRIM �Լ��� ���ǵ� ���ڿ����� ������ �ܾ �߰��ϸ� ����, �������� RTRIM
-- ������ ���ڸ� �������� ������ ���� ����
SELECT LTRIM('JavaSpecialist', 'Java') FROM DUAL;
SELECT LTRIM('  JavaSpecialist') FROM DUAL;
SELECT RTRIM('JavaSpecialist  ') FROM DUAL;
SELECT TRIM('  JavaSpecialist   ') FROM DUAL;

-- REPLACE �Լ��� ���ǵ� ���ڿ����� ������ ���ڿ��� ���ο� ���ڿ��� ��ü, ���� ���ŵ� ����
-- TRANSLATE �Լ��� ���ڿ��� 1��1�� ���� �� ��ȣȭ ������ ��
SELECT REPLACE('JavaSpecialist', 'Java','Bigdata') FROM DUAL;
SELECT REPLACE('Java Specialist', ' ', '') FROM DUAL;
SELECT TRANSLATE('javaspecialist', 'abcdefghijklmnopqrstuvwxyz','defghijklmnopqrstuvwxyzabc') from dual;
-- ��ø ����
SELECT REPLACE(REPLACE('My dream is president', 'president', 'programmer'), ' ', '') as test from dual;

-- ���ڿ� ���� ���� ����
--���� 1. EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS �̸�, REPLACE(HIRE_DATE, '/', '') AS �Ի���¥
FROM EMPLOYEES
ORDER BY �̸� ASC;

--���� 2. EMPLOYEES ���̺� ���� phone_numbe�÷��� ###.###.####���·� ����Ǿ� �ִ�
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
SELECT CONCAT('(02)',SUBSTR(PHONE_NUMBER,4,LENGTH(PHONE_NUMBER)))
FROM EMPLOYEES;

--���� 3. EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
select rpad(substr(first_name,1,3),length(first_name),'*') as name, lpad(salary,10, '*') as salary
from employees
where lower(job_id) = 'it_prog';

-- ���� �Լ�
-- ROUND
SELECT 45.923, ROUND(45.925, 2), ROUND(45.923), ROUND(45.923, -1) FROM DUAL;

-- TRUNC
SELECT 45.923, TRUNC(45.923, 2), TRUNC(45.923,0), TRUNC(45.923, -1) FROM DUAL;

-- ABS
SELECT ABS(-34) FROM DUAL;

-- CEIL(�ø�), FLOOR(����)
SELECT CEIL(3.14), FLOOR(3.14) FROM DUAL;

-- MOD(������)
SELECT 10/4, MOD(10,4) FROM DUAL;


-- ��¥�Լ�
SELECT SYSDATE FROM DUAL; -- ���� ��¥ ���
SELECT SYSTIMESTAMP FROM DUAL; -- �ú��ʱ��� ���

-- ��¥�� ������ �����ϴ� > ���ϱ� ���⸸ ����
SELECT SYSDATE+2 FROM DUAL;
SELECT SYSDATE-7 FROM DUAL;

SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME),
       TRUNC(SYSDATE - HIRE_DATE) AS �ٹ��ϼ�,
       TRUNC((SYSDATE - HIRE_DATE)/7) AS �ٹ��ּ�,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS �ټӿ���
FROM EMPLOYEES
ORDER BY �ټӿ��� DESC;

-- ��¥���� ROUND, TRUNC ��� ����
SELECT ROUND(SYSDATE) FROM DUAL; -- 12�ð� ������ ����
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL; -- �⵵�� �������� �ݿø�
SELECT ROUND(SYSDATE, 'MONTH') FROM DUAL; -- �� ���� �ݿø�
SELECT ROUND(SYSDATE, 'DAY') FROM DUAL; -- ��(1) ~ ��(7), �������� �������� �ݿø�

SELECT TRUNC(SYSDATE) FROM DUAL;
SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- �⵵ �������� ����
SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL;
SELECT TRUNC(SYSDATE, 'DAY') FROM DUAL; -- �� ���� ����, ���� �Ͽ��� ��¥�� ����


-- ����ȯ �Լ�
-- ��¥�� ���ڷ� : TO_CHAR(��¥, ��¥����)
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') FROM DUAL; -- JAVA�� ���������� �ݴ�

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES;
-- YYYY-MM-DD���� ��ȯ
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') FROM EMPLOYEES;
-- YY-MM-DD HH24:MI:SS�� ��ȯ
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD HH24:MI:SS') FROM EMPLOYEES;

-- ���ڸ� ���ڷ� : TO_CHAR(����, ��������)
SELECT TO_CHAR(20000, '99999') FROM DUAL;
SELECT TO_CHAR(20000, '9999') FROM DUAL; -- �ڸ� ���� �����ϸ� ����
SELECT TO_CHAR(20000.14, '99999') FROM DUAL; -- ����
SELECT TO_CHAR(20000.14, '99999.99') FROM DUAL;
SELECT TO_CHAR(20000, '99,999') FROM DUAL;
SELECT TO_CHAR(20000, '$99999') FROM DUAL;
SELECT TO_CHAR(20000, 'L99,999') FROM DUAL; -- L�� �ش� ������ ��ȭ ��ȣ

SELECT FIRST_NAME, TO_CHAR(SALARY, 'L9,999,999.99') AS SALARY FROM EMPLOYEES;

SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'MM/YY') AS MONTH_HIRED
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) = 'STEVEN';

-- ���ڸ� ���ڷ� : TO_NUMBER(����, ��������)
-- ����ǥ���Ŀ��� �������� �ʴ� ������ ��ȯ�� �� ���� EX) �޸��� �����ð� �ִ� ���
SELECT '2000' + 2000 FROM DUAL; -- �ڵ�����ȯ
SELECT TO_NUMBER('2000') +2000 FROM DUAL;

SELECT TO_NUMBER('$5,500', '$999,999') - 4000 FROM DUAL;

-- ���ڸ� ��¥�� : TO_DATE(����, '��¥����')
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = TO_DATE('2003/06/17', 'YYYY/MM/DD');

SELECT TO_DATE('2001-03-31') FROM DUAL; -- ��¥ ������ ���ڶ�� ������ ���� �ʾƵ� �ȴ�
SELECT SYSDATE - TO_DATE('2020-03-01') FROM DUAL;
SELECT TO_DATE('2021/03/25', 'YYYY/MM/DD') FROM DUAL;

-- '20201111', '20201130' ��¥ ����
SELECT TO_DATE('20201130') - TO_DATE('20201111') FROM DUAL;
-- 20051002�� xxxx��xx��xx�Ϸ� ���
SELECT TO_CHAR(TO_DATE('20051002'), 'YYYY"��" MM"��" DD"��"') FROM DUAL;


-- NVL
SELECT NVL(200, 0), NVL(NULL, 0) FROM DUAL;
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) FROM EMPLOYEES;

-- NVL2
SELECT NVL2(NULL, 'NULL�ƴ�', 'NULL') FROM DUAL;
SELECT FIRST_NAME,
       NVL2(COMMISSION_PCT, SALARY*(1+COMMISSION_PCT), SALARY) AS SALARY
FROM EMPLOYEES;

-- DECODE
SELECT DECODE ('F', 'A', 'A�Դϴ�',
                    'B', 'B�Դϴ�',
                    'C', 'C�Դϴ�',
                    '���� �ƴմϴ�') AS DECODE
FROM DUAL;

SELECT JOB_ID, SALARY,
       DECODE(JOB_ID, 'IT_PROG', SALARY*1.1,
                      'FI_MGR', SALARY*1.15,
                      'FI_ACCOUNT', SALARY*1.2,
                      SALARY) AS REVISED_SALARY
FROM EMPLOYEES;

-- CASE �÷� WHEN �� THEN ��� END
SELECT FIRST_NAME, JOB_ID, SALARY,
       (CASE JOB_ID WHEN 'IT_PROG' THEN SALARY*1.3
                    WHEN 'AD_VP' THEN SALARY*1.2
                    ELSE SALARY*1.1
        END) AS REVISED_SALARY
FROM EMPLOYEES;

SELECT FIRST_NAME, JOB_ID, SALARY,
       (CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY*1.3
             WHEN JOB_ID = 'AD_VP' THEN SALARY*1.2
             ELSE SALARY*1.1
        END) AS REVISED_SALARY
FROM EMPLOYEES;

-- ��������
--���� 1. �������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� 
--�ټӳ���� 10�� �̻��� ����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME || ' ' || LAST_NAME AS �����,
       HIRE_DATE AS �Ի�����,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS �ټӿ���
FROM EMPLOYEES
WHERE (SYSDATE - HIRE_DATE)/365 >= 10;

--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �������, 
--120�̶�� �����ӡ�
--121�̶�� ���븮��
--122��� �����塯
--�������� ���ӿ��� ���� ����մϴ�.
--���� 1) manager_id�� 50�� ������� ������θ� ��ȸ�մϴ�
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, 
       MANAGER_ID,
       CASE MANAGER_ID WHEN 100 THEN '���'
                       WHEN 120 THEN '����'
                       WHEN 121 THEN '�븮'
                       WHEN 122 THEN '����'
                       ELSE '�ӿ�'
       END AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT TO_CHAR(LAST_DAY(TO_DATE('01', 'MM')), 'DD') AS "1" FROM DUAL;