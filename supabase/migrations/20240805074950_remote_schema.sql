drop function if exists "public"."fetch_vehicle_location_scheduler"();

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fetch_leaderboard_scheduler()
 RETURNS void
 LANGUAGE sql
AS $function$select 
  cron.schedule(
    'fetch-leaderboard-scheduler',
    '*/1 * * * *', -- Executes every 5 minutes
    $$
    select 
      "net"."http_post"(
        url:='https://sqqjlcwcjyclnhakdycb.supabase.co/functions/v1/fetch_leaderboard',
        headers:='{"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNxcWpsY3djanljbG5oYWtkeWNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgxOTM0MTEsImV4cCI6MjAzMzc2OTQxMX0.ifhRns2skLt7aDOjcXfBSSB3FxGt0EjNTxvAkJAWZEw"}'::jsonb,
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
    '*/1 * * * *', -- Executes every 5 minutes
    $$
    select 
      "net"."http_post"(
        url:='https://sqqjlcwcjyclnhakdycb.supabase.co/functions/v1/fetch_vehicle_location',
        headers:='{"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNxcWpsY3djanljbG5oYWtkeWNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgxOTM0MTEsImV4cCI6MjAzMzc2OTQxMX0.ifhRns2skLt7aDOjcXfBSSB3FxGt0EjNTxvAkJAWZEw"}'::jsonb,
        body:='{"name": "pg_net"}'::jsonb
      ) as "vehicle_location";
    $$
  );$function$
;


