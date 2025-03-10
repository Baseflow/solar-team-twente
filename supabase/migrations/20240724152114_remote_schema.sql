revoke delete on table "public"."solar_teams" from "anon";

revoke insert on table "public"."solar_teams" from "anon";

revoke references on table "public"."solar_teams" from "anon";

revoke select on table "public"."solar_teams" from "anon";

revoke trigger on table "public"."solar_teams" from "anon";

revoke truncate on table "public"."solar_teams" from "anon";

revoke update on table "public"."solar_teams" from "anon";

revoke delete on table "public"."solar_teams" from "authenticated";

revoke insert on table "public"."solar_teams" from "authenticated";

revoke references on table "public"."solar_teams" from "authenticated";

revoke select on table "public"."solar_teams" from "authenticated";

revoke trigger on table "public"."solar_teams" from "authenticated";

revoke truncate on table "public"."solar_teams" from "authenticated";

revoke update on table "public"."solar_teams" from "authenticated";

revoke delete on table "public"."solar_teams" from "service_role";

revoke insert on table "public"."solar_teams" from "service_role";

revoke references on table "public"."solar_teams" from "service_role";

revoke select on table "public"."solar_teams" from "service_role";

revoke trigger on table "public"."solar_teams" from "service_role";

revoke truncate on table "public"."solar_teams" from "service_role";

revoke update on table "public"."solar_teams" from "service_role";

alter table "public"."solar_teams" drop constraint "solar_teams_pkey";

drop index if exists "public"."solar_teams_pkey";

drop table "public"."solar_teams";

drop sequence if exists "public"."solar_teams_id_seq";


