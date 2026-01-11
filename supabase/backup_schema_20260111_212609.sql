


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."exercise_type" AS ENUM (
    'bodyweight',
    'weighted',
    'cardio',
    'timed'
);


ALTER TYPE "public"."exercise_type" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."are_friends"("user1" "uuid", "user2" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.friendships
    WHERE status = 'accepted'
    AND ((requester_id = user1 AND addressee_id = user2)
      OR (requester_id = user2 AND addressee_id = user1))
  );
$$;


ALTER FUNCTION "public"."are_friends"("user1" "uuid", "user2" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_friend_ids"("user_uuid" "uuid") RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT CASE
    WHEN requester_id = user_uuid THEN addressee_id
    ELSE requester_id
  END
  FROM public.friendships
  WHERE status = 'accepted'
  AND (requester_id = user_uuid OR addressee_id = user_uuid);
$$;


ALTER FUNCTION "public"."get_friend_ids"("user_uuid" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  INSERT INTO public.profiles (user_id, display_name)
  VALUES (new.id, new.raw_user_meta_data ->> 'display_name');
  RETURN new;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"("user_uuid" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT COALESCE(
    (SELECT is_admin FROM public.profiles WHERE user_id = user_uuid LIMIT 1),
    false
  );
$$;


ALTER FUNCTION "public"."is_admin"("user_uuid" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_friendships_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO 'public'
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_friendships_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO 'public'
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."body_weight_history" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "weight" numeric(5,2) NOT NULL,
    "date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."body_weight_history" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."exercises" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "type" "public"."exercise_type" DEFAULT 'weighted'::"public"."exercise_type" NOT NULL,
    "is_preset" boolean DEFAULT false NOT NULL,
    "user_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "image_url" "text",
    "name_translations" "jsonb" DEFAULT '{}'::"jsonb"
);


ALTER TABLE "public"."exercises" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."favorite_exercises" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "exercise_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."favorite_exercises" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."friendships" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "requester_id" "uuid" NOT NULL,
    "addressee_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "friendships_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'accepted'::"text", 'rejected'::"text"])))
);


ALTER TABLE "public"."friendships" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "display_name" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "current_weight" numeric(5,2),
    "gender" "text",
    "date_of_birth" "date",
    "height" numeric(5,2),
    "avatar" "text",
    "is_skuf" integer DEFAULT 0 NOT NULL,
    "is_admin" boolean DEFAULT false NOT NULL,
    CONSTRAINT "is_skuf_check" CHECK ((("is_skuf" >= 0) AND ("is_skuf" <= 4))),
    CONSTRAINT "profiles_gender_check" CHECK (("gender" = ANY (ARRAY['male'::"text", 'female'::"text", 'other'::"text"])))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workout_sets" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "workout_id" "uuid" NOT NULL,
    "exercise_id" "uuid" NOT NULL,
    "set_number" integer DEFAULT 1 NOT NULL,
    "reps" integer,
    "weight" numeric(5,2),
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "distance_km" numeric(6,2),
    "duration_minutes" integer,
    "plank_seconds" integer,
    CONSTRAINT "workout_sets_cardio_check" CHECK (((("distance_km" IS NOT NULL) AND ("duration_minutes" IS NOT NULL)) OR (("distance_km" IS NULL) AND ("duration_minutes" IS NULL))))
);


ALTER TABLE "public"."workout_sets" OWNER TO "postgres";


COMMENT ON COLUMN "public"."workout_sets"."distance_km" IS 'Distance in kilometers for cardio exercises (NULL for other types)';



COMMENT ON COLUMN "public"."workout_sets"."duration_minutes" IS 'Duration in minutes for cardio exercises (NULL for other types)';



COMMENT ON COLUMN "public"."workout_sets"."plank_seconds" IS 'Время в секундах для упражнений типа timed (например, планка)';



CREATE TABLE IF NOT EXISTS "public"."workout_shares" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "workout_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "share_token" "text" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."workout_shares" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workouts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "photo_url" "text",
    "is_locked" boolean DEFAULT false
);


ALTER TABLE "public"."workouts" OWNER TO "postgres";


ALTER TABLE ONLY "public"."body_weight_history"
    ADD CONSTRAINT "body_weight_history_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."body_weight_history"
    ADD CONSTRAINT "body_weight_history_user_id_date_key" UNIQUE ("user_id", "date");



ALTER TABLE ONLY "public"."exercises"
    ADD CONSTRAINT "exercises_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."favorite_exercises"
    ADD CONSTRAINT "favorite_exercises_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."favorite_exercises"
    ADD CONSTRAINT "favorite_exercises_user_id_exercise_id_key" UNIQUE ("user_id", "exercise_id");



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_requester_id_addressee_id_key" UNIQUE ("requester_id", "addressee_id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."workout_shares"
    ADD CONSTRAINT "unique_active_share_per_workout" UNIQUE ("workout_id", "is_active");



ALTER TABLE ONLY "public"."workout_sets"
    ADD CONSTRAINT "workout_sets_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workout_shares"
    ADD CONSTRAINT "workout_shares_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workout_shares"
    ADD CONSTRAINT "workout_shares_share_token_key" UNIQUE ("share_token");



ALTER TABLE ONLY "public"."workouts"
    ADD CONSTRAINT "workouts_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_exercises_name_translations" ON "public"."exercises" USING "gin" ("name_translations");



CREATE INDEX "idx_favorite_exercises_exercise_id" ON "public"."favorite_exercises" USING "btree" ("exercise_id");



CREATE INDEX "idx_favorite_exercises_user_id" ON "public"."favorite_exercises" USING "btree" ("user_id");



CREATE INDEX "idx_friendships_addressee" ON "public"."friendships" USING "btree" ("addressee_id");



CREATE INDEX "idx_friendships_requester" ON "public"."friendships" USING "btree" ("requester_id");



CREATE INDEX "idx_friendships_status" ON "public"."friendships" USING "btree" ("status");



CREATE INDEX "idx_workout_shares_token" ON "public"."workout_shares" USING "btree" ("share_token") WHERE ("is_active" = true);



CREATE INDEX "idx_workout_shares_user" ON "public"."workout_shares" USING "btree" ("user_id");



CREATE OR REPLACE TRIGGER "friendships_updated_at" BEFORE UPDATE ON "public"."friendships" FOR EACH ROW EXECUTE FUNCTION "public"."update_friendships_updated_at"();



CREATE OR REPLACE TRIGGER "update_workouts_updated_at" BEFORE UPDATE ON "public"."workouts" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



ALTER TABLE ONLY "public"."body_weight_history"
    ADD CONSTRAINT "body_weight_history_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."exercises"
    ADD CONSTRAINT "exercises_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."favorite_exercises"
    ADD CONSTRAINT "favorite_exercises_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "public"."exercises"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."favorite_exercises"
    ADD CONSTRAINT "favorite_exercises_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_addressee_id_fkey" FOREIGN KEY ("addressee_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_requester_id_fkey" FOREIGN KEY ("requester_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workout_sets"
    ADD CONSTRAINT "workout_sets_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "public"."exercises"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workout_sets"
    ADD CONSTRAINT "workout_sets_workout_id_fkey" FOREIGN KEY ("workout_id") REFERENCES "public"."workouts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workout_shares"
    ADD CONSTRAINT "workout_shares_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workout_shares"
    ADD CONSTRAINT "workout_shares_workout_id_fkey" FOREIGN KEY ("workout_id") REFERENCES "public"."workouts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workouts"
    ADD CONSTRAINT "workouts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Admins can view all profiles" ON "public"."profiles" FOR SELECT USING ("public"."is_admin"(( SELECT "auth"."uid"() AS "uid")));



CREATE POLICY "Admins can view all workout sets" ON "public"."workout_sets" FOR SELECT USING ("public"."is_admin"(( SELECT "auth"."uid"() AS "uid")));



CREATE POLICY "Admins can view all workouts" ON "public"."workouts" FOR SELECT USING ("public"."is_admin"(( SELECT "auth"."uid"() AS "uid")));



CREATE POLICY "Allow anonymous access to view profiles" ON "public"."profiles" FOR SELECT TO "anon" USING (true);



CREATE POLICY "Anyone can read active shares" ON "public"."workout_shares" FOR SELECT USING (("is_active" = true));



CREATE POLICY "Friends can view profiles" ON "public"."profiles" FOR SELECT USING ("public"."are_friends"(( SELECT "auth"."uid"() AS "uid"), "user_id"));



CREATE POLICY "Friends can view workout sets" ON "public"."workout_sets" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."workouts" "w"
  WHERE (("w"."id" = "workout_sets"."workout_id") AND "public"."are_friends"(( SELECT "auth"."uid"() AS "uid"), "w"."user_id")))));



CREATE POLICY "Friends can view workouts" ON "public"."workouts" FOR SELECT USING ("public"."are_friends"(( SELECT "auth"."uid"() AS "uid"), "user_id"));



CREATE POLICY "Public read access to exercises" ON "public"."exercises" FOR SELECT USING (true);



CREATE POLICY "Public read access to profiles" ON "public"."profiles" FOR SELECT USING (true);



CREATE POLICY "Public read access via share token" ON "public"."workouts" FOR SELECT USING (((("auth"."uid"() IS NOT NULL) AND ("auth"."uid"() = "user_id")) OR (EXISTS ( SELECT 1
   FROM "public"."workout_shares"
  WHERE (("workout_shares"."workout_id" = "workouts"."id") AND ("workout_shares"."is_active" = true))))));



CREATE POLICY "Public read sets via share token" ON "public"."workout_sets" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."workouts"
  WHERE (("workouts"."id" = "workout_sets"."workout_id") AND ((("auth"."uid"() IS NOT NULL) AND ("workouts"."user_id" = "auth"."uid"())) OR (EXISTS ( SELECT 1
           FROM "public"."workout_shares"
          WHERE (("workout_shares"."workout_id" = "workouts"."id") AND ("workout_shares"."is_active" = true)))))))));



CREATE POLICY "Users can create own exercises" ON "public"."exercises" FOR INSERT WITH CHECK (((( SELECT "auth"."uid"() AS "uid") = "user_id") AND ("is_preset" = false)));



CREATE POLICY "Users can create own profile" ON "public"."profiles" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can create own weight records" ON "public"."body_weight_history" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can create own workouts" ON "public"."workouts" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can create sets for own workouts" ON "public"."workout_sets" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."workouts" "w"
  WHERE (("w"."id" = "workout_sets"."workout_id") AND ("w"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Users can create shares for their workouts" ON "public"."workout_shares" FOR INSERT WITH CHECK (((( SELECT "auth"."uid"() AS "uid") = "user_id") AND (EXISTS ( SELECT 1
   FROM "public"."workouts"
  WHERE (("workouts"."id" = "workout_shares"."workout_id") AND ("workouts"."user_id" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "Users can delete own exercises" ON "public"."exercises" FOR DELETE USING (((( SELECT "auth"."uid"() AS "uid") = "user_id") AND ("is_preset" = false)));



CREATE POLICY "Users can delete own friendships" ON "public"."friendships" FOR DELETE USING (((( SELECT "auth"."uid"() AS "uid") = "requester_id") OR (( SELECT "auth"."uid"() AS "uid") = "addressee_id")));



CREATE POLICY "Users can delete own weight records" ON "public"."body_weight_history" FOR DELETE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can delete own workout sets" ON "public"."workout_sets" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."workouts" "w"
  WHERE (("w"."id" = "workout_sets"."workout_id") AND ("w"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Users can delete own workouts" ON "public"."workouts" FOR DELETE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can delete their own favorites" ON "public"."favorite_exercises" FOR DELETE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can delete their own shares" ON "public"."workout_shares" FOR DELETE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can insert their own favorites" ON "public"."favorite_exercises" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can respond to friend requests" ON "public"."friendships" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "addressee_id")) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "addressee_id"));



CREATE POLICY "Users can send friend requests" ON "public"."friendships" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "requester_id"));



CREATE POLICY "Users can update own exercises" ON "public"."exercises" FOR UPDATE USING (((( SELECT "auth"."uid"() AS "uid") = "user_id") AND ("is_preset" = false)));



CREATE POLICY "Users can update own profile" ON "public"."profiles" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can update own weight records" ON "public"."body_weight_history" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can update own workout sets" ON "public"."workout_sets" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."workouts" "w"
  WHERE (("w"."id" = "workout_sets"."workout_id") AND ("w"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Users can update own workouts" ON "public"."workouts" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can update their own shares" ON "public"."workout_shares" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "user_id")) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can view all profiles for leaderboard" ON "public"."profiles" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Users can view all workout sets for leaderboard" ON "public"."workout_sets" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Users can view all workouts for leaderboard" ON "public"."workouts" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Users can view own friendships" ON "public"."friendships" FOR SELECT USING (((( SELECT "auth"."uid"() AS "uid") = "requester_id") OR (( SELECT "auth"."uid"() AS "uid") = "addressee_id")));



CREATE POLICY "Users can view own profile" ON "public"."profiles" FOR SELECT USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can view own weight history" ON "public"."body_weight_history" FOR SELECT USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can view own workout sets" ON "public"."workout_sets" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."workouts" "w"
  WHERE (("w"."id" = "workout_sets"."workout_id") AND ("w"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Users can view own workouts" ON "public"."workouts" FOR SELECT USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can view preset and own exercises" ON "public"."exercises" FOR SELECT USING ((("is_preset" = true) OR (( SELECT "auth"."uid"() AS "uid") = "user_id")));



CREATE POLICY "Users can view their own favorites" ON "public"."favorite_exercises" FOR SELECT USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Users can view their own shares" ON "public"."workout_shares" FOR SELECT USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



ALTER TABLE "public"."body_weight_history" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."exercises" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."favorite_exercises" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."friendships" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."workout_sets" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."workout_shares" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."workouts" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."are_friends"("user1" "uuid", "user2" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."are_friends"("user1" "uuid", "user2" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."are_friends"("user1" "uuid", "user2" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_friend_ids"("user_uuid" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_friend_ids"("user_uuid" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_friend_ids"("user_uuid" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"("user_uuid" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"("user_uuid" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"("user_uuid" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_friendships_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_friendships_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_friendships_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";


















GRANT ALL ON TABLE "public"."body_weight_history" TO "anon";
GRANT ALL ON TABLE "public"."body_weight_history" TO "authenticated";
GRANT ALL ON TABLE "public"."body_weight_history" TO "service_role";



GRANT ALL ON TABLE "public"."exercises" TO "anon";
GRANT ALL ON TABLE "public"."exercises" TO "authenticated";
GRANT ALL ON TABLE "public"."exercises" TO "service_role";



GRANT ALL ON TABLE "public"."favorite_exercises" TO "anon";
GRANT ALL ON TABLE "public"."favorite_exercises" TO "authenticated";
GRANT ALL ON TABLE "public"."favorite_exercises" TO "service_role";



GRANT ALL ON TABLE "public"."friendships" TO "anon";
GRANT ALL ON TABLE "public"."friendships" TO "authenticated";
GRANT ALL ON TABLE "public"."friendships" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."workout_sets" TO "anon";
GRANT ALL ON TABLE "public"."workout_sets" TO "authenticated";
GRANT ALL ON TABLE "public"."workout_sets" TO "service_role";



GRANT ALL ON TABLE "public"."workout_shares" TO "anon";
GRANT ALL ON TABLE "public"."workout_shares" TO "authenticated";
GRANT ALL ON TABLE "public"."workout_shares" TO "service_role";



GRANT ALL ON TABLE "public"."workouts" TO "anon";
GRANT ALL ON TABLE "public"."workouts" TO "authenticated";
GRANT ALL ON TABLE "public"."workouts" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































