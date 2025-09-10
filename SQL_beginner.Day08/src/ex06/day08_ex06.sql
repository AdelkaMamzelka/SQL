-- Session #1:
begin transaction isolation level read committed;
select sum(rating) from pizzeria;

-- Session #2:
begin transaction isolation level read committed;
insert into pizzeria values (11, 'Казань Пицца 2', 4);
commit;

-- Session #1:
select sum(rating) from pizzeria;

-- Session #2:
select sum(rating) from pizzeria;