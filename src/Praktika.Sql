-- - 1. Owner_лердин аттарынын арасынан эн коп символ камтыган owner_ди жана анын уйун(House) чыгар.
select o.first_name,max(o.first_name),H.id, house_type from Owners o join houses H on o.id = H.owner_id
group by o.first_name, H.id, house_type, price, rating, description, room, furniture, adress_id, owner_id;
-- 2. Уйлордун баалары 1500, 2000 дин аралыгында бар болсо true чыгар, жок болсо false чыгар.
select furniture from houses where price between 1500 and 2000 and furniture = 'true' or price not between 1500 and 2000 and furniture = 'false';
-- 3. id_лери 5, 6, 7, 8, 9, 10 го барабар болгон адресстерди жана ал адрессте кайсы уйлор бар экенин чыгар.
select a.street,h.house_type from adresses a join houses h on a.id = h.adress_id where a.id in (5,6,7,8,9,10);
-- 4. Бардык уйлорду, уйдун ээсинин атын, клиенттин атын, агенттин атын чыгар.
select h.house_type as house,o.first_name as ownerHouse,C.first_name as Customer,a.name as AgenCyName from houses h join owners o on
        o.id = h.owner_id join Customers C on o.id = C.id join agencys a on h.id=a.id;
-- 5. Клиенттердин 10-катарынан баштап 1999-жылдан кийин туулган 15 клиентти чыгар.
select * from Customers where date_of_birth between '1999-01-01' and '2023-12-31' offset 10 limit 15;
-- 6. Рейтинги боюнча уйлорду сорттоп, уйлордун тайптарын, рейтингин жана уйдун ээлерин чыгар. (asc and desc)
select h.house_type,h.rating,o.first_name from houses h join owners o on o.id = h.owner_id
order by h.rating;
-- 7. Уйлордун арасынан квартиралардын (apartment) санын жана алардын баасынын суммасын чыгар.
select house_type,count(house_type),sum(price) from houses where house_type = 'Apartment'
group by house_type, price;
-- 8. Агентсволардын арасынан аты ‘My_House’ болгон агентсвоны, агентсвонын адресин жана анын бардык уйлорун, уйлордун адрессин чыгар.
select a.name,a2.street,h.id,h.house_type from agencys a join adresses a2 on a2.id = a.adress_id join houses h on a2.id = h.adress_id
where a.name = 'My House';
-- 9. Уйлордун арасынан мебели бар уйлорду, уйдун ээсин жана уйдун адрессин чыгар.
select o.first_name,a.street,furniture from houses join owners o on o.id = houses.owner_id join adresses a on a.id = houses.adress_id
where furniture='true';
-- 10.Кленти жок уйлордун баарын жана анын адрессин жана ал уйлор кайсыл агентсвога тийешелуу экенин чыгар.
select  * from  houses right join owners o on o.id = houses.owner_id;
-- 11.Клиенттердин улутуна карап, улутуну жана ал улуутта канча клиент жашайт санын чыгар.
select nationality,count(*) from customers
group by  nationality;
-- 12.Уйлордун арасынан рейтингтери  чон, кичине, орточо болгон 3 уйду чыгар.
select max(rating) from houses;
select min(rating) from houses;
select  avg(rating) from houses;
-- 13.Уйлору жок киленттерди, клиенттери жок уйлорду чыгар.
select c.first_name,h.house_type from rent_info join houses h on h.id = rent_info.house_id join Customers C on C.id = rent_info.customer_id
where h.id != c.id and c.id != h.id group by c.first_name, h.house_type;
-- 14.Уйлордун бааларынын орточо суммасын чыгар.
select avg(price) from houses;
-- 15.‘A’ тамга менен  башталган уйдун ээсинин аттарын, клиенттердин аттарын чыгар.
select o.first_name,c.first_name from rent_info join Customers C on C.id = rent_info.customer_id join
                                      houses H on H.id = rent_info.house_id join owners o on o.id = H.owner_id where o.first_name ilike 'A%';
-- 16.Эн уйу коп owner_ди жана анын уйлорунун санын чыгар.

-- 17.Улуту Kyrgyzstan уй-булолу customerлерди чыгарыныз.
select * from Customers where nationality = 'Kyrgyz' and  Customers.marital_status = 'Married';
-- 18.Эн коп болмолуу уйду жана анын адресин ал уй кайсыл ownerге таандык ошону чыгарыныз.
select house_type,a.street,o.first_name from houses join adresses a on a.id = houses.adress_id join owners o on o.id = houses.owner_id
having room > (select max(room.length));
-- 19.Бишкекте  жайгашкан уйлорду  жана  клиентерин кошo чыгарыныз.
select H.house_type,H.price,H.rating,H.description,H.room,C.first_name
from rent_info join
     Customers C on C.id = rent_info.customer_id join
     houses H on H.id = rent_info.house_id join adresses a on a.id = H.adress_id
where a.city = 'Bishkek';
-- 20.Жендерине карап группировка кылыныз.
-- Male
select first_name,last_name,email,date_of_birth,gender,nationality,marital_status from Customers
where gender = 'Male'
group by first_name, last_name, email, date_of_birth, gender, nationality, marital_status;
-- Female
select first_name,last_name,email,date_of_birth,gender,nationality,marital_status from Customers
where gender = 'Female'
group by first_name, last_name, email, date_of_birth, gender, nationality, marital_status;
-- 21.Эн коп моонотко  ижарага алынган уйду чыгарыныз.
select*from houses;
-- 22.Эн кымбат уйду жана анын ээсин чыгарыныз.
-- 23.Бир региондо жайгашкан баардык агентстволорду чыгарыныз
-- 24.Рейтинг боюнча эн популярдуу 5 уйду чыгар.
-- 25.Орто жаштагы owner_ди , анын уйун , уйдун адрессин чыгар.