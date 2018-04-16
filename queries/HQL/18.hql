create table q18_tmp(l_orderkey int, t_sum_quantity double);
create table q18_large_volume_customer(c_name string, c_custkey int, o_orderkey int, o_orderdate string, o_totalprice double, sum_quantity double);
insert overwrite table q18_tmp
select
  l_orderkey, sum(l_quantity) as t_sum_quantity
from
  lineitem
group by l_orderkey;
insert overwrite table q18_large_volume_customer
select
  c_name,c_custkey,o_orderkey,o_orderdate,o_totalprice,sum(l_quantity)
from
  customer c join orders o
  on
    c.c_custkey = o.o_custkey
  join q18_tmp t
  on
    o.o_orderkey = t.l_orderkey and t.t_sum_quantity > 300
  join lineitem l
  on
    o.o_orderkey = l.l_orderkey
group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice
order by o_totalprice desc, o_orderdate
limit 100;
drop table q18_tmp;
drop table q18_large_volume_customer;
