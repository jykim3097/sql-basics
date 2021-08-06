-- 210330
-- SQL ���� ��ҹ��ڸ� ������ �ʴ´�. (ORACLE������)
-- �빮�ڸ� ���� ����
-- ���� �������� �׻� ;�� �����Ѵ�
-- ���� ����� CTRL + ENTER

SELECT * FROM EMPLOYEES;

select employee_id, first_name, last_name from employees;

-- null�� Ȯ��
select employee_id, salary, commission_pct from employees;

-- ���� Į���� ������ ����
select employee_id, salary, salary+salary*0.1 from employees;

-- ����� (�÷����� ��Ī)
select employee_id as ������̵�, first_name as �̸�, last_name as ��, salary+salary*0.1 as �޿� from employees;

-- �÷� ����
select first_name || last_name from employees;
select first_name || ' ' || last_name from employees;
select first_name || ' ' || last_name || 's salary is $' || salary as �޿����� from employees;

-- �� �ߺ� ���� distinct
select distinct department_id from employees;
select distinct salary from employees;

-- ��� ����(ROWNUM), ��������ġ(ROWID)
select rownum, rowid, employee_id, first_name from employees;
select rownum, first_name from employees;

-- ���̺� ���� ����
desc employees;

