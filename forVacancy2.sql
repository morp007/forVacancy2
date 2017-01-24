use testDB;

select
	Sales.ProductId,
	Count(res.id) 'Куплен первым Х раз'
from
(
	select t2.id
	from
	(
		select
			CustomerId,
			min(DateCreated) b
		from Sales
		group by CustomerId
	) t1
	left outer join Sales t2
	on
		t1.CustomerId = t2.CustomerId and
		t1.b = t2.DateCreated
) res, Sales
where Sales.id = res.id
group by Sales.ProductId
