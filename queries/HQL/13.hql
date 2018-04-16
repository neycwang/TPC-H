select
  c_count, count(1) as custdist
from
  (select
    c_custkey, count(o_orderkey) as c_count
  from
    customer c left outer join orders o
    on
      c.c_custkey = o.o_custkey and not o.o_comment like '%special%requests%'
  group by c_custkey
  ) c_orders
group by c_count
order by custdist desc, c_count desc;
