# SQL Examples

# 1 – See all shipments
SELECT Product, s.Date, Amount, Boxes FROM shipments s;
# 2 – All shipments by SP02
select *from shipments s 
where s.`Sales Person` = 'SP02';
# 3 – All shipments by SP02 to G3
select * from shipments s
where s.`Sales Person` = 'SP02' and s.Geo = 'G3';
# 4 – All shipments in Jan 2023
select * from shipments s 
where s.date between '2023-1-1' and '2023-1-31'; 

select* from shipments s
where extract(year_month from s.date) = 202301;

# 5 – All shipments by SP02, SP03, SP12, SP15   
SELECT * from shipments s
where s.`Sales Person` = "SP02" 
	or s.`Sales Person` = "SP03"
    or s.`Sales Person` = "SP12"
    or s. `Sales Person` = "SP15";
    
select * from shipments s
where s.`Sales Person` in ("SP02", "SP03", "SP12", "SP15");
# IN should be used for same columns only ex: above we only for sales person

# 6 – Products that have the word choco in them
select * from products
where Product like '%choco%';

# 7 – Sales persons whose name begins with S
select * from people p
where p.`Sales Person` like 's%';

select * from people p
where p.`Sales Person` like 's%' and Location = "Hyderabad";

# 8 – Sales per box of chocolates in Feb 2023
select s.Date, s.Amount, s.Boxes, round(s.Amount /s.Boxes,1)  as 'amouunt per bebox' from shipments s 
where extract(year_month from s.date) = 202302;

# 9 – All shipment data for Subbarao
select g.Geo, p.`Sales Person`, s.date, s.amount, s.boxes from shipments s
join people p on p.`SP ID` = s.`Sales Person`
where p.`Sales Person` like 'subbarao%' ; 

# 10 – All shipment data for Subbarao by month
select extract(year_month from  s.date), sum(s.amount), sum(s.boxes) from shipments s
join people p on p.`SP ID` = s.`Sales Person`
where p.`Sales Person` like 'subbarao%'
group by extract(year_month from  s.date);


# H1 – All shipment data for Subbarao to USA
select p.`Sales Person`, s.Geo, s.date, s.amount, s.boxes from shipments s
join people p on p.`SP ID` = s.`Sales Person`
where p.`Sales Person` like "subbarao%" and s.Geo = "G2";
### another method
select p.`Sales Person`,g.Geo, s.date, s.amount, s.boxes from shipments s
join people p on p.`SP ID` = s.`Sales Person`
join geo g on g.GeoID = s.Geo
where p.`Sales Person` like "subbarao%" and g.Geo = "USA";
# H2 – What is the maximum amount in each month?
select extract(year_month from  s.date), max(s.amount) from shipments s
group by extract(year_month from  s.date);
# H3 – How many shipments we do by each country in the month of March 2023
select g.geo, count(*), sum(s.Amount) from shipments s
join geo g on g.GeoID = s. Geo
where extract(year_month from  s.date)=202303
group by g.Geo;