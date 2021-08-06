-- 연습 문제
--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
select concat(first_name, last_name) as 이름, replace(hire_date, '/', '') as 입사일자 
from employees 
order by 이름 asc;


--문제 2.
--EMPLOYEES 테이블 에서 phone_number컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
-- 내 방법1
select lpad(ltrim(phone_number, substr(phone_number,1,3)),length(phone_number)+1,'(02)') 
from employees;

-- 내 방법2
select lpad(substr(phone_number,4,length(phone_number)),length(phone_number)+1,'(02)')
from employees;

-- 문자열 붙이기! = concat!
select concat('(02)',substr(phone_number, 4, length(phone_number)))
from employees; 

--문제 3. 
--EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
select rpad(substr(first_name, 1, 3), length(first_name), '*') as name, lpad(salary,10,'*') as salary 
from employees 
where lower(job_id) = 'it_prog';