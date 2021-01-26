-- How many stops are in the database.
SELECT count(*) 
FROM stops

-- Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops 
WHERE name = 'Craiglockhart'

-- Give the id and the name for the stops on the '4' 'LRT' service.
SELECT DISTINCT id, stops.name 
FROM stops JOIN route ON stops.id = stop 
WHERE num = '4' AND company = 'LRT';

-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*)
FROM route 
WHERE stop=149 OR stop=53
GROUP BY company, num having count(*) = 2

-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop = 149

-- The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'

-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT Distinct a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name = 'Leith'

-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT Distinct a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross'

-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
SELECT Distinct stopb.name,  a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND b.company = 'LRT'

-- Find the routes involving two buses that can go from Craiglockhart to Lochend.Show the bus no. and company for the first bus, the name of the stop for the transfer,and the bus no. and company for the second bus.
SELECT S.num, S.company, S.name, T.num, T.company 
FROM 
    (SELECT DISTINCT a.num, a.company, stopb.name 
     FROM route a JOIN route b ON (a.num = b.num and a.company = b.company) 
                  JOIN stops stopa ON stopa.id = a.stop 
                  JOIN stops stopb ON stopb.id = b.stop 
     WHERE stopa.name = 'Craiglockhart' AND stopb.name <> 'Craiglockhart'
)S
JOIN
    (SELECT x.num, x.company, stopy.name 
     FROM route x JOIN route y ON (x.num = y.num and x.company = y.company) 
                  JOIN stops stopx ON stopx.id = x.stop 
                  JOIN stops stopy ON stopy.id = y.stop 
     WHERE stopx.name = 'Lochend' AND stopy.name <> 'Lochend'
    )T
ON (S.name = T.name)
ORDER BY S.num, S.name, T.num