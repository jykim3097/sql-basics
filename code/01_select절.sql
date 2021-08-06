-- 210330
-- SQL 문은 대소문자를 가리지 않는다. (ORACLE에서만)
-- 대문자를 많이 쓴다
-- 구문 마지막에 항상 ;로 마감한다
-- 실행 명령은 CTRL + ENTER

SELECT * FROM EMPLOYEES;

select employee_id, first_name, last_name from employees;

-- null값 확인
select employee_id, salary, commission_pct from employees;

-- 숫자 칼럼은 연산이 가능
select employee_id, salary, salary+salary*0.1 from employees;

-- 엘리어스 (컬럼명의 별칭)
select employee_id as 사원아이디, first_name as 이름, last_name as 성, salary+salary*0.1 as 급여 from employees;

-- 컬럼 연결
select first_name || last_name from employees;
select first_name || ' ' || last_name from employees;
select first_name || ' ' || last_name || 's salary is $' || salary as 급여내역 from employees;

-- 행 중복 제거 distinct
select distinct department_id from employees;
select distinct salary from employees;

-- 출력 순서(ROWNUM), 데이터위치(ROWID)
select rownum, rowid, employee_id, first_name from employees;
select rownum, first_name from employees;

-- 테이블 정보 보기
desc employees;

