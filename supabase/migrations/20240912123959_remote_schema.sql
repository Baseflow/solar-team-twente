alter table "public"."leaderboard" alter column "distance" set default 0;

alter table "public"."leaderboard" alter column "last_updated" set default now();

alter table "public"."leaderboard" alter column "vehicle_class" set default 'challenger'::text;

alter table "public"."leaderboard" alter column "vehicle_class" set data type text using "vehicle_class"::text;


