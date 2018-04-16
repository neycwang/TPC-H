select
  l_shipmode,
  sum(case
    when o_orderpriority ='1-URGENT' or o_orderpriority ='2-HIGH'
    then 1
    else 0
    end
  ) as high_line_count,
  sum(case
    when o_orderpriority <> '1-URGENT' and o_orderpriority <> '2-HIGH'
    then 1
    else 0
    end
  ) as low_line_count
from
  orders o join lineitem l
  on
    o.o_orderkey = l.l_orderkey and l.l_commitdate < l.l_receiptdate and l.l_shipdate < l.l_commitdate and l.l_receiptdate >= '1994-01-01' and l.l_receiptdate < '1995-01-01'
where
  l.l_shipmode = 'MAIL' or l.l_shipmode = 'SHIP'
group by l_shipmode
order by l_shipmode;
