create table "public"."news_messages" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "title" text,
    "message" text
);


alter table "public"."news_messages" enable row level security;

CREATE UNIQUE INDEX news_messages_pkey ON public.news_messages USING btree (id);

alter table "public"."news_messages" add constraint "news_messages_pkey" PRIMARY KEY using index "news_messages_pkey";

grant delete on table "public"."news_messages" to "anon";

grant insert on table "public"."news_messages" to "anon";

grant references on table "public"."news_messages" to "anon";

grant select on table "public"."news_messages" to "anon";

grant trigger on table "public"."news_messages" to "anon";

grant truncate on table "public"."news_messages" to "anon";

grant update on table "public"."news_messages" to "anon";

grant delete on table "public"."news_messages" to "authenticated";

grant insert on table "public"."news_messages" to "authenticated";

grant references on table "public"."news_messages" to "authenticated";

grant select on table "public"."news_messages" to "authenticated";

grant trigger on table "public"."news_messages" to "authenticated";

grant truncate on table "public"."news_messages" to "authenticated";

grant update on table "public"."news_messages" to "authenticated";

grant delete on table "public"."news_messages" to "service_role";

grant insert on table "public"."news_messages" to "service_role";

grant references on table "public"."news_messages" to "service_role";

grant select on table "public"."news_messages" to "service_role";

grant trigger on table "public"."news_messages" to "service_role";

grant truncate on table "public"."news_messages" to "service_role";

grant update on table "public"."news_messages" to "service_role";

create policy "Enable insert for authenticated users only"
on "public"."news_messages"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for all users"
on "public"."news_messages"
as permissive
for select
to public
using (true);