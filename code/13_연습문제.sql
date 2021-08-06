-- �������� (210405 - 210406)

--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
---EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
select *
from employees
where salary > (select avg(salary) from employees)
order by salary;

select count(*)
from employees
where salary > (select avg(salary) from employees)
order by salary;

select *
from employees
where salary > (select avg(salary)
                from employees
                where job_id = 'IT_PROG')
order by salary;

-- ���� 2.
-- DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
-- EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
select *
from employees e left outer join departments d on e.department_id = d.department_id
where e.manager_id = 100;
      
select *
from employees
where department_id = (select department_id
                       from departments
                       where manager_id = 100);

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
-- ��������
select manager_id
from employees
where first_name = 'Pat';

select *
from employees
where manager_id > (select manager_id
                    from employees
                    where first_name = 'Pat');

---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
select manager_id
from employees
where first_name = 'James';

-- ����� 2���̹Ƿ� ������ ������ ���
select *
from employees
where manager_id in (select manager_id
                     from employees
                     where first_name = 'James');

--���� 4.
-- EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
-- pk�� �̿��� ��Ʈ������ �����Ѵ�
select *
from (select rownum as rnum, a.first_name -- rownum�� �÷����� ���� ��
      from (select *
            from employees e
            order by first_name desc) a)
where rnum between 41 and 50;

--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
select *
from (select rownum as rnum, employee_id, first_name, phone_number, hire_date
      from (select *
            from employees 
            order by hire_date)) -- ��¥�� ���ڷ� �ȹٲ㵵 ������ ��
where rnum between 31 and 40;

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
select e.employee_id, concat(e.first_name||' ', last_name) as �̸�, d.department_id,d.department_name
from employees e left outer join departments d on e.department_id = d.department_id
order by e.employee_id;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
select e.employee_id,
       concat(e.first_name||' ', e.last_name) as �̸�,
       e.department_id,
       (select d.department_name -- �ٸ� ���̺��� �� �÷��� ������ �� ��Į�� ������ �����ϴ�
        from departments d
        where e.department_id = d.department_id) as department_name
from employees e
order by e.employee_id;

--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
select d.department_id, d.department_name, d.manager_id, d.location_id, l.street_address, l.postal_code, l.city
from departments d left outer join locations l on d.location_id = l.location_id
order by d.department_id;

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
select d.department_id, d.department_name, d.manager_id, d.location_id,
       (select l.street_address
        from locations l
        where d.location_id = l.location_id) as address,
       (select l.postal_code
        from locations l
        where d.location_id = l.location_id) as post_code,
       (select l.city
        from locations l
        where d.location_id = l.location_id) as city
from departments d
order by d.department_id;

--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
select * from countries;
select * from locations;

select l.location_id, l.street_address, l.city, c.country_id, c.country_name
from locations l left outer join countries c on l.country_id = c.country_id
order by country_name;

--���� 11. �ٽ� Ǯ��
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
select (select l.location_id
        from locations l
        where l.country_id = c.country_id)
from countries c
order by country_name;

select l.location_id, l.street_address, l.city, c.country_id, c.country_name
from locations l, countries c
where l.country_id = c.country_id;

-- join �������� ���̺� ��� ���������� �� �� �ִ�
-- ����
select *
from employees e
left outer join (select *
                 from departments) d
on e.department_id = d.department_id;

--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
select *
from (select rownum as rn, 
             employee_id,
             concat(first_name || ' ', last_name) as �̸�,
             hire_date,
             job_id,
             department_name
      from (select *
            from employees e left outer join departments d on e.department_id = d.department_id
            order by hire_date))
where rn <11;

-- ���� 13. 
-- EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
-- DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���
select * from employees;
select * from departments;

--��������
select *
from employees
where job_id = 'SA_MAN';

-- �� ���
select a.*,
       (select d.department_name
        from departments d
        where a.department_id = d.department_id) as department_name
from (select last_name, job_id, department_id
      from employees 
      where job_id = 'SA_MAN') a;
      
-- �� ���
select e.last_name, e.job_id, e.department_id, d.department_name
from (select *
      from employees 
      where job_id = 'SA_MAN') e
left outer join departments d on e.department_id = d.department_id;

--���� 14
----DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
----�ο��� ���� �������� �����ϼ���.
----����� ���� �μ��� ������� �ʽ��ϴ�
select * from departments;
select * from employees;

--��������
select count(*)
from employees
group by department_id;

-- �� ���
select *
from(select d.department_id, 
            d.department_name,
            d.manager_id,
            (select count(*)
             from employees e
             where e.department_id = d.department_id
             group by e.department_id) as ������
     from departments d)
where ������ is not null
order by ������ desc;

-- �� ��� 1
select department_id,
       department_name,
       manager_id,
       ������
from (select department_id,
             department_name,
             manager_id,
            (select count(*)
             from employees e
             where e.department_id = d.department_id
             group by department_id) as ������
      from departments d)
where ������ is not null
order by ������ desc;

-- �� ��� 2 - ���� ���̺��� �׷������ department_id�� ����
select d.department_id, department_name, manager_id, total
from departments d left outer join (select department_id,
                                    count(*) as total
                                    from employees
                                    group by department_id) e
on d.department_id = e.department_id
where total is not null
order by total desc;

--���� 15
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���
select * from departments;
select * from locations; --�ּ�(street_address), �����ȣ(postal_code)
select * from employees; -- salary

--��������
select department_id
from employees
group by department_id;

-- �� �ڵ�
select d.department_id, l.street_address, l.postal_code,
       nvl(trunc((select avg(salary)
              from employees e
              where d.department_id = e.department_id)),0)as ��տ���
from departments d inner join locations l on d.location_id = l.location_id 
group by d.department_id, l.street_address, l.postal_code;

--1st
select a.*,
       nvl((select avg(salary)
        from employees
        where department_id = a.department_id
        group by department_id), 0) as avg
from (select d.*,
             l.street_address,
             l.postal_code
      from departments d
      left outer join locations l
      on d.location_id = l.location_id) a;

--2nd
select d.*,
       l.street_address,
       l.postal_code,
       nvl(trunc(a.avg_sal), 0) as result
from departments d
left outer join locations l
on d.location_id = l.location_id
left outer join (select department_id,
                 avg(salary) as avg_sal
                 from employees
                 group by department_id )a
on d.department_id = a.department_id;
---���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

select rownum, a.*
from (select d.department_id, l.street_address, l.postal_code,
       nvl(trunc((select avg(salary)
              from employees e
              where d.department_id = e.department_id)),0)as ��տ���
      from departments d inner join locations l on d.location_id = l.location_id 
      group by d.department_id, l.street_address, l.postal_code
      order by d.department_id) a
where rownum < 11;

select *
from (select rownum as rn,
             department_id,
             department_name,
             manager_id,
             location_id,
             street_address,
             postal_code,
             result
      from (select d.*,
                   l.street_address,
                   l.postal_code,
                   nvl(trunc(a.avg_sal), 0) as result
            from departments d
            left outer join locations l
            on d.location_id = l.location_id
            left outer join (select department_id,
                                    avg(salary) as avg_sal
                             from employees
                             group by department_id )a
            on d.department_id = a.department_id))
where rn > 0 and rn < 10;
