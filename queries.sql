--service division
SELECT TOP 10
    fit.service_id,
    dis.service_name,
    COUNT(ticket_id)
FROM itincident.dbo.fact_incident_tickets fit
JOIN itincident.dbo.dim_it_services dis
    ON fit.service_id = dis.service_id
GROUP BY fit.service_id, dis.service_name
ORDER BY COUNT(ticket_id) DESC

--issuesfix time avg
SELECT 
    fit.sla_tier_id,
    dst.sla_tier_name,
    AVG(resolution_time_hrs)
FROM itincident.dbo.fact_incident_tickets fit
JOIN itincident.dbo.dim_sla_tiers dst
    ON fit.sla_tier_id = dst.sla_tier_id
GROUP BY fit.sla_tier_id, dst.sla_tier_name
ORDER BY fit.sla_tier_id

--support team analysis
SELECT
    dsa.support_level,
    AVG(resolution_time_hrs)
FROM itincident.dbo.fact_incident_tickets fit
JOIN itincident.dbo.dim_support_actors dsa
    ON fit.actor_id = dsa.actor_id
GROUP BY dsa.support_level