-- Ʈ�����
-- ����Ŀ�� Ȯ��
SHOW AUTOCOMMIT;

-- ����Ŀ�� ON
SET AUTOCOMMIT ON;
-- ����Ŀ�� OFF
SET AUTOCOMMIT OFF;

SELECT * FROM DEPTS;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10; -- Ʈ����� ����� ���� ������ ��¥, ����� �� �ƴ�
SAVEPOINT SV1; -- ù��° �������� ����

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;
SAVEPOINT SV2;

ROLLBACK TO SV1;

ROLLBACK TO SV2;

COMMIT; -- ���̺� �ݿ�! (Ŀ�� ���Ŀ��� � ����� ������ �ǵ��� �� ����!)