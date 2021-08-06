select *
from (
    select rownum rn,
           a.*,
           case when gap <= 60 then '방금 전'
                when gap <= 60*24 then trunc(gap/60) || '시간 전'
                else to_char(replyDate, 'YYYY-MM-DD')
           end as timegap
    from (
        select rno,
               bno,
               reply,
               replyId,
               replyPw,
               replyDate,
               updateDate,
               trunc((sysdate - replydate) * 24 * 60) as gap
            from FREEREPLY 
            where bno = 310
            order by rno desc ) a )
where rn > 0 and rn <= 20;

select count(*) as count
from FREEREPLY
where rno = 26 and replyPw = 'fff';

delete from freereply
where rno = 27 and replyPw = 'ddd'

declare
    var1 number := 1;
begin
    while var1 <=100
    loop
        insert into freereply(bno, rno, reply, replyId, replyPw)
        values(310, freereply_seq.nextval, 'test' || var1, 'test' || var1, 'test' || var1);
        
        var1 := var1 + 1;
        
        end loop;
        commit;
end;