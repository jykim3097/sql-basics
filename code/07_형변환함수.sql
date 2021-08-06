-- 형 변환 함수 TO_CHAR, TO_DATE, TO_NUMBER

-- TO_CHAR(날짜, 날짜형식) : 날짜를 문자로
select to_char(sysdate) from dual;
select to_char(sysdate, 'YY-MM-DD') from dual; -- -/: 포맷형식으로 사용가능
select to_char(sysdate, 'YY-MM-DD HH:MI:SS') from dual;
select to_char(sysdate, 'YYYY"년" MM"월" DD"일"' ) from dual; -- 포맷형식이 아닌 문자는 ""로 묶는다

select first_name, hire_date from employees;
select first_name, to_char(hire_date, 'YYYY-MM-DD') from employees;
select first_name, to_char(hire_date, 'YY-MM-DD HH24:MI:SS') from employees;
select first_name, to_char(hire_date, 'YYYY"년" MM"월" DD"일"') from employees; -- 포맷형식이 아닌 문자는 ""로 묶는다

-- TO_CHAR(숫자, 숫자형식) : 숫자를 문자로
select to_char(20000, '99999') from dual; -- 문자라서 좌측정렬, 9는 자리수
select to_char(20000, '9999') from dual; -- 자릿수가 부족하면 표현이 안된다
select to_char(20000.14, '99999') from dual;
select to_char(20000.14, '99999.99') from dual; -- .은 소수점 자리를 의미
select to_char(20000, '99,999') from dual; -- 20,000, 콤마가 찍혀서 나온다
select to_char(20000, '$99999') from dual;
select to_char(20000, 'L99,999') from dual; -- L은 각 나라의 원화 기호

select first_name, to_char(salary, 'L9999,999.99') as salary from employees;

-- TO_NUMBER(문자, 숫자형식) : 문자를 숫자로 (숫자표현식에서 지원하지 않는 구문은 바꿀 수 없다)
select '2000' + 2000 from dual; -- 자동 형변환
select to_number('2000') + 2000 from dual;

select '$3,300' + 2000 from dual; -- 에러
select to_number('$3,300', '$9,999') + 2000 from dual; -- 숫자 포맷형식을 사용해서 명시적 형변환

-- to_date : 문자와 날짜표현형식이 들어간다

select to_date('2021-03-31') from dual; -- 날짜 형식이 문자라면 fmt를 적지 않아도 된다
select sysdate - to_date('2020-03-31') from dual; -- 현재 날짜와 비교할 수 있다

select to_date('2021/03/25', 'YYYY/MM/DD') from dual;
select to_date('2021-03-25 14:51:24', 'YYYY-MM-DD HH24:MI:SS') from dual;

-- '20201111', '20201130' 날짜 차이
select abs(to_date('20201111') - to_date('20201130')) as 날짜차이 from dual;

-- xxxx년xx월xx일로 출력
select to_char(to_date('20051002'), 'YYYY"년" MM"월" DD"일"') as 날짜 from dual;

-- NVL(컬럼, NULL일 경우 변환할 값) - ★★★★★
select nvl(200, 0), nvl(null, 0) from dual;
select first_name, nvl(commission_pct, 0) as commission_pct from employees;

-- NVL2(컬럼, NULL이 아닐 경우 반환할 값, NULL일 경우 반환할 값) - ★★★★★
select nvl2(null, 'null아님', 'null임') from dual;
select first_name, salary, commission_pct, nvl2(commission_pct, salary + salary*commission_pct, salary) as realSalary from employees;

-- DECODE(컬럼, 값, 결과, 값, 결과, ... , DEFAULT) - ★★★★★
select decode('C', 'A', 'A입니다', 'B', 'B입니다', 'C', 'C입니다', '전부 아닙니다') from dual;
select first_name, salary, decode(job_id, 'IT_PROG', salary*1.1, 'AD_VP', salary*1.2, salary*1.1) as salary from employees;

-- CASE 컬럼 WHEN 값 THEN 결과 END
select first_name, 
       salary, 
       job_id,
       (case job_id when 'IT_PROG' then salary*1.5
                    when 'AD_VP' then salary*1.2
                    else salary*1.1
       end)  as salary
from employees;

-- 210401

-- 문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
--조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다

select employee_id as 사원번호,
       concat(first_name, last_name) as 사원명,
       hire_date as 입사일자,
       trunc((sysdate-hire_date)/365) as 근속연수 
from employees
where trunc((sysdate-hire_date)/365) >= 10
order by 근속연수 desc;

--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘사원’, 
--120이라면 ‘주임’
--121이라면 ‘대리’
--122라면 ‘과장’
--나머지는 ‘임원’ 으로 출력합니다.
--조건 1) department_id가 50인 사람들을 대상으로만 조회합니다

select first_name, manager_id,
       (case manager_id when 100 then '사원'
                        when 120 then '주임'
                        when 121 then '대리'
                        when 122 then '과장'
                        else '임원'
       end)as 직급
from employees
where department_id = 50;
