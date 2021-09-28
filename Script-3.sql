select g.name, count(e.nickname)
from genre as g
left join executor_genre as ge on g.id = ge.genre_id
left join executor as e on ge.executor_id = e.id
group by g.name
order by count(e.id) desc


select t.name, a.release
from album as a
left join track as t on t.album_id = a.id
where (a.release >= 2019) and (a.release <= 2020)


select a.name, AVG(t.duration)
from album as a
left join track as t on t.album_id = a.id
group by a.name
order by AVG(t.duration)


select distinct e.nickname
from executor as e
where e.nickname not in (
    select distinct e.nickname
    from executor as e
    left join executor_album as ea on e.id = ea.executor_id
    left join album as a on a.id = ea.album_id
    where a.release = 2020
)
order by e.nickname


select distinct c.name
from collection as c
left join collection_track as ct on c.id = ct.collection_id
left join track as t on t.id = ct.track_id
left join album as a on a.id = t.album_id
left join executor_album as ea on ea.album_id = a.id
left join executor as e on e.id = ea.executor_id
where e.nickname like '%%Dan%%'
order by c.name


select a.name
from album as a
left join executor_album as ea on a.id = ea.album_id
left join executor as e on e.id = ea.executor_id
left join executor_genre as eg on e.id = eg.executor_id
left join genre as g on g.id = eg.genre_id
group by a.name
having count(distinct g.name) > 1
order by a.name


select t.name
from track as t
left join collection_track as ct on t.id = ct.track_id
where ct.track_id is null


select e.nickname, t.duration
from track as t
left join album as a on a.id = t.album_id
left join executor_album as ea on ea.album_id = a.id
left join executor as e on e.id = ea.executor_id
group by e.nickname, t.duration
having t.duration = (select min(duration) from track)
order by e.nickname


select distinct a.name
from album as a
left join track as t on t.album_id = a.id
where t.album_id in (
    select album_id
    from track
    group by album_id
    having count(id) = (
        select count(id)
        from track
        group by album_id
        order by count
        limit 1
    )
)
order by a.name