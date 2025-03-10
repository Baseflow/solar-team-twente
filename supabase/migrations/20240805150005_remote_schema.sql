set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.read_secret(secret_name text)
 RETURNS text
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$declare
  secret text;
begin 
  select decrypted_secret from vault.decrypted_secrets where name =
  secret_name into secret;
  return secret;
end;$function$
;

CREATE OR REPLACE FUNCTION public.fetch_leaderboard_scheduler()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare 
  anon_key text := read_secret('supabase_anon_key');
begin
  perform
    cron.schedule(
      'fetch-leaderboard-scheduler',
      '*/5 * * * *',
      format(
        'SELECT "net"."http_post"(
          url:=%L,
          headers:=%L,
          body:=%L
        ) AS "leaderboard_result";',
        'https://sqqjlcwcjyclnhakdycb.supabase.co/functions/v1/fetch_leaderboard',
        jsonb_build_object('Authorization', 'Bearer ' || anon_key),
        '{"name": "pg_net"}'::jsonb
      )
    );
end;
$function$
;

CREATE OR REPLACE FUNCTION public.fetch_location_scheduler()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare 
  anon_key text := read_secret('supabase_anon_key');
begin
  perform
    cron.schedule(
      'fetch-location-scheduler',
      '*/5 * * * *',
      format(
        'SELECT "net"."http_post"(
          url:=%L,
          headers:=%L,
          body:=%L
        ) AS "location_result";',
        'https://sqqjlcwcjyclnhakdycb.supabase.co/functions/v1/fetch_vehicle_location',
        jsonb_build_object('Authorization', 'Bearer ' || anon_key),
        '{"name": "pg_net"}'::jsonb
      )
    );
end;
$function$
;


