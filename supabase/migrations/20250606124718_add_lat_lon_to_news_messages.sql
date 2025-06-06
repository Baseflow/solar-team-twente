alter table "public"."leaderboard" drop column "lat";

alter table "public"."leaderboard" drop column "lon";

alter table "public"."news_messages" add column "lat" real;

alter table "public"."news_messages" add column "lon" real;


