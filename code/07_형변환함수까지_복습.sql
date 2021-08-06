-- 03_함수 복습

-- 문자 함수
-- 가상 테이블
select 'hello world', 'happy' from dual;
select lower('hello WORLD'), upper('hello WORLD'), initcap('hello WORLD') from dual;

select first_name, lower(first_name), upper(first_name), initcap(first_name) from employees;
select last_name, lower(last_name), initcap(last_name), upper(last_name) from employees;

-- 함수는 조건절에도 들어갈 수 있다.
-- 대소문자 구분이 명확하지 않은 경우 where 조건절에서 유용하게 사용될 수 있다
select *
from employees
where lower(last_name) = 'austin';

-- length : 문자열의 길이 반환
-- instr : 문자의 위치 반환, 없으면 0 반환
select first_name, length(first_name), instr(first_name, 'a')
from employees;

-- substr : 주어진 문자열에서 주어진 시작 위치에서부터 지정한 개수만큼 부분 문자열 반환
-- concat : 두 문자열 연결
select first_name, substr(first_name,1,3), concat(first_name, last_name)
from employees;

select concat(concat('hello',' '),'world') from dual; -- 중첩이 가능하다
select 'hello ' || 'world' from dual; -- ||로도 문자를 연결할 수 있다

-- lpad는 왼쪽, rpad는 오른쪽에 남은 자릿 수를 주어진 문자로 채운다
SELECT RPAD(FIRST_NAME, 10, '-') AS NAME, LPAD(SALARY, 10, '*') AS SAL
FROM employees;

-- LTRIM 함수는 정의된 문자열에서 지정된 단어를 발견하면 제거, 오른쪽은 RTRIM
-- 제거할 문자를 지정하지 않으면 공백 제거
SELECT LTRIM('JavaSpecialist', 'Java') FROM DUAL;
SELECT LTRIM('  JavaSpecialist') FROM DUAL;
SELECT RTRIM('JavaSpecialist  ') FROM DUAL;
SELECT TRIM('  JavaSpecialist   ') FROM DUAL;

-- REPLACE 함수는 정의된 문자열에서 지정한 문자열을 새로운 문자열로 대체, 공백 제거도 가능
-- TRANSLATE 함수는 문자열을 1대1로 대응 → 암호화 가능할 듯
SELECT REPLACE('JavaSpecialist', 'Java','Bigdata') FROM DUAL;
SELECT REPLACE('Java Specialist', ' ', '') FROM DUAL;
SELECT TRANSLATE('javaspecialist', 'abcdefghijklmnopqrstuvwxyz','defghijklmnopqrstuvwxyzabc') from dual;
-- 중첩 가능
SELECT REPLACE(REPLACE('My dream is president', 'president', 'programmer'), ' ', '') as test from dual;

-- 문자열 조작 실전 문제
--문제 1. EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS 이름, REPLACE(HIRE_DATE, '/', '') AS 입사일짜
FROM EMPLOYEES
ORDER BY 이름 ASC;

--문제 2. EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT CONCAT('(02)',SUBSTR(PHONE_NUMBER,4,LENGTH(PHONE_NUMBER)))
FROM EMPLOYEES;

--문제 3. EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
select rpad(substr(first_name,1,3),length(first_name),'*') as name, lpad(salary,10, '*') as salary
from employees
where lower(job_id) = 'it_prog';

-- 숫자 함수
-- ROUND
SELECT 45.923, ROUND(45.925, 2), ROUND(45.923), ROUND(45.923, -1) FROM DUAL;

-- TRUNC
SELECT 45.923, TRUNC(45.923, 2), TRUNC(45.923,0), TRUNC(45.923, -1) FROM DUAL;

-- ABS
SELECT ABS(-34) FROM DUAL;

-- CEIL(올림), FLOOR(내림)
SELECT CEIL(3.14), FLOOR(3.14) FROM DUAL;

-- MOD(나머지)
SELECT 10/4, MOD(10,4) FROM DUAL;


-- 날짜함수
SELECT SYSDATE FROM DUAL; -- 현재 날짜 출력
SELECT SYSTIMESTAMP FROM DUAL; -- 시분초까지 출력

-- 날짜도 연산이 가능하다 > 더하기 빼기만 가능
SELECT SYSDATE+2 FROM DUAL;
SELECT SYSDATE-7 FROM DUAL;

SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME),
       TRUNC(SYSDATE - HIRE_DATE) AS 근무일수,
       TRUNC((SYSDATE - HIRE_DATE)/7) AS 근무주수,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS 근속연수
FROM EMPLOYEES
ORDER BY 근속연수 DESC;

-- 날짜에도 ROUND, TRUNC 사용 가능
SELECT ROUND(SYSDATE) FROM DUAL; -- 12시가 지나면 내일
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL; -- 년도를 기준으로 반올림
SELECT ROUND(SYSDATE, 'MONTH') FROM DUAL; -- 월 기준 반올림
SELECT ROUND(SYSDATE, 'DAY') FROM DUAL; -- 일(1) ~ 토(7), 수요일을 기준으로 반올림

SELECT TRUNC(SYSDATE) FROM DUAL;
SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- 년도 기준으로 절삭
SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL;
SELECT TRUNC(SYSDATE, 'DAY') FROM DUAL; -- 일 기준 절삭, 과거 일요일 날짜가 나옴


-- 형변환 함수
-- 날짜를 문자로 : TO_CHAR(날짜, 날짜형식)
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM DUAL; -- JAVA랑 포맷형식이 반대

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES;
-- YYYY-MM-DD으로 변환
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') FROM EMPLOYEES;
-- YY-MM-DD HH24:MI:SS로 변환
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD HH24:MI:SS') FROM EMPLOYEES;

-- 숫자를 문자로 : TO_CHAR(숫자, 숫자형식)
SELECT TO_CHAR(20000, '99999') FROM DUAL;
SELECT TO_CHAR(20000, '9999') FROM DUAL; -- 자릿 수가 부족하면 에러
SELECT TO_CHAR(20000.14, '99999') FROM DUAL; -- 절삭
SELECT TO_CHAR(20000.14, '99999.99') FROM DUAL;
SELECT TO_CHAR(20000, '99,999') FROM DUAL;
SELECT TO_CHAR(20000, '$99999') FROM DUAL;
SELECT TO_CHAR(20000, 'L99,999') FROM DUAL; -- L은 해당 국가의 원화 기호

SELECT FIRST_NAME, TO_CHAR(SALARY, 'L9,999,999.99') AS SALARY FROM EMPLOYEES;

SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'MM/YY') AS MONTH_HIRED
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) = 'STEVEN';

-- 문자를 숫자로 : TO_NUMBER(문자, 숫자형식)
-- 숫자표현식에서 지원하지 않는 문구는 변환할 수 없다 EX) 콤마나 슬래시가 있는 경우
SELECT '2000' + 2000 FROM DUAL; -- 자동형변환
SELECT TO_NUMBER('2000') +2000 FROM DUAL;

SELECT TO_NUMBER('$5,500', '$999,999') - 4000 FROM DUAL;

-- 문자를 날짜로 : TO_DATE(문자, '날짜형식')
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = TO_DATE('2003/06/17', 'YYYY/MM/DD');

SELECT TO_DATE('2001-03-31') FROM DUAL; -- 날짜 형식이 문자라면 형식을 적지 않아도 된다
SELECT SYSDATE - TO_DATE('2020-03-01') FROM DUAL;
SELECT TO_DATE('2021/03/25', 'YYYY/MM/DD') FROM DUAL;

-- '20201111', '20201130' 날짜 차이
SELECT TO_DATE('20201130') - TO_DATE('20201111') FROM DUAL;
-- 20051002를 xxxx년xx월xx일로 출력
SELECT TO_CHAR(TO_DATE('20051002'), 'YYYY"년" MM"월" DD"일"') FROM DUAL;


-- NVL
SELECT NVL(200, 0), NVL(NULL, 0) FROM DUAL;
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) FROM EMPLOYEES;

-- NVL2
SELECT NVL2(NULL, 'NULL아님', 'NULL') FROM DUAL;
SELECT FIRST_NAME,
       NVL2(COMMISSION_PCT, SALARY*(1+COMMISSION_PCT), SALARY) AS SALARY
FROM EMPLOYEES;

-- DECODE
SELECT DECODE ('F', 'A', 'A입니다',
                    'B', 'B입니다',
                    'C', 'C입니다',
                    '전부 아닙니다') AS DECODE
FROM DUAL;

SELECT JOB_ID, SALARY,
       DECODE(JOB_ID, 'IT_PROG', SALARY*1.1,
                      'FI_MGR', SALARY*1.15,
                      'FI_ACCOUNT', SALARY*1.2,
                      SALARY) AS REVISED_SALARY
FROM EMPLOYEES;

-- CASE 컬럼 WHEN 값 THEN 결과 END
SELECT FIRST_NAME, JOB_ID, SALARY,
       (CASE JOB_ID WHEN 'IT_PROG' THEN SALARY*1.3
                    WHEN 'AD_VP' THEN SALARY*1.2
                    ELSE SALARY*1.1
        END) AS REVISED_SALARY
FROM EMPLOYEES;

SELECT FIRST_NAME, JOB_ID, SALARY,
       (CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY*1.3
             WHEN JOB_ID = 'AD_VP' THEN SALARY*1.2
             ELSE SALARY*1.1
        END) AS REVISED_SALARY
FROM EMPLOYEES;

-- 연습문제
--문제 1. 현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 
--근속년수가 10년 이상인 사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID AS 사원번호,
       FIRST_NAME || ' ' || LAST_NAME AS 사원명,
       HIRE_DATE AS 입사일자,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS 근속연수
FROM EMPLOYEES
WHERE (SYSDATE - HIRE_DATE)/365 >= 10;

--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘사원’, 
--120이라면 ‘주임’
--121이라면 ‘대리’
--122라면 ‘과장’
--나머지는 ‘임원’ 으로 출력합니다.
--조건 1) manager_id가 50인 사람들을 대상으로만 조회합니다
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME, 
       MANAGER_ID,
       CASE MANAGER_ID WHEN 100 THEN '사원'
                       WHEN 120 THEN '주임'
                       WHEN 121 THEN '대리'
                       WHEN 122 THEN '과장'
                       ELSE '임원'
       END AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT TO_CHAR(LAST_DAY(TO_DATE('01', 'MM')), 'DD') AS "1" FROM DUAL;