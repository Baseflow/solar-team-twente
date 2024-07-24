revoke delete on table "public"."leaderboard" from "anon";

revoke insert on table "public"."leaderboard" from "anon";

revoke references on table "public"."leaderboard" from "anon";

revoke select on table "public"."leaderboard" from "anon";

revoke trigger on table "public"."leaderboard" from "anon";

revoke truncate on table "public"."leaderboard" from "anon";

revoke update on table "public"."leaderboard" from "anon";

revoke delete on table "public"."leaderboard" from "authenticated";

revoke insert on table "public"."leaderboard" from "authenticated";

revoke references on table "public"."leaderboard" from "authenticated";

revoke select on table "public"."leaderboard" from "authenticated";

revoke trigger on table "public"."leaderboard" from "authenticated";

revoke truncate on table "public"."leaderboard" from "authenticated";

revoke update on table "public"."leaderboard" from "authenticated";

revoke delete on table "public"."leaderboard" from "service_role";

revoke insert on table "public"."leaderboard" from "service_role";

revoke references on table "public"."leaderboard" from "service_role";

revoke select on table "public"."leaderboard" from "service_role";

revoke trigger on table "public"."leaderboard" from "service_role";

revoke truncate on table "public"."leaderboard" from "service_role";

revoke update on table "public"."leaderboard" from "service_role";

alter table "public"."leaderboard" drop constraint "solar_teams_pkey";

drop index if exists "public"."solar_teams_pkey";

drop table "public"."leaderboard";

drop sequence if exists "public"."solar_teams_id_seq";


