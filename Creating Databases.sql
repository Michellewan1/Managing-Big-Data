USE 671db;
Create table airbnb(id int,	name text, host_id int, host_name text, neighbourhood_group	text, neighbourhood text, latitude float, longitude float, room_type text, price int, minimum_nights int, number_of_reviews	int, last_review date, reviews_per_month float, calculated_host_listings_count int,	availability_365 int);
Load data local infile "C:\\Users\\Michelle Wan\\Documents\\Big Data\\AB_NYC_2019.csv"
into table airbnb
fields terminated by ","
lines terminated by "\n"
ignore 1 lines;

Create table listing(id int, name text, host_id int, neighbourhood varchar(500), latitude float, longitude float,
Primary Key (id), 
Foreign key(host_id) references Host(host_id),
Foreign key(neighbourhood) references location(neighbourhood));
Insert into listing(
Select distinct id, name, host_id, neighbourhood, latitude, longitude
from airbnb);

Create table Host(host_id int, host_name text, calculated_host_listings_count int,
Primary Key (host_id));
Insert into Host(
Select distinct host_id, host_name, calculated_host_listings_count
from airbnb);

Create table location(neighbourhood varchar(500), neighbourhood_group text,
Primary Key(neighbourhood));
Insert into location(
Select distinct neighbourhood, neighbourhood_group
from airbnb);

Create table reviews(listing_id int, number_of_reviews	int, last_review date, reviews_per_month float,
Primary Key(listing_id),
Foreign Key(listing_id) references Listing(id));
Insert into reviews(
Select distinct id, number_of_reviews, last_review,reviews_per_month
from airbnb);

Create table booking_type(listing_id int, room_type text, price int, minimum_nights int, availability_365 int,
Primary Key(listing_id),
Foreign Key(listing_id) references Listing(id));
Insert into booking_type(
Select distinct id, room_type, price, minimum_nights,availability_365
from airbnb);