drop function if exists "public"."fetch_vehicle_location_scheduler"();

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fetch_leaderboard_scheduler()
 RETURNS void
 LANGUAGE sql
AS $function$select 
  cron.schedule(
    'fetch-leaderboard-scheduler',
    '*/5 * * * *', -- Executes every 5 minutes
    $$
    select 
      "net"."http_post"(
        url:='https://sqqjlcwcjyclnhakdycb.supabase.co/functions/v1/fetch_leaderboard',
        headers:='{"Authorization": "Bearer SECRET"}'::jsonb,
        body:='{"name": "pg_net"}'::jsonb
      ) as "leaderboard_result";
    $$
  );$function$
;

CREATE OR REPLACE FUNCTION public.fetch_location_scheduler()
 RETURNS void
 LANGUAGE sql
AS $function$select 
  cron.schedule(
    'fetch-vehicle-location-scheduler',
    '*/5 * * * *', -- Executes every 5 minutes
    $$
    select 
      "net"."http_post"(
        url:='https://sqqjlcwcjyclnhakdycb.supabase.co/functions/v1/fetch_vehicle_location',
        headers:='{"Authorization": "Bearer SECRET"}'::jsonb,
        body:='{"name": "pg_net"}'::jsonb
      ) as "vehicle_location";
    $$
  );$function$
;


