-- �� ��ȯ �Լ� TO_CHAR, TO_DATE, TO_NUMBER

-- TO_CHAR(��¥, ��¥����) : ��¥�� ���ڷ�
select to_char(sysdate) from dual;
select to_char(sysdate, 'YY-MM-DD') from dual; -- -/: ������������ ��밡��
select to_char(sysdate, 'YY-MM-DD HH:MI:SS') from dual;
select to_char(sysdate, 'YYYY"��" MM"��" DD"��"' ) from dual; -- ���������� �ƴ� ���ڴ� ""�� ���´�

select first_name, hire_date from employees;
select first_name, to_char(hire_date, 'YYYY-MM-DD') from employees;
select first_name, to_char(hire_date, 'YY-MM-DD HH24:MI:SS') from employees;
select first_name, to_char(hire_date, 'YYYY"��" MM"��" DD"��"') from employees; -- ���������� �ƴ� ���ڴ� ""�� ���´�

-- TO_CHAR(����, ��������) : ���ڸ� ���ڷ�
select to_char(20000, '99999') from dual; -- ���ڶ� ��������, 9�� �ڸ���
select to_char(20000, '9999') from dual; -- �ڸ����� �����ϸ� ǥ���� �ȵȴ�
select to_char(20000.14, '99999') from dual;
select to_char(20000.14, '99999.99') from dual; -- .�� �Ҽ��� �ڸ��� �ǹ�
select to_char(20000, '99,999') from dual; -- 20,000, �޸��� ������ ���´�
select to_char(20000, '$99999') from dual;
select to_char(20000, 'L99,999') from dual; -- L�� �� ������ ��ȭ ��ȣ

select first_name, to_char(salary, 'L9999,999.99') as salary from employees;

-- TO_NUMBER(����, ��������) : ���ڸ� ���ڷ� (����ǥ���Ŀ��� �������� �ʴ� ������ �ٲ� �� ����)
select '2000' + 2000 from dual; -- �ڵ� ����ȯ
select to_number('2000') + 2000 from dual;

select '$3,300' + 2000 from dual; -- ����
select to_number('$3,300', '$9,999') + 2000 from dual; -- ���� ���������� ����ؼ� ����� ����ȯ

-- to_date : ���ڿ� ��¥ǥ�������� ����

select to_date('2021-03-31') from dual; -- ��¥ ������ ���ڶ�� fmt�� ���� �ʾƵ� �ȴ�
select sysdate - to_date('2020-03-31') from dual; -- ���� ��¥�� ���� �� �ִ�

select to_date('2021/03/25', 'YYYY/MM/DD') from dual;
select to_date('2021-03-25 14:51:24', 'YYYY-MM-DD HH24:MI:SS') from dual;

-- '20201111', '20201130' ��¥ ����
select abs(to_date('20201111') - to_date('20201130')) as ��¥���� from dual;

-- xxxx��xx��xx�Ϸ� ���
select to_char(to_date('20051002'), 'YYYY"��" MM"��" DD"��"') as ��¥ from dual;

-- NVL(�÷�, NULL�� ��� ��ȯ�� ��) - �ڡڡڡڡ�
select nvl(200, 0), nvl(null, 0) from dual;
select first_name, nvl(commission_pct, 0) as commission_pct from employees;

-- NVL2(�÷�, NULL�� �ƴ� ��� ��ȯ�� ��, NULL�� ��� ��ȯ�� ��) - �ڡڡڡڡ�
select nvl2(null, 'null�ƴ�', 'null��') from dual;
select first_name, salary, commission_pct, nvl2(commission_pct, salary + salary*commission_pct, salary) as realSalary from employees;

-- DECODE(�÷�, ��, ���, ��, ���, ... , DEFAULT) - �ڡڡڡڡ�
select decode('C', 'A', 'A�Դϴ�', 'B', 'B�Դϴ�', 'C', 'C�Դϴ�', '���� �ƴմϴ�') from dual;
select first_name, salary, decode(job_id, 'IT_PROG', salary*1.1, 'AD_VP', salary*1.2, salary*1.1) as salary from employees;

-- CASE �÷� WHEN �� THEN ��� END
select first_name, 
       salary, 
       job_id,
       (case job_id when 'IT_PROG' then salary*1.5
                    when 'AD_VP' then salary*1.2
                    else salary*1.1
       end)  as salary
from employees;

-- 210401

-- ���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
--���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�

select employee_id as �����ȣ,
       concat(first_name, last_name) as �����,
       hire_date as �Ի�����,
       trunc((sysdate-hire_date)/365) as �ټӿ��� 
from employees
where trunc((sysdate-hire_date)/365) >= 10
order by �ټӿ��� desc;

--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �������, 
--120�̶�� �����ӡ�
--121�̶�� ���븮��
--122��� �����塯
--�������� ���ӿ��� ���� ����մϴ�.
--���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�

select first_name, manager_id,
       (case manager_id when 100 then '���'
                        when 120 then '����'
                        when 121 then '�븮'
                        when 122 then '����'
                        else '�ӿ�'
       end)as ����
from employees
where department_id = 50;
