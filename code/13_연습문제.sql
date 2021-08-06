-- 연습문제 (210405 - 210406)

--문제 1.
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
---EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요
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

-- 문제 2.
-- DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
-- EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.
select *
from employees e left outer join departments d on e.department_id = d.department_id
where e.manager_id = 100;
      
select *
from employees
where department_id = (select department_id
                       from departments
                       where manager_id = 100);

--문제 3.
---EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
-- 서브쿼리
select manager_id
from employees
where first_name = 'Pat';

select *
from employees
where manager_id > (select manager_id
                    from employees
                    where first_name = 'Pat');

---EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 갖는 모든 사원의 데이터를 출력하세요.
select manager_id
from employees
where first_name = 'James';

-- 결과가 2개이므로 다중행 연산자 사용
select *
from employees
where manager_id in (select manager_id
                     from employees
                     where first_name = 'James');

--문제 4.
-- EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요
-- pk를 이용한 힌트구문이 존재한다
select *
from (select rownum as rnum, a.first_name -- rownum을 컬럼으로 만든 것
      from (select *
            from employees e
            order by first_name desc) a)
where rnum between 41 and 50;

--문제 5.
---EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
--입사일을 출력하세요.
select *
from (select rownum as rnum, employee_id, first_name, phone_number, hire_date
      from (select *
            from employees 
            order by hire_date)) -- 날짜는 숫자로 안바꿔도 정렬이 됨
where rnum between 31 and 40;

--문제 6.
--employees테이블 departments테이블을 left 조인하세요
--조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
--조건) 직원아이디 기준 오름차순 정렬
select e.employee_id, concat(e.first_name||' ', last_name) as 이름, d.department_id,d.department_name
from employees e left outer join departments d on e.department_id = d.department_id
order by e.employee_id;

--문제 7.
--문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
select e.employee_id,
       concat(e.first_name||' ', e.last_name) as 이름,
       e.department_id,
       (select d.department_name -- 다른 테이블의 한 컬럼만 가져올 때 스칼라 쿼리가 유리하다
        from departments d
        where e.department_id = d.department_id) as department_name
from employees e
order by e.employee_id;

--문제 8.
--departments테이블 locations테이블을 left 조인하세요
--조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
--조건) 부서아이디 기준 오름차순 정렬
select d.department_id, d.department_name, d.manager_id, d.location_id, l.street_address, l.postal_code, l.city
from departments d left outer join locations l on d.location_id = l.location_id
order by d.department_id;

--문제 9.
--문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
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

--문제 10.
--locations테이블 countries 테이블을 left 조인하세요
--조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
--조건) country_name기준 오름차순 정렬
select * from countries;
select * from locations;

select l.location_id, l.street_address, l.city, c.country_id, c.country_name
from locations l left outer join countries c on l.country_id = c.country_id
order by country_name;

--문제 11. 다시 풀어
--문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
select (select l.location_id
        from locations l
        where l.country_id = c.country_id)
from countries c
order by country_name;

select l.location_id, l.street_address, l.city, c.country_id, c.country_name
from locations l, countries c
where l.country_id = c.country_id;

-- join 구문에도 테이블 대신 서브쿼리가 들어갈 수 있다
-- 예시
select *
from employees e
left outer join (select *
                 from departments) d
on e.department_id = d.department_id;

--문제 12. 
--employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 1-10번째 데이터만 출력합니다
--조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 부서아이디, 부서이름 을 출력합니다.
--조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
select *
from (select rownum as rn, 
             employee_id,
             concat(first_name || ' ', last_name) as 이름,
             hire_date,
             job_id,
             department_name
      from (select *
            from employees e left outer join departments d on e.department_id = d.department_id
            order by hire_date))
where rn <11;

-- 문제 13. 
-- EMPLOYEES 과 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
-- DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요
select * from employees;
select * from departments;

--서브쿼리
select *
from employees
where job_id = 'SA_MAN';

-- 내 방법
select a.*,
       (select d.department_name
        from departments d
        where a.department_id = d.department_id) as department_name
from (select last_name, job_id, department_id
      from employees 
      where job_id = 'SA_MAN') a;
      
-- 쌤 방법
select e.last_name, e.job_id, e.department_id, d.department_name
from (select *
      from employees 
      where job_id = 'SA_MAN') e
left outer join departments d on e.department_id = d.department_id;

--문제 14
----DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
----인원수 기준 내림차순 정렬하세요.
----사람이 없는 부서는 출력하지 않습니다
select * from departments;
select * from employees;

--서브쿼리
select count(*)
from employees
group by department_id;

-- 내 방법
select *
from(select d.department_id, 
            d.department_name,
            d.manager_id,
            (select count(*)
             from employees e
             where e.department_id = d.department_id
             group by e.department_id) as 직원수
     from departments d)
where 직원수 is not null
order by 직원수 desc;

-- 쌤 방법 1
select department_id,
       department_name,
       manager_id,
       직원수
from (select department_id,
             department_name,
             manager_id,
            (select count(*)
             from employees e
             where e.department_id = d.department_id
             group by department_id) as 직원수
      from departments d)
where 직원수 is not null
order by 직원수 desc;

-- 쌤 방법 2 - 직원 테이블의 그룹바이절 department_id만 추출
select d.department_id, department_name, manager_id, total
from departments d left outer join (select department_id,
                                    count(*) as total
                                    from employees
                                    group by department_id) e
on d.department_id = e.department_id
where total is not null
order by total desc;

--문제 15
----부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요
----부서별 평균이 없으면 0으로 출력하세요
select * from departments;
select * from locations; --주소(street_address), 우편번호(postal_code)
select * from employees; -- salary

--서브쿼리
select department_id
from employees
group by department_id;

-- 내 코드
select d.department_id, l.street_address, l.postal_code,
       nvl(trunc((select avg(salary)
              from employees e
              where d.department_id = e.department_id)),0)as 평균연봉
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
---문제 15결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
--출력하세요

select rownum, a.*
from (select d.department_id, l.street_address, l.postal_code,
       nvl(trunc((select avg(salary)
              from employees e
              where d.department_id = e.department_id)),0)as 평균연봉
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
