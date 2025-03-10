set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fetch_vehicle_location_scheduler()
 RETURNS void
 LANGUAGE sql
AS $function$select cron.schedule(
	'cron-job-name',
	'*/5 * * * *', -- Executes every 5 minutes
	$$
	    -- SQL query
	    select "net"."http_post"(
            -- URL of Edge function
            url:='https://sqqjlcwcjyclnhakdycb.supabase.co/functions/v1/fetch_vehicle_location',
            headers:='{"Authorization": "Bearer SECRET"}'::jsonb,
            body:='{"name": "pg_net"}'::jsonb
	    ) as "request_id";
	$$
);$function$
;


