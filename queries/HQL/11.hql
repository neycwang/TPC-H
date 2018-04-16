create table q11_important_stock(ps_partkey int, value double);
create table q11_part_tmp(ps_partkey int, part_value double);
create table q11_sum_tmp(total_value double);
insert overwrite table q11_part_tmp
select
  ps_partkey, sum(ps_supplycost * ps_availqty) as part_value
from
  nation n join supplier s
  on
    s.s_nationkey = n.n_nationkey and n.n_name = 'GERMANY'
  join partsupp ps
  on
    ps.ps_suppkey = s.s_suppkey
group by ps_partkey;

--select sum(part_value) as total_value from q11_part_tmp;

insert overwrite table q11_important_stock
select
  ps_partkey, part_value as value
from
  q11_part_tmp
where part_value > 6.299282487523999e7
order by value desc;
drop table q11_important_stock;
drop table q11_part_tmp;
drop table q11_sum_tmp;
