-- where���� ���� ��������
-- �������� ����
-- 1. () �ȿ� �ݵ�� �ۼ�
-- 2. ������ �������� ���� ����� �ݵ�� 1���̾�� �Ѵ�
-- 3. ���������� �����ʿ� ��ġ�Ѵ�
-- 4. ������������ ���� �ؼ��Ѵ�

-- ������ �޿����� ������ ���� �޴� ����� ��ȸ
select salary from employees where first_name = 'Nancy';

select *
from employees
where salary > (select salary
                from employees
                where first_name = 'Nancy');
                
-- ���� ���̵� 103���� ������ ���� job�� ���� ���
select *
from employees
where job_id = (select job_id
                from employees
                where employee_id = 103);
                
-- job_id�� 'IT_PROG'�� ����, ����! ���� ���� ���� �� ������ �����ڸ� ����� �� ����
select *
from employees
where job_id = (select job_id
                from employees
                where job_id = 'IT_PROG');
                

-- ������ ��������
-- in : ������ ������������ ���� �� �߿� �ϳ��� ��ġ�ϸ� ��ȯ
select salary from employees where first_name = 'David';

select *
from employees
where salary in (select salary from employees where first_name = 'David');

select *
from employees
where job_id in (select job_id
                from employees
                where job_id = 'IT_PROG');

-- any : �ּҰ����� ũ��, �ִ밪���� �۴�
select salary from employees where first_name = 'David';

select *
from employees
where salary > any (select salary from employees where first_name = 'David')
order by salary asc;

select *
from employees
where salary < any (select salary from employees where first_name = 'David')
order by salary desc;

-- all : �ּҰ����� �۴�, �ִ밪���� ũ��
select *
from employees
where salary < all (select salary from employees where first_name = 'David')
order by salary desc;

select *
from employees
where salary > all (select salary from employees where first_name = 'David')
order by salary asc;

-- 210405
-- ��Į�� ���� (select ���� ���������� ���� ����, left outer join�� ������ ���)
-- ��Į�� ���� ����� : where���� ������ ������ ���
select e.*, 
       (select department_name
        from departments d
        where d.department_id = e.department_id) as department_name,
       (select job_title
        from jobs j
        where e.job_id = j.job_id) as job_title
from employees e
order by first_name desc;

select e.*, d.department_name, j.job_title
from employees e left outer join departments d on d.department_id = e.department_id
                 left outer join jobs j on e.job_id = j.job_id
order by first_name desc;

-- left join (�μ����� �̸�)
select * from employees;
select * from departments;

select d.*, e.first_name
from departments d left outer join employees e on d.manager_id = e.employee_id
where d.manager_id is not null
order by d.manager_id;

-- ��Į�� ���� (�μ����� �̸�)
select d.*,
       (select e.first_name
        from employees e
        where e.employee_id = d.manager_id)
from departments d
where d.manager_id is not null
order by d.manager_id;

-- ��Į�� ���� (departments ���̺�� locations ���̺��� city, street_address ���� ��������)
-- �� ���̺��� �ΰ��� ���� �������� ������ ������ 2�� �����!
select * from locations;
select * from departments;

select d.*,
       (select l.city
        from locations l
        where d.location_id = l.location_id) as city,
       (select l.street_address
        from locations l
        where d.location_id = l.location_id) as street_address
from departments d;

select d.*, l.city, l.street_address
from departments d left outer join locations l on d.location_id = l.location_id
order by d.department_id;

-- ��Į�� ����(�� �μ��� �����)
-- 1. employees ���̺��� �� �μ��� ������� ���غ��� -> �̰� ���������� �ȴ�
-- 2. departments ���̺� ���δ�
select * from departments;
select * from employees;

select d.*,
       nvl((select count(*)
            from employees e
            where e.department_id = d.department_id
            group by e.department_id),0) as �μ���_�����
from departments d;

-- �ζ��� �� (from���� select���� ���� ����, ���� ���̺�)
select *
from employees;

select *
from (select *
      from employees);
      
-- rownum�� ���̴� ���� �߻�
select rownum, first_name, job_id, salary
from employees
order by salary;

-- �ζ��� ��� �ذ�
select first_name, job_id, salary -- ���ʿ� ���� ������ �����
from employees
order by salary;
-- ��
select rownum, first_name, job_id, salary
from (select first_name, job_id, salary -- ���ʿ� ���� ������ �����
      from employees
      order by salary);

-- �ζ��� ��� ���� ����� ���ؼ� 10������� ���
select rownum, a.*
from (select first_name, job_id, salary
      from employees
      order by salary) a
where rownum <= 10;

-- �ζ��� ��� ���� ����� ���ؼ� 10~20������� ���
-- �� ��� : ������ ���
select rownum, a.*
from (select first_name, job_id, salary
      from employees
      order by salary) a
where rownum between 1 and 20
minus
select rownum, a.*
from (select first_name, job_id, salary
      from employees
      order by salary) a
where rownum between 1 and 10;

-- �ζ��κ並 ����ϴ� ���
select rnum, b.*
from (select rownum as rnum, a.*
      from (select first_name, job_id, salary
            from employees
            order by salary) a
      ) b
where rnum between 11 and 20;

-- �ζ��� ��(�� �������̺� ����, 03�� 01�� �����͸� ����
select *
from( select name, to_date(test) as d
      from (select 'ȫ�浿' as name, '20200211' as test from dual 
            union all select '�̼���', '20190301' from dual 
            union all select '������', '20200314' from dual 
            union all select '������', '20200403' from dual 
            union all select 'ȫ����', '20200301' from dual))
where to_char(d, 'MM-DD') = '03-01';

-- ���� (join ���̺��� ��ġ�� �ζ��κ� ���� ���� or ��Į�� ������ ȥ���ؼ� ��� ����)
-- salary�� 10000 �̻��� ������ first_name, �μ���, �μ��� �ּ�, job_title�� ���
-- salary �������� ��������
select * from employees;
select * from departments;
select * from locations;
select * from jobs;

select first_name, department_name,
       (select job_title
        from jobs j
        where e.job_id = j.job_id) as job_title,
       (select street_address
        from locations l
        where d.location_id = l.location_id) as street_address
from employees e left outer join departments d on e.department_id = d.department_id
where e.salary >= 10000
order by salary desc;

-- 1st
select e.first_name,
       d.department_name,
       l.street_address,
       j.job_title
from employees e
left outer join departments d on e.department_id = d.department_id
left outer join locations l on d.location_id = l.location_id
left outer join jobs j on e.job_id = j.job_id
where salary >= 10000
order by salary desc;

--2nd
select a.first_name, a.department_name,
       (select street_address from locations l where l.location_id = a.location_id) as address,
       (select job_title from jobs j where j.job_id = a.job_id) as job_title
from (select *
      from employees e left outer join departments d on e.department_id = d.department_id
      where salary >= 10000
      order by salary desc) a;
      
-- ����
-- where ���� ���� ���������� ������ vs ������ (in, any, all)
-- ��Į������ : select���� ���� ��������(���� ���� ����� ��������, left outer join�� ���� ����)
-- �ζ��κ� : from ���� ���� ��������(���ʿ��� �ʿ��� �������� �ۼ�, �������̺�)