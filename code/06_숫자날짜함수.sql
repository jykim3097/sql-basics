S-- ���� �Լ�
-- round (�ݿø�)
select 45.923 from dual;
select round(45.923, 2), round(45.923), round(45.923, -1) from dual;

-- trunc (����)
select trunc(45.923,2), trunc(45.923, 0), trunc(45.923, -1) from dual;

-- abs(���밪)
select abs(-34) from dual;

-- ceil(�ø�), floor(����)
select ceil(3.14), floor(3.14) from dual; -- ���� �ø�

-- mod (������)
select 10/4, mod(10,4) from dual;

-- ��¥ �Լ� * ������ �ܿ�
select sysdate from dual; -- ���ڱ��� (�Ϲ������� �� ���� ����Ѵ�)
select systimestamp from dual; -- �ú��ʱ���

-- ��¥�� ������ �����ϴ�
select sysdate + 2 from dual; -- ���� ��¥ + 2��
select sysdate - 7 from dual; -- ���� ��¥ + 3��

select (sysdate - hire_date) from employees; -- �ٹ��ϼ�
select (sysdate - hire_date)/7 from employees; -- �� �� �ٹ��ߴ°�?
select trunc((sysdate - hire_date)/365) as �ټӿ��� from employees; -- �ټӿ���

-- ��¥���� trunc, round ������ �����ϴ�
select round(sysdate) from dual; -- 12�ð� ������ �ø��� �� ��
select round(sysdate, 'year') from dual; -- �� �������� �ݿø�
select round(sysdate, 'month') from dual; -- �� �������� �ݿø�, �ش� ���� ���� �� �������� 1���� �ȴ�
select round(sysdate, 'day') from dual; -- �� �������� �ݿø�, ��(1) ~ ��(7), 4(������)�� �ݿø��̶� �����ַ� �Ѿ

select trunc(sysdate) from dual;
select trunc(sysdate, 'year') from dual; -- �� �������� ����
select trunc(sysdate, 'month') from dual; -- �� �������� ����
select trunc(sysdate, 'day') from dual; -- �� �������� ���� (���� �Ͽ��� ��¥�� ����)

