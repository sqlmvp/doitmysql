create database us_stock;

use us_stock;

/*
drop table nasdaq_company;
*/
create table nasdaq_company(
symbol varchar(255),
company_name varchar(255),
country	varchar(255),
ipo_year int,
sector varchar(255),
industry varchar(255),
last_crawel_date_stock datetime,
is_delete varchar(5),
open decimal(18,2),
high decimal(18,2),
low decimal(18,2),
close decimal(18,2),
adj_close decimal(18,2),
volume bigint
);

alter table nasdaq_company add primary key (symbol);

create table stock(
date datetime,
symbol varchar(255),
open decimal(18,2),
high decimal(18,2),
low decimal(18,2),
close decimal(18,2),
adj_close decimal(18,2),
volume bigint
);
create index ix_stock_1 on stock(date,symbol);
create index ix_stock_2 on stock(symbol,date);
