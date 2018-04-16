create table q17_small_quantity_order_revenue(avg_yearly double);
create table lineitem_tmp(t_partkey int, t_avg_quantity double);
create table q17_tmp(l_quantity int, l_partkey int, l_extendedprice double);
create table q17_tmp2(l_quantity int, l_extendedprice double, t_avg_quantity double);
insert overwrite table lineitem_tmp
select
  l_partkey as t_partkey, 0.2 * avg(l_quantity) as t_avg_quantity
from
  lineitem
group by l_partkey;
insert overwrite table q17_tmp
select
  l_quantity, l_partkey, l_extendedprice
from
  part p join lineitem l
  on
    p.p_partkey = l.l_partkey
where
  p.p_brand = 'Brand#23' and p.p_container = 'MED BOX';
insert overwrite table q17_tmp2
select
  l_quantity, l_extendedprice, t_avg_quantity
from
  lineitem_tmp t join
  q17_tmp l1 on l1.l_partkey = t.t_partkey;
insert overwrite table q17_small_quantity_order_revenue
select
  sum(l_extendedprice) / 7.0 as avg_yearly
from
  q17_tmp2
where l_quantity < t_avg_quantity;
drop table q17_small_quantity_order_revenue;
drop table lineitem_tmp;
drop table q17_tmp;
drop table q17_tmp2;
