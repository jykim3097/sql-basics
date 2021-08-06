-- 집합연산자 (위, 아래 column 개수가 정확히 일치해야 함)
-- union(합집합 중복x), union all(합집합 중복o), intersect(교집합), minus(차집합)

select employee_id, first_name, hire_date from employees where hire_date like '04%'
union 
select employee_id, first_name, hire_date from employees where department_id = 20; -- michael

select employee_id, first_name, department_id from employees where hire_date like '04%'
union all
select employee_id, first_name, department_id from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
intersect
select employee_id, first_name from employees where department_id = 20;

select employee_id, first_name from employees where hire_date like '04%'
minus
select employee_id, first_name from employees where department_id = 20;

-- union이나 union all은 듀얼테이블(가상테이블)로 만들어서 사용하는 경우가 많다
select employee_id, first_name, salary from employees where department_id = 100
union
select employee_id, first_name, salary from employees where salary > 10000
union all
select 300, 'hong', 10000 from dual
union all
select 400, 'kim', 20000 from dual;