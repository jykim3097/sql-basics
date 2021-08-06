-- 데이터 행 제한 WHERE절

select * from employees;

select first_name, last_name, job_id from employees where job_id = 'IT_PROG';

select * from employees where first_name = 'Valli';
select * from employees where salary >= 15000;
select * from employees where department_id = 60;
select * from employees where hire_date >= '08/01/01'; -- 날짜 형식(년/월/일) 대소비교가 가능
select * from employees where hire_date = '08/01/24';

-- where 연산자 (between, in, like)
select * from employees where salary between 10000 and 20000;
select * from employees where hire_date between '05/01/01' and '05/12/31';

-- in 연산자 > 유용하다!
select * from employees where manager_id in (101, 102, 103);
select * from employees where job_id in ('AD_ASST', 'FI_MGR', 'IT_PROG');

-- like 연산자
select * from employees where first_name like 'A%'; -- A로 시작하는
select * from employees where hire_date like '05%'; -- 05로 시작하는
select * from employees where hire_date like '%15'; -- 15로 끝나는
select * from employees where hire_date like '%07%'; -- 07이 포함되어 있으면
select * from employees where hire_date like '___07%'; -- _는 위치

-- is null (null 값 확인)
-- select * from employees where commission_pct <> null;
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

-- and, or 조건 (and가 or보다 빠름)
select * from employees where job_id = 'IT_PROG' and salary >= 6000;
select * from employees where salary >= 10000 and salary <= 20000;
select * from employees where job_id = 'AD_VP' or salary >= 15000;
select * from employees where job_id = 'IT_PROG' or job_id = 'AD_VP';
select * from employees where (job_id = 'IT_PROG' or job_id = 'AD_VP') and salary >= 6000;

-- 데이터 정렬 order by문
select * from employees order by first_name asc;
select * from employees order by hire_date asc;
select * from employees order by hire_date desc;
select * from employees where job_id in ('IT_PROG','AD_VP') order by salary desc;

-- 급여가 5000이상인 사람들 중에서 직원아이디 기준으로 내림차순 정렬
select * from employees where salary >= 5000 order by desc;

-- 커미션이 null이 아닌 사람들 중에서 직원아이디 기준으로 오름차순 정렬
select * from employees where commission_pct is not null order by employee_id asc;

-- job_id 기준 오름차순, 급여기준 내림차순 (여러 기준으로 정렬하려면 쉼표 사용)
select * from employees order by job_id asc, salary desc;

-- order by문에서 엘리어스를 이용해 정렬이 가능하다
select first_name||' '||last_name as 이름, salary, salary*12 as 연봉 from employees order by 연봉 desc;
