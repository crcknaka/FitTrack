SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict j8vevA6aoTySbo1DxVIp4RmnfXlarAOX50J0dapSJZPvszQCXPsBMmHOX3qvCfp

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'fa9af964-426b-4bea-bc4a-f4e4fa23260a', 'authenticated', 'authenticated', 'igoshin@me.com', '$2a$10$OyE2vEuFcNun.M.MupAf3e4OQwrF2TPZQr87YwrIvZrgzbUrtB4GK', '2026-01-07 20:09:49.86944+00', NULL, '', '2026-01-07 20:09:36.72486+00', '', NULL, '', '', NULL, '2026-01-07 20:09:49.875446+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "fa9af964-426b-4bea-bc4a-f4e4fa23260a", "email": "igoshin@me.com", "display_name": "UncleSeryozha", "email_verified": true, "phone_verified": false}', NULL, '2026-01-07 20:09:36.679382+00', '2026-01-07 20:09:49.886574+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'e0d15c8c-e789-4a0d-b29b-2b28f1071fad', 'authenticated', 'authenticated', 'ilja_kovalenko@inbox.lv', '$2a$10$6MTEbv7XWCusuq4SgYk1cOOu/JuuX9nJgSWMV.NV9tHxboQ9oNJYK', '2026-01-07 18:14:18.200695+00', NULL, '', '2026-01-07 18:13:57.488943+00', '', NULL, '', '', NULL, '2026-01-07 18:14:18.205174+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "e0d15c8c-e789-4a0d-b29b-2b28f1071fad", "email": "ilja_kovalenko@inbox.lv", "display_name": "TEst", "email_verified": true, "phone_verified": false}', NULL, '2026-01-07 18:12:52.980147+00', '2026-01-07 20:27:07.505267+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '9e0b5edb-b896-4453-8d05-10ab9802533a', 'authenticated', 'authenticated', 'arturs.birzgals@gmail.com', '$2a$10$F5vPxKYAB/JrDWxgLpUh9eJXNCsdafxfG1FWCyxwSkM1fPoioMcKa', '2026-01-08 10:14:19.143253+00', NULL, '', '2026-01-08 10:14:06.09529+00', '', NULL, '', '', NULL, '2026-01-08 10:14:19.149248+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "9e0b5edb-b896-4453-8d05-10ab9802533a", "email": "arturs.birzgals@gmail.com", "display_name": "Arturs Birzgals", "email_verified": true, "phone_verified": false}', NULL, '2026-01-08 10:14:06.054183+00', '2026-01-08 10:14:19.157215+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '1b437abf-4d9e-4263-ad4b-5306289e3b99', 'authenticated', 'authenticated', 'sexsik@inbox.lv', '$2a$10$z6haQVFH.DIvxlZ/1LRzCeOzeuBkF6n.FIg5B.7JwTznDoHvVUFke', '2026-01-07 23:12:05.204503+00', NULL, '', '2026-01-07 23:11:35.1123+00', '', NULL, '', '', NULL, '2026-01-07 23:12:05.20855+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "1b437abf-4d9e-4263-ad4b-5306289e3b99", "email": "sexsik@inbox.lv", "display_name": "sfdgsdfg", "email_verified": true, "phone_verified": false}', NULL, '2026-01-07 23:11:35.079106+00', '2026-01-07 23:12:05.210445+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '081d8a8a-7e87-41fb-b714-7d74065f46a0', 'authenticated', 'authenticated', 'sergej.chistov@gmail.com', '$2a$10$.GCspZolHZd82/JLPCtp8e4uYWMp5bLCFey.t2CreHqRXslPZEvPS', '2026-01-07 22:42:30.605915+00', NULL, '', '2026-01-07 22:42:17.210659+00', '', NULL, '', '', NULL, '2026-01-08 13:15:30.222091+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "081d8a8a-7e87-41fb-b714-7d74065f46a0", "email": "sergej.chistov@gmail.com", "display_name": "Sergey ", "email_verified": true, "phone_verified": false}', NULL, '2026-01-07 22:42:17.178896+00', '2026-01-11 18:54:17.805692+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '52d6f439-65c2-43be-b93b-3bce58744755', 'authenticated', 'authenticated', 'iljacrc@gmail.com', '$2a$10$Wqz/Ecxg3cGAHeMRGasW1.l4ywyRtWNPVV.DvZ0w4dCL9Z50r4ICa', '2026-01-07 14:51:21.806528+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-01-11 16:56:43.890459+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "52d6f439-65c2-43be-b93b-3bce58744755", "email": "iljacrc@gmail.com", "display_name": "Ilja", "email_verified": true, "phone_verified": false}', NULL, '2026-01-07 14:51:03.454012+00', '2026-01-11 18:58:41.914133+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '41a5fed9-1999-4a59-a20d-41e84a580fe3', 'authenticated', 'authenticated', 'alexz005.info@gmail.com', '$2a$10$M3Aarq4xnKkl5c/94PcDye9dETqAn0A5pzLxCZkcJDLmWLSaWs7qq', '2026-01-07 18:58:08.52905+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-01-11 15:12:56.338387+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "41a5fed9-1999-4a59-a20d-41e84a580fe3", "email": "alexz005.info@gmail.com", "display_name": "Aleksandrs", "email_verified": true, "phone_verified": false}', NULL, '2026-01-07 18:57:54.956525+00', '2026-01-11 17:34:40.782267+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', 'authenticated', 'authenticated', 'akozulina7@gmail.com', '$2a$10$Z9Rr9xBCeQUYLIKB02qDEOs/BZV1X4Nhjpu.89p1uvOLnTjnScMyq', '2026-01-09 18:36:37.81245+00', NULL, '', '2026-01-09 18:36:13.254521+00', '', NULL, '', '', NULL, '2026-01-09 18:36:37.821683+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "ae2055a8-1bbe-4326-b366-5a6dbc8a4148", "email": "akozulina7@gmail.com", "display_name": "Алина", "email_verified": true, "phone_verified": false}', NULL, '2026-01-09 18:36:13.195215+00', '2026-01-11 15:53:00.871645+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('52d6f439-65c2-43be-b93b-3bce58744755', '52d6f439-65c2-43be-b93b-3bce58744755', '{"sub": "52d6f439-65c2-43be-b93b-3bce58744755", "email": "iljacrc@gmail.com", "display_name": "Ilja", "email_verified": true, "phone_verified": false}', 'email', '2026-01-07 14:51:03.471577+00', '2026-01-07 14:51:03.47163+00', '2026-01-07 14:51:03.47163+00', '79180403-95d0-491b-aa30-55a9bb64dcae'),
	('e0d15c8c-e789-4a0d-b29b-2b28f1071fad', 'e0d15c8c-e789-4a0d-b29b-2b28f1071fad', '{"sub": "e0d15c8c-e789-4a0d-b29b-2b28f1071fad", "email": "ilja_kovalenko@inbox.lv", "display_name": "TEst", "email_verified": true, "phone_verified": false}', 'email', '2026-01-07 18:12:53.010275+00', '2026-01-07 18:12:53.010332+00', '2026-01-07 18:12:53.010332+00', '83f53c78-339f-41b3-b914-ac520bb77701'),
	('41a5fed9-1999-4a59-a20d-41e84a580fe3', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '{"sub": "41a5fed9-1999-4a59-a20d-41e84a580fe3", "email": "alexz005.info@gmail.com", "display_name": "Aleksandrs", "email_verified": true, "phone_verified": false}', 'email', '2026-01-07 18:57:54.996858+00', '2026-01-07 18:57:54.996909+00', '2026-01-07 18:57:54.996909+00', 'd78b034d-4cae-43ba-898b-e88ff94d6272'),
	('fa9af964-426b-4bea-bc4a-f4e4fa23260a', 'fa9af964-426b-4bea-bc4a-f4e4fa23260a', '{"sub": "fa9af964-426b-4bea-bc4a-f4e4fa23260a", "email": "igoshin@me.com", "display_name": "UncleSeryozha", "email_verified": true, "phone_verified": false}', 'email', '2026-01-07 20:09:36.709075+00', '2026-01-07 20:09:36.709123+00', '2026-01-07 20:09:36.709123+00', '7343d52d-8bdd-4488-b8de-a1ec5b90aad0'),
	('081d8a8a-7e87-41fb-b714-7d74065f46a0', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '{"sub": "081d8a8a-7e87-41fb-b714-7d74065f46a0", "email": "sergej.chistov@gmail.com", "display_name": "Sergey ", "email_verified": true, "phone_verified": false}', 'email', '2026-01-07 22:42:17.203679+00', '2026-01-07 22:42:17.203727+00', '2026-01-07 22:42:17.203727+00', 'f369e40a-d2f3-418b-8436-0a30e12e6917'),
	('1b437abf-4d9e-4263-ad4b-5306289e3b99', '1b437abf-4d9e-4263-ad4b-5306289e3b99', '{"sub": "1b437abf-4d9e-4263-ad4b-5306289e3b99", "email": "sexsik@inbox.lv", "display_name": "sfdgsdfg", "email_verified": true, "phone_verified": false}', 'email', '2026-01-07 23:11:35.107783+00', '2026-01-07 23:11:35.107833+00', '2026-01-07 23:11:35.107833+00', 'f4d7fd82-04bf-4062-8879-70f126a98052'),
	('9e0b5edb-b896-4453-8d05-10ab9802533a', '9e0b5edb-b896-4453-8d05-10ab9802533a', '{"sub": "9e0b5edb-b896-4453-8d05-10ab9802533a", "email": "arturs.birzgals@gmail.com", "display_name": "Arturs Birzgals", "email_verified": true, "phone_verified": false}', 'email', '2026-01-08 10:14:06.089675+00', '2026-01-08 10:14:06.089725+00', '2026-01-08 10:14:06.089725+00', '1b95e2b6-4f3a-49f3-8b5f-493f4f010448'),
	('ae2055a8-1bbe-4326-b366-5a6dbc8a4148', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', '{"sub": "ae2055a8-1bbe-4326-b366-5a6dbc8a4148", "email": "akozulina7@gmail.com", "display_name": "Алина", "email_verified": true, "phone_verified": false}', 'email', '2026-01-09 18:36:13.246901+00', '2026-01-09 18:36:13.246959+00', '2026-01-09 18:36:13.246959+00', '7f8c8714-a197-4e95-9b71-ac25373ab27b');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('23d03f2e-08df-4c1b-af28-cf7143f5cc6c', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 21:00:16.981297+00', '2026-01-11 18:28:20.421524+00', NULL, 'aal1', NULL, '2026-01-11 18:28:20.420872', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('4f70fe08-4c21-48c0-8775-2a728e1ea7b8', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-11 15:11:20.348857+00', '2026-01-11 18:41:07.805021+00', NULL, 'aal1', NULL, '2026-01-11 18:41:07.804295', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('a295dbba-4e80-448b-b826-d5d83635c7f2', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-10 20:23:06.605966+00', '2026-01-10 20:23:06.605966+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('78f74789-c8f6-43be-b0b9-1bfa91a1d96d', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-10 18:27:01.45283+00', '2026-01-10 20:23:47.589206+00', NULL, 'aal1', NULL, '2026-01-10 20:23:47.588016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('c6c2cf0d-b505-453f-bdc8-24c73c63b716', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '2026-01-07 22:42:30.610859+00', '2026-01-11 18:54:17.824442+00', NULL, 'aal1', NULL, '2026-01-11 18:54:17.818388', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '78.84.155.220', NULL, NULL, NULL, NULL, NULL),
	('9101c156-3eec-4961-a203-6ad406700d20', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-11 16:56:43.890561+00', '2026-01-11 18:58:41.916776+00', NULL, 'aal1', NULL, '2026-01-11 18:58:41.916689', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('5175e3e7-c520-4b06-94ed-aa8a9a95177c', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 21:53:40.096372+00', '2026-01-11 10:16:20.010966+00', NULL, 'aal1', NULL, '2026-01-11 10:16:20.010023', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('d7e28a3f-2871-4200-94ad-0b5ca240662f', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', '2026-01-09 18:36:37.821773+00', '2026-01-11 15:53:00.880694+00', NULL, 'aal1', NULL, '2026-01-11 15:53:00.880566', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('ce398347-b1c3-412d-845e-f00a280b3a76', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '2026-01-08 13:15:30.222192+00', '2026-01-08 14:53:00.291628+00', NULL, 'aal1', NULL, '2026-01-08 14:53:00.291507', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('d9cc5485-3c7e-49b5-a52c-f7029e7a7499', 'fa9af964-426b-4bea-bc4a-f4e4fa23260a', '2026-01-07 20:09:49.87555+00', '2026-01-07 20:09:49.87555+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '80.89.76.5', NULL, NULL, NULL, NULL, NULL),
	('cf6abc20-8300-4df8-8723-c371a06e9f8e', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '2026-01-08 13:08:24.671475+00', '2026-01-08 15:36:50.056517+00', NULL, 'aal1', NULL, '2026-01-08 15:36:50.056401', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('2c994ac3-49ef-4aeb-a8a4-4673a6e40cad', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '2026-01-09 07:16:05.843899+00', '2026-01-11 17:32:33.034993+00', NULL, 'aal1', NULL, '2026-01-11 17:32:33.034241', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '77.219.13.241', NULL, NULL, NULL, NULL, NULL),
	('184c5d4e-1e9e-4b30-98b7-bf2612d41682', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '2026-01-11 15:12:56.339114+00', '2026-01-11 17:34:40.79524+00', NULL, 'aal1', NULL, '2026-01-11 17:34:40.795121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '77.38.246.153', NULL, NULL, NULL, NULL, NULL),
	('9d052c90-ec1d-479a-8496-e6b0c4927217', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 22:10:54.954748+00', '2026-01-11 17:52:38.161688+00', NULL, 'aal1', NULL, '2026-01-11 17:52:38.161566', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '212.142.89.190', NULL, NULL, NULL, NULL, NULL),
	('93ffb0af-e4e8-4e4c-b1f9-185d8530645b', '9e0b5edb-b896-4453-8d05-10ab9802533a', '2026-01-08 10:14:19.149344+00', '2026-01-08 10:14:19.149344+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '91.90.253.163', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('d9cc5485-3c7e-49b5-a52c-f7029e7a7499', '2026-01-07 20:09:49.887159+00', '2026-01-07 20:09:49.887159+00', 'otp', 'da02ec33-3d5c-43de-ab24-bb761ef50671'),
	('c6c2cf0d-b505-453f-bdc8-24c73c63b716', '2026-01-07 22:42:30.620974+00', '2026-01-07 22:42:30.620974+00', 'otp', '3957138f-7596-4385-a170-9306f26fba61'),
	('93ffb0af-e4e8-4e4c-b1f9-185d8530645b', '2026-01-08 10:14:19.15763+00', '2026-01-08 10:14:19.15763+00', 'otp', '04c027cf-4481-49b3-8015-318f07024f7d'),
	('cf6abc20-8300-4df8-8723-c371a06e9f8e', '2026-01-08 13:08:24.686463+00', '2026-01-08 13:08:24.686463+00', 'password', '3d8e83f2-5c84-4d13-b1f4-42929ab1774a'),
	('ce398347-b1c3-412d-845e-f00a280b3a76', '2026-01-08 13:15:30.255843+00', '2026-01-08 13:15:30.255843+00', 'password', '177d5a65-9254-48e0-a80d-9bbe43903d43'),
	('23d03f2e-08df-4c1b-af28-cf7143f5cc6c', '2026-01-08 21:00:16.984112+00', '2026-01-08 21:00:16.984112+00', 'password', '8a61984b-f1e8-4f4a-99e8-c14e6f0dd0a7'),
	('5175e3e7-c520-4b06-94ed-aa8a9a95177c', '2026-01-08 21:53:40.138057+00', '2026-01-08 21:53:40.138057+00', 'password', 'cc646228-d375-46fc-a502-12630583adc8'),
	('9d052c90-ec1d-479a-8496-e6b0c4927217', '2026-01-08 22:10:54.981555+00', '2026-01-08 22:10:54.981555+00', 'password', 'f9703a7f-9884-410a-923f-9863a14cced6'),
	('2c994ac3-49ef-4aeb-a8a4-4673a6e40cad', '2026-01-09 07:16:05.850357+00', '2026-01-09 07:16:05.850357+00', 'password', 'f176f70a-c204-4bee-bc26-0f5a3a6f5f55'),
	('d7e28a3f-2871-4200-94ad-0b5ca240662f', '2026-01-09 18:36:37.837269+00', '2026-01-09 18:36:37.837269+00', 'otp', '8b873e3e-5f65-40f6-9ae9-9eee8e227cc8'),
	('78f74789-c8f6-43be-b0b9-1bfa91a1d96d', '2026-01-10 18:27:01.559552+00', '2026-01-10 18:27:01.559552+00', 'password', 'fef0a565-0ea8-4106-9931-080973bbef0f'),
	('a295dbba-4e80-448b-b826-d5d83635c7f2', '2026-01-10 20:23:06.62422+00', '2026-01-10 20:23:06.62422+00', 'password', '3f0e6496-68b3-4428-af4e-c88478759ef7'),
	('4f70fe08-4c21-48c0-8775-2a728e1ea7b8', '2026-01-11 15:11:20.355066+00', '2026-01-11 15:11:20.355066+00', 'password', '14eba171-fcf1-4d21-9724-21b0f24997a5'),
	('184c5d4e-1e9e-4b30-98b7-bf2612d41682', '2026-01-11 15:12:56.342117+00', '2026-01-11 15:12:56.342117+00', 'password', 'beca498c-ab63-4b6c-bf5b-1ee9989dbbf2'),
	('9101c156-3eec-4961-a203-6ad406700d20', '2026-01-11 16:56:43.955705+00', '2026-01-11 16:56:43.955705+00', 'password', '38fdee33-5a96-47a7-bc51-2973bb59fc80');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 116, 'kefwrcdswd2p', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 16:57:01.508447+00', '2026-01-10 20:22:58.62402+00', '33hc76yknamj', '5175e3e7-c520-4b06-94ed-aa8a9a95177c'),
	('00000000-0000-0000-0000-000000000000', 127, '5fsprhfxqrnt', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-09 19:18:39.728405+00', '2026-01-11 11:26:49.966861+00', 'bnzaiwr5sdkb', '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 93, 'aiqerjbnb6cs', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-08 21:00:16.982652+00', '2026-01-08 22:18:10.167491+00', NULL, '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 75, 'p2a6ziuzi7du', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-08 18:06:58.88492+00', '2026-01-08 22:40:20.151436+00', '6j3rr4o2du7t', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 48, 'nnonyeg7xuu4', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-08 10:44:28.267748+00', '2026-01-08 12:53:26.163068+00', 'flv3y3lcvjk5', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 97, '2njyvpppw5re', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-08 22:10:54.96821+00', '2026-01-08 23:16:30.414535+00', NULL, '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 98, '6txqlq3nypts', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-08 22:18:10.193062+00', '2026-01-08 23:35:39.440176+00', 'aiqerjbnb6cs', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 104, '6weemi4zubam', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-09 07:16:05.846274+00', '2026-01-09 08:56:43.690703+00', NULL, '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 99, 'eumxk4xzjkdw', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-08 22:40:20.169637+00', '2026-01-09 11:39:19.44101+00', 'p2a6ziuzi7du', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 22, 'unfeiewbsbll', 'fa9af964-426b-4bea-bc4a-f4e4fa23260a', false, '2026-01-07 20:09:49.879737+00', '2026-01-07 20:09:49.879737+00', NULL, 'd9cc5485-3c7e-49b5-a52c-f7029e7a7499'),
	('00000000-0000-0000-0000-000000000000', 62, '6se56qyby27w', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-08 13:15:30.243301+00', '2026-01-08 14:53:00.268045+00', NULL, 'ce398347-b1c3-412d-845e-f00a280b3a76'),
	('00000000-0000-0000-0000-000000000000', 65, 'agyqr67yh5vw', '081d8a8a-7e87-41fb-b714-7d74065f46a0', false, '2026-01-08 14:53:00.273191+00', '2026-01-08 14:53:00.273191+00', '6se56qyby27w', 'ce398347-b1c3-412d-845e-f00a280b3a76'),
	('00000000-0000-0000-0000-000000000000', 101, 'jxl227qpoqzl', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-08 23:16:30.426551+00', '2026-01-09 11:52:22.795281+00', '2njyvpppw5re', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 95, '4a6qbwkpp3kj', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-08 21:53:40.125067+00', '2026-01-09 12:00:43.362877+00', NULL, '5175e3e7-c520-4b06-94ed-aa8a9a95177c'),
	('00000000-0000-0000-0000-000000000000', 59, 'iemvb25u37na', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-08 13:08:24.683177+00', '2026-01-08 15:36:50.018297+00', NULL, 'cf6abc20-8300-4df8-8723-c371a06e9f8e'),
	('00000000-0000-0000-0000-000000000000', 68, 'dx4oe5irfyex', '081d8a8a-7e87-41fb-b714-7d74065f46a0', false, '2026-01-08 15:36:50.029919+00', '2026-01-08 15:36:50.029919+00', 'iemvb25u37na', 'cf6abc20-8300-4df8-8723-c371a06e9f8e'),
	('00000000-0000-0000-0000-000000000000', 56, 'ftekmqfseube', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-08 12:53:26.188762+00', '2026-01-08 15:36:56.181232+00', 'nnonyeg7xuu4', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 107, 'eargu4d344fc', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-09 11:39:19.460119+00', '2026-01-09 14:41:16.354659+00', 'eumxk4xzjkdw', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 112, 'jnpfew7j2obj', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-09 14:41:16.384438+00', '2026-01-09 16:52:43.895875+00', 'eargu4d344fc', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 102, 'p5o54qxxiwnv', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-08 23:35:39.449949+00', '2026-01-09 16:55:03.275384+00', '6txqlq3nypts', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 110, '33hc76yknamj', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 12:00:43.365813+00', '2026-01-09 16:57:01.507484+00', '4a6qbwkpp3kj', '5175e3e7-c520-4b06-94ed-aa8a9a95177c'),
	('00000000-0000-0000-0000-000000000000', 32, 'zl4uisppsaql', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-07 22:42:30.617843+00', '2026-01-07 23:44:25.599189+00', NULL, 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 69, '6j3rr4o2du7t', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-08 15:36:56.182485+00', '2026-01-08 18:06:58.863682+00', 'ftekmqfseube', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 109, 'okebeiqwnx5e', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 11:52:22.808131+00', '2026-01-09 16:57:10.612682+00', 'jxl227qpoqzl', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 105, 'zj3du5oeqsv7', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-09 08:56:43.71672+00', '2026-01-09 17:12:24.715956+00', '6weemi4zubam', '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 115, 't6cywmbcfvlw', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 16:55:03.276988+00', '2026-01-09 17:54:00.690444+00', 'p5o54qxxiwnv', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 114, 'hvzntvw6l2z7', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-09 16:52:43.918761+00', '2026-01-09 18:25:16.557562+00', 'jnpfew7j2obj', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 47, 'jbseaxscke7t', '9e0b5edb-b896-4453-8d05-10ab9802533a', false, '2026-01-08 10:14:19.153094+00', '2026-01-08 10:14:19.153094+00', NULL, '93ffb0af-e4e8-4e4c-b1f9-185d8530645b'),
	('00000000-0000-0000-0000-000000000000', 38, 'flv3y3lcvjk5', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-07 23:44:25.617183+00', '2026-01-08 10:44:28.236788+00', 'zl4uisppsaql', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 117, 'rwyl6x3p2rsa', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 16:57:10.613149+00', '2026-01-09 18:29:00.906464+00', 'okebeiqwnx5e', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 120, 'yfm2yfqyxzag', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 17:54:00.704297+00', '2026-01-09 19:15:54.514292+00', 't6cywmbcfvlw', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 119, 'bnzaiwr5sdkb', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-09 17:12:24.727288+00', '2026-01-09 19:18:39.727343+00', 'zj3du5oeqsv7', '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 122, '2qbg2bnb4ord', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-09 18:25:16.569988+00', '2026-01-09 19:23:41.15856+00', 'hvzntvw6l2z7', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 126, 'suhl6zbolj47', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 19:15:54.523393+00', '2026-01-09 20:22:28.773777+00', 'yfm2yfqyxzag', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 128, 'au6s7t2s4y6l', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-09 19:23:41.16625+00', '2026-01-09 20:33:07.096284+00', '2qbg2bnb4ord', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 123, 'bvcrtay263jb', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 18:29:00.908594+00', '2026-01-09 20:37:55.727271+00', 'rwyl6x3p2rsa', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 130, 'b7n7cg2vbrod', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 20:22:28.788078+00', '2026-01-09 21:24:50.960419+00', 'suhl6zbolj47', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 131, 'a5kcwzmpp6ep', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-09 20:33:07.102236+00', '2026-01-09 22:10:04.752982+00', 'au6s7t2s4y6l', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 124, 'dwahwewrtavr', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', true, '2026-01-09 18:36:37.82981+00', '2026-01-10 08:24:50.532366+00', NULL, 'd7e28a3f-2871-4200-94ad-0b5ca240662f'),
	('00000000-0000-0000-0000-000000000000', 163, 'jfmn6qt7ng67', '52d6f439-65c2-43be-b93b-3bce58744755', false, '2026-01-10 20:22:58.640788+00', '2026-01-10 20:22:58.640788+00', 'kefwrcdswd2p', '5175e3e7-c520-4b06-94ed-aa8a9a95177c'),
	('00000000-0000-0000-0000-000000000000', 164, 'oxs674orgzkt', '52d6f439-65c2-43be-b93b-3bce58744755', false, '2026-01-10 20:23:06.621841+00', '2026-01-10 20:23:06.621841+00', NULL, 'a295dbba-4e80-448b-b826-d5d83635c7f2'),
	('00000000-0000-0000-0000-000000000000', 160, 'd4kednyz5tas', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 19:25:36.477708+00', '2026-01-10 20:23:47.573998+00', '7jwahrs66o45', '78f74789-c8f6-43be-b0b9-1bfa91a1d96d'),
	('00000000-0000-0000-0000-000000000000', 132, 'rzmfbxkb2tmn', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 20:37:55.748408+00', '2026-01-09 21:36:11.262581+00', 'bvcrtay263jb', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 165, 'akot66kcuqab', '52d6f439-65c2-43be-b93b-3bce58744755', false, '2026-01-10 20:23:47.574989+00', '2026-01-10 20:23:47.574989+00', 'd4kednyz5tas', '78f74789-c8f6-43be-b0b9-1bfa91a1d96d'),
	('00000000-0000-0000-0000-000000000000', 161, '4hvioievcmio', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 19:31:25.375556+00', '2026-01-10 20:29:30.901868+00', 'sypvq6jkikxx', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 134, 'yph4xsjy3ggp', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 21:24:50.976958+00', '2026-01-09 22:23:12.769104+00', 'b7n7cg2vbrod', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 162, 'fyokzdvv6fhe', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-10 19:52:26.399799+00', '2026-01-10 20:51:25.646268+00', 'sielhmjm6neb', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 135, 'dcsqbl43ebxj', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 21:36:11.282407+00', '2026-01-09 22:34:48.371131+00', 'rzmfbxkb2tmn', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 138, 'qz7lhkmmnhjk', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 22:23:12.771466+00', '2026-01-10 08:23:08.387276+00', 'yph4xsjy3ggp', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 141, 'txfvi6a7dqw4', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', true, '2026-01-10 08:24:50.535865+00', '2026-01-10 21:13:37.290645+00', 'dwahwewrtavr', 'd7e28a3f-2871-4200-94ad-0b5ca240662f'),
	('00000000-0000-0000-0000-000000000000', 139, '2gngw6ouv4a6', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-09 22:34:48.380971+00', '2026-01-10 09:36:47.596245+00', 'dcsqbl43ebxj', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 166, 'vrur4m76whfb', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 20:29:30.903676+00', '2026-01-10 23:38:50.654311+00', '4hvioievcmio', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 140, 'obzbjnsk5zln', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 08:23:08.416459+00', '2026-01-10 09:53:38.026305+00', 'qz7lhkmmnhjk', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 144, 'addmqjnpsc2n', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 09:36:47.596613+00', '2026-01-10 10:52:25.532459+00', '2gngw6ouv4a6', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 168, 'twwwb4teuohy', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', true, '2026-01-10 21:13:37.304961+00', '2026-01-11 07:50:20.375748+00', 'txfvi6a7dqw4', 'd7e28a3f-2871-4200-94ad-0b5ca240662f'),
	('00000000-0000-0000-0000-000000000000', 146, 'qqyiexfwxxdb', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 10:52:25.560084+00', '2026-01-10 11:58:41.041562+00', 'addmqjnpsc2n', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 147, 'srv7f7nd3hn6', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 11:58:41.058525+00', '2026-01-10 13:00:08.22559+00', 'qqyiexfwxxdb', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 169, '4yfeaz637fuz', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 23:38:50.679137+00', '2026-01-11 09:29:40.931769+00', 'vrur4m76whfb', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 148, '3evwq7qihbbt', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 13:00:08.245791+00', '2026-01-10 14:14:32.323899+00', 'srv7f7nd3hn6', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 149, 'cqqp6nkmq5kz', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 14:14:32.35149+00', '2026-01-10 15:15:49.61733+00', '3evwq7qihbbt', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 137, 'u663qdzyhf6p', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-09 22:10:04.755446+00', '2026-01-10 15:16:35.213089+00', 'a5kcwzmpp6ep', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 150, 'lhn5sggkmaqm', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 15:15:49.634336+00', '2026-01-10 16:14:05.431591+00', 'cqqp6nkmq5kz', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 151, 'ey4o6f77bpq4', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-10 15:16:35.213736+00', '2026-01-10 16:18:13.825786+00', 'u663qdzyhf6p', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 152, '65bou446navd', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 16:14:05.454157+00', '2026-01-10 17:30:58.924457+00', 'lhn5sggkmaqm', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 171, 'ocbm3knqaytr', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 09:29:40.960959+00', '2026-01-11 11:10:23.308297+00', '4yfeaz637fuz', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 145, '6bxrh7dzsjx2', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 09:53:38.047089+00', '2026-01-10 17:47:49.704255+00', 'obzbjnsk5zln', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 167, 'fxxuv6diw4zg', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-10 20:51:25.661289+00', '2026-01-11 11:15:10.466452+00', 'fyokzdvv6fhe', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 154, 'bdljaaurygzl', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 17:30:58.950338+00', '2026-01-10 18:30:25.270412+00', '65bou446navd', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 153, 'qu2mn3lpsl4n', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-10 16:18:13.82856+00', '2026-01-10 18:54:02.80697+00', 'ey4o6f77bpq4', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 155, 'wj7f4cjomfzx', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 17:47:49.709755+00', '2026-01-10 19:24:13.741952+00', '6bxrh7dzsjx2', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 156, '7jwahrs66o45', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 18:27:01.505844+00', '2026-01-10 19:25:36.466691+00', NULL, '78f74789-c8f6-43be-b0b9-1bfa91a1d96d'),
	('00000000-0000-0000-0000-000000000000', 157, 'sypvq6jkikxx', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 18:30:25.278979+00', '2026-01-10 19:31:25.373365+00', 'bdljaaurygzl', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 158, 'sielhmjm6neb', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-10 18:54:02.8243+00', '2026-01-10 19:52:26.389198+00', 'qu2mn3lpsl4n', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 174, 'iokipg44wki7', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 11:10:23.330461+00', '2026-01-11 12:15:19.059517+00', 'ocbm3knqaytr', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 170, 'x7qhvkjv5g4z', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', true, '2026-01-11 07:50:20.406188+00', '2026-01-11 12:39:14.757071+00', 'twwwb4teuohy', 'd7e28a3f-2871-4200-94ad-0b5ca240662f'),
	('00000000-0000-0000-0000-000000000000', 176, 'e52qeohirxj2', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-11 11:26:49.981981+00', '2026-01-11 12:47:40.788117+00', '5fsprhfxqrnt', '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 175, 'aqeifxoyodda', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-11 11:15:10.481187+00', '2026-01-11 12:56:01.576265+00', 'fxxuv6diw4zg', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 159, 'xxzauxewlwbt', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-10 19:24:13.755869+00', '2026-01-11 13:20:29.428761+00', 'wj7f4cjomfzx', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 178, 'aoxw7dpvguzy', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 12:15:19.082365+00', '2026-01-11 13:27:14.500426+00', 'iokipg44wki7', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 180, 'lzth6tetltdc', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', true, '2026-01-11 12:39:14.758472+00', '2026-01-11 14:29:07.092338+00', 'x7qhvkjv5g4z', 'd7e28a3f-2871-4200-94ad-0b5ca240662f'),
	('00000000-0000-0000-0000-000000000000', 181, 'j3ipolho2f3e', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-11 12:47:40.793374+00', '2026-01-11 15:08:22.036994+00', 'e52qeohirxj2', '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 182, 'yw3k2u5p2wuk', '081d8a8a-7e87-41fb-b714-7d74065f46a0', true, '2026-01-11 12:56:01.591718+00', '2026-01-11 18:54:17.777592+00', 'aqeifxoyodda', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 184, 'x5nfrg22r35e', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 13:27:14.508721+00', '2026-01-11 14:25:27.460732+00', 'aoxw7dpvguzy', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 183, 'q74xwk7adwpa', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 13:20:29.436489+00', '2026-01-11 15:27:17.136016+00', 'xxzauxewlwbt', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 186, 'rl4hieibdqjv', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 14:25:27.485095+00', '2026-01-11 15:50:16.704434+00', 'x5nfrg22r35e', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 187, 'dlhls7mkvmwz', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', true, '2026-01-11 14:29:07.093021+00', '2026-01-11 15:53:00.840637+00', 'lzth6tetltdc', 'd7e28a3f-2871-4200-94ad-0b5ca240662f'),
	('00000000-0000-0000-0000-000000000000', 196, 'ghkwnfha32ud', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', false, '2026-01-11 15:53:00.861174+00', '2026-01-11 15:53:00.861174+00', 'dlhls7mkvmwz', 'd7e28a3f-2871-4200-94ad-0b5ca240662f'),
	('00000000-0000-0000-0000-000000000000', 192, '5bc44vkq54ko', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 15:11:20.351478+00', '2026-01-11 16:10:18.015149+00', NULL, '4f70fe08-4c21-48c0-8775-2a728e1ea7b8'),
	('00000000-0000-0000-0000-000000000000', 194, 'biweii64ixbc', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 15:27:17.151335+00', '2026-01-11 16:39:08.822487+00', 'q74xwk7adwpa', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 195, 'dvocuvh3arbz', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 15:50:16.711291+00', '2026-01-11 16:53:20.352281+00', 'rl4hieibdqjv', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 190, 'cggof4wpmxix', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-11 15:08:22.040167+00', '2026-01-11 17:32:32.993967+00', 'j3ipolho2f3e', '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 201, 'sutj5d3fxevw', '41a5fed9-1999-4a59-a20d-41e84a580fe3', false, '2026-01-11 17:32:33.009017+00', '2026-01-11 17:32:33.009017+00', 'cggof4wpmxix', '2c994ac3-49ef-4aeb-a8a4-4673a6e40cad'),
	('00000000-0000-0000-0000-000000000000', 193, 'zamwmwwlwr5u', '41a5fed9-1999-4a59-a20d-41e84a580fe3', true, '2026-01-11 15:12:56.340431+00', '2026-01-11 17:34:40.768765+00', NULL, '184c5d4e-1e9e-4b30-98b7-bf2612d41682'),
	('00000000-0000-0000-0000-000000000000', 202, 'haignyyftp4u', '41a5fed9-1999-4a59-a20d-41e84a580fe3', false, '2026-01-11 17:34:40.775924+00', '2026-01-11 17:34:40.775924+00', 'zamwmwwlwr5u', '184c5d4e-1e9e-4b30-98b7-bf2612d41682'),
	('00000000-0000-0000-0000-000000000000', 199, 'srfdanhgvase', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 16:53:20.370359+00', '2026-01-11 17:52:38.142557+00', 'dvocuvh3arbz', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 203, 'mckowkxvb6h6', '52d6f439-65c2-43be-b93b-3bce58744755', false, '2026-01-11 17:52:38.151756+00', '2026-01-11 17:52:38.151756+00', 'srfdanhgvase', '9d052c90-ec1d-479a-8496-e6b0c4927217'),
	('00000000-0000-0000-0000-000000000000', 200, 'f5agrl54trcu', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 16:56:43.929606+00', '2026-01-11 17:58:15.713672+00', NULL, '9101c156-3eec-4961-a203-6ad406700d20'),
	('00000000-0000-0000-0000-000000000000', 198, 'keffskswyzdp', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 16:39:08.839456+00', '2026-01-11 18:28:20.374515+00', 'biweii64ixbc', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 205, 'a3wohoj7fta4', '52d6f439-65c2-43be-b93b-3bce58744755', false, '2026-01-11 18:28:20.390248+00', '2026-01-11 18:28:20.390248+00', 'keffskswyzdp', '23d03f2e-08df-4c1b-af28-cf7143f5cc6c'),
	('00000000-0000-0000-0000-000000000000', 197, 'hi7x46ujnk5p', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 16:10:18.033796+00', '2026-01-11 18:41:07.78178+00', '5bc44vkq54ko', '4f70fe08-4c21-48c0-8775-2a728e1ea7b8'),
	('00000000-0000-0000-0000-000000000000', 206, 'hstgx4f2kewi', '52d6f439-65c2-43be-b93b-3bce58744755', false, '2026-01-11 18:41:07.786643+00', '2026-01-11 18:41:07.786643+00', 'hi7x46ujnk5p', '4f70fe08-4c21-48c0-8775-2a728e1ea7b8'),
	('00000000-0000-0000-0000-000000000000', 207, 'wumrfiesdspe', '081d8a8a-7e87-41fb-b714-7d74065f46a0', false, '2026-01-11 18:54:17.790504+00', '2026-01-11 18:54:17.790504+00', 'yw3k2u5p2wuk', 'c6c2cf0d-b505-453f-bdc8-24c73c63b716'),
	('00000000-0000-0000-0000-000000000000', 204, 'ndaljs3yswjz', '52d6f439-65c2-43be-b93b-3bce58744755', true, '2026-01-11 17:58:15.71974+00', '2026-01-11 18:58:41.909757+00', 'f5agrl54trcu', '9101c156-3eec-4961-a203-6ad406700d20'),
	('00000000-0000-0000-0000-000000000000', 208, 'qsfx6br2a5hp', '52d6f439-65c2-43be-b93b-3bce58744755', false, '2026-01-11 18:58:41.912899+00', '2026-01-11 18:58:41.912899+00', 'ndaljs3yswjz', '9101c156-3eec-4961-a203-6ad406700d20');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: body_weight_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."body_weight_history" ("id", "user_id", "weight", "date", "created_at") VALUES
	('2981a2cb-f618-4512-b1cd-abd4833e293a', '52d6f439-65c2-43be-b93b-3bce58744755', 102.00, '2025-06-07', '2026-01-07 14:54:40.467222+00'),
	('ae5ee654-407b-4216-8cf7-8037aa2ee400', '52d6f439-65c2-43be-b93b-3bce58744755', 92.00, '2025-11-10', '2026-01-07 14:55:08.301684+00'),
	('24ceb37c-86ae-4636-bb6a-cb7d0b96e8ad', '52d6f439-65c2-43be-b93b-3bce58744755', 89.00, '2026-01-05', '2026-01-07 14:58:21.560221+00'),
	('43581681-2cb5-4250-9c10-65f17f79ce93', '52d6f439-65c2-43be-b93b-3bce58744755', 88.00, '2026-01-07', '2026-01-07 18:49:01.551251+00'),
	('99232819-1f18-4b87-87c3-cb9da3c79546', '081d8a8a-7e87-41fb-b714-7d74065f46a0', 82.00, '2026-01-01', '2026-01-08 13:22:51.204482+00'),
	('cfd9f150-7ef8-4f6a-b25e-060fc1f73240', '081d8a8a-7e87-41fb-b714-7d74065f46a0', 79.00, '2025-12-11', '2026-01-08 13:23:26.924774+00'),
	('4705a0ac-e6ca-437c-b865-6099483c72e7', '52d6f439-65c2-43be-b93b-3bce58744755', 84.00, '2025-12-05', '2026-01-09 11:25:02.273768+00'),
	('249c5b6b-601c-4139-9e81-95c58d9c8189', '52d6f439-65c2-43be-b93b-3bce58744755', 85.00, '2026-01-09', '2026-01-09 11:24:43.595912+00'),
	('18ccdf2c-4523-4f2c-9f67-5fa0059b68b6', '081d8a8a-7e87-41fb-b714-7d74065f46a0', 81.00, '2026-01-10', '2026-01-10 19:14:12.78134+00');


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."exercises" ("id", "name", "type", "is_preset", "user_id", "created_at", "image_url", "name_translations") VALUES
	('b066fa58-0265-4c89-93d8-2b8187efbadd', 'Отжимания', 'bodyweight', true, NULL, '2026-01-07 14:25:36.340175+00', '/exercises/pushups.jpg', '{"de": "Liegestütze", "en": "Push-ups", "es": "Flexiones", "fr": "Pompes", "pt-BR": "Flexões"}'),
	('45ad8b60-d9ca-4414-8c08-15122d9c828c', 'Приседания', 'bodyweight', true, NULL, '2026-01-07 14:25:36.340175+00', '/exercises/squats.jpg', '{"de": "Kniebeugen", "en": "Squats", "es": "Sentadillas", "fr": "Squats", "pt-BR": "Agachamentos"}'),
	('972732ad-ec4d-4f38-a8f6-b76a73850079', 'Пресс', 'bodyweight', true, NULL, '2026-01-07 14:25:36.340175+00', '/exercises/abs.jpg', '{"de": "Bauchmuskel", "en": "Abs", "es": "Abdominales", "fr": "Abdos", "pt-BR": "Abdominais"}'),
	('4dd2c7cb-eacf-4a07-80ec-31e54279981c', 'Подтягивания', 'bodyweight', true, NULL, '2026-01-07 14:25:36.340175+00', '/exercises/pullups.jpg', '{"de": "Klimmzüge", "en": "Pull-ups", "es": "Dominadas", "fr": "Tractions", "pt-BR": "Barras"}'),
	('d6c2bfad-ad11-45c8-b943-2da67e9e66c5', 'Штанга лёжа', 'weighted', true, NULL, '2026-01-07 14:25:36.340175+00', '/exercises/bench-press.jpg', '{"de": "Bankdrücken", "en": "Bench Press", "es": "Press de banca", "fr": "Développé couché", "pt-BR": "Supino"}'),
	('aa301f2f-eec3-470d-9ddd-a082a67b2c39', 'Гантели Плечи', 'weighted', true, NULL, '2026-01-07 14:25:36.340175+00', '/exercises/shoulder-press.jpg', '{"de": "Schulterdrücken", "en": "Shoulder Press", "es": "Press de hombros", "fr": "Développé épaules", "pt-BR": "Desenvolvimento"}'),
	('93f83cd7-7847-47a6-a912-f6ad1e077d48', 'Гантели Бицепс', 'weighted', true, NULL, '2026-01-07 14:25:36.340175+00', '/exercises/bicep-curl.jpg', '{"de": "Bizepscurls", "en": "Bicep Curls", "es": "Curl de bíceps", "fr": "Curl biceps", "pt-BR": "Rosca bíceps"}'),
	('1c09c20d-0758-47c4-b30f-1775506f9ecf', 'Тяга на себя', 'weighted', true, NULL, '2026-01-07 15:06:09.680545+00', '/exercises/cable-row.jpg', '{"de": "Kabelrudern", "en": "Cable Row", "es": "Remo con cable", "fr": "Tirage câble", "pt-BR": "Remada"}'),
	('2f517fb3-94b8-4735-89bb-2a6af8899472', 'Бег', 'cardio', true, NULL, '2026-01-08 00:25:21.510949+00', '/exercises/run.jpg', '{"de": "Laufen", "en": "Running", "es": "Correr", "fr": "Course", "pt-BR": "Corrida"}'),
	('9a077624-b8ae-4461-927b-957c119c383a', 'Планка', 'timed', true, NULL, '2026-01-08 14:57:15.248748+00', '/exercises/planka.jpg', '{"de": "Plank", "en": "Plank", "es": "Plancha", "fr": "Planche", "pt-BR": "Prancha"}'),
	('63b3071b-4600-4391-9176-2e1efcce379d', 'Тяга верхнего блока', 'weighted', true, NULL, '2026-01-08 16:05:45.913754+00', '/exercises/lat-pulldown.jpg', '{"de": "Latzug", "en": "Lat Pulldown", "es": "Jalón al pecho", "fr": "Tirage poitrine", "pt-BR": "Puxada alta"}'),
	('ec868828-c6bf-449b-b1be-dc6511609e5b', 'Отжимания на брусьях', 'bodyweight', true, NULL, '2026-01-09 11:46:28.065743+00', '/exercises/dips.jpg', '{"de": "Dips", "en": "Dips", "es": "Fondos", "fr": "Dips", "pt-BR": "Paralelas"}'),
	('19afb3c5-c0b1-4572-aff1-7d89ce537560', 'Жим Ногами', 'weighted', true, NULL, '2026-01-07 23:40:09.09299+00', '/exercises/leg-up.jpg', '{"de": "Beinpresse", "en": "Leg Press", "es": "Prensa de piernas", "fr": "Presse à cuisses", "pt-BR": "Leg press"}');


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profiles" ("id", "user_id", "display_name", "created_at", "current_weight", "gender", "date_of_birth", "height", "avatar", "is_skuf", "is_admin") VALUES
	('c38f2028-04bd-434c-9418-30fc9275de73', '52d6f439-65c2-43be-b93b-3bce58744755', 'Илья', '2026-01-07 14:51:03.453696+00', 187.40, 'male', '1988-01-19', 6.00, '😎', 3, false),
	('be9173ed-7ca1-4a66-a7f8-80ccbee9da97', 'fa9af964-426b-4bea-bc4a-f4e4fa23260a', 'UncleSeryozha', '2026-01-07 20:09:36.678375+00', NULL, NULL, NULL, NULL, NULL, 0, false),
	('0a2b0f61-9037-4ab4-a6fb-587c5f91e30a', '41a5fed9-1999-4a59-a20d-41e84a580fe3', 'Александр', '2026-01-07 18:57:54.956184+00', 55.00, 'male', NULL, 172.00, '🏋️', 4, false),
	('8e2b7c70-1b47-406d-9a7d-3f8643d364b9', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', 'Алина', '2026-01-09 18:36:13.189942+00', 61.00, 'female', '1997-05-17', 162.00, NULL, 4, false),
	('85e43d18-1db9-495e-bcdb-291f62d2a846', '9e0b5edb-b896-4453-8d05-10ab9802533a', 'Arturs Birzgals', '2026-01-08 10:14:06.053844+00', 66.00, 'male', '1982-09-21', 184.00, '🐯', 4, false),
	('4c355620-3b67-447f-a366-03e3216745cd', '081d8a8a-7e87-41fb-b714-7d74065f46a0', 'Sergey', '2026-01-07 22:42:17.178533+00', 81.00, 'male', '1986-09-10', 186.00, '🏃', 3, false);


--
-- Data for Name: favorite_exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."favorite_exercises" ("id", "user_id", "exercise_id", "created_at") VALUES
	('f1fc1d95-fee8-407a-a283-b48900ab2e42', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '2f517fb3-94b8-4735-89bb-2a6af8899472', '2026-01-10 20:52:33.797496+00'),
	('b5d7f375-f613-44df-95d3-c4a55c616340', '52d6f439-65c2-43be-b93b-3bce58744755', 'b066fa58-0265-4c89-93d8-2b8187efbadd', '2026-01-10 21:02:30.849244+00'),
	('1ba2f040-7d47-4e7b-95c0-19b95aa5e872', '52d6f439-65c2-43be-b93b-3bce58744755', '2f517fb3-94b8-4735-89bb-2a6af8899472', '2026-01-11 10:41:56.419551+00'),
	('bb5fd0a5-e649-403d-8db4-d31353985b22', '52d6f439-65c2-43be-b93b-3bce58744755', 'ec868828-c6bf-449b-b1be-dc6511609e5b', '2026-01-11 10:41:59.538421+00');


--
-- Data for Name: friendships; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."friendships" ("id", "requester_id", "addressee_id", "status", "created_at", "updated_at") VALUES
	('726b5bff-5593-4223-b460-001a734e63b7', '52d6f439-65c2-43be-b93b-3bce58744755', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', 'accepted', '2026-01-11 12:46:26.537001+00', '2026-01-11 12:46:44.66987+00'),
	('444c6281-df66-40be-b71f-e8a7c97557c2', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '52d6f439-65c2-43be-b93b-3bce58744755', 'accepted', '2026-01-11 12:56:15.748105+00', '2026-01-11 12:56:43.569845+00'),
	('a88fb677-8ec7-4feb-9ddf-07b2e5f33681', '52d6f439-65c2-43be-b93b-3bce58744755', '41a5fed9-1999-4a59-a20d-41e84a580fe3', 'accepted', '2026-01-11 15:06:08.953909+00', '2026-01-11 15:11:39.963203+00'),
	('c1efeecf-8a5d-4f15-87f1-d3f29e2b1458', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '081d8a8a-7e87-41fb-b714-7d74065f46a0', 'accepted', '2026-01-11 15:06:12.999527+00', '2026-01-11 18:54:27.200842+00');


--
-- Data for Name: workouts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."workouts" ("id", "user_id", "date", "notes", "created_at", "updated_at", "photo_url", "is_locked") VALUES
	('4277dc22-9916-43c7-98bf-97f5f7baaf06', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-11', 'Biggest update', '2026-01-11 18:36:04.884377+00', '2026-01-11 18:36:55.662299+00', NULL, false),
	('94bb9431-5814-4b82-b519-0ba783f884da', '9e0b5edb-b896-4453-8d05-10ab9802533a', '2026-01-08', NULL, '2026-01-08 10:15:46.526342+00', '2026-01-08 10:15:46.526342+00', NULL, false),
	('486333c5-42a6-41c2-8992-03d5d6de0efa', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-05', 'Табата 1 час. Жость', '2026-01-07 22:22:57.722643+00', '2026-01-10 20:15:01.057902+00', 'https://gjcbspomrqajtkjfevsf.supabase.co/storage/v1/object/public/workout-photos/52d6f439-65c2-43be-b93b-3bce58744755/486333c5-42a6-41c2-8992-03d5d6de0efa/1767911406979.jpg', true),
	('3931377b-5785-4a1a-8ace-e1c3632ed033', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-06', 'После Табаты было тяжко', '2026-01-07 22:06:34.358008+00', '2026-01-11 10:16:51.311954+00', 'https://gjcbspomrqajtkjfevsf.supabase.co/storage/v1/object/public/workout-photos/52d6f439-65c2-43be-b93b-3bce58744755/3931377b-5785-4a1a-8ace-e1c3632ed033/1767911323715.jpg', true),
	('422ce788-35e1-4c4c-ae1f-1637a1f4ac22', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '2026-01-07', 'Готово :)', '2026-01-07 22:45:53.055152+00', '2026-01-10 20:12:43.267244+00', NULL, true),
	('d8b01620-8743-464c-966f-749346aae4d8', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-10', 'Норм идёт сегодня . Саня заболел жаль, Артур не перезвонил  :(. Зажигаем с Серёгой', '2026-01-10 12:44:31.843307+00', '2026-01-11 16:26:58.57535+00', 'https://gjcbspomrqajtkjfevsf.supabase.co/storage/v1/object/public/workout-photos/52d6f439-65c2-43be-b93b-3bce58744755/d8b01620-8743-464c-966f-749346aae4d8/1768060133324.jpg', true),
	('75da55cb-7cd8-411e-a5c6-25d7acd12104', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-09', 'Пока улучшаю апп, немного занимаюсь параллельно', '2026-01-09 10:54:37.293298+00', '2026-01-10 20:13:14.028994+00', 'https://gjcbspomrqajtkjfevsf.supabase.co/storage/v1/object/public/workout-photos/52d6f439-65c2-43be-b93b-3bce58744755/75da55cb-7cd8-411e-a5c6-25d7acd12104/1767959547345.jpg', true),
	('2e71a931-9dee-4ad7-973a-b4419a94a519', 'ae2055a8-1bbe-4326-b366-5a6dbc8a4148', '2026-01-08', NULL, '2026-01-09 18:37:28.549111+00', '2026-01-09 18:37:28.549111+00', NULL, false),
	('d1d005a5-5f1c-43e2-9581-675748ef8abe', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '2026-01-08', 'ьыло слова', '2026-01-08 16:35:00.665189+00', '2026-01-11 11:37:36.59492+00', 'https://gjcbspomrqajtkjfevsf.supabase.co/storage/v1/object/public/workout-photos/41a5fed9-1999-4a59-a20d-41e84a580fe3/d1d005a5-5f1c-43e2-9581-675748ef8abe/1768131454232.jpg', false),
	('64c39589-9270-4a9d-aa69-57e0dc0f1c59', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '2026-01-10', NULL, '2026-01-10 15:16:37.501157+00', '2026-01-10 20:31:53.664645+00', NULL, true),
	('575c0313-8551-4b4b-ba24-a9a72c401ce0', '081d8a8a-7e87-41fb-b714-7d74065f46a0', '2026-01-09', NULL, '2026-01-09 14:41:19.541933+00', '2026-01-10 20:14:07.068252+00', NULL, true),
	('ee1718a8-7736-4de5-a289-ea04331d79d9', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08', 'Жим ногами делал 110кг , сделал легко но голова закружилась в глазах потемнело', '2026-01-08 00:26:04.990442+00', '2026-01-11 15:57:04.057532+00', 'https://gjcbspomrqajtkjfevsf.supabase.co/storage/v1/object/public/workout-photos/52d6f439-65c2-43be-b93b-3bce58744755/ee1718a8-7736-4de5-a289-ea04331d79d9/1767909503672.jpg', true),
	('caeaf8a0-5b8c-4eff-85e7-35896c04471d', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-03', NULL, '2026-01-08 10:37:13.577685+00', '2026-01-11 15:57:31.711305+00', 'https://gjcbspomrqajtkjfevsf.supabase.co/storage/v1/object/public/workout-photos/52d6f439-65c2-43be-b93b-3bce58744755/caeaf8a0-5b8c-4eff-85e7-35896c04471d/1767911433619.jpg', true);


--
-- Data for Name: workout_sets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."workout_sets" ("id", "workout_id", "exercise_id", "set_number", "reps", "weight", "created_at", "distance_km", "duration_minutes", "plank_seconds") VALUES
	('de94ce63-212f-4d37-89b7-2a63eefb7b9e', '3931377b-5785-4a1a-8ace-e1c3632ed033', '972732ad-ec4d-4f38-a8f6-b76a73850079', 1, 50, NULL, '2026-01-08 16:00:50.373243+00', NULL, NULL, NULL),
	('d4b0062d-1422-441c-9e65-6047f45e8ae5', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-08 16:35:20.921355+00', 3.36, 30, NULL),
	('807a45bd-38c5-4c99-baed-e32ee48b1f6e', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 1, 8, 30.00, '2026-01-08 17:33:52.911403+00', NULL, NULL, NULL),
	('18a6300e-b69c-4938-8feb-5828a1f30f78', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 2, 8, 70.00, '2026-01-08 17:34:48.098856+00', NULL, NULL, NULL),
	('5f1c11c6-3007-4882-a1c6-03b484ef7154', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 2, 8, 50.00, '2026-01-08 17:36:01.324141+00', NULL, NULL, NULL),
	('70432900-4de7-444d-9dee-062786c439d5', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 3, 10, 110.00, '2026-01-08 17:40:25.946069+00', NULL, NULL, NULL),
	('72a5a40a-f7d7-40fa-9d99-547795b39cee', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 1, 8, 30.00, '2026-01-08 17:47:48.217279+00', NULL, NULL, NULL),
	('09715328-3a07-46f4-9516-d0ed388cee77', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 2, 8, 35.00, '2026-01-08 17:53:22.995789+00', NULL, NULL, NULL),
	('b8dde32f-9810-4875-aa07-c7111fd60861', 'ee1718a8-7736-4de5-a289-ea04331d79d9', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 2, 8, 60.00, '2026-01-08 17:59:44.611882+00', NULL, NULL, NULL),
	('9c4156e5-d871-4d0f-801f-245fe46f5ef1', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 3, 2, 40.00, '2026-01-08 18:01:50.334623+00', NULL, NULL, NULL),
	('7ad9c2a9-ba78-4b37-bf67-0994a83ea382', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 1, 12, NULL, '2026-01-08 18:16:31.728396+00', NULL, NULL, NULL),
	('5c3f460b-c5f1-445f-90e1-2db41cbf37e5', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 2, 6, NULL, '2026-01-08 18:18:01.278781+00', NULL, NULL, NULL),
	('14348bd1-0bf1-4c6c-b49e-bf5d844aefde', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 2, 9, NULL, '2026-01-08 18:22:17.600223+00', NULL, NULL, NULL),
	('28c6804b-5c30-4415-bf83-9b0e8f9d24d6', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 3, 5, NULL, '2026-01-08 18:22:38.637017+00', NULL, NULL, NULL),
	('13a7f292-c2d0-4e3e-b15b-b8ff908dd475', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 3, 4, NULL, '2026-01-08 18:24:58.587183+00', NULL, NULL, NULL),
	('aa289776-a98f-4202-b2d6-9cfade275e57', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '972732ad-ec4d-4f38-a8f6-b76a73850079', 1, 55, NULL, '2026-01-08 18:30:55.909935+00', NULL, NULL, NULL),
	('b907145a-f7ac-4223-a5c7-ede477823411', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '972732ad-ec4d-4f38-a8f6-b76a73850079', 1, 47, NULL, '2026-01-08 18:30:57.910701+00', NULL, NULL, NULL),
	('cf235e97-3a8f-4078-83e2-e44be14807de', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '972732ad-ec4d-4f38-a8f6-b76a73850079', 2, 50, NULL, '2026-01-08 18:38:45.729595+00', NULL, NULL, NULL),
	('d898502c-7058-487e-84fd-80e454f533a4', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '972732ad-ec4d-4f38-a8f6-b76a73850079', 2, 21, NULL, '2026-01-08 18:39:02.237653+00', NULL, NULL, NULL),
	('ba9174b2-3992-4bc3-8cef-6fec81f4c5cf', '3931377b-5785-4a1a-8ace-e1c3632ed033', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 1, 6, NULL, '2026-01-07 22:08:20.994198+00', NULL, NULL, NULL),
	('3b702320-a147-4fb0-b4bb-b4166955af04', '3931377b-5785-4a1a-8ace-e1c3632ed033', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 1, 8, 14.00, '2026-01-07 22:09:57.138972+00', NULL, NULL, NULL),
	('1877541d-cce9-4374-909a-688a026ba22f', '3931377b-5785-4a1a-8ace-e1c3632ed033', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 2, 10, 18.00, '2026-01-07 22:10:13.251203+00', NULL, NULL, NULL),
	('89f78264-5e60-4b87-8b21-921015e7f231', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '972732ad-ec4d-4f38-a8f6-b76a73850079', 3, 40, NULL, '2026-01-08 18:45:20.409345+00', NULL, NULL, NULL),
	('96e8c57c-4245-45fd-bd7c-0140b26a9439', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '9a077624-b8ae-4461-927b-957c119c383a', 1, NULL, NULL, '2026-01-08 18:53:42.336815+00', NULL, NULL, 195),
	('88ad89e7-47c6-4815-897a-db39c20d1f98', 'd1d005a5-5f1c-43e2-9581-675748ef8abe', '9a077624-b8ae-4461-927b-957c119c383a', 1, NULL, NULL, '2026-01-08 18:54:05.045431+00', NULL, NULL, 210),
	('f8600b11-bd67-4e18-85e9-1a3f06470dee', '3931377b-5785-4a1a-8ace-e1c3632ed033', '93f83cd7-7847-47a6-a912-f6ad1e077d48', 1, 8, 14.00, '2026-01-08 23:29:44.079953+00', NULL, NULL, NULL),
	('ba92792e-05bf-4f5c-84ea-6aa8af46f575', '3931377b-5785-4a1a-8ace-e1c3632ed033', '93f83cd7-7847-47a6-a912-f6ad1e077d48', 2, 8, 16.00, '2026-01-08 23:30:03.267415+00', NULL, NULL, NULL),
	('12d650b1-2651-423f-becf-4def1f636eaa', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-08 17:25:19.536579+00', 5.20, 38, NULL),
	('3ed725e7-caf3-4c3b-aca1-2617179534c8', '3931377b-5785-4a1a-8ace-e1c3632ed033', '93f83cd7-7847-47a6-a912-f6ad1e077d48', 3, 3, 20.00, '2026-01-08 23:30:23.123364+00', NULL, NULL, NULL),
	('64242c59-6980-4188-82b9-4a4aba89a5a7', '3931377b-5785-4a1a-8ace-e1c3632ed033', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 3, 9, 20.00, '2026-01-07 22:20:02.161318+00', NULL, NULL, NULL),
	('9d318732-2836-48a7-ab78-a4b4e295b3b1', '486333c5-42a6-41c2-8992-03d5d6de0efa', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 1, 10, NULL, '2026-01-07 22:36:02.672791+00', NULL, NULL, NULL),
	('b51ae1f0-3a98-42b2-9c00-3e684d309dd5', '486333c5-42a6-41c2-8992-03d5d6de0efa', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 2, 10, NULL, '2026-01-07 22:36:07.157303+00', NULL, NULL, NULL),
	('dc6b446a-2922-4e6c-9388-b364ab9c8151', '486333c5-42a6-41c2-8992-03d5d6de0efa', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 3, 10, NULL, '2026-01-07 22:36:10.199937+00', NULL, NULL, NULL),
	('73a79f45-9aae-4397-ab02-e62e410209ee', '486333c5-42a6-41c2-8992-03d5d6de0efa', '45ad8b60-d9ca-4414-8c08-15122d9c828c', 1, 10, NULL, '2026-01-07 22:36:29.121413+00', NULL, NULL, NULL),
	('287d73b5-4d79-42e4-b150-43866bbd0bdf', '486333c5-42a6-41c2-8992-03d5d6de0efa', '45ad8b60-d9ca-4414-8c08-15122d9c828c', 2, 10, NULL, '2026-01-07 22:36:33.138114+00', NULL, NULL, NULL),
	('0c9bb9a2-c79b-4754-8107-44542d0d5771', '486333c5-42a6-41c2-8992-03d5d6de0efa', '45ad8b60-d9ca-4414-8c08-15122d9c828c', 3, 10, NULL, '2026-01-07 22:36:35.637262+00', NULL, NULL, NULL),
	('17bbede4-ebab-45b4-8474-c452ef5d806e', '575c0313-8551-4b4b-ba24-a9a72c401ce0', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-09 14:41:30.486386+00', 6.40, 42, NULL),
	('318b526b-8774-4c56-8d6d-5f5ff385db8f', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 2, 10, 50.00, '2026-01-07 22:47:05.407855+00', NULL, NULL, NULL),
	('40160fae-dc91-465f-81de-9280f09743b8', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 1, 8, 40.00, '2026-01-07 22:49:15.853297+00', NULL, NULL, NULL),
	('9c01b8c8-2fd7-4c0b-9252-9d8adf856fac', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 2, 8, 55.00, '2026-01-07 22:50:38.471305+00', NULL, NULL, NULL),
	('fe22b6e1-aeca-4dc1-8a03-7b24304dffc5', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 3, 8, 55.00, '2026-01-07 22:50:52.3442+00', NULL, NULL, NULL),
	('ceb6dd5f-aa56-4280-974c-26299e0f7cea', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 1, 8, 16.00, '2026-01-07 22:51:19.754368+00', NULL, NULL, NULL),
	('00c7d19a-f195-40e3-b30b-021c7d7be951', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 2, 8, 16.00, '2026-01-07 22:51:36.533398+00', NULL, NULL, NULL),
	('5ac1b9af-1323-4444-a377-617bf85070ed', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 2, 8, 42.00, '2026-01-07 22:52:41.44244+00', NULL, NULL, NULL),
	('e3e24e54-eae5-4858-9003-77adf9e4d57e', '3931377b-5785-4a1a-8ace-e1c3632ed033', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 1, 8, 40.00, '2026-01-07 22:07:21.981061+00', NULL, NULL, NULL),
	('e7972b8f-34fe-485c-9d47-ac6be7d540fc', '3931377b-5785-4a1a-8ace-e1c3632ed033', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 3, 3, 70.00, '2026-01-07 22:07:49.641687+00', NULL, NULL, NULL),
	('62bcfb25-6749-4809-8795-ac115c9e44ea', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 4, 4, NULL, '2026-01-08 10:37:35.700476+00', NULL, NULL, NULL),
	('f5b646b8-52c8-4f88-b5ab-e0f631fd06c7', '3931377b-5785-4a1a-8ace-e1c3632ed033', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 2, 8, 60.00, '2026-01-07 22:07:41.514467+00', NULL, NULL, NULL),
	('df650e13-40ee-4ced-9aff-c733b52d9af1', '575c0313-8551-4b4b-ba24-a9a72c401ce0', '9a077624-b8ae-4461-927b-957c119c383a', 1, NULL, NULL, '2026-01-09 14:45:23.71497+00', NULL, NULL, 45),
	('ac5f00b1-9e14-4bc3-847c-a26492dcad0a', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 5, 5, NULL, '2026-01-08 10:37:37.163196+00', NULL, NULL, NULL),
	('871714d9-d8b6-4df9-a294-cb4f2e85ad84', 'ee1718a8-7736-4de5-a289-ea04331d79d9', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 1, 30, NULL, '2026-01-08 00:26:13.916295+00', NULL, NULL, NULL),
	('bf0d5c77-e7a1-475d-b75a-ffb048a34526', '3931377b-5785-4a1a-8ace-e1c3632ed033', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-08 00:26:41.843545+00', 5.00, 38, NULL),
	('4c1b653e-158e-48fe-8a1f-8b4eefbb6698', 'ee1718a8-7736-4de5-a289-ea04331d79d9', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 2, 30, NULL, '2026-01-08 09:58:08.672552+00', NULL, NULL, NULL),
	('de551b0f-4809-46aa-a353-9313a9f710a3', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 1, 1, NULL, '2026-01-08 10:37:30.132872+00', NULL, NULL, NULL),
	('0ec08402-4c94-48ff-a9ec-622e38b4ff7b', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 2, 2, NULL, '2026-01-08 10:37:32.577437+00', NULL, NULL, NULL),
	('94d92009-4e05-4f0a-b8f0-70929a7f33b2', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 3, 3, NULL, '2026-01-08 10:37:34.154984+00', NULL, NULL, NULL),
	('f37d3de1-b125-498d-8ab5-d22a25c0b6dc', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 6, 4, NULL, '2026-01-08 10:37:38.632047+00', NULL, NULL, NULL),
	('6c2c0c47-da42-42dc-b95a-a68f179fecc0', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 7, 3, NULL, '2026-01-08 10:37:40.069912+00', NULL, NULL, NULL),
	('b43db4b3-48f4-468f-9d26-5d2892a871c4', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 8, 2, NULL, '2026-01-08 10:37:41.614564+00', NULL, NULL, NULL),
	('397dc4c4-cb5b-408d-a574-1d98938aed37', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 9, 1, NULL, '2026-01-08 10:37:43.198528+00', NULL, NULL, NULL),
	('3802c041-a754-4f47-a523-20aaf46933f2', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '972732ad-ec4d-4f38-a8f6-b76a73850079', 1, 50, NULL, '2026-01-08 10:38:13.540196+00', NULL, NULL, NULL),
	('10cf6289-bc1b-40bc-9dd0-8fe499720b4e', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-08 10:38:23.426227+00', 5.00, 40, NULL),
	('5d52ccc5-82c7-4c12-8a6f-7dec2720e79a', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 1, 8, 40.00, '2026-01-08 10:39:07.650931+00', NULL, NULL, NULL),
	('733df703-6416-4fb7-8bd6-feb16d63d193', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 2, 8, 80.00, '2026-01-08 10:39:19.259308+00', NULL, NULL, NULL),
	('7df9daad-a4ca-4c14-ae79-96ca230e4954', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 3, 8, 100.00, '2026-01-08 10:39:27.546013+00', NULL, NULL, NULL),
	('4abb94db-1767-476f-a920-ea1b81ae365f', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 1, 8, 40.00, '2026-01-08 10:40:17.849782+00', NULL, NULL, NULL),
	('2e3a8b02-f888-4256-b16c-d64155895167', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 2, 6, 60.00, '2026-01-08 10:40:31.299653+00', NULL, NULL, NULL),
	('43259b01-2247-4485-a77b-82ac0599e646', 'caeaf8a0-5b8c-4eff-85e7-35896c04471d', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 3, 1, 70.00, '2026-01-08 10:40:39.066284+00', NULL, NULL, NULL),
	('d8ea9dc4-3b89-47df-8d49-a69a3dc1c3da', '575c0313-8551-4b4b-ba24-a9a72c401ce0', '9a077624-b8ae-4461-927b-957c119c383a', 2, NULL, NULL, '2026-01-09 14:47:23.15988+00', NULL, NULL, 45),
	('95df5cfd-e528-4593-b1be-ef3739daa348', '575c0313-8551-4b4b-ba24-a9a72c401ce0', '9a077624-b8ae-4461-927b-957c119c383a', 3, NULL, NULL, '2026-01-09 14:49:16.215428+00', NULL, NULL, 45),
	('8624e275-513a-4690-8584-9fa0675bada8', '575c0313-8551-4b4b-ba24-a9a72c401ce0', '972732ad-ec4d-4f38-a8f6-b76a73850079', 1, 20, NULL, '2026-01-09 14:50:20.896564+00', NULL, NULL, NULL),
	('35bb51bb-619a-40c1-ab84-1b66d0a69a07', '75da55cb-7cd8-411e-a5c6-25d7acd12104', 'ec868828-c6bf-449b-b1be-dc6511609e5b', 1, 8, NULL, '2026-01-09 11:48:32.967111+00', NULL, NULL, NULL),
	('c4afc608-fda5-4345-b5d2-d1546a9e886f', 'ee1718a8-7736-4de5-a289-ea04331d79d9', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 3, 2, 70.00, '2026-01-08 18:08:02.226551+00', NULL, NULL, NULL),
	('c4eb364e-3637-43df-aa54-23cacd0d8b84', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 1, 9, NULL, '2026-01-08 18:11:56.797896+00', NULL, NULL, NULL),
	('5bf80ddd-6e4d-4e4d-b16a-4d0f73f4e0d4', '422ce788-35e1-4c4c-ae1f-1637a1f4ac22', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-08 13:39:24.008557+00', 6.40, 42, NULL),
	('4a385bf3-f1c7-4180-b130-4b89a20aa51d', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 1, 8, 40.00, '2026-01-08 17:31:39.615631+00', NULL, NULL, NULL),
	('39037a10-2c09-4d61-8697-fd29e3288626', 'ee1718a8-7736-4de5-a289-ea04331d79d9', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 1, 8, 50.00, '2026-01-08 17:50:31.005095+00', NULL, NULL, NULL),
	('e2b429d2-c28c-421e-9c54-0abce38b9cb6', '575c0313-8551-4b4b-ba24-a9a72c401ce0', '972732ad-ec4d-4f38-a8f6-b76a73850079', 2, 20, NULL, '2026-01-09 14:51:39.853524+00', NULL, NULL, NULL),
	('408d5faa-ed1f-49ac-9240-8a18b2fd6afb', '75da55cb-7cd8-411e-a5c6-25d7acd12104', '9a077624-b8ae-4461-927b-957c119c383a', 1, NULL, NULL, '2026-01-09 17:03:55.942562+00', NULL, NULL, 90),
	('b88feac8-0a50-43de-be0d-1d8220d5167b', '75da55cb-7cd8-411e-a5c6-25d7acd12104', 'ec868828-c6bf-449b-b1be-dc6511609e5b', 2, 8, NULL, '2026-01-09 17:04:29.149308+00', NULL, NULL, NULL),
	('1cd81db5-eec3-47fc-a2ad-ad4ec70fbf0a', '75da55cb-7cd8-411e-a5c6-25d7acd12104', '972732ad-ec4d-4f38-a8f6-b76a73850079', 2, 20, NULL, '2026-01-09 20:20:11.638909+00', NULL, NULL, NULL),
	('50677b3f-9665-4f22-9125-e8592bf16270', 'd8b01620-8743-464c-966f-749346aae4d8', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-10 15:16:19.314853+00', 6.35, 41, NULL),
	('c0372551-5e31-49e5-8f09-7503a5fb3499', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '2f517fb3-94b8-4735-89bb-2a6af8899472', 1, NULL, NULL, '2026-01-10 15:16:48.031808+00', 5.60, 36, NULL),
	('1e8f4e82-836e-4ffe-953a-2d8a2de9fb07', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 1, 10, 45.00, '2026-01-10 15:19:56.471603+00', NULL, NULL, NULL),
	('1d0d17d5-2afb-4113-9e2c-1200285bd665', 'd8b01620-8743-464c-966f-749346aae4d8', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 1, 30, NULL, '2026-01-10 12:44:42.343797+00', NULL, NULL, NULL),
	('c89e008d-9be2-4895-8b51-5dc84870b6dc', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 2, 10, 50.00, '2026-01-10 15:23:09.501623+00', NULL, NULL, NULL),
	('af92d66d-538d-4c15-a97b-b5f660ceb1fa', 'd8b01620-8743-464c-966f-749346aae4d8', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 2, 10, 50.00, '2026-01-10 15:23:45.004986+00', NULL, NULL, NULL),
	('2b555630-f58f-4f52-9d1a-d3b4f5807e16', '75da55cb-7cd8-411e-a5c6-25d7acd12104', '972732ad-ec4d-4f38-a8f6-b76a73850079', 1, 30, NULL, '2026-01-09 17:34:41.54555+00', NULL, NULL, NULL),
	('bb78ebf9-d079-4e6e-af9f-67d13ae3a32a', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 3, 8, 50.00, '2026-01-10 15:26:13.74303+00', NULL, NULL, NULL),
	('dc393478-d916-42d1-8d07-69787cf8f90e', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 1, 8, 40.00, '2026-01-10 15:33:09.437585+00', NULL, NULL, NULL),
	('f1977ada-a000-47a1-95a8-e1fe1746f6eb', 'd8b01620-8743-464c-966f-749346aae4d8', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 1, 8, 40.00, '2026-01-10 15:33:49.06807+00', NULL, NULL, NULL),
	('f093025d-55fe-40a5-a9e3-d6a5cdf7b042', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 2, 5, 60.00, '2026-01-10 15:35:45.073082+00', NULL, NULL, NULL),
	('7b14e303-1148-43ac-8277-ffe97a045500', 'd8b01620-8743-464c-966f-749346aae4d8', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 2, 8, 60.00, '2026-01-10 15:38:47.723171+00', NULL, NULL, NULL),
	('6d660a98-79a7-417e-bffd-13aab3c8889c', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 3, 2, 65.00, '2026-01-10 15:42:30.614586+00', NULL, NULL, NULL),
	('5eaa6c88-4c2e-462d-8b61-1e15bd3a8731', 'd8b01620-8743-464c-966f-749346aae4d8', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 3, 4, 65.00, '2026-01-10 15:43:37.816822+00', NULL, NULL, NULL),
	('8c9761ca-408f-48dc-9853-18a3a92ffee8', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 4, 1, 70.00, '2026-01-10 15:48:20.356251+00', NULL, NULL, NULL),
	('b9fabe56-be90-4009-8095-4acd0c58dda5', 'd8b01620-8743-464c-966f-749346aae4d8', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 4, 1, 70.00, '2026-01-10 15:50:38.467493+00', NULL, NULL, NULL),
	('db75031a-7590-44db-8c6d-8db3fa5d870f', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 5, 1, 75.00, '2026-01-10 15:58:48.276232+00', NULL, NULL, NULL),
	('7aa89e3c-4f10-4eab-a556-779afed3588f', 'd8b01620-8743-464c-966f-749346aae4d8', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 5, 1, 75.00, '2026-01-10 15:59:54.792316+00', NULL, NULL, NULL),
	('f12e776a-ed97-491b-a6b7-3644d8a38d48', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 6, 1, 75.00, '2026-01-10 16:06:30.205596+00', NULL, NULL, NULL),
	('7f7d1cdf-d02d-4676-94b2-a9f62b25380d', 'd8b01620-8743-464c-966f-749346aae4d8', 'd6c2bfad-ad11-45c8-b943-2da67e9e66c5', 6, 2, 70.00, '2026-01-10 16:08:02.157743+00', NULL, NULL, NULL),
	('abd2ef94-be35-4455-90c4-f9a6c826e314', '75da55cb-7cd8-411e-a5c6-25d7acd12104', 'ec868828-c6bf-449b-b1be-dc6511609e5b', 3, 8, NULL, '2026-01-09 17:12:18.725899+00', NULL, NULL, NULL),
	('e318ce16-4688-4c3b-81ad-e928062ce272', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 1, 10, 40.00, '2026-01-10 16:11:22.727347+00', NULL, NULL, NULL),
	('3787e3d2-ad32-4700-9659-124047c91e92', 'd8b01620-8743-464c-966f-749346aae4d8', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 1, 8, 80.00, '2026-01-10 16:13:39.945168+00', NULL, NULL, NULL),
	('858094a7-273c-4bb2-99a2-1c62ae357188', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 2, 15, 60.00, '2026-01-10 16:14:32.209792+00', NULL, NULL, NULL),
	('866ffb18-5055-48db-bdf1-a3c04dce97bb', 'd8b01620-8743-464c-966f-749346aae4d8', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 2, 10, 100.00, '2026-01-10 16:18:30.117682+00', NULL, NULL, NULL),
	('f3184c58-05f3-484e-92c8-e22cbb0b04f8', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 3, 10, 80.00, '2026-01-10 16:20:59.072311+00', NULL, NULL, NULL),
	('d1d616b9-7df0-493f-a8c3-42c0c14b78a6', 'd8b01620-8743-464c-966f-749346aae4d8', '19afb3c5-c0b1-4572-aff1-7d89ce537560', 3, 8, 120.00, '2026-01-10 16:23:03.586339+00', NULL, NULL, NULL),
	('1eaae5a1-8e61-42c9-b35a-3f1e28eb2990', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 1, 10, 16.00, '2026-01-10 16:26:00.841419+00', NULL, NULL, NULL),
	('389db0fd-51ed-41b9-9dd7-df7fc53c44b0', '75da55cb-7cd8-411e-a5c6-25d7acd12104', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 1, 20, NULL, '2026-01-09 10:54:47.647782+00', NULL, NULL, NULL),
	('fa316a76-15d4-4b7b-8c64-05e32d3f099c', 'd8b01620-8743-464c-966f-749346aae4d8', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 1, 10, 16.00, '2026-01-10 16:27:40.707741+00', NULL, NULL, NULL),
	('5cb6ed25-c471-4bd5-afaa-6822cc8664da', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 2, 12, 16.00, '2026-01-10 16:28:40.49736+00', NULL, NULL, NULL),
	('8eaea6e9-93b0-430c-b5bd-877608817a3d', 'd8b01620-8743-464c-966f-749346aae4d8', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 2, 12, 18.00, '2026-01-10 16:30:08.740756+00', NULL, NULL, NULL),
	('249797ea-ac4a-4cc5-ab63-e6f860b5f989', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 1, 3, NULL, '2026-01-10 16:35:44.334787+00', NULL, NULL, NULL),
	('5af01e74-7873-4016-9a19-64b90efe88d8', 'd8b01620-8743-464c-966f-749346aae4d8', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 2, 5, NULL, '2026-01-10 16:46:08.114948+00', NULL, NULL, NULL),
	('157f7b3b-901c-4f5d-a804-78d5e04d1360', 'd8b01620-8743-464c-966f-749346aae4d8', 'b066fa58-0265-4c89-93d8-2b8187efbadd', 2, 20, NULL, '2026-01-10 21:02:50.344897+00', NULL, NULL, NULL),
	('e8f59d5b-1bf5-4f98-9899-59cdf091e900', 'd8b01620-8743-464c-966f-749346aae4d8', '972732ad-ec4d-4f38-a8f6-b76a73850079', 2, 30, NULL, '2026-01-10 16:45:04.560215+00', NULL, NULL, NULL),
	('c9dfe1ac-fe2e-4492-97d7-e7ff81eb9b33', 'd8b01620-8743-464c-966f-749346aae4d8', '972732ad-ec4d-4f38-a8f6-b76a73850079', 1, 70, NULL, '2026-01-10 16:39:20.464568+00', NULL, NULL, NULL),
	('c9d0d49c-0cce-4b7d-b7c3-c263215fd03e', 'd8b01620-8743-464c-966f-749346aae4d8', '4dd2c7cb-eacf-4a07-80ec-31e54279981c', 1, 7, NULL, '2026-01-10 16:35:40.695189+00', NULL, NULL, NULL),
	('28f51d5e-e909-46f0-84fc-68c66d524788', 'd8b01620-8743-464c-966f-749346aae4d8', 'aa301f2f-eec3-470d-9ddd-a082a67b2c39', 3, 8, 20.00, '2026-01-10 16:32:43.077497+00', NULL, NULL, NULL),
	('cd1a2b89-dcc6-4251-b809-468b9b503a42', 'd8b01620-8743-464c-966f-749346aae4d8', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 3, 8, 55.00, '2026-01-10 15:25:52.915442+00', NULL, NULL, NULL),
	('e748174d-82bf-40c3-b97f-3999c1d35c3a', 'd8b01620-8743-464c-966f-749346aae4d8', '1c09c20d-0758-47c4-b30f-1775506f9ecf', 1, 10, 45.00, '2026-01-10 15:20:53.343464+00', NULL, NULL, NULL),
	('2fcb1866-ab5e-4886-b643-9dd25f2e25b2', '4277dc22-9916-43c7-98bf-97f5f7baaf06', 'ec868828-c6bf-449b-b1be-dc6511609e5b', 1, 10, NULL, '2026-01-11 18:36:37.192305+00', NULL, NULL, NULL);


--
-- Data for Name: workout_shares; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."workout_shares" ("id", "workout_id", "user_id", "share_token", "is_active", "created_at") VALUES
	('84074acb-f104-46d2-a1c3-3f6580a0440b', '64c39589-9270-4a9d-aa69-57e0dc0f1c59', '081d8a8a-7e87-41fb-b714-7d74065f46a0', 'f1cda10d5f69295fbc64ea7f2d8d6f17c6c2303c00df1f324fce9ac93a4b785d', true, '2026-01-10 19:20:44.674698+00'),
	('3002609c-cddc-451a-bffa-faa1fd449527', '75da55cb-7cd8-411e-a5c6-25d7acd12104', '52d6f439-65c2-43be-b93b-3bce58744755', '052ccf600094d3b0622b7676687f6c135d50bfa94a775e9bd90539fbfe10cf65', false, '2026-01-10 20:24:57.482868+00'),
	('04666754-daea-4811-977c-92e576b80f98', 'ee1718a8-7736-4de5-a289-ea04331d79d9', '52d6f439-65c2-43be-b93b-3bce58744755', 'f7230d3cdf2237f0b8eef9e0c679059960682a436f2abc48e4df0ae4e11d7783', true, '2026-01-10 20:25:10.296816+00'),
	('a1a7cc09-d684-4a8a-8654-5f62570f9833', 'd8b01620-8743-464c-966f-749346aae4d8', '52d6f439-65c2-43be-b93b-3bce58744755', 'b7a48ea4073cd0e1a87dcab99fc6fe8b0f556ec8072c2bfd780e8b046fff283f', false, '2026-01-10 19:14:34.329385+00'),
	('0056c4f1-55be-460a-bf4d-feffe447a78a', 'd8b01620-8743-464c-966f-749346aae4d8', '52d6f439-65c2-43be-b93b-3bce58744755', 'b0ab4a4a4c295064538adc30438980c9dd16b1705149789eafc033e1c32d237d', true, '2026-01-11 14:46:51.980946+00');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") VALUES
	('workout-photos', 'workout-photos', NULL, '2026-01-08 21:52:12.659875+00', '2026-01-08 21:52:12.659875+00', true, false, NULL, NULL, NULL, 'STANDARD');


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata", "level") VALUES
	('b4a91093-353c-4b56-a1ba-6d4170525bfd', 'workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/ee1718a8-7736-4de5-a289-ea04331d79d9/1767909503672.jpg', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 21:58:24.553585+00', '2026-01-08 21:58:24.553585+00', '2026-01-08 21:58:24.553585+00', '{"eTag": "\"9684c4c8892d90a470419ec9e5ab76e8\"", "size": 100497, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-08T21:58:25.000Z", "contentLength": 100497, "httpStatusCode": 200}', 'ac9a9285-9eae-4d1c-be81-4b5f2db4e898', '52d6f439-65c2-43be-b93b-3bce58744755', '{}', 3),
	('49390794-8275-4ec9-ad72-729e6ed2ea28', 'workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/3931377b-5785-4a1a-8ace-e1c3632ed033/1767911323715.jpg', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 22:28:44.738985+00', '2026-01-08 22:28:44.738985+00', '2026-01-08 22:28:44.738985+00', '{"eTag": "\"95d1ed0dfebef7156a02513418f06ca2\"", "size": 47962, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-08T22:28:45.000Z", "contentLength": 47962, "httpStatusCode": 200}', '61b77bf1-4621-4a1a-81f0-717773d66252', '52d6f439-65c2-43be-b93b-3bce58744755', '{}', 3),
	('0b6203ce-2e33-42a2-9ac3-8f5e6a9bfb85', 'workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/486333c5-42a6-41c2-8992-03d5d6de0efa/1767911406979.jpg', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 22:30:07.817363+00', '2026-01-08 22:30:07.817363+00', '2026-01-08 22:30:07.817363+00', '{"eTag": "\"83618cced36669c95b8b511c227f00b9\"", "size": 64859, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-08T22:30:08.000Z", "contentLength": 64859, "httpStatusCode": 200}', '6d3fef92-8ec8-40f6-a9c3-a6cff5e54128', '52d6f439-65c2-43be-b93b-3bce58744755', '{}', 3),
	('d21d21c5-4699-4c32-9e17-7aa2e2d29c26', 'workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/caeaf8a0-5b8c-4eff-85e7-35896c04471d/1767911433619.jpg', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 22:30:34.707872+00', '2026-01-08 22:30:34.707872+00', '2026-01-08 22:30:34.707872+00', '{"eTag": "\"64df633cb10319d53c5e42cdfa0037ef\"", "size": 92333, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-08T22:30:35.000Z", "contentLength": 92333, "httpStatusCode": 200}', '8fffd88a-b954-4d14-bec8-99b86a32953b', '52d6f439-65c2-43be-b93b-3bce58744755', '{}', 3),
	('8707a5b5-533f-439a-9b08-1edc7e88318e', 'workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/75da55cb-7cd8-411e-a5c6-25d7acd12104/1767959547345.jpg', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-09 11:52:28.429946+00', '2026-01-09 11:52:28.429946+00', '2026-01-09 11:52:28.429946+00', '{"eTag": "\"417fee4b624eca92554931efea144932\"", "size": 64804, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-09T11:52:29.000Z", "contentLength": 64804, "httpStatusCode": 200}', '9ed7a85c-1f0e-445e-acd3-b1904184cfe2', '52d6f439-65c2-43be-b93b-3bce58744755', '{}', 3),
	('62fe9034-ff2d-47bb-a1be-47dd2dc8e88a', 'workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/488594fb-0524-4712-95fb-067cefd4800e/1768047723043.jpg', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-10 12:22:04.179052+00', '2026-01-10 12:22:04.179052+00', '2026-01-10 12:22:04.179052+00', '{"eTag": "\"5a68b7cc4abda5b3dfc884b32f4a16b8\"", "size": 84734, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-10T12:22:05.000Z", "contentLength": 84734, "httpStatusCode": 200}', 'd45f5943-0b7f-4b52-885b-e79132bca644', '52d6f439-65c2-43be-b93b-3bce58744755', '{}', 3),
	('178a76d7-7f88-429b-a589-397d9141f889', 'workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/d8b01620-8743-464c-966f-749346aae4d8/1768060133324.jpg', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-10 15:48:54.416596+00', '2026-01-10 15:48:54.416596+00', '2026-01-10 15:48:54.416596+00', '{"eTag": "\"9a1d46aed293d803387be1829072c6a4\"", "size": 73001, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-10T15:48:55.000Z", "contentLength": 73001, "httpStatusCode": 200}', 'c51dc78a-a2a8-48ee-a29f-b17753505ed6', '52d6f439-65c2-43be-b93b-3bce58744755', '{}', 3),
	('470e33af-0df4-44d0-aa57-f584146660d3', 'workout-photos', '41a5fed9-1999-4a59-a20d-41e84a580fe3/d1d005a5-5f1c-43e2-9581-675748ef8abe/1768131454232.jpg', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '2026-01-11 11:37:36.137683+00', '2026-01-11 11:37:36.137683+00', '2026-01-11 11:37:36.137683+00', '{"eTag": "\"9a1a0c58a80bc092baa9fdf8960c0193\"", "size": 91137, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-01-11T11:37:37.000Z", "contentLength": 91137, "httpStatusCode": 200}', '6ea76b3d-b0ca-454c-9733-936565dd2cf9', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '{}', 3);


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."prefixes" ("bucket_id", "name", "created_at", "updated_at") VALUES
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755', '2026-01-08 21:58:24.553585+00', '2026-01-08 21:58:24.553585+00'),
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/ee1718a8-7736-4de5-a289-ea04331d79d9', '2026-01-08 21:58:24.553585+00', '2026-01-08 21:58:24.553585+00'),
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/3931377b-5785-4a1a-8ace-e1c3632ed033', '2026-01-08 22:28:44.738985+00', '2026-01-08 22:28:44.738985+00'),
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/486333c5-42a6-41c2-8992-03d5d6de0efa', '2026-01-08 22:30:07.817363+00', '2026-01-08 22:30:07.817363+00'),
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/caeaf8a0-5b8c-4eff-85e7-35896c04471d', '2026-01-08 22:30:34.707872+00', '2026-01-08 22:30:34.707872+00'),
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/75da55cb-7cd8-411e-a5c6-25d7acd12104', '2026-01-09 11:52:28.429946+00', '2026-01-09 11:52:28.429946+00'),
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/488594fb-0524-4712-95fb-067cefd4800e', '2026-01-10 12:22:04.179052+00', '2026-01-10 12:22:04.179052+00'),
	('workout-photos', '52d6f439-65c2-43be-b93b-3bce58744755/d8b01620-8743-464c-966f-749346aae4d8', '2026-01-10 15:48:54.416596+00', '2026-01-10 15:48:54.416596+00'),
	('workout-photos', '41a5fed9-1999-4a59-a20d-41e84a580fe3', '2026-01-11 11:37:36.137683+00', '2026-01-11 11:37:36.137683+00'),
	('workout-photos', '41a5fed9-1999-4a59-a20d-41e84a580fe3/d1d005a5-5f1c-43e2-9581-675748ef8abe', '2026-01-11 11:37:36.137683+00', '2026-01-11 11:37:36.137683+00');


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 208, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict j8vevA6aoTySbo1DxVIp4RmnfXlarAOX50J0dapSJZPvszQCXPsBMmHOX3qvCfp

RESET ALL;
