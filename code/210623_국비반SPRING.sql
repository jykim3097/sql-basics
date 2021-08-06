--declare
--    var1 number := 1;
--begin
--
--    while var1 <= 100
--    loop
--        insert into FREEBOARD(bno, writer, title, content) values(FREEBOARD_SEQ.nextval, 'test', 'test', 'test');
--        insert into FREEBOARD(bno, writer, title, content) values(FREEBOARD_SEQ.nextval, 'admin', 'admin', 'admin');
--        insert into FREEBOARD(bno, writer, title, content) values(FREEBOARD_SEQ.nextval, 'dev', 'dev', 'dev');
--    
--        var1 := var1 + 1;
--    end loop;
--    
--    commit;
--end;

select *
from (select rownum rn,
       a.*
      from (select * 
            from FREEBOARD
            -- where title like '%e%'
            -- where writer like '%d%'
            -- where title like '%dev%' or writer like '%dev%'
            where 1 = 1
            order by bno desc) a)
where rn > 0 and rn <= 10;

select count(*) as total
from freeboard
where title like '%' || 'test' || '%';

select count(*) from freeboard;


      
