create sequence "public"."vehicle_locations_id_seq";

create table "public"."vehicle_locations" (
    "id" bigint not null default nextval('vehicle_locations_id_seq'::regclass),
    "name" text not null,
    "longitude" numeric not null,
    "latitude" numeric not null,
    "last_seen" bigint not null,
    "created_at" timestamp with time zone default now()
);


alter sequence "public"."vehicle_locations_id_seq" owned by "public"."vehicle_locations"."id";

CREATE UNIQUE INDEX vehicle_locations_pkey ON public.vehicle_locations USING btree (id);

alter table "public"."vehicle_locations" add constraint "vehicle_locations_pkey" PRIMARY KEY using index "vehicle_locations_pkey";

grant delete on table "public"."vehicle_locations" to "anon";

grant insert on table "public"."vehicle_locations" to "anon";

grant references on table "public"."vehicle_locations" to "anon";

grant select on table "public"."vehicle_locations" to "anon";

grant trigger on table "public"."vehicle_locations" to "anon";

grant truncate on table "public"."vehicle_locations" to "anon";

grant update on table "public"."vehicle_locations" to "anon";

grant delete on table "public"."vehicle_locations" to "authenticated";

grant insert on table "public"."vehicle_locations" to "authenticated";

grant references on table "public"."vehicle_locations" to "authenticated";

grant select on table "public"."vehicle_locations" to "authenticated";

grant trigger on table "public"."vehicle_locations" to "authenticated";

grant truncate on table "public"."vehicle_locations" to "authenticated";

grant update on table "public"."vehicle_locations" to "authenticated";

grant delete on table "public"."vehicle_locations" to "service_role";

grant insert on table "public"."vehicle_locations" to "service_role";

grant references on table "public"."vehicle_locations" to "service_role";

grant select on table "public"."vehicle_locations" to "service_role";

grant trigger on table "public"."vehicle_locations" to "service_role";

grant truncate on table "public"."vehicle_locations" to "service_role";

grant update on table "public"."vehicle_locations" to "service_role";


