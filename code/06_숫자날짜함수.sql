S-- 숫자 함수
-- round (반올림)
select 45.923 from dual;
select round(45.923, 2), round(45.923), round(45.923, -1) from dual;

-- trunc (절삭)
select trunc(45.923,2), trunc(45.923, 0), trunc(45.923, -1) from dual;

-- abs(절대값)
select abs(-34) from dual;

-- ceil(올림), floor(내림)
select ceil(3.14), floor(3.14) from dual; -- 정수 올림

-- mod (나머지)
select 10/4, mod(10,4) from dual;

-- 날짜 함수 * 무조건 외웡
select sysdate from dual; -- 일자까지 (일반적으로 더 많이 사용한다)
select systimestamp from dual; -- 시분초까지

-- 날짜도 연산이 가능하다
select sysdate + 2 from dual; -- 오늘 날짜 + 2일
select sysdate - 7 from dual; -- 오늘 날짜 + 3일

select (sysdate - hire_date) from employees; -- 근무일수
select (sysdate - hire_date)/7 from employees; -- 몇 주 근무했는가?
select trunc((sysdate - hire_date)/365) as 근속연수 from employees; -- 근속연수

-- 날짜에도 trunc, round 적용이 가능하다
select round(sysdate) from dual; -- 12시가 지나서 올림이 된 듯
select round(sysdate, 'year') from dual; -- 년 기준으로 반올림
select round(sysdate, 'month') from dual; -- 월 기준으로 반올림, 해당 월이 반이 안 지났으면 1일이 된다
select round(sysdate, 'day') from dual; -- 일 기준으로 반올림, 일(1) ~ 토(7), 4(수요일)의 반올림이라 다음주로 넘어감

select trunc(sysdate) from dual;
select trunc(sysdate, 'year') from dual; -- 년 기준으로 절삭
select trunc(sysdate, 'month') from dual; -- 월 기준으로 절삭
select trunc(sysdate, 'day') from dual; -- 일 기준으로 절삭 (과거 일요일 날짜가 나옴)

