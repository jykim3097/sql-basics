-- where절에 들어가는 서브쿼리
-- 서브쿼리 사용법
-- 1. () 안에 반드시 작성
-- 2. 단일행 서브쿼리 질의 결과는 반드시 1행이어야 한다
-- 3. 조건절보다 오른쪽에 위치한다
-- 4. 서브쿼리절을 먼저 해석한다

-- 낸시의 급여보다 월급을 많이 받는 사람을 조회
select salary from employees where first_name = 'Nancy';

select *
from employees
where salary > (select salary
                from employees
                where first_name = 'Nancy');
                
-- 직원 아이디가 103번인 직원과 같은 job을 갖는 사람
select *
from employees
where job_id = (select job_id
                from employees
                where employee_id = 103);
                
-- job_id가 'IT_PROG'인 직원, 주의! 여러 행을 비교할 때 단일행 연산자를 사용할 수 없다
select *
from employees
where job_id = (select job_id
                from employees
                where job_id = 'IT_PROG');
                

-- 다중행 서브쿼리
-- in : 다중행 서브쿼리에서 여러 값 중에 하나라도 일치하면 반환
select salary from employees where first_name = 'David';

select *
from employees
where salary in (select salary from employees where first_name = 'David');

select *
from employees
where job_id in (select job_id
                from employees
                where job_id = 'IT_PROG');

-- any : 최소값보다 크다, 최대값보다 작다
select salary from employees where first_name = 'David';

select *
from employees
where salary > any (select salary from employees where first_name = 'David')
order by salary asc;

select *
from employees
where salary < any (select salary from employees where first_name = 'David')
order by salary desc;

-- all : 최소값보다 작다, 최대값보다 크다
select *
from employees
where salary < all (select salary from employees where first_name = 'David')
order by salary desc;

select *
from employees
where salary > all (select salary from employees where first_name = 'David')
order by salary asc;

-- 210405
-- 스칼라 쿼리 (select 절에 서브쿼리가 들어가는 구문, left outer join과 동일한 결과)
-- 스칼라 쿼리 사용방법 : where절에 조인의 조건을 기술
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

-- left join (부서장의 이름)
select * from employees;
select * from departments;

select d.*, e.first_name
from departments d left outer join employees e on d.manager_id = e.employee_id
where d.manager_id is not null
order by d.manager_id;

-- 스칼라 쿼리 (부서장의 이름)
select d.*,
       (select e.first_name
        from employees e
        where e.employee_id = d.manager_id)
from departments d
where d.manager_id is not null
order by d.manager_id;

-- 스칼라 쿼리 (departments 테이블과 locations 테이블의 city, street_address 정보 가져오기)
-- 한 테이블에서 두개의 열을 가져오고 싶으면 쿼리를 2개 만든다!
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

-- 스칼라 쿼리(각 부서별 사원수)
-- 1. employees 테이블에서 각 부서별 사원수를 구해본다 -> 이게 서브쿼리가 된다
-- 2. departments 테이블에 붙인다
select * from departments;
select * from employees;

select d.*,
       nvl((select count(*)
            from employees e
            where e.department_id = d.department_id
            group by e.department_id),0) as 부서별_사원수
from departments d;

-- 인라인 뷰 (from절에 select문이 들어가는 형태, 가상 테이블)
select *
from employees;

select *
from (select *
      from employees);
      
-- rownum이 섞이는 문제 발생
select rownum, first_name, job_id, salary
from employees
order by salary;

-- 인라인 뷰로 해결
select first_name, job_id, salary -- 안쪽에 넣을 구문을 만든다
from employees
order by salary;
-- ↓
select rownum, first_name, job_id, salary
from (select first_name, job_id, salary -- 안쪽에 넣을 구문을 만든다
      from employees
      order by salary);

-- 인라인 뷰로 나온 결과에 대해서 10행까지만 출력
select rownum, a.*
from (select first_name, job_id, salary
      from employees
      order by salary) a
where rownum <= 10;

-- 인라인 뷰로 나온 결과에 대해서 10~20행까지만 출력
-- 내 방법 : 차집합 사용
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

-- 인라인뷰를 사용하는 방법
select rnum, b.*
from (select rownum as rnum, a.*
      from (select first_name, job_id, salary
            from employees
            order by salary) a
      ) b
where rnum between 11 and 20;

-- 인라인 뷰(이 가상테이블 기준, 03월 01일 데이터만 추출
select *
from( select name, to_date(test) as d
      from (select '홍길동' as name, '20200211' as test from dual 
            union all select '이순신', '20190301' from dual 
            union all select '강감찬', '20200314' from dual 
            union all select '김유신', '20200403' from dual 
            union all select '홍길자', '20200301' from dual))
where to_char(d, 'MM-DD') = '03-01';

-- 응용 (join 테이블의 위치로 인라인뷰 삽입 가능 or 스칼라 쿼리와 혼합해서 사용 가능)
-- salary가 10000 이상인 직원의 first_name, 부서명, 부서의 주소, job_title을 출력
-- salary 기준으로 내림차순
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
      
-- 정리
-- where 절에 들어가는 서브쿼리문 단일행 vs 다중행 (in, any, all)
-- 스칼라쿼리 : select절에 들어가는 서브쿼리(단일 행의 결과로 쓰여야함, left outer join과 같은 역할)
-- 인라인뷰 : from 절에 들어가는 서브쿼리(안쪽에서 필요한 쿼리문을 작성, 가상테이블)