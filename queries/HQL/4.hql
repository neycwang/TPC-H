select o_orderpriority, count(*) as order_count
from
  orders o
where
  exists (
  select DISTINCT l_orderkey
  from
    lineitem
  where
    l_orderkey = o.o_orderkey and l_commitdate < l_receiptdate) and o.o_orderdate >= '1993-07-01' and o.o_orderdate < '1993-10-01'
group by o_orderpriority
order by o_orderpriority;
