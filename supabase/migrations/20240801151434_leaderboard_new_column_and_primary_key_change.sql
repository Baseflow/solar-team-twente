alter table "public"."leaderboard" drop constraint "leaderboard_pkey";

drop index if exists "public"."leaderboard_pkey";

alter table "public"."leaderboard" add column "last_updated" timestamp with time zone;

CREATE UNIQUE INDEX leaderboard_number_unique ON public.leaderboard USING btree (number);

CREATE UNIQUE INDEX leaderboard_pkey ON public.leaderboard USING btree (number);

alter table "public"."leaderboard" add constraint "leaderboard_pkey" PRIMARY KEY using index "leaderboard_pkey";

alter table "public"."leaderboard" add constraint "leaderboard_number_unique" UNIQUE using index "leaderboard_number_unique";

-- insert some dummy data into the vehicle_locations table
insert into vehicle_locations (name, longitude, latitude, last_seen, created_at)
VALUES ('DMU', 5.889339, 52.060017, 1720354200, '2024-08-01 15:14:34');

-- insert some dummy data into the last_updated column in the leaderboard table
update leaderboard set last_updated = '2024-08-01 15:14:34';

-- remove id column from leaderboard table
alter table "public"."leaderboard" drop column "id";