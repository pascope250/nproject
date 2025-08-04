--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF-8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO neondb_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: neondb_owner
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO neondb_owner;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.categories OWNER TO neondb_owner;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO neondb_owner;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: commentlike; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.commentlike (
    id integer NOT NULL,
    "commentId" integer NOT NULL,
    ip text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.commentlike OWNER TO neondb_owner;

--
-- Name: commentlike_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.commentlike_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commentlike_id_seq OWNER TO neondb_owner;

--
-- Name: commentlike_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.commentlike_id_seq OWNED BY public.commentlike.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    "movieId" integer NOT NULL,
    "userName" text NOT NULL,
    comment text NOT NULL,
    "commentLike" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.comments OWNER TO neondb_owner;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO neondb_owner;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    subject text NOT NULL,
    message text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.contacts OWNER TO neondb_owner;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_seq OWNER TO neondb_owner;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: inquiries; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.inquiries (
    id integer NOT NULL,
    name text NOT NULL,
    company text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    budget text NOT NULL,
    message text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.inquiries OWNER TO neondb_owner;

--
-- Name: inquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.inquiries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inquiries_id_seq OWNER TO neondb_owner;

--
-- Name: inquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.inquiries_id_seq OWNED BY public.inquiries.id;


--
-- Name: movies; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.movies (
    id integer NOT NULL,
    "categoryId" integer NOT NULL,
    title text NOT NULL,
    year integer NOT NULL,
    rating double precision NOT NULL,
    description text NOT NULL,
    poster text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type text DEFAULT 'TRANSLATED'::text NOT NULL
);


ALTER TABLE public.movies OWNER TO neondb_owner;

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_id_seq OWNER TO neondb_owner;

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    url character varying(512),
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.notification OWNER TO neondb_owner;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_id_seq OWNER TO neondb_owner;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


--
-- Name: replies; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.replies (
    id integer NOT NULL,
    "commentId" integer NOT NULL,
    "userName" text NOT NULL,
    content text NOT NULL,
    "replyLike" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.replies OWNER TO neondb_owner;

--
-- Name: replies_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.replies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.replies_id_seq OWNER TO neondb_owner;

--
-- Name: replies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.replies_id_seq OWNED BY public.replies.id;


--
-- Name: replylikes; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.replylikes (
    id integer NOT NULL,
    "replyId" integer NOT NULL,
    ip text NOT NULL
);


ALTER TABLE public.replylikes OWNER TO neondb_owner;

--
-- Name: replylikes_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.replylikes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.replylikes_id_seq OWNER TO neondb_owner;

--
-- Name: replylikes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.replylikes_id_seq OWNED BY public.replylikes.id;


--
-- Name: sources; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.sources (
    id integer NOT NULL,
    "movieId" integer NOT NULL,
    name text NOT NULL,
    domain text NOT NULL,
    type text NOT NULL,
    part integer NOT NULL,
    "baseUrl" text NOT NULL,
    "downloadLink" text,
    "isIframe" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.sources OWNER TO neondb_owner;

--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sources_id_seq OWNER TO neondb_owner;

--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.sources_id_seq OWNED BY public.sources.id;


--
-- Name: subscription; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.subscription (
    id integer NOT NULL,
    endpoint text NOT NULL,
    p256dh_key character varying(256) NOT NULL,
    auth_key character varying(256) NOT NULL,
    browser_id character varying(64) NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.subscription OWNER TO neondb_owner;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_id_seq OWNER TO neondb_owner;

--
-- Name: subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.subscription_id_seq OWNED BY public.subscription.id;


--
-- Name: usernotifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.usernotifications (
    id integer NOT NULL,
    "subscriptionId" integer NOT NULL,
    "notificationId" integer NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.usernotifications OWNER TO neondb_owner;

--
-- Name: usernotifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.usernotifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usernotifications_id_seq OWNER TO neondb_owner;

--
-- Name: usernotifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.usernotifications_id_seq OWNED BY public.usernotifications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: commentlike id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.commentlike ALTER COLUMN id SET DEFAULT nextval('public.commentlike_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: inquiries id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.inquiries ALTER COLUMN id SET DEFAULT nextval('public.inquiries_id_seq'::regclass);


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: replies id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.replies ALTER COLUMN id SET DEFAULT nextval('public.replies_id_seq'::regclass);


--
-- Name: replylikes id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.replylikes ALTER COLUMN id SET DEFAULT nextval('public.replylikes_id_seq'::regclass);


--
-- Name: sources id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sources ALTER COLUMN id SET DEFAULT nextval('public.sources_id_seq'::regclass);


--
-- Name: subscription id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.subscription ALTER COLUMN id SET DEFAULT nextval('public.subscription_id_seq'::regclass);


--
-- Name: usernotifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.usernotifications ALTER COLUMN id SET DEFAULT nextval('public.usernotifications_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
be3e2202-8d11-472e-9359-533b68462d70	08a3ef695754349e4a0889eba45690234958da60ea38be153d48fe113aaadff6	2025-06-12 22:31:02.784982+00	20250612223053_database_migrations	\N	\N	2025-06-12 22:31:01.757418+00	1
571bc3dd-cea8-400b-9e5c-ef0a06f43e3b	aff79e27d674d75c6ec9bdc17323c4abddd77e7d8a88c5aff0ebf6a01bc7cc63	2025-06-28 22:58:06.78361+00	20250628225751_source_add_created_at_column	\N	\N	2025-06-28 22:58:05.160454+00	1
3cf7104a-8b5c-408f-a9a7-de134191096a	cfbdfe5a89da73fb4674181fa226cdf59f5e9b935cc6d413a8f9ad52bbd5debf	2025-07-30 13:25:01.312033+00	20250730132458_add_type_column_on_movie	\N	\N	2025-07-30 13:24:59.743769+00	1
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.categories (id, name, "createdAt") FROM stdin;
0	Home	2025-04-29 11:26:02
1	Actions	2025-04-28 08:35:09
2	Comedy	2025-04-28 08:35:20
3	Horrors	2025-04-28 08:35:26
4	Drama	2025-04-28 08:35:35
5	Sci-Fi	2025-04-28 08:35:44
6	Thriller	2025-04-28 08:35:54
7	Indian	2025-04-28 20:42:29
9	Romance	2025-05-17 08:29:00
10	Cartoons	2025-06-30 17:43:32.263
11	Documentary	2025-07-31 11:17:38.58
\.


--
-- Data for Name: commentlike; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.commentlike (id, "commentId", ip, "createdAt") FROM stdin;
1	1	::1	2025-06-13 10:07:47.988
2	8	197.243.44.93	2025-06-20 10:48:34.616
3	5	51.158.112.253	2025-06-20 19:28:37.733
4	11	41.186.13.132	2025-06-23 08:58:14.335
5	14	41.186.135.240	2025-06-28 11:21:13.472
6	14	197.157.187.140	2025-06-28 12:25:06.971
7	14	102.22.141.129	2025-06-28 14:29:03.814
8	12	68.56.99.5	2025-06-29 04:55:33.083
9	20	102.212.246.41	2025-07-01 06:57:03.533
10	21	146.70.174.67	2025-07-04 12:50:29.89
11	21	197.157.186.169	2025-07-04 14:33:08.443
12	22	197.157.186.33	2025-07-04 17:43:49.759
13	23	197.157.186.33	2025-07-04 18:15:15.462
14	23	::1	2025-07-04 21:05:36.712
15	20	102.22.141.129	2025-07-10 18:34:36.253
16	32	41.186.133.164	2025-07-11 23:11:04.284
17	35	197.157.184.160	2025-07-13 16:38:48.279
18	34	197.157.184.160	2025-07-13 16:38:51.111
19	33	197.157.184.160	2025-07-13 16:38:54.462
20	36	197.157.185.191	2025-07-14 18:08:12.714
21	35	197.157.187.150	2025-07-15 08:27:13.49
22	36	197.157.187.150	2025-07-15 08:27:19.966
23	36	197.157.155.87	2025-07-16 00:48:19.698
24	39	41.216.108.243	2025-07-17 20:43:48.397
25	39	197.157.145.161	2025-07-18 12:51:01.956
26	40	197.157.187.230	2025-07-22 21:18:01.428
27	42	197.157.145.208	2025-07-24 16:55:51.988
28	45	197.157.186.89	2025-07-25 18:25:25.706
29	19	197.157.187.210	2025-07-30 18:56:37.302
30	48	197.157.186.114	2025-08-02 06:01:27.244
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.comments (id, "movieId", "userName", comment, "commentLike", "createdAt") FROM stdin;
1	5	pascal	jkljl;'	1	2025-06-13 10:07:42.787
3	235	Eric	Nice Movie Kbx	0	2025-06-16 18:30:02.219
4	205	K	Video zawe ntago ziba downloaded	0	2025-06-16 19:00:35.981
6	224	Reo	Yes	0	2025-06-18 17:35:35.338
7	224	Reo	Pushipa	0	2025-06-18 17:36:32.743
8	248	Ange	This movie is Mwuuauua	1	2025-06-20 10:48:17.063
9	249	Ip	Kuyi downloading byanze kbx	0	2025-06-20 19:27:18.501
5	249	SADEPA	Yooo brother gukuraho movie x kobitarigukunda mn ndavuga gukuraho serie ep	1	2025-06-18 16:41:22.291
10	205	Divine	Ko movie zitaba downloaded x	0	2025-06-21 13:54:37.11
11	268	GENTiL	The vampire diaries plz	1	2025-06-23 08:58:05.44
13	205	Sam	Please can you give us download option to dirty linen	0	2025-06-26 17:30:07.62
15	279	Mr eagle ≡ƒªà	Thanks boi kbx urimukazi	0	2025-06-28 14:24:11.826
16	279	Mr eagle ≡ƒªà	Reka ngusabe movie waduhaye movie yitwa(Aitraaz by Rocky korumuti musaz)≡ƒÖÅ	0	2025-06-28 14:28:32.784
14	279	Prince	≡ƒñæ	3	2025-06-28 11:14:56.751
17	279	Mr eagle ≡ƒªà	Yeah 2004 \nNibyo kbx	0	2025-06-28 20:36:20.706
18	279	Mr eagle ≡ƒªà	2004Γ£à	0	2025-06-28 20:39:01.492
12	268	Mugisha	Mn thanks kuba ukomeje ukudutamo movie zubwejye wa \nNshyiriraho the cleaning lady s4 yose please ≡ƒÖÅ	1	2025-06-24 12:38:07.067
21	299	developer	wow this web is cool kbx ui  irarez	2	2025-07-04 11:10:36.016
22	299	cedo	nkunze ukuntu nta ads zirimo kuri iyi website kbsa , good job bro, I'm your new follower ≡ƒöÑ	1	2025-07-04 15:12:04.645
23	299	dig	iyi web nineza	2	2025-07-04 15:30:19.86
27	281	Becky	ItΓÇÖs scare	0	2025-07-05 22:10:37.874
28	58	Savior	Pls we need to download	0	2025-07-08 22:24:53.806
29	261	richard	uzaduhe serie yitwa devious maids ya rocky	0	2025-07-09 17:40:15.819
20	280	Shami	Keep up good working KBC ukomeze uduhe inya Korea	2	2025-07-01 06:56:48.655
30	280	Mwanya	Noex mwaduhaye high school on sex by siniya	0	2025-07-10 18:36:53.782
32	319	CULLO RADIO&TV	Nice Movie	1	2025-07-11 20:27:48.317
34	232	Ange	Please waduhaye professionals	1	2025-07-13 08:29:51.939
33	78	Peter	Good	1	2025-07-12 02:39:55.211
35	292	Emmy	Good movie	2	2025-07-13 12:03:07.953
36	315	Valens	Cool kbs waziye igihe	3	2025-07-14 18:08:00.29
37	186	Ira	The original season 2 ko kuy downloading bidakunda x	0	2025-07-16 09:13:37.18
38	190	jenvah	why full window doesn't accessed?	0	2025-07-17 20:23:41.24
39	325	alc	kuki itarangiy	2	2025-07-17 20:43:38.319
40	243	elon	this is so good	1	2025-07-22 13:27:55.424
41	332	Obed	Where's part b	0	2025-07-24 07:16:35.276
42	280	kevin	ko web itarigukora	1	2025-07-24 16:50:47.91
43	205	Philos	Download yaranze peee!!!!!	0	2025-07-24 18:14:29.554
44	283	Bagabo Johnson	Mujye muduha no kuri filme ziri up date	0	2025-07-24 21:17:05.674
45	338	White fox	9te hs cm	1	2025-07-25 08:56:31.575
46	303	D'amour	Nta bwo iri ku downloading \nIyo moves≡ƒæëMaze Runner 2: The scorch Trials	0	2025-07-26 18:21:45.326
47	186	angel	the orginals s2 ?	0	2025-07-27 07:21:14.25
19	268	Claire	≡¥òô≡¥òú≡¥òá ≡¥ò¿≡¥òÆ≡¥ò₧≡¥òÆ Vampire ≡¥ö╗≡¥òÜ≡¥òÆ≡¥òú≡¥òÜ≡¥òû≡¥òñ ≡¥òè11 ≡¥òí≡¥ò¥≡¥òû≡¥òÆ≡¥òñ≡¥òû	1	2025-06-29 04:55:20.543
48	337	#M	I'm your first fan MN keep going on what you do	1	2025-08-01 22:55:22.105
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.contacts (id, name, email, subject, message, "createdAt") FROM stdin;
1	RWAMUZA Bruce	cullobruce@gmail.com	Info about your webite	I want get experience on you	2025-07-06 01:02:06.014
\.


--
-- Data for Name: inquiries; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.inquiries (id, name, company, email, phone, budget, message, "createdAt") FROM stdin;
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.movies (id, "categoryId", title, year, rating, description, poster, "createdAt", "updatedAt", type) FROM stdin;
1	3	The Mirror	2021	3	Ben guards a partly destroyed property during the nights but begins to see strange images in its impeccable mirrors. After his sister is killed, he is convinced that evil forces are out to ge	images (3).jpeg	2025-04-28 08:39:05	2025-04-29 18:12:55	TRANSLATED
3	7	Salaar -ROCKY	2023	5	The film follows the friendship between Deva (Prabhas), the exiled prince of Khansaar, and Varadha (Prithviraj Sukumaran), the current prince of Khansaar.	download.jpeg	2025-04-28 20:47:19	2025-04-28 20:47:19	TRANSLATED
4	4	The Last Supper	2025	6	It explores key events in the life of Jesus Christ, including the Last Supper and Judas Iscariot's betrayal. The season is being released in three parts, with the first two episodes premierin	images (1).jpeg	2025-04-28 20:51:29	2025-04-28 20:51:29	TRANSLATED
5	2	God must be crazy | Sagatwa	1980	3	A Coca-Cola bottle dropped from an airplane raises havoc among a normally peaceful tribe of African bushmen who believe it to be a utensil of the gods.	da8418cd201f60503ba59a86ed2406ab.jpg	2025-05-09 17:14:42	2025-05-09 17:14:42	TRANSLATED
6	2	The three stooges - Git	2012	2	While trying to save their childhood orphanage, Moe, Larry, and Curly inadvertently stumble into a murder plot and wind up starring in a reality television show.	2f8deb247dcfe09d3cc9160b86fbbe75.jpg	2025-05-09 17:23:32	2025-05-09 17:23:45	TRANSLATED
7	2	Milk Money - SAVIMBI	1994	3	Parents need to know that Milk Money is a 1994 comedy about the sexual curiosity of three 12-year-old boys who pay a prostitute to let them see her naked and its unintended consequences. The 	44b0c28775e77fe50c054185ad37856c.jpg	2025-05-09 17:40:34	2025-05-09 17:40:34	TRANSLATED
9	4	As The Crow Flies	2022	8	A young fan insinuates herself into a veteran anchor's newsroom but soon confronts the dark side of ambition, envy and the desire to be seen as they strive to reach the top of the newsroom.	543ceea410be42da88f298a4b6dc720d.jpg	2025-05-09 17:51:10	2025-05-09 17:51:10	TRANSLATED
10	4	Bel Air S2	2023	8	Jabari Banks, a young man, moves all the way from West Philadelphia to the affluent residential neighbourhood of Bel-Air	p23438705_b_h9_aa.jpg	2025-05-09 18:29:32	2025-05-09 18:29:32	TRANSLATED
11	4	Game of Thrones S4	2014	9	Nine noble families wage war against each other in order to gain control over the mythical land of Westeros. Meanwhile, a force is rising after millenniums and threatens the existence of livi	5ebabec3a569f1751345cd6fe5c9d4e4.jpg	2025-05-09 19:02:37	2025-05-09 19:02:37	TRANSLATED
12	4	In Time - Rocky	2011	6	In the future, people stop ageing at 25 years and must buy time to live. While the rich become immortal, the poor beg, borrow or steal hours. Accused of murdering, Will is on the run with a h	41ac707697da17b2b8961483479ef836.jpg	2025-05-09 19:22:44	2025-05-09 19:22:44	TRANSLATED
14	7	RRR - ROCKY	2022	9	A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.	e52152364dc8fb2b25e3dadb188af09f.jpg	2025-05-09 19:37:14	2025-05-09 19:37:14	TRANSLATED
15	7	Sooryavanshi - ROCKY	2021	8	With the looming threat of a terrorist attack on Mumbai, ATS chief Sooryavanshi embarks on a mission to hunt for 600 kgs of missing RDX and the conspiring perpetrators.	images (4).jpeg	2025-05-09 19:42:54	2025-05-09 19:42:54	TRANSLATED
16	7	3 Idiots -Rocky	2009	6	In college, Farhan and Raju form a great bond with Rancho due to his refreshing outlook. Years later, a bet gives them a chance to look for their long-lost friend whose existence seems rather	1e431c48223eac35b991a9d4663d3d9a.jpg	2025-05-09 19:47:33	2025-05-09 19:47:33	TRANSLATED
17	7	Kabhi Alvida Naa Kehna - GAHEZA	2006	7	Dev and Maya, who face struggles in their respective marriages, become friends. They try to help each other salvage their relationships but end up falling in love instead.	756e3e3fd61d9c7b2655d07433f91ca3.jpg	2025-05-09 19:53:22	2025-05-09 19:53:38	TRANSLATED
18	7	Deewaar - ROCKY	2004	5	A group of Indian soldiers is captured during the Indo-Pak War. Gaurav, whose father, Major Ranvir, has been held captive by the enemies, decides to go on a rescue mission.	c6b2bdd1f512eb6e665dc67dc0c976f4.jpg	2025-05-09 20:03:10	2025-05-09 20:03:10	TRANSLATED
19	7	Mimi - ROCKY	2021	7	Harbouring big dreams but not the means to achieve them, a woman reluctantly agrees to become a surrogate for a couple. However, when problems begin to crop up, she must face some tough decis	Mimi_2021_Hindi_poster.jpg	2025-05-09 20:08:08	2025-05-09 20:08:08	TRANSLATED
20	7	Baby John	2024	6	DCP Satya Verma fakes his own death to protect his daughter from the dangerous politician Babbar Sher. When old enemies resurface, Satya must confront his past and put everything on the line 	images (5).jpeg	2025-05-09 20:12:25	2025-05-09 20:12:25	TRANSLATED
21	7	The Billionaire - ROCKY	2023	5	Bichagadu: The Billionaire* is the Telugu-dubbed version of the Tamil film *Pichaikkaran*, directed by Sasi and starring Vijay Antony and Satna Titus. The movie tells the story of a wealthy b	bichagadu-2-776.webp	2025-05-09 20:22:12	2025-05-09 22:46:26	TRANSLATED
22	7	Satyameva Jayate - ROCKY	2018	8	DCP Shivansh is given a case to arrest the man responsible for the deaths of corrupt police officers. He begins his search without realising the killer is none other than Vir, his younger bro	download (1).jpeg	2025-05-09 20:26:06	2025-05-09 20:26:06	TRANSLATED
23	7	Bagheera - FEY	2024	7	In a lawless land of injustice and corruption, a police officer turns to vigilante justice to protect innocents.	images (4).jpeg	2025-05-09 20:29:52	2025-05-09 20:30:17	TRANSLATED
24	7	FATEH - ROCKY	2025	6	Fateh is a 2025 Indian action thriller film written and directed by Sonu Sood in his directorial debut. Produced by Shakti Sagar Productions, and Zee Studios and co-produced by Ajay Dhama, th	download (1).jpeg	2025-05-09 20:36:08	2025-05-09 20:36:08	TRANSLATED
25	7	GARV - ROCKY	2004	6	An honest officer falls prey to a corrupt system where he is dismissed from the police force for getting involved in a murder case while trying to arrest a few corrupt politicians.	download (2).jpeg	2025-05-09 20:39:49	2025-05-09 20:40:43	TRANSLATED
26	7	Rocky Handsome - ROCKY	2016	5	Kabir, a young man who runs a pawn shop in Goa, befriends his little neighbour Naomi, a bright eight-year-old girl. After she gets abducted, he goes on a vengeful spree to get her back.	download (3).jpeg	2025-05-09 20:46:49	2025-05-09 20:46:49	TRANSLATED
27	7	RUSTOM - ROCKY	2016	6	Rustom, a naval officer, shares a happy relationship with his wife Cynthia. Soon, he discovers her affair with Vikram, a close friend, and is accused of murdering him.	MV5BMzFmNGQ0MTctYTk1ZC00YWZlLWIyMWUtODUxOTJjMGFjYmZhXkEyXkFqcGc@._V1_.jpg	2025-05-09 20:51:11	2025-05-09 20:51:11	TRANSLATED
28	7	DEVA - ROCKY	2025	8	A skilled but defiant police officer investigates a major case. The officer discovers layers of lies and betrayal during the investigation.	download (4).jpeg	2025-05-09 20:53:26	2025-05-09 20:53:26	TRANSLATED
29	6	Eagle - Rocky	2024	8	A journalist uncovers the story of a ruthless assassin when she investigates a government cover up.	download (5).jpeg	2025-05-09 20:59:00	2025-05-09 20:59:00	TRANSLATED
30	7	Baahubali 2: The Conclusion	2017	8	After learning that his father was brutally killed by Bhallaladeva, Mahendra Baahubali raises an army to defeat him and release his mother from the former's captivity.	download (6).jpeg	2025-05-09 21:08:01	2025-05-09 21:08:01	TRANSLATED
32	6	Hacked - ROCKY	2020	8	Sameera's boyfriend disappoints her on her birthday and she ends up sleeping with Vivek, her neighbour. However, when she rebuffs his love, Vivek hacks into everything and makes her life mise	images (5)lllllllllllll.jpeg	2025-05-09 21:25:25	2025-05-09 21:28:52	TRANSLATED
33	7	War - Rocky	2019	8	War is a 2019 Indian Hindi-language action thriller film directed by Siddharth Anand, who co-wrote the script with Shridhar Raghavan, Abbas Tyrewala and Aditya Chopra, and produced by Chopra'	War_official_poster.jpg	2025-05-09 21:31:42	2025-05-09 21:31:42	TRANSLATED
34	5	Spider Man - Savimbi	2002	7	Peter Parker, a shy and awkward high school student, is often bullied by people, including his best friend. His life changes when he is bitten by a genetically altered spider and gains superp	download (1)jkkkkkkkkkkkkkk.jpeg	2025-05-09 21:43:43	2025-05-09 21:43:43	TRANSLATED
35	5	65 million years - GAHEZA	2023	5	A spaceship crash lands on prehistoric Earth, leaving only two survivors. Soon, they must survive against the hostile terrain and vicious creatures.	download (1)nn.jpeg	2025-05-09 21:47:47	2025-05-09 21:47:47	TRANSLATED
36	5	THOR - YANGA	2011	7	Thor is exiled by his father, Odin, the King of Asgard, to the Earth to live among mortals. When he lands on Earth, his trusted weapon Mjolnir is discovered and captured by S.H.I.E.L.D	thors.jpeg	2025-05-09 21:50:44	2025-05-09 21:50:44	TRANSLATED
38	5	The Matrix - SAVIMBI	1999	6	eo, a computer programmer and hacker, has always questioned the reality of the world around him. His suspicions are confirmed when Morpheus, a rebel leader, contacts him and reveals the truth	images.webp	2025-05-09 21:59:53	2025-05-09 21:59:53	TRANSLATED
39	5	Avenger Endgame - PK	2019	7	After Thanos, an intergalactic warlord, disintegrates half of the universe, the Avengers must reunite and assemble again to reinvigorate their trounced allies and restore balance.	download (1)endgame.jpeg	2025-05-09 22:02:29	2025-05-09 22:02:42	TRANSLATED
40	5	AVENGERS INFINITY WAR - PK	2018	8	As Thanos sets about his quest for finding the infinity stones and carrying out his twisted scheme, the Avengers join forces with their allies to stop him from causing chaos and destruction.	download (1)kkkkkkkkkknj.jpeg	2025-05-09 22:07:09	2025-05-09 22:07:09	TRANSLATED
41	5	Captain America - SANKRA	2014	7	Steve Rogers, along with Black Widow and Falcon, must uncover the secrets hidden within S.H.I.E.L.D., while also battling a dangerous new enemy, who is only known as The Winter Soldier.	images (4)jssjsjss.jpeg	2025-05-09 22:12:37	2025-05-09 22:12:37	TRANSLATED
42	5	CASSANDRA - HABIBU	2025	7	A family moves into the oldest  smart home in Germany, decades after the original owner dies; the AI household helper awakens, and is resolved to never be alone again.	download (1)jdjdjdudszz.jpeg	2025-05-09 22:19:54	2025-05-09 22:19:54	TRANSLATED
43	5	Vivarium - SANKRA	2019	6	While looking for a house, Tom and Gemma get stuck in a maze of identical houses. As they try to figure out a way to escape, they receive a package containing a child and are asked to raise h	hdhdhsklaaa.jpeg	2025-05-09 22:26:40	2025-05-09 22:46:05	TRANSLATED
44	5	Black Widow - SANKRA	2021	1	Natasha Romanoff, a member of the Avengers and a former KGB spy, is forced to confront her dark past when a conspiracy involving her old handler arises.	Black_Widow_(2021_film)_posterkkk.jpg	2025-05-09 22:29:09	2025-05-09 22:29:09	TRANSLATED
45	5	Doctor Strange - Sankra	2016	8	In an accident, Stephen Strange, a famous neurosurgeon, loses the ability to use his hands. He goes to visit the mysterious Ancient One to heal himself and becomes a great sorcerer under her 	71lUs8vxKgS._AC_UF894,1000_QL80_k.jpg	2025-05-09 22:32:33	2025-05-09 22:32:33	TRANSLATED
46	5	Civil War Captain america - SANKRA	2020	8	When the collective governments decide to ratify the Sokovia Accords, a legal document that regulates superhuman activity, it leads to a discordance between Captain America and Iron Man.	images (4)cival.jpeg	2025-05-09 22:36:09	2025-05-09 22:37:15	TRANSLATED
47	1	Buffalo Boys - SAVIMBI	2018	7	Brothers Jamar and Suwo are exiled from their homeland in Java by a Dutch administrator, Van Trach, who also kills their father. Years later, they return to Java to avenge their father's murd	download (1)bu    tasl.jpeg	2025-05-09 22:55:14	2025-05-09 22:55:14	TRANSLATED
48	1	Sinners and Saints - YANGA	2010	7	After a series of brutal murders, detective Sean is hired to probe into the case. He takes the help of his friend who gets killed while gathering evidence. Will Sean get to the bottom of the 	71FVgBYtY6L._AC_UF894,1000_QL80_.jpg	2025-05-10 11:25:54	2025-05-10 11:25:54	TRANSLATED
49	1	The 355 - ROCKY	2022	6	A group of highly trained female agents from around the globe must work at breakneck speed to stop a criminal mastermind who possesses a deadly cyberweapon.	images (4)335kzklass.jpeg	2025-05-10 11:28:18	2025-05-10 11:28:18	TRANSLATED
50	1	Weekend in Taipei - SANKRA	2024	6	A former DEA agent and an ex-undercover operative rekindle their romance during a weekend in Taipei. As they reconnect, they're oblivious to the looming dangers stemming from their past opera	P_HO00011384_1722583967055jss.jpg	2025-05-10 11:31:07	2025-05-10 11:31:07	TRANSLATED
51	1	Clash of the Titans - SANKRA	2010	7	Perseus, a demigod and the son of Zeus, embarks on a mission to defeat the vengeful god of the underworld, Hades, who threatens to release the monstrous Kraken on Earth if his demands are not	download (1)titans.jpeg	2025-05-10 11:34:33	2025-05-10 11:34:33	TRANSLATED
52	1	The Family Plan - ROCKY	2023	7	When enemies from his past track him down, former elite government assassin Dan packs his wife, teen daughter, teen son, and 10-month-old baby into their minivan and takes off on an impromptu	download (1)family plan.jpeg	2025-05-10 11:37:39	2025-05-10 11:37:39	TRANSLATED
53	1	Carry On - ROCKZ	2024	7	A young airline security guard is blackmailed by a mysterious passenger who threatens to smuggle a dangerous package onto a plane on Christmas Eve.	Carry_On_film_poster.jpg	2025-05-10 11:41:29	2025-05-10 11:41:29	TRANSLATED
54	1	Red One - ROCKY	2024	7	When a villain kidnaps Santa Claus from the North Pole, an E.L.F. (Extremely Large and Formidable) operative joins forces with the world's most accomplished tracker to find him and save Chris	images (1)redOne.webp	2025-05-10 11:44:02	2025-05-10 11:44:02	TRANSLATED
55	6	Rebel Ridge - SAVIMBI	2024	8	A former Marine confronts corruption in a small town when local law enforcement unjustly seizes the bag of cash he needs to post his cousin's bail.	hq720hhhhsjsi.jpg	2025-05-10 11:46:46	2025-05-10 11:46:46	TRANSLATED
56	6	Sentinelle - ROCKY	2021	9	Following a traumatic experience in Syria, Klara, a highly trained French soldier, is transferred home. The day after a nightclub party, her sister was found raped and almost dead, so Klara u	images (4)hsjskso9993.jpeg	2025-05-10 11:50:09	2025-05-10 11:50:09	TRANSLATED
57	1	The Shadow Strays - SANKRA	2024	6	Skilled in the art of killing, a young assassin defies her mentor to save a boy from a ruthless crime syndicate.	images (4)wyfilsdzxcjknm.jpeg	2025-05-10 11:52:47	2025-05-10 11:52:47	TRANSLATED
58	3	Sick - DIDIER	2022	6	While quarantining at her family's lake house during the pandemic, Parker and her best friend are threatened by an unexpected visitor.	download (1)sick.jpeg	2025-05-10 11:55:13	2025-05-10 11:55:13	TRANSLATED
59	1	Kraven the Hunter - GAHEZA	2024	9	Kraven's complex relationship with his ruthless father starts him down a path of vengeance, motivating him to become not only the greatest hunter in the world, but also one of its most feared	images (4)kheven.jpeg	2025-05-10 11:57:54	2025-05-10 11:57:54	TRANSLATED
60	1	Striking Rescue - GAHEZA	2024	8	A veteran Muay Thai expert goes on a take-no-prisoners mission of revenge after his wife and daughter are brutally murdered by mysterious forces.	download (1)jin777777.jpeg	2025-05-10 12:01:26	2025-05-10 12:01:26	TRANSLATED
61	1	Violent Night - ROCK	2022	8	An elite team of mercenaries breaks into a family compound on Christmas Eve, taking everyone hostage inside. However, they aren't prepared for a surprise combatant: Santa Claus is on the grou	images (4)night violent.jpeg	2025-05-10 12:04:05	2025-05-10 12:04:05	TRANSLATED
62	1	To Live through Death - GAHEZA	2024	6	n a certain island in the Pacific, an invincible human-smuggling organization kidnaps and defrauds Chinese people. In order to rescue his kidnapped adopted daughter, the usually taciturn Chen	download (1)jsd9o0sss.jpeg	2025-05-10 12:06:55	2025-05-10 12:06:55	TRANSLATED
63	1	High Forces - GAHEZA	2024	7	Gao Haojun, an international security expert, is hijacked by gunmen on the first flight of A380 airliner, and his blind daughter is one of the undercover hostages, a fact that he doesn't know	download (1) high force.jpeg	2025-05-10 12:08:53	2025-05-10 12:08:53	TRANSLATED
64	1	GladiatorNEW 2 - ROCKY	2024	8	Years after witnessing the death of Maximus at the hands of his uncle, Lucius must enter the Colosseum after the powerful emperors of Rome conquer his home. With rage in his heart and the fut	07c54dd26281975820972f30efb9617b.jpg	2025-05-10 12:12:06	2025-05-10 12:12:06	TRANSLATED
65	6	Customs Frontline - SANKRA	2024	7	When a container ship mysteriously turns up in Hong Kong waters, local Customs officers sail into dangerous international drama.	download (1).jpeg	2025-05-10 12:24:05	2025-05-10 12:24:05	TRANSLATED
66	1	Knight and Day - SAVIMBI	2010	7	When June meets Roy, a lethal operative, in an unlikely encounter, she gets entangled in his adventures and falls in love with him. However, she has to figure out whether he's a traitor or a 	images (4).jpeg	2025-05-10 12:27:07	2025-05-10 12:27:07	TRANSLATED
67	1	Dirt Angel - SAVIMBI	2024	7	Soldiers in an all-female commando unit pose as members of a relief organisation to save a group of schoolgirls taken hostage by terrorists in Afghanistan.	download (2)drfghjkl.jpeg	2025-05-10 12:29:25	2025-05-10 12:29:25	TRANSLATED
68	1	Largo Winch - GAHEZA	2008	7	After the owner of a reputed company is killed, his secret son comes out in the open and claims to be the rightful successor of the company. But he soon faces problems with the competitors.	download (2)latgo.jpeg	2025-05-10 12:33:27	2025-05-10 12:33:27	TRANSLATED
69	1	Come Out Fighting - GAHEZA	2023	8	A squad of African-American soldiers are tasked with a dangerous mission behind enemy lines to locate a missing commanding officer and a stranded fighter pilot. They must navigate treacherous	download (2)comeout.jpeg	2025-05-10 12:35:07	2025-05-17 08:19:14	TRANSLATED
70	6	Wrath of Man - SANKRA	2021	9	H is a mysterious man who starts working for a cash moving truck company. He becomes known for using amazing precision and dexterity to neutralise robbers. However, H is actually out for reve	Wrath-of-man.jpg	2025-05-10 12:37:19	2025-05-10 12:37:19	TRANSLATED
71	1	Back in Action - ROCKY	2025	7	Former CIA spies Emily and Matt are pulled back into espionage after their secret identities are exposed.	download (2)in action.jpeg	2025-05-10 12:38:57	2025-05-10 12:38:57	TRANSLATED
72	1	Ad Vitam - ROCKY	2025	8	After escaping an attempted murder, Franck Lazarev must find his wife Leo, who has been kidnapped by a mysterious group of armed men. He is caught up with his past and plunged into a state af	images (5)advitam.jpeg	2025-05-10 12:41:01	2025-05-10 12:41:01	TRANSLATED
73	1	Sixty Minutes - SANKRA	2024	8	Desperate not to lose custody, a mixed martial arts fighter makes dangerous enemies when he ditches a matchup to race to his daughter's birthday party.	download (2)60mminutses.jpeg	2025-05-10 12:43:14	2025-05-10 12:43:14	TRANSLATED
74	1	30 jour max (30 Days Left) - DYLAN	2020	7	Rayane, a clumsy young policeman, constantly taunts his teammates. However, he discovers that he has a short time to live, and this may be his last chance to become a hero and thus impress hi	download (2)dilan.jpeg	2025-05-10 12:45:27	2025-05-10 12:45:27	TRANSLATED
75	6	The Prot├⌐g├⌐ - GAHEZA	2021	7	Anna is raised and trained by Moody, an extremely skilled assassin. But when he gets brutally murdered, she uses all her training to find his killers and exact bloody revenge.	download (2)protrge.jpeg	2025-05-10 12:47:26	2025-05-10 12:47:26	TRANSLATED
76	1	Man With No Past - JASCOV	2025	7	Waking up in an unfamiliar city, a man with no memory must confront the mysteries of his own identity. However, his desperate search to uncover the past pits him against a powerful enemy, lea	download (2)with no past.jpeg	2025-05-10 12:51:49	2025-05-10 12:51:49	TRANSLATED
77	6	EXTRACTION - ROCKY	2020	8	While battling his own demons, Tyler, a ruthless mercenary, accepts the offer of rescuing an Indian crime lord's teenage son from Bangladesh. However, when he arrives, a gruesome blood bath e	AAAAQR--51djRo3BkQ6B6bz2yYMN9ttc36SkZJ_xNVyhZJrAG4ziBDo8ZeefXhNyPZlrYpIJNN9Dfg63LINRdEZQJ10bkPsox3Z0h2CfKoIB5opVXLU-JFoDvznmaGUiSGImZZrmsOxS4K8m6_pAPlRPxqrN.jpg	2025-05-10 12:54:43	2025-05-10 12:54:43	TRANSLATED
78	2	Focus - Sankra	2015	8	Nicky, an accomplished criminal, gets romantically involved with his disciple Jess and later breaks up with her. Years later, Jess, now a femme fatale, returns to his life to mess up his plan	download (2) will smith.jpeg	2025-05-10 12:56:33	2025-05-10 12:56:33	TRANSLATED
79	5	What Happened to Monday - SANKRA	2017	8	In a world where overpopulation has compelled governments to adopt the one-child policy, a set of identical septuplets live a hide-and-seek life while searching for their missing sister.	download (2) what happen on monday.jpeg	2025-05-10 12:58:31	2025-05-10 12:58:31	TRANSLATED
80	1	Sniper: The Last Stand - GAHEZA	2025	9	On a mission to stop an arms dealer from unleashing a deadly weapon, ace sniper Brandon Beckett and Agent Zero lead a group of elite soldiers against an unrelenting militia in Costa Verde.	download (2) last sniper.jpeg	2025-05-10 13:00:48	2025-05-10 13:00:48	TRANSLATED
81	1	Den of Thieves - ROCKY	2018	7	A group of elite deputies in the LA County sheriff's department has to stop a notorious crew of expert thieves from executing a robbery plan at the Federal Reserve Bank.	images (5)den of th.jpeg	2025-05-10 13:03:51	2025-05-10 13:03:51	TRANSLATED
82	6	The Target - SAVIMBI	2014	7	An ER doctor saves a former mercenary from getting assassinated by criminals. Later, the doctor's wife gets kidnapped and he realises that he must team up with the mercenary to rescue his wif	download (2) target.jpeg	2025-05-10 13:05:25	2025-05-10 13:05:25	TRANSLATED
83	6	The Black Book - SAVIMBI	2023	7	After his son is framed for a kidnapping, a bereaved deacon takes justice into his own hands and fights a corrupt police gang to absolve him of both his crimes and his sins.	images (5) black book.jpeg	2025-05-10 13:07:32	2025-05-10 13:07:32	TRANSLATED
84	1	Den of Thieves 2 - ROCKY	2025	8	Lawman "Big Nick" O'Brien gets embroiled in the treacherous and unpredictable world of diamond thieves as he pursues career criminal Donnie Wilson to Europe.	download (2) den thieve 2.jpeg	2025-05-10 13:11:18	2025-05-10 13:11:18	TRANSLATED
85	6	Take Cover - SANKRA	2014	9	When burned-out professional sniper Sam Lorde ends up trapped in an all-glass penthouse, he must find a way to make it out alive with little to no cover between him and his attackers.	download (2) take cover.jpeg	2025-05-10 13:20:31	2025-05-10 13:21:07	TRANSLATED
86	1	The Prosecutor - SAVIMBI	2024	9	A poor young man is wrongly charged with drug trafficking after being deceived. An ex-prosecutor investigates the case, uncovers a corrupt lawyer team's scheme, and restores justice despite o	images (5) the prosecuter.jpeg	2025-05-10 13:23:10	2025-05-10 13:23:10	TRANSLATED
87	6	Gunpowder Milkshake - SANKRA	2021	8	Three generations of hitwomen fight for survival against a criminal firm and try to protect what is most important to them.	images (5) gun powder.jpeg	2025-05-10 13:25:14	2025-05-10 13:25:14	TRANSLATED
88	6	Canary Blacka - ROCKY	2024	8	Avery Graves, a CIA operative, is blackmailed by terrorists into betraying her own country to save her kidnapped husband. Cut off from her team, she turns to her underworld contacts to surviv	maxresdefaultjkwdfnweqdf.jpg	2025-05-10 13:27:02	2025-05-10 13:27:02	TRANSLATED
89	6	KILL BOKSOO- GAHEZA	2023	7	Gil Bok-Soon is a single mother and merciless murderer who works for Cha Min-Kyu's M.K. Ent. Before renewing her contract, Bok-Soon engages in a kill-or-be-killed confrontation.	kill-boksoon-aka-kill-bok-soon-us-poster-from-top-jeon-do-yeon-sol-kyung-gu-kim-si-a-left-esom-koo-kyo-hwan-2023-netflix-courtesy-everett-collection-2PK9FG2.jpg	2025-05-10 13:30:31	2025-05-10 13:30:31	TRANSLATED
90	5	SURVIVE - SANKRA	2024	8	After a violent storm nearly capsizes a family's boat, they awaken in a desert land. Earth has had a polarity reversal, draining water from the Oceans. They must now survive in a world where 	MV5BNGMwNGVkYTMtYThlNS00OTlhLTk1YjAtYjcyNDg2YjNlNjhkXkEyXkFqcGc@._V1_FMjpg_UY3000_.jpg	2025-05-10 14:55:48	2025-05-10 14:55:48	TRANSLATED
91	1	Run All Night - GAHEZA	2015	7	Jimmy Conlon, a contract killer, is best friends with his mob boss Shawn Maguire. The situation changes when Shawn hires contract shooters to kill Michael, Jimmy's estranged son.	images (5) run all night.jpeg	2025-05-10 14:58:51	2025-05-10 14:58:51	TRANSLATED
92	1	Mr AND Mrs Smith - ROCKY	2005	9	A husband and wife struggle to keep their marriage alive until they realise they are both secretly working as assassins. Now, their respective assignments require them to kill each other.	download (2) ms-mr.jpeg	2025-05-10 15:01:56	2025-05-10 15:01:56	TRANSLATED
93	1	LOVE HURTS - GAHEZA	2025	8	Marvin is a Milwaukee realtor who receives a crimson envelope from Rose, a former partner-in-crime whom he left for dead. He now finds himself thrust back into a world of ruthless hit men and	images (5) love hurts.jpeg	2025-05-10 15:10:29	2025-05-10 15:10:29	TRANSLATED
94	1	DEMON CITY - SANKRA	2025	8	Framed for his family's murder and left for dead, an ex-hitman will stop at nothing to exact revenge on the masked "demons" who have taken over his city.	Demon_City_Netflix-p.jpg	2025-05-10 15:12:59	2025-05-10 15:12:59	TRANSLATED
95	1	JACK REACHER 2 - SANKRA	2016	7	Jack Reacher tries to free his closest friend, Major Susan Turner, who is accused of espionage and is arrested. In this attempt, he realises that they both are entrapped in a much bigger cons	819ac6c102d5a8d94f13af627c0f24d1.jpg	2025-05-10 15:48:25	2025-05-10 15:48:25	TRANSLATED
96	6	Flight Risk - GAHEZA	2025	8	A U.S. marshal boards a small plane to transfer a government witness to New York. As they cross the Alaskan wilderness, tensions start to rise as not everyone on the flight is who they appear	download (2) flightsdwsdsad.jpeg	2025-05-10 15:51:42	2025-05-10 15:51:42	TRANSLATED
97	1	COUTER STRIKE - GAHEZA	2025	7	When a hostage rescue mission creates a new enemy, Captain Guerrero and his elite soldiers must face an ambush by a criminal group.	images (5)counterattack.jpeg	2025-05-10 16:07:58	2025-05-10 16:07:58	TRANSLATED
98	6	Fight or Flight - GAHEZA	2025	9	A mercenary takes on the job of tracking a high-value asset known only as "The Ghost" on an international flight. Realizing the plane is filled with assassins assigned to kill them both, the 	download (2) flight of fight.jpeg	2025-05-10 16:11:03	2025-05-10 16:11:03	TRANSLATED
99	6	End of the Road - ROCKY	2022	8	A cross-country road trip becomes a highway to hell for Brenda, her two kids and her brother, Reggie. After witnessing a murder, the family finds itself in the crosshairs of a killer. Now alo	9b5100a3d428d95ed9cc619299e455d1.jpg	2025-05-10 16:13:55	2025-05-10 16:13:55	TRANSLATED
100	6	SURVIVOR - SANKRA	2015	6	A foreign service officer teams up with her colleague in order to prove her innocence while also trying to simultaneously thwart a terrorist attack.	images (1)survivior.webp	2025-05-10 16:17:21	2025-05-10 16:17:21	TRANSLATED
101	1	Panda Plan - GAHEZA	2024	8	Panda Plan is a 2024 Chinese action comedy film starring Jackie Chan.	images (5)panda plan.jpeg	2025-05-10 16:19:59	2025-05-10 16:19:59	TRANSLATED
102	6	Retribution - SANKRA	2023	9	While driving with his two kids, a man receives a phone call from an unknown assailant who claims there is a bomb in the car. Unable to exit the vehicle, he must now follow a series of twiste	images (5)retribution.jpeg	2025-05-10 16:22:58	2025-05-10 16:22:58	TRANSLATED
103	1	GARDNER - ROCKY	2021	8	A vicious home invader wreaks havoc on the inhabitants of a manor house in the middle of the night. Meanwhile, the gardener makes it his mission to protect the family.	images (5)gardener.jpeg	2025-05-10 16:26:52	2025-05-10 16:26:52	TRANSLATED
104	6	A Good Day to Die Hard - SANKRA	2013	7	Set in his ways, no-nonsense cop John McClane travels to Moscow, Russia to help his wayward son, Jack. But, when Jack turns out to be an undercover CIA agent, father and son team up to gun do	download (2) die hard.jpeg	2025-05-10 16:31:13	2025-05-10 16:31:13	TRANSLATED
105	1	Mechanic Resurrection - SANKRA	2016	9	Arthur, a contract killer, is forced to assassinate three men and make them look like accidents by his arch-rival, who kidnaps his girlfriend and threatens to kill her.	p12587950_v_v10_an.jpg	2025-05-10 16:33:59	2025-05-10 16:34:14	TRANSLATED
106	1	The Cleaner - Gaheza	2025	9	Hoping to expose corruption, radical activists take 300 hostages at an energy company's annual gala in a high-rise building. Their cause soon gets hijacked by an extremist within their ranks 	images (5) the cleaner.jpeg	2025-05-10 16:36:23	2025-05-10 16:36:23	TRANSLATED
107	3	TRAP - ROCKY	2024	8	A man and his teenage daughter realize they're at the center of a dark and sinister event while watching a concert.	533bf11c31e961dd0b13d70212248eb0.jpg	2025-05-10 16:38:50	2025-05-10 16:38:50	TRANSLATED
108	6	Hitman Agent 47 - SANKRA	2015	8	Agent 47, a genetically engineered assassin, teams up with a woman to find her father and his creator. However, they must get to him before a rival organization forces him to divulge his secr	images (1)hitman 47.webp	2025-05-10 16:40:47	2025-05-10 16:40:47	TRANSLATED
109	6	Gemini Man - SANKRA	2019	8	Henry is an ageing assassin who finds himself being chased by someone with the ability to predict his moves. He soon discovers that the person is his clone and sets out to discover his origin	MV5BMWY2ZmM4ZGEtODJjMC00MzY5LTk4ZmYtNzA5NmRhYzA5Y2EzXkEyXkFqcGc@._V1_QL75_UX190_CR0,0,190,281_.jpg	2025-05-10 16:43:05	2025-05-10 16:43:05	TRANSLATED
110	6	G20 - ROCKY	2024	8	When terrorists take over the G20 summit, US President Danielle Sutton uses her governing and military experience to defend her family, fellow leaders, and the world.	maxresdefaultg20.jpg	2025-05-10 16:45:36	2025-05-10 16:45:36	TRANSLATED
111	6	Nightcrawler - ROCKY	2014	8	Lou Bloom, a petty thief, becomes a photojournalist and sells footage of sensational and violent stories in Los Angeles to Nina, a news director. Soon, Lou turns desperate to stay ahead of th	p10939779_p_v10_adkdkkdd.jpg	2025-05-10 17:05:38	2025-05-10 17:05:38	TRANSLATED
112	1	The Lost Lands - GAHEZA	2025	8	A witch travels to the Lost Lands in search of a magical power that allows a person to transform into a werewolf.	images (5)lost land.jpeg	2025-05-10 17:20:27	2025-05-10 17:20:27	TRANSLATED
113	1	American Muscle - SANKRA	2014	8	After serving hard time for 10 years, an ex-con (Nick Principe) has 24 hours to take his revenge on those who put him in prison.	download (2)amarican masacle.jpeg	2025-05-10 17:24:05	2025-05-10 17:24:05	TRANSLATED
114	1	Nanked Weapon - YANGA	2002	8	When 40 young girls are kidnapped, a CIA is put in charge of the case but he does not get any leads. Later, when a series of assassinations take place, he suspects a connection between the ca	images (5)nakedpfkfgkgkg.jpeg	2025-05-10 17:33:42	2025-05-10 17:33:42	TRANSLATED
115	1	The Cure - SANKRA	2020	8	*The Cure* (2020) is a short action sci-fi film directed by Ahmet Atalay. Set in the near future, the story revolves around a **mysterious virus** that has infected a large portion of the wor	download (2)kfkdidkcod0erlrl,dd.jpeg	2025-05-10 17:41:42	2025-05-10 17:41:42	TRANSLATED
116	1	Havoc - SANKRA	2025	8	After a drug deal gone wrong, a bruised detective must fight his way through the criminal underworld to rescue a politician's estranged son, unravelling a deep web of corruption and conspirac	download (2)havoc.jpeg	2025-05-10 17:54:50	2025-05-10 17:54:50	TRANSLATED
117	6	Locked - ROCKY	2025	8	When Eddie breaks into a luxury SUV, he steps into a deadly trap set by a self-proclaimed vigilante who delivers his own brand of twisted justice. Trapped inside the car, Eddie soon discovers	download (2)lockedefvd.jpeg	2025-05-10 17:57:32	2025-05-10 17:57:32	TRANSLATED
118	1	The Cure 2 - SANKRA	2020	8	In the near future, a mysterious virus has taken over a large portion of the world's population.Upon contamination, it kills the host within a day. There is no permanent cure, only a temporar	images (5)lkdm2kemde23kdmkxsx.jpeg	2025-05-10 18:03:36	2025-05-10 18:03:36	TRANSLATED
119	6	Exterritorial - ROCKY	2025	9	When a soldier's son vanishes at a US consulate, she illegally remains on the premises to search for him, unknowingly entangling herself in a dangerous conspiracy.	download (2)exteritorial.jpeg	2025-05-10 18:06:58	2025-05-10 18:06:58	TRANSLATED
120	1	The Cold Light of Day - GAHEZA	2012	8	Will, a Wall Street businessman, is shaken when his family is kidnapped during a trip. As he embarks on a mission to save them, he is followed by intelligence agents to recover a mysterious b	download (2)thecold night.jpeg	2025-05-10 18:10:46	2025-05-10 18:11:03	TRANSLATED
121	6	Death Race - GAHEZA	2008	8	When Warden Hennessey offers Jensen and other prisoners a chance to compete in a car race and earn their freedom, millions watch as criminals with life sentences race armoured cars to earn fr	download (2)death race.jpeg	2025-05-10 18:30:43	2025-05-10 18:30:43	TRANSLATED
122	6	iHostage - GAHEZA	2025	8	When a gunman enters an Apple Store in the heart of Amsterdam, the police face a delicate challenge to resolve the stand-off.	download (2)nnnnnnnnnnnnnnnnnnnnnnn.jpeg	2025-05-10 18:33:01	2025-05-10 18:33:01	TRANSLATED
123	1	HOME FRONT - GAHEZA	2013	8	Phil Broker quits the DEA after his cover is blown during a failed mission and retires to a small town with his young daughter. Trouble follows them when Phil gets into a fight with a local d	91RPYFInHqL.jpg	2025-05-10 18:37:43	2025-05-10 18:37:43	TRANSLATED
124	4	We Are Family - ROCKY	2010	9	Separated from her husband, Aman, Maya lives with her three children. Aman lives with his girlfriend Shreya but decides to return to his family when Maya is diagnosed with cancer.	maxresdefaultwearefamily.jpg	2025-05-10 18:43:11	2025-05-10 18:43:11	TRANSLATED
125	1	BLITZ	2011	8	Detective Tom Brant is tasked with tracking down a serial killer who targets police officers. However, the culprit constantly frustrates him with his elusiveness.	downloadBLITZmoview.jpeg	2025-05-14 11:12:38	2025-05-17 08:18:52	TRANSLATED
126	9	Beautiful Disaster	2023	8	Travis Maddox spends his nights fighting in underground boxing matches, and his days as the ultimate college campus charmer. Intrigued by a freshman's resistance to his appeal, Travis offers 	downloadjdddddddddddd.jpeg	2025-05-17 08:52:05	2025-05-17 08:52:05	TRANSLATED
127	9	Maid in Manhattan	2002	8	'Maid in Manhattan' is a romantic comedy featuring Jennifer Lopez as Marisa Ventura, a hotel maid who falls in love with a rising politician, played by Ralph Fiennes. The film explores themes	download main in manhatann.jpeg	2025-05-17 08:57:12	2025-05-17 08:57:12	TRANSLATED
128	9	Private Valentine-SAVIMBI	2008	7	Private Valentine: Blonde & Dangerous is a 2008 American comedy film featuring Jessica Simpson as Megan Valentine, a Hollywood starlet who faces humiliation and financial troubles.	downloadPrivate Valentine.jpeg	2025-05-17 09:00:43	2025-05-17 09:00:43	TRANSLATED
129	9	The Boy Next Door- SANKARA	2015	8	When Claire Peterson engages in a steamy affair with Noah Sandborn, a man much younger than herself, little does she realise the consequences of her actions will have a perilous outcome.	download boy next door.webp	2025-05-17 09:03:44	2025-05-17 09:04:16	TRANSLATED
130	9	A Jazzman's Blues - ROCKY	2022	8	A tale of forbidden love and family drama unravels 40 years of secrets and lies in the deep south during an unsolved murder investigation.	download A Jazzman's Blues.jpeg	2025-05-17 09:06:42	2025-05-17 09:06:42	TRANSLATED
131	9	Love Don't Cost a Thing-YANGA	2003	7	Alvin, a nerd, yearns to associate with the popular groups at high school. His dream comes true, when Paris, a pretty cheerleader, agrees to pose as his girlfriend for two weeks.	download love not cont.jpeg	2025-05-17 09:11:06	2025-05-17 09:11:06	TRANSLATED
132	9	Purple Hearts - RCOKY	2022	7	Cassie, a struggling singer-songwriter agrees to marry a troubled Marine, Luke for military benefits. The line between real and pretend begins to blur.	download purple heart.jpeg	2025-05-17 09:13:26	2025-05-17 09:13:26	TRANSLATED
134	9	A Fall from Grace -ROCKY	2020	8	Jasmine, a public defender, decides to investigate the case of her latest client Grace, who confesses that she killed her husband.	maxresdefault fall from grace.jpg	2025-05-17 09:44:38	2025-05-17 09:44:38	TRANSLATED
136	9	365 Days	2020	7	The life of Laura, a simple sales director, changes when she takes a trip to Sicily but gets kidnapped by Massimo, a mafia member. Massimo keeps her hostage for 365 days to make her fall for 	365 Days.jpeg	2025-05-17 10:16:11	2025-05-17 10:16:11	TRANSLATED
137	9	Romeo + Juliet - PK	1996	8	The rivalry between Verona's two well-established families, the Capulets and the Montagues, affects the relationship of their children Romeo and Juliet.	Romeo + Juliet.jpeg	2025-05-17 10:31:54	2025-05-17 10:31:54	TRANSLATED
138	9	Fatale	2020	8	A successful sports agent in a strained marriage has a one-night stand with a beautiful woman. However, his life and reputation begin to spiral downwards following the encounter.	Fatale.jpeg	2025-05-17 10:35:16	2025-05-17 10:35:16	TRANSLATED
139	9	Vicious Affair - SANKRA	2023	7	Skyler's perfect life is uprooted when her best friend falls in love with her husband. iyi ni film nziza yakozwe na sankra da premier ariho nizindi nyinshi nziza ze	Vicious Affair.jpeg	2025-05-17 10:39:11	2025-05-17 10:39:11	TRANSLATED
140	9	August Rush - ROCKY	2007	7	Lyla and Louis, a singer and a musician, fall in love but are soon forced to separate. Lyla gives up her newborn to an orphanage, and unknown to her, he grows up to become a musical genius.	August Rush - ROCKY.jpeg	2025-05-17 10:45:36	2025-05-17 10:45:36	TRANSLATED
141	6	AWAKE - ROCKY	2007	6	As the scion of a wealthy banking family undergoes a heart transplant he's fully conscious, yet unable to move. That's when he discovers the operation is slated to fail in order to claim his 	AWAKE - ROCKY.jpeg	2025-05-17 10:51:57	2025-05-17 10:51:57	TRANSLATED
142	9	TO ALL THE BOYS - DYLAN	2018	7	Lara Jean, a high school girl, writes letters to the boys she is infatuated with but keeps them in her closet instead of mailing them. Things change when her sister discovers the letters.	71TsljeDmxL._AC_UF1000,1000_QL80_TO ALL THE BOYS - DYLAN.jpg	2025-05-17 10:56:19	2025-05-17 10:56:19	TRANSLATED
143	9	DEVORCE IN BLACK - ROCKY	2024	8	Ava's husband, Dallas, leaves her heartbroken as he deserts their marriage. Dallas' malicious actions unravel as Ava gets a chance to find true love with her destined soulmate.	DEVORCE IN BLACK - ROCKY.jpeg	2025-05-17 10:59:57	2025-05-17 10:59:57	TRANSLATED
144	9	Namaste Wahala - SAVIMBI MUSA	2020	7	An interracial couple face a new dilemma when their respective parents find out about their relationship and disapprove.	Namaste Wahala - SAVIMBI MUSA.jpeg	2025-05-17 11:04:14	2025-05-17 11:04:14	TRANSLATED
145	9	Marry Me - ROCKY	2022	8	Latin superstar Kat Valdez decides to impetuously marry an audience member during her concert after she learns of her fiance's infidelity before her live performance.	Marry Me - ROCKY.jpeg	2025-05-17 11:06:08	2025-05-17 11:06:08	TRANSLATED
146	9	The Royal Treatment - ROCKY	2022	7	New York hairdresser Izzy seizes the chance to work at the wedding of a charming prince. When sparks start to fly between the two of them, love and duty are put to the test as the time of the	The Royal Treatment - ROCKY.jpeg	2025-05-17 11:07:30	2025-05-17 11:07:30	TRANSLATED
147	9	After Ever Happy A - DIDIER	2022	6	After Ever Happy is a 2022 American romantic drama film directed by Castille Landon from a screenplay by Sharon Soboil, based on the 2015 novel of the same name by Anna Todd.	5i1i70gzfr29.jpg	2025-05-17 11:10:19	2025-05-17 11:10:19	TRANSLATED
148	9	AFTER - DYLAN	2019	7	Tessa, a young student and devoted girlfriend, looks forward to greater prospects in college. However, she soon meets Hardin, an enigmatic rebel who makes her question her notions of life and	AFTER - DYLAN.jpeg	2025-05-17 11:13:31	2025-05-17 11:13:31	TRANSLATED
149	9	After We Fell - DIDIER	2021	5	The future of Tessa and Hardin's passionate love is challenged when their ambitions and promises fail to align with their raging emotions.	After We Fell A - DIDIER.jpeg	2025-05-17 11:16:25	2025-05-17 11:16:25	TRANSLATED
150	6	Fatal Seductio S1 - ROCKY	2023	7	A married woman goes on a dangerous weekend trip away from home that sparks desire but ends tragically, making her wonder if the people close to her are telling the truth.	8ymbyph10435ddddd.jpeg	2025-05-17 11:23:55	2025-05-17 11:31:39	TRANSLATED
151	9	Lady Voye - ROCKY	2023	8	"Lady Voyeur" is a Brazilian thriller TV mini-series that follows Miranda, a skilled hacker and avid voyeur, who lives across the street from Cl├⌐o, a luxury prostitute. When Cl├⌐o asks Miranda	MV5BMjVkMzVlMTctN2E5Zi00YzQ2LTgxYTItN2E4Yzk4MDdiM2QzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg	2025-05-17 11:40:20	2025-05-17 11:40:20	TRANSLATED
153	9	My Secret Billionaire - ROCKY	2011	9	To satisfy his father's wish, a handsome and powerful billionaire travels to New York City poised as a working-class guy. When he meets a beautiful and down-to-earth real estate agent, he dis	My Secret Billionaire - ROCKY.jpeg	2025-05-17 12:19:54	2025-05-17 12:19:54	TRANSLATED
154	4	The Ex Wife  - Sankra	2022	7	Tasha and Jack seem to have a happy life with their child Emily, but Jack's relationship with his ex-wife hinders the family. Later, Jack and Emily go missing.	The Ex Wife Ep1 - Sankra.jpeg	2025-05-17 12:23:23	2025-05-17 12:23:23	TRANSLATED
155	4	Beauty in Black S1 - ROCKY	2024	9	A stripper's fate takes a turn when she crosses paths with the wealthy, dysfunctional family behind a cosmetics dynasty and a devious trafficking scheme.	AAAAQaDOaPRxZFQqfHJ1ZTHw_j3QaY5_hOdB4O-nYpb33IZ4YFlRpZwGYBPNRW6XoEdieOd9ujdsJ5Rccodq34KQ_j628XuIfR8OEt5lb6AKwnY6NdcXswTtKD8OjYCtYmYUnUSulO5gEjSMr9l6wWdkHshq.jpg	2025-05-17 12:30:35	2025-05-17 12:30:35	TRANSLATED
156	3	IMMACULE - ROCKY	2024	8	An American nun embarks on a new journey when she joins a remote convent in the Italian countryside. However, her warm welcome quickly turns into a living nightmare when she discovers her new	IMMACULE.jpeg	2025-05-17 12:47:00	2025-05-17 12:47:00	TRANSLATED
158	3	SLAXX - GAHEZA	2020	7	A possessed pair of jeans terrorizes trapped workers at a trendy clothing store.	SLAXX - GAHEZA.jpeg	2025-05-17 12:53:04	2025-05-17 12:53:04	TRANSLATED
159	3	FINAL DESTINATION - ROCK	2000	8	Plagued by a violent and recurring nightmare, a college student heads home to track down the one person who might be able to break the cycle of death and save her family from the grisly demis	FINAL DESTINATION - ROCK.jpeg	2025-05-17 12:56:33	2025-05-17 12:56:33	TRANSLATED
160	3	THE UNHOLY - GAHE	2021	8	Alice, a girl with hearing impairment, is able to hear, speak and even heal the ill after having visions of the Virgin Mary. But when a journalist probes into the matter, he unearths a conspi	THE UNHOLY - GAHEZA.jpeg	2025-05-17 12:58:54	2025-05-17 12:58:54	TRANSLATED
161	3	The Silence	2019	8	When the world is under attack by a swarm of creatures called vesps, Ally, a teenager who is aurally impaired, and her family take refuge in a house in a remote place.	The Silence.jpeg	2025-05-17 13:01:24	2025-05-17 13:01:24	TRANSLATED
162	3	Angels Fallen: Warriors of Peace - GAHEZA SIMBA	2024	7	Called by a higher power, an Iraq War veteran embarks on a mission to stop a fallen angel from raising an army of the dead to take over the world.	Angels Fallen Warriors of.jpeg	2025-05-17 13:04:35	2025-05-17 13:04:35	TRANSLATED
163	3	Night Teeth - ROCKY	2021	8	A college student moonlighting as a chauffeur picks up two mysterious women for a night of party-hopping across LA. However, when he uncovers their bloodthirsty intentions and their dangerous	Night Teeth - ROCKY.jpeg	2025-05-17 13:08:03	2025-05-17 13:08:03	TRANSLATED
164	3	Rat Disaster - GAHEZA SIMBA	2021	8	Su Zhenghuai boards a train to visit his relatives with his children. However, when the train is attacked by rats, Zhenghuai must find a way to save the passengers and his family.	Rat Disaster - GAHEZA SIMBA.jpeg	2025-05-17 13:09:55	2025-05-17 13:09:55	TRANSLATED
165	3	Peninsula - SANKARA	2020	8	Jung Seok, a former soldier, along with his teammates, sets out on a mission to battle hordes of post-apocalyptic zombies in the Korean peninsula wastelands.	Peninsula - sankra.jpg	2025-05-17 13:11:54	2025-05-17 13:11:54	TRANSLATED
166	3	The Last House on the Left - YANGA	2009	6	A couple shows kindness to a group of strangers, unaware that the same men just assaulted their daughter. However, when the truth is revealed, the devastated parents plan revenge.	The Last House on the Left - YANGA.jpeg	2025-05-17 13:15:23	2025-05-17 15:51:39	TRANSLATED
168	3	Don't Move - ROCKY	2024	7	When a killer injects her with a paralytic agent, a woman must run, fight and hide before her body completely shuts down.	Don't Move - ROCKY.jpeg	2025-05-17 13:56:51	2025-05-17 13:56:51	TRANSLATED
169	3	Time Cut - ROCKY	2024	8	A teen in 2024 accidentally time-travels to 2003, days before a masked killer murders his sister.	Time Cut - ROCKY.jpeg	2025-05-17 13:59:48	2025-05-17 13:59:48	TRANSLATED
170	3	Resident Evil - GAHEZA	2002	7	Claire and her brother Chris get caught in a zombie outbreak in the dying Raccoon City. They must band together with others to survive and uncover the truth about the experiments held in the 	MV5BYmI3YjJkN2ItY2ZmYS00Y2JhLTk2YTQtYzE5YWU5ODI1MzJmXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg	2025-05-17 14:03:58	2025-05-17 14:04:14	TRANSLATED
171	3	Cold Meat - Master P	2023	9	David Petersen is passing through the Colorado Rockies during a blizzard. One false move behind the wheel has him waking up inside a ravine, in the eye of the storm. But the cold is the least	Cold Meat A - Master P.webp	2025-05-17 14:08:20	2025-05-17 14:08:20	TRANSLATED
172	3	Scary Stories to Tell in the Dark - GAHEZA SIMBA	2019	7	In 1968, the night of Halloween brings mayhem in a small town when a group of friends discovers a notebook written by a mysterious girl that foretells terrifying events.	Scary Stories to Tell in the Dark - GAHEZA SIMBA.jpeg	2025-05-17 14:10:22	2025-05-17 14:10:22	TRANSLATED
173	3	Smile 2 - SANKRA	2028	8	About to embark on a new world tour, global pop sensation Skye Riley begins to experience increasingly terrifying and inexplicable events. Overwhelmed by the escalating horrors and pressures 	Smile 2 - SANKRA.jpeg	2025-05-17 14:12:21	2025-05-17 14:12:21	TRANSLATED
174	3	READY OR NOT - ROCKY	2019	8	After the wedding ceremony of a young woman, her new in-laws force her to participate in a seemingly innocent game. Things soon turn bloody and sinister, revealing the sick rituals of the fam	READY OR NOT - ROCKY.jpeg	2025-05-17 14:14:45	2025-05-17 14:14:45	TRANSLATED
175	3	UNDER PARIS - SANKRA	2024	8	To save Paris from a bloodbath, a grieving scientist is forced to face her tragic past when a giant shark appears in the Seine.	UNDER PARIS - SANKRA.jpeg	2025-05-17 14:18:02	2025-05-17 14:18:02	TRANSLATED
176	3	Carrie - ROCKY	2013	7	Carrie, an awkward teenager protected by fanatical mother, becomes the butt of all jokes in school. When the pranks of her classmates go out of hand, she unleashes her telekinetic powers.	Carrie - ROCKY.jpeg	2025-05-17 14:23:51	2025-05-17 14:23:51	TRANSLATED
177	3	The Unborn - GAHEYA SIMBA	2009	7	When Casey Beldon witnesses a series of paranormal activities around her, she takes the help of a spiritual adviser and soon finds out a frightful family secret solely responsible for her con	The Unborn - GAHEYA SIMBA.jpeg	2025-05-17 14:27:13	2025-05-17 14:27:13	TRANSLATED
178	3	I Spit on Your Grave - GAHEZA	2010	7	Jennifer (Sarah Butler), a writer, rents an isolated cabin in the country so she can work on her latest novel. The peace and quiet is soon shattered by a gang of local thugs who rape and tort	I Spit on Your Grave - GAHEZA.jpeg	2025-05-17 14:30:01	2025-05-17 14:30:01	TRANSLATED
179	3	In the Tall Grass - GAHEZA	2019	7	A brother and sister enter a field of tall grass to rescue a boy, but they soon realize they cannot escape and something evil lurks in the grass.	In the Tall Grass - GAHEZA.jpeg	2025-05-17 14:32:27	2025-05-17 14:32:27	TRANSLATED
180	1	The Collective - MASTER P	2023	8	A group of righteous assassins called the Collective takes aim at a highly sophisticated human trafficking ring that's backed by a network of untouchable billionaires. With their back against	The Collective - MASTER P.jpeg	2025-05-17 14:36:29	2025-05-17 14:36:29	TRANSLATED
181	3	From S1 - SANKARA	2022	8	"FROM" is a sci-fi horror TV series about a mysterious town that traps all who enter. Residents struggle to survive the town and the creatures of the surrounding forest, particularly during t	From S1ep1 - Sankra.jpg	2025-05-17 14:46:41	2025-05-17 14:46:41	TRANSLATED
182	3	From S2 - SANKARA	2022	8	The residents of a small town struggle to find a way out when mysterious unknown forces keep them from leaving.	From S1ep1 - Sankra.jpg	2025-05-17 14:58:40	2025-05-17 14:58:40	TRANSLATED
183	3	WOLF MAN - HABIBU	2025	8	Blake and his family are attacked by an unseen animal and, in a desperate escape, barricade themselves inside a farmhouse as the creature prowls the perimeter. As the night stretches on, howe	WOLF MAN - HABIBU.jpeg	2025-05-17 15:15:18	2025-05-17 15:15:18	TRANSLATED
184	3	EVIL DEAD - YANGA	2013	6	The *Evil Dead* franchise is a legendary series in the horror genre, created by Sam Raimi. It began with the 1981 film *The Evil Dead*, which follows a group of friends who unwittingly unleas	EVIL DEAD IKIKANGO.jpeg	2025-05-17 15:21:07	2025-05-17 15:21:07	TRANSLATED
185	3	Abraham Linkon Vampire Hunter - Sankra	2012	8	Abraham Lincoln loses his mother at a young age and discovers that she was killed by a vampire. Years later, he becomes the president of the USA and makes it his mission to wipe out the blood	Abraham Linkon Vampire Hunter - Sankra.jpeg	2025-05-17 15:29:54	2025-05-17 15:29:54	TRANSLATED
186	3	The Originals - DYLAN	2013	8	The Original family of vampires settle down in the city of New Orleans that they helped to construct several decades ago. They encounter old buddies and confront new foes.	The Originals Ep1 - Dylan.jpeg	2025-05-17 15:33:00	2025-05-17 15:33:00	TRANSLATED
187	3	The Exorcism of God - SANKRA	2021	9	Peter Williams is an American priest in Mexico who's considered a saint by many local parishioners. However, due to a botched exorcism, he carries a dark secret that's eating him alive until 	The Exorcism of God - SANKRA.jpeg	2025-05-17 15:40:54	2025-05-17 15:40:54	TRANSLATED
188	3	It Feeds - GAHEZA	2025	8	A clairvoyant therapist confronts her own personal demons while trying to save a young girl who believes a malevolent entity is feeding on her.	It Feeds - GAHEZA.jpeg	2025-05-17 15:43:29	2025-05-17 15:43:29	TRANSLATED
189	3	No Way Up - GAHEZA	2024	8	Trapped underwater when their plane crashes into the ocean, survivors must find a way to escape as sharks start to circle the wreckage.	No Way Up - GAHEZA.jpeg	2025-05-17 15:45:39	2025-05-17 15:45:39	TRANSLATED
190	3	FREAKY - ROCKY	2020	7	An ancient dagger causes a high-school student to switch bodies with a middle-aged serial killer. She must reverse it within 24 hours, or she will forever occupy the man's body.	FREAKY - ROCKY.jpeg	2025-05-17 15:47:25	2025-05-17 15:47:25	TRANSLATED
191	3	Home Sweet Home - SAVIMBI	2025	8	Based on the hit Home Sweet Home video game franchise, a police officer is thrust into an alternate realm and, with a mysterious monk's help, races against the clock to save his wife and stop	Home Sweet Home - SAVIMBI.jpeg	2025-05-17 15:48:47	2025-05-17 15:48:47	TRANSLATED
192	1	Last Bullet - SAVIMBI	2025	8	Car genius Lino returns to conclude his vendetta against Areski and the corrupt commander who ruined their lives.	Last Bullet - SAVIMBI.jpeg	2025-05-17 17:40:12	2025-05-17 17:40:12	TRANSLATED
193	7	Fighter - ROCKY	2024	9	Shamsher Pathania fulfills his lifelong dream and becomes a member of the Indian air force. As he faces rigorous challenges, Patty must rise above his own limitations to become a true hero.	Fighter A - ROCKY.jpg	2025-05-17 17:42:18	2025-05-17 18:14:35	TRANSLATED
194	7	Amaran - Fey	2024	8	A true-life story of Major Mukund Varadarajan, a commissioned officer in the Indian Army`s Rajput Regiment, who was posthumously awarded the Ashok Chakra for his valor during a counterterrori	Amaran A - Fey.jpeg	2025-05-17 17:50:26	2025-05-17 17:50:26	TRANSLATED
195	7	Captain Miller - Senior	2024	9	A renegade Captain and his unconventional outlaws execute daring heists in the 1930s and 1940s. Miller must decide whether to continue running or confront the challenges head-on.	Captain Miller - Senior.jpeg	2025-05-17 17:56:54	2025-05-17 17:56:54	TRANSLATED
196	7	Bang Bang - FEY	2014	7	Harleen leads a boring life with her grandmother and works as a bank receptionist. However, her life takes a sudden turn after she falls in love with Rajveer, a thief.	Bang Bang A - FEY.jpeg	2025-05-17 18:09:32	2025-05-17 18:09:32	TRANSLATED
197	1	Vikings S2 - ROCKY	2014	9	The second season of the historical drama television series Vikings premiered on February 27, 2014, on History in Canada, and concluded on May 1, 2014, consisting of ten episodes. The series 	Vikings_Season_2.jpg	2025-05-17 18:17:24	2025-05-17 18:17:24	TRANSLATED
198	1	Vikings S3 - ROCKY	2015	8	The third season of the historical drama television series Vikings premiered on February 19, 2015, on History in Canada, and concluded on April 23, 2015, consisting of ten episodes. The serie	Vikings_Season_3.jpg	2025-05-17 18:27:49	2025-05-18 17:34:14	TRANSLATED
199	6	The Chosen - SAVIMBI	2017	8	The Chosen is a historical drama based on the life of Jesus and those who knew him. Set against the backdrop of Roman oppression in first-century Israel, the series shares an authentic look a	the choosen.jpeg	2025-05-17 18:41:50	2025-05-27 18:02:49	TRANSLATED
200	5	Mutant - Senior	2024	7	In the 2024 Chinese sci-fi movie "Mutant", artificial intelligence has risen to power, controlling the Earth and initiating an eradication campaign against humans. The surviving humans are fi	Mutant - Senior.jpg	2025-05-17 18:54:05	2025-05-17 18:54:05	TRANSLATED
201	7	Mazaka	2025	9	Ramana, a devoted single father, and his son Krishna unexpectedly fall in love. Their happiness is short-lived when they realize that both women are related, stirring family opposition. As te	mazaka.jpeg	2025-05-17 19:10:38	2025-05-17 19:11:30	TRANSLATED
203	6	Drop	2025	8	Violet is a widowed mother who goes to an upscale restaurant to meet Henry, her charming and handsome date. However, her pleasant evening soon turns into a living nightmare when she receives 	drop movie.jpeg	2025-05-18 17:29:35	2025-05-18 17:29:35	TRANSLATED
204	4	Blood Sisters - SAVIMBI	2022	9	Bound by a dangerous secret, friends Sarah and Kemi are forced to go on the run after a wealthy groom disappears during his engagement party.	Blood Sisters.jpg	2025-05-21 19:03:49	2025-05-21 19:03:49	TRANSLATED
205	4	Dirty Linen - ROCKY	2023	8	After the mysterious disappearance of house help from a wealthy family's house, four of their relatives start working there again after many years. They are focused on seeking revenge and ans	zkm9qopie782 dirty line.jpg	2025-05-22 21:21:28	2025-05-22 21:21:28	TRANSLATED
206	3	Final destination Bloodlines - ROCKY	2025	9	Plagued by a violent and recurring nightmare, a college student heads home to track down the one person who might be able to break the cycle of death and save her family from the grisly demis	Final destination Bloodlines - ROCKY.jpeg	2025-05-22 21:28:22	2025-05-22 21:28:22	TRANSLATED
207	7	Duplicate - THE GRATE	1999	7	Manu, a criminal, finds his doppelganger in a budding chef, Bablu, and uses this fact to his advantage. Later, Manu tries to kill the chef so that he can take over his life and escape the law	Duplicate.jpeg	2025-05-25 13:41:35	2025-05-25 13:41:35	TRANSLATED
208	5	Aquaman and the lost kingdom - Gaheza	2022	9	After failing to defeat Aquaman the first time, Black Manta wields the power of the mythic Black Trident to unleash an ancient and malevolent force. Hoping to end his reign of terror, Aquaman	Aquaman and the Lost Kingdom.jpeg	2025-05-27 17:46:46	2025-05-27 17:46:46	TRANSLATED
209	1	Colombiana - De Great	2011	7	When Cataleya witnesses her parents' death, she goes on to become an expert assassin and sets out to seek revenge against the culprits.	Colombiana.jpeg	2025-05-27 17:52:10	2025-05-27 17:52:10	TRANSLATED
210	1	G.I. Joe: Retaliation - Sankara	2013	9	The Joes are declared traitors by Zartan, and the Cobra Commander now has all the world leaders under his control. With nowhere to go, the remaining Joes turn to their original leader, Genera	G.I. JoeRetaliation.jpeg	2025-05-27 17:57:33	2025-05-27 20:34:16	TRANSLATED
211	1	vikings s4 - ROCKY	2013	8	As Ragnar Lodbrok, a Norse farmer, carries out triumphant raids into English territory with the help of his fellow warriors, he ends up holding sway over the Vikings and becoming a Scandinavi	Vikings_Season_4_Volume_2.png	2025-05-27 18:09:07	2025-05-27 18:09:07	TRANSLATED
212	1	Fury 12 hours - SANKARA	2024	8	Overview. A retired Chinese soldier, Lei Jun, finds himself in a race against time when a terrorist attack targets a Chinese community abroad. With only 12 hours to act, he must summon all hi	fury-12-hours-2024.webp	2025-05-27 20:33:59	2025-05-27 20:33:59	TRANSLATED
213	1	Tin Soldier - KIM	2025	8	"Tin Soldier," a 2025 action thriller, is directed by Brad Furman and stars Jamie Foxx, Robert De Niro, and Scott Eastwood. The film follows a former soldier who returns to a cult leader's co	Tin Soldier.jpg	2025-05-28 19:43:59	2025-05-28 19:43:59	TRANSLATED
214	1	Mayhem - GAHEZA	2023	8	Mayhem! (2023) is an action-thriller film directed by Xavier Gens. It follows Sam, a professional boxer and ex-convict, who relocates to Thailand to escape his troubled past. However, his lif	Mayhem.jpeg	2025-05-28 19:48:03	2025-05-28 19:48:03	TRANSLATED
215	3	Until Dawn - GAHEZA	2025	8	One year after her sister disappeared, Clover and her friends head to the remote valley where she vanished to search for answers. Exploring an abandoned visitor center, they soon encounter a 	until down.jpeg	2025-05-28 19:51:43	2025-05-30 10:59:22	TRANSLATED
216	4	The Kid Who Would Be King - ROCKY	2019	8	Alex, a 12-year-old boy, and his friends fight an evil sorceress with the help of Excalibur, the sword of King Arthur, in a bid to save the world from her atrocities.	The Kid Who Would Be King.jpeg	2025-05-30 11:02:45	2025-05-30 11:03:05	TRANSLATED
217	7	The Diplomat - SINIYA	2025	8	An Indian diplomat tries to repatriate an Indian girl from Pakistan, where she was presumably forced and deceived into marrying against her will.	the diplomate.jpeg	2025-05-30 11:07:24	2025-05-30 11:07:24	TRANSLATED
218	7	K.G.F: Chapter 2 - SINIYA	2022	7	Rocky successfully rises as the leader and saviour of the people of the Kolar Gold Fields. But, in his goal to fulfil his mother's wishes, Rocky must tackle Adheera, Inayat Khalil and Ramika 	kgf-chapter-2.jpeg	2025-05-30 11:11:04	2025-05-30 11:11:04	TRANSLATED
219	7	Sikandar - ROCKY	2025	8	A young, passionate individual challenges a widespread corrupt system, advocates for the rights of ordinary citizens and disrupts established power structures in a country marked by unfairnes	Sikandar.jpg	2025-05-30 11:22:02	2025-05-30 11:22:02	TRANSLATED
220	1	Fountain of Youth - ROCKY	2025	9	Two estranged siblings partner on a global heist to find the mythological Fountain of Youth. They must use their knowledge of history to follow clues on an adventure that will change their li	Fountain of Youth.jpg	2025-05-31 14:04:56	2025-05-31 14:04:56	TRANSLATED
221	1	Headhunters - SANKARA	2011	8	Roger is not only Norway's most accomplished headhunter but also an art thief. He is married to Diana who owns an art gallery. Their lives change when Diana introduces Roger to a former merce	Headhunters.jpg	2025-06-01 11:38:17	2025-06-01 11:38:17	TRANSLATED
222	3	Rosario - SANKARA	2025	8	Wall Street stockbroker Rosario Fuentes returns to her grandmother's apartment after her sudden death. While sorting through her belongings, Rosario discovers a hidden chamber that's filled w	Rosario.jpg	2025-06-01 11:41:42	2025-06-01 11:41:42	TRANSLATED
223	3	Sinners - ROCKY	2025	9	Trying to leave their troubled lives behind, twin brothers return to their Mississippi hometown to start again, only to discover that an even greater evil is waiting to welcome them back.	sinners.jpeg	2025-06-02 12:44:15	2025-06-02 12:44:15	TRANSLATED
224	7	Pushpa: The Rise - ROCKY	2021	9	A labourer named Pushpa makes enemies as he rises in the world of red sandalwood smuggling. However, violence erupts when the police attempt to bring down his illegal business.	puspa the arise.jpeg	2025-06-02 14:58:38	2025-06-02 14:58:38	TRANSLATED
225	7	Pushpa 2: The Rule - FEY	2024	9	A powerful smuggler goes head-to-head with a vengeful enemy while controlling politics and managing high-stakes confrontations. A public apology sparks a tense showdown, culminating in a chal	pushpa2 the rule.jpeg	2025-06-02 15:04:05	2025-06-02 15:08:43	TRANSLATED
226	7	Vaamana - FEY	2025	8	Vaamana is a 2025 Indian Kannada-language action film directed by Shankar Raman S and produced by Chethan Kumar Gowda under Equinox Global Entertainments. The film stars Dhanveer Gowda and Re	Vaamana.jpg	2025-06-02 23:22:05	2025-06-02 23:22:45	TRANSLATED
227	6	Triada Season 01 - JUNIOR GITI	2023	8	Aleida Trujano learns that she is one of the three triplets. After this surprising discovery, the detective embarks on a dangerous search for clues to unravel her mysterious past.	Triptych.jpg	2025-06-03 09:22:33	2025-06-03 09:22:33	TRANSLATED
228	1	Unbeatable Youth - SINIYA	2014	7	When a martial artist invites his rivals from different parts of China to a party, tensions rise because each warrior vows to prove their supremacy.	unbtable-youth-scaled.webp	2025-06-04 00:43:29	2025-06-04 00:43:29	TRANSLATED
229	9	Love Per Square Foot - SAVIMBI	2018	7	In order to be able to purchase their first home, Karina and Sanjay enter into a marriage of convenience. But they gain more than they bargained for.	Love Per Square Foot.jpeg	2025-06-04 15:17:57	2025-06-04 15:17:57	TRANSLATED
230	4	The Cleaning Lady S01 - SANKARA	2022	9	When whip-smart Cambodian doctor Thony De La Rosa comes to the United States for medical treatment to save her ailing son, she soon discovers her path won't be as straightforward as she had h	The-Cleaning-Lady-S01.jpg	2025-06-06 09:30:29	2025-06-06 09:30:29	TRANSLATED
231	4	 The Cleaning Lady S02	2022	9	In Season 2 of "The Cleaning Lady," Thony De La Rosa, a cleaning lady for organized crime, faces new challenges after her son, Luca, is kidnapped by his father. She teams up with FBI agent Ga	The-Cleaning-Lady-S02.jpg	2025-06-06 09:39:17	2025-06-06 09:39:17	TRANSLATED
232	4	The Cleaning Lady S03 - SANAKARA	2024	6	In Season 3 of "The Cleaning Lady," Thony finds herself increasingly entangled with the criminal world, working for Ramona and her organization while also navigating a new reality without her	The-Cleaning-Lady-S03.jpg	2025-06-06 09:51:19	2025-06-06 09:51:19	TRANSLATED
233	4	The Cleaning Lady S04	2024	9	In Season 4 of "The Cleaning Lady," Thony De La Rosa finds herself entangled with the Sanchez cartel, facing increasingly dangerous situations as she navigates her life and the criminal under	The-Cleaning-Lady-S04.jpg	2025-06-06 11:18:36	2025-06-06 11:18:36	TRANSLATED
234	7	Jaat - ROCKY	2025	9	In a remote coastal village, criminal Varadaraja Ranatunga terrorizes the locals. A traveling stranger's encounter with his men uncovers the villagers' suffering.	Jaat_film_poster.jpg	2025-06-07 09:47:13	2025-06-07 13:52:22	TRANSLATED
235	6	Straw - Rocky	2025	9	traw is a 2025 American psychological crime drama film directed by Tyler Perry, focusing on the struggles of a single mother as she navigates a series of unfortunate events. 	Straw.jpg	2025-06-08 14:32:47	2025-06-08 14:32:47	TRANSLATED
237	7	Maaveeran	2023	8.5	After an accident, a timid cartoonist begins to hear the voice of a comic character he has created. Guided by this voice, he takes a stand against a group of evil men.	Maaveeran.jpeg	2025-06-11 11:24:59	2025-06-11 11:24:59	TRANSLATED
240	7	Attack - Senior	2022	7.3	A terrorist attack renders Arjun paralysed and distraught with the thoughts of his dead lover. So, when the attacker returns, Arjun participates in an experiment to seek revenge.	poster-5544a2f3-b74d-4819-958d-6d2bbad645b0.jpg	2025-06-13 16:16:08.979	2025-06-13 16:16:08.979	TRANSLATED
241	7	Tools Jewel Thief - Senior	2025	8.6	In this high-octane battle of wits and wills, ingenious con artist Rehan devises a diamond heist while trying to outsmart Rajan, his sadistic adversary.	poster-9925b7b6-7669-4846-96a0-b4c076576618.jpg	2025-06-13 16:42:34.109	2025-06-13 16:42:34.109	TRANSLATED
242	1	Trouble - ROCKY	2025	8.9	Wrongfully convicted of murder, an electronics salesman faces police corruption and criminal conspiracies in an attempt to prove his innocence.	poster-586c1d11-f256-47ac-8339-1336035d879c.jpg	2025-06-13 16:50:41.499	2025-06-13 16:50:41.499	TRANSLATED
243	7	Naa Peru Surya - B Da Great	2018	8.9	A soldier aspiring to be posted at the LOC suffers from anger management issues, due to which he gets court-martialled. He then sets out to meet a psychologist whose approval can get him back on duty.	poster-e3f80ed6-ce31-452b-8608-0af63b62edf1.jpg	2025-06-14 18:41:49.402	2025-06-14 18:41:49.402	TRANSLATED
244	1	Nameless Heroes - B Da Great	2023	7.9	On the eve of the Liaoshen campaign, the Northeast Field Army attacked the counties around Jinzhou and surrounded Jinzhou. The intelligence agent code-named "Green Snake" was arrested, and Lin Xi, the head of the Confidentiality Bureau with heavy responsibilities, was ordered to go to Jinzhou to conduct a thorough investigation of the incident together with Zhou Yingqun of the Party Communication Bureau and Jiang Wei of the Second Department of National Defense. Lin Xi was actually a red agent whose secret mission was to rescue the "Green Snake" and help him hand over the Jinzhou city defense map to the east outside the city to support the attack on Jinzhou. Unexpectedly, in the city of Jinzhou, there were surging undercurrents and numerous changes.	poster-a4a61ad0-5498-4a6f-8c84-aaca3060439c.jpg	2025-06-14 18:45:49.882	2025-06-14 18:45:49.882	TRANSLATED
245	1	Ramabanam - B Da Great	2023	8.2	Vicky runs away from home after having a disagreement with his brother Rajaram and goes on to become a known gangster. Years later when he returns, the two polar opposite brothers reunite.	poster-917e6db9-15e9-468b-a236-2d3dc4ac804d.jpg	2025-06-14 18:49:05.691	2025-06-14 18:49:05.691	TRANSLATED
246	1	The Lord of the Rings: The Rings of Power - PK	2022	7.8	Galadriel and an injured Halbrand arrive in Eregion. Halbrand gives Celebrimbor the idea of forging the mithril with other metals to enhance its strength. Galadriel becomes suspicious and checks into the royal lineages of the Southlands.	poster-de6d7df8-a6b2-4261-a6ab-78cf464a7358.jpg	2025-06-14 18:54:01.108	2025-06-14 18:54:01.108	TRANSLATED
247	1	Pathaan - GAHEZA	2023	9.3	A Pakistani general hires a private terror outfit to conduct attacks in India while Pathaan, an Indian secret agent, is on a mission to form a special unit.	poster-1a09fc39-e034-433e-ae28-54e685a55695.jpg	2025-06-14 19:02:16.829	2025-06-14 19:02:16.829	TRANSLATED
248	6	Triple Frontier - SANKRA	2019	7.8	With the help of information provided by Yovanna, Pope recruits a crew to steal money from Lorea, a drug lord. However, greed gets the best of them, sparking discord.	poster-7958650b-81e8-43e6-b070-3c80ccc97fc0.jpg	2025-06-14 19:06:38.766	2025-06-14 19:06:38.766	TRANSLATED
249	4	Vis a Vis - ROCKY	2015	9.5	Vis a Vis (also known as Locked Up) season 1 centers on Macarena Ferreiro, a young woman who is imprisoned for a crime she committed under duress. Her naive nature is quickly challenged as she navigates the harsh realities of prison life and the dangerous dynamics among inmates, particularly with the cunning and ruthless Zulema. Season 1 focuses on Macarena's struggle to survive in prison, adapt to her new environment, and deal with the emotional and physical challenges of confinement. 	poster-4745e478-9386-4882-8868-024711b591e9.jpg	2025-06-15 14:01:42.327	2025-06-15 14:01:42.327	TRANSLATED
250	4	Vis a Vis season 2 _ ROCKY	2015	8.6	Vis a Vis season 2 continues the story of Macarena, now linked with Zulema and her crew, as they navigate the challenges of prison life and the consequences of their escape attempt. New, stricter rules are imposed by Miranda, and the police are desperately searching for the escaped inmates. The season also explores the evolving relationship between Macarena and Zulema, as well as other inmates, alongside increased action and twists. 	poster-b407ec87-8bbd-4f2b-a3b4-3eb047bade5d.jpg	2025-06-15 16:33:20.444	2025-06-15 16:33:20.444	TRANSLATED
251	4	Vis a Vis Season 3 - ROCKY	2018	8.2	Vis a Vis season 3, also known as Locked Up season 3, sees the inmates of Cruz del Sur transferred to a new, more dangerous prison, Cruz del Norte, due to overcrowding. This new environment forces them to adapt and unite against new threats, including a powerful Chinese gang and the prison guards who are now armed. The season explores the power dynamics within Cruz del Norte, with Macarena and Zulema facing new challenges and rivalries. 	poster-ebfd6a7d-d93f-49ac-9954-f5fc6c7e0ca5.jpg	2025-06-15 16:37:53.093	2025-06-15 16:37:53.093	TRANSLATED
252	4	Vis a Vis season 4 - ROCKY	2018	8.9	Vis a Vis season 4, the final season, focuses on the aftermath of the prison riot and the power struggles within Cruz del Norte. Key storylines include Zulema and Saray's fractured friendship, the introduction of Altagracia as an inmate, and the impact of Sandoval's harsh leadership. Macarena, recovering from a coma, faces a changed prison environment while dealing with the consequences of past actions. The season culminates in a final confrontation and reveals the fates of several main characters. 	poster-064ffab2-87be-42b9-8162-354f945ceeb7.jpg	2025-06-15 16:39:46.407	2025-06-15 16:39:46.407	TRANSLATED
253	1	Counter Attack (Attaque programm├⌐e) - Master P	2021	8.2	A security expert working on an oil plant feels trapped when false evidence of murder is fabricated against him. Moreover, he plans to counterstrike to prove his innocence.	poster-370c6e7f-97a4-45ae-818e-0047e1217515.jpg	2025-06-17 15:16:57.028	2025-06-17 15:16:57.028	TRANSLATED
254	1	Eye for an Eye 2 - Master P	2024	7.2	A highly trained and exceptionally deadly swordsman looks for revenge after being caught in the middle of a power struggle that results in the assassination of an innocent woman's family.	poster-b58ad323-d964-4eb5-8ef1-17773f645ca5.jpg	2025-06-17 15:21:28.349	2025-06-17 15:21:28.349	TRANSLATED
255	1	King Arthur: Legend of the Sword - Vj Steppin	2017	8	Arthur learns about his royal lineage after he pulls the Excalibur, a magical sword, from a stone. Along with Sir Bedivere, he sets out to destroy King Vortigern, who had killed his father.	poster-0f69bd28-c293-4fdd-afd6-80113b2e3a8b.jpg	2025-06-17 15:25:19.643	2025-06-17 15:25:19.643	TRANSLATED
256	1	Ghost Rider - SANKARA	2017	7.7	The Ghost Rider film series consists of two main movies: Ghost Rider (2007) and Ghost Rider: Spirit of Vengeance (2012). The first film, starring Nicolas Cage as Johnny Blaze, a stunt motorcyclist who makes a deal with the devil, was directed by Mark Steven Johnson. The sequel, directed by Neill Marshall and Brian Taylor, features Johnny Blaze again, but with a different storyline and a more intense tone. 	poster-3d7843ec-449c-4d3e-8c51-c53b2c133172.jpg	2025-06-17 15:28:52.946	2025-06-17 15:28:52.946	TRANSLATED
257	1	Diablo - ROCKY	2024	9.3	Ex-con Kris Chaney seizes the daughter of a Colombian gangster to fulfill a noble promise to the young girl's mother. When her father enlists both the criminal underworld and a psychotic killer to exact his revenge, Kris relies on everything he's ever learned to stay alive and keep his word.	poster-edf09743-c3b5-4da8-934c-0edf2289dd0e.jpg	2025-06-18 08:58:43.429	2025-06-18 08:58:43.429	TRANSLATED
258	6	Unhinged - ROCKY	2022	6.7	Rachel gets into a small argument with the stranger on the road. But the man turns out to be mentally unstable and makes her a target of his rage, killing and injuring several people.	poster-9f869de6-8e50-45a1-945b-8f05ceb013c4.jpg	2025-06-18 09:06:23.881	2025-06-18 09:06:23.881	TRANSLATED
259	1	The 100 Season 01 - Sankara	2014	8	A nuclear conflict has decimated civilisation. A century later, a spaceship accommodating humanity's lone survivors dispatch 100 juvenile delinquents back to the Earth to determine its habitability.	poster-ddb86d36-035d-43d6-acaa-3f82ce136d1b.jpg	2025-06-18 12:54:48.75	2025-06-18 12:54:48.75	TRANSLATED
260	6	P├ílpito Season 01	2022	9.4	Simon's wife is murdered in order to remove her heart and transplant it into the wife of a powerful millionaire. Seeking revenge, Simon throws himself into the dangerous world of organ trafficking.	poster-7709894f-a156-4a69-bb65-5295fb30cbf9.jpg	2025-06-18 17:38:23.947	2025-06-18 17:38:23.947	TRANSLATED
261	1	The 100 Season 02	2014	8.2	The 100's second season dives deeper into the post-apocalyptic world and the complex moral dilemmas faced by the survivors. Picking up immediately after the first season finale, the group is scattered and facing new threats, primarily from the Mountain Men who reside in Mount Weather and are harvesting bone marrow from the delinquents to survive the radiation. The season explores themes of survival, rebuilding society, and the ethical costs of keeping humanity alive. 	poster-34b523aa-0208-4d9f-af70-13877ad089a6.jpg	2025-06-20 14:56:43.344	2025-06-20 14:56:43.344	TRANSLATED
262	7	Bhimaa - B Da Great	2024	7.9	After some mysterious instances at a temple of historical significance, a detective visits the region to investigate and find out the truth behind the incidents.	poster-31537218-2fd3-4053-8678-f8c29830f16a.jpg	2025-06-20 15:14:59.941	2025-06-20 15:14:59.941	TRANSLATED
263	1	13 Sins - Rocky	2014	9.1	Elliot, an indebted salesman, finds himself part of a hidden-camera game show where he has to execute 13 tasks to win a grand prize. But the tasks become increasingly macabre with the passage of time.	poster-6ef3ceec-308e-4312-9a59-39f53ed0ef7f.jpg	2025-06-20 15:19:48.216	2025-06-20 15:19:48.216	TRANSLATED
264	1	The Guest - SANKARA	2018	8.8	While the Petersons grieve over their son Caleb, a soldier who died in action, David appears at their doorstep claiming to have known him. At the same time, a series of killings begin in the town.	poster-5fd6e61d-9ea8-412b-ba8f-06d715ce7dd5.jpg	2025-06-21 13:48:42.452	2025-06-21 13:48:42.452	TRANSLATED
270	1	The Old Guard - Rocky	2022	8.1	A group of mercenaries, all centuries-old immortals with the ablity to heal themselves, discover someone is onto their secret, and they must fight to protect their freedom.	poster-1a6bec68-6602-498b-bd8c-c23d099b7c98.jpg	2025-06-24 17:33:54.909	2025-06-24 17:33:54.909	TRANSLATED
266	7	Kesari - SAVIMBI	2019	9.2	Havildar Ishar Singh, a soldier in the British Indian Army, leads 21 Sikh soldiers in a fight against 10,000 Pashtun invaders. However, what unfolds is the greatest last stand wars of all time.	poster-ffd0361c-61d5-4118-8c7c-e9e4ca0d62c2.jpg	2025-06-22 18:48:00.988	2025-06-22 18:48:00.988	TRANSLATED
267	7	Kesari Chapter 2 (full) - Rocky	2025	8.8	Kesari Chapter 2: The Untold Story of Jallianwala Bagh is a 2025 Indian Hindi-language historical courtroom drama film directed by Karan Singh Tyagi and produced by Dharma Productions, Leo Media Collective, and Cape of Good\n	poster-01b7e261-6419-4472-ad98-8b669172c05a.jpg	2025-06-22 18:49:15.552	2025-06-22 18:49:15.552	TRANSLATED
268	6	Deep Water - SANKARA	2022	8.4	A well-to-do husband who allows his wife to have affairs in order to avoid a divorce becomes a prime suspect in the disappearance of her lovers.	poster-86fc9a7f-8dc9-4d9d-bf17-7d5060ff3763.jpg	2025-06-22 18:51:18.383	2025-06-22 18:51:18.383	TRANSLATED
269	6	Action Jackson - Da Great	2011	7.5	Vishi, a small-time crook, looks like AJ, a professional assassin. AJ convinces Vishi to help him fool the mob so he can be with his wife while she has a baby, and as the crooks close in on Vishi, AJ arrives to deal with them.	poster-6af5e846-1a1d-4f90-b8a1-49189057dd00.jpg	2025-06-24 17:26:02.64	2025-06-24 17:26:02.64	TRANSLATED
271	1	Shadow Force - Gaheza	2025	8.6	An estranged couple with a bounty on their heads must go on the run with their son to avoid their former employer, a unit of shadow ops that has been sent to kill them.	poster-8d2e22d0-739a-4857-88ad-cf5a0c223796.jpg	2025-06-24 17:35:32.137	2025-06-24 17:35:32.137	TRANSLATED
272	1	Shadow Master - GAHEZA	2022	7.9	Bibire works for Jamal, who encourages her to deceive their clients. However, their plan will turn sour when Mike becomes involved. With Femi Adebayo. A Yoruba language movie with English subtitles.	poster-8440196d-b5d3-44d8-8fbe-e4d8c2f378c6.jpg	2025-06-24 22:45:29.837	2025-06-24 22:45:29.837	TRANSLATED
273	4	Duplicity - DYLAN	2025	7.3	A high-powered attorney faces her most personal case yet when she's tasked with uncovering the truth behind the shooting death of her best friend's husband. With help from her boyfriend -- a former cop turned private investigator -- her search for what really happened leads her down a treacherous maze of deception and betrayal.	poster-bdc31f65-d1e2-4a12-803f-6e0472f0ae8b.jpg	2025-06-25 08:51:39.406	2025-06-25 08:51:39.406	TRANSLATED
274	1	The Prot├⌐g├⌐ - Sankara	2021	6.5	Anna is raised and trained by Moody, an extremely skilled assassin. But when he gets brutally murdered, she uses all her training to find his killers and exact bloody revenge.	poster-178580e8-8c88-4978-8e17-62ba9a68e6f6.jpg	2025-06-26 21:44:01.588	2025-06-26 21:44:01.588	TRANSLATED
275	7	Radhe Shyam - ROCKY	2022	9.2	In 1970s Europe, a world-renowned palmist named Vikramaditya finds love when he meets Prerana, a doctor. However, their relationship is threatened by his view of destiny and a terminal illness.	poster-ceb36a7e-83ad-46b6-aa8a-5484e45c96cd.jpg	2025-06-26 22:08:09.969	2025-06-26 22:08:09.969	TRANSLATED
277	1	Squid Game season 1 - Rocky	2021	8.8	A story of people who fail at life for various reasons, but suddenly receive a mysterious invitation to participate in a survival game to win more than 38 million US dollars. The game takes place on an isolated island and the participants are locked up until there is a final winner.	poster-398e61f2-51c7-40e8-97c4-cc8307a0caa5.jpg	2025-06-27 23:01:23.135	2025-06-27 23:01:23.135	TRANSLATED
278	1	Squid Game season 2	2025	9.2	Kim and Woo-seok are abducted by the Recruiter and forced into a deadly game of rock paper scissors combined with Russian roulette, resulting in Kim's death. Jun-ho locates Gi-hun's base. There, the Recruiter confronts Gi-hun, revealing he once served as a soldier in the games and killed his own father, a player.	poster-e177f25c-7c86-4701-8149-ec73be56b962.jpg	2025-06-27 23:12:33.847	2025-06-27 23:12:33.847	TRANSLATED
288	6	Outer Banks Season 03 - Rocky	2023	9	Outer Banks season 3 sees the Pogues stranded on a deserted island they dub "Poguelandia" after escaping a treasure hunt gone wrong in season 2. They are eventually rescued, only to be thrown into a new treasure hunt for El Dorado, led by a ruthless treasure hunter named Carlos Singh. The season involves betrayals, kidnappings, near-death experiences, and reunions, ultimately leading to the discovery of El Dorado and the deaths of Ward and Big John. 	poster-c654b514-595f-4fcc-9fb3-a0f479fb618f.jpg	2025-07-01 20:59:37.25	2025-07-01 20:59:37.25	TRANSLATED
279	1	Squid Game Season 3 - Rocky	2025	9.1	\n\nΓÇ£WeΓÇÖll see how Gi-hun returns to the game arena and faces the challenges and games ahead,ΓÇ¥ creator and director Hwang Dong-hyuk tells Tudum. ΓÇ£The story focuses on Seong Gi-hunΓÇÖs transformation and how he overcomes what comes his way.ΓÇ¥   \n\nThe newly released images below hint at whatΓÇÖs in store for Gi-hun, his enigmatic antagonist the Front Man (Lee Byung-hun), and more characters caught in the terrifying competition. In one of the photos, you see a devastated Gi-hun handcuffed to a bed in the player dormitory. Lee Jung-jae empathized deeply with his character while filming Squid GameΓÇÖs final six episodes. 	poster-f5bd3b00-8edd-4423-9a81-9d08e303db66.jpg	2025-06-27 23:20:58.892	2025-06-27 23:20:58.892	TRANSLATED
280	4	Jumong Season 01 (full) - Master P	2009	9.4	Jumong was the founder of Goguryeo in 37 BC. He was the son of General Hae Mo Su and Lady Yoo Hwa and was raised by King Geum Wa, who took him and his mother in when Hae Mo Su was believed to have been killed in an ambush by the Han Dynasty.	poster-34a20ce1-838d-41fc-aa7b-b0718b9a4322.jpg	2025-06-28 18:00:01.472	2025-06-28 18:00:01.472	TRANSLATED
281	3	Shark Bait - Sankara Da Premier	2022	7.8	Some friends who are enjoying a weekend steal a couple of jet skis, race them out to sea and end up in a horrific head-on collision. They struggle to find a way home with a badly injured friend while predators lurk below the water.	poster-2f35e00d-2898-45b0-b320-fa97f26eceb3.jpg	2025-06-30 17:52:57.513	2025-06-30 17:52:57.513	TRANSLATED
282	5	Doctor Strange 2	2022	8.1	Doctor Strange teams up with a mysterious teenage girl from his dreams who can travel across multiverses, to battle multiple threats, including other-universe versions of himself, which threaten to wipe out millions across the multiverse.	poster-6a434240-0434-4167-b001-fc94ee277e67.jpg	2025-06-30 18:07:33.763	2025-06-30 18:07:33.763	TRANSLATED
283	10	Sonic the Hedgehog1 - Master P.	2020	7.7	Sonic the Hedgehog is a blue anthropomorphic hedgehog and the main protagonist of the Sonic video game series and Sega's mascot. He is known for his incredible speed, able to run faster than the speed of sound. Sonic's signature move is rolling into a ball to attack enemies. He often embarks on adventures to protect his world from his nemesis, Dr. Eggman, and other threats. 	poster-ea34f097-f947-47e3-95e6-090abec81752.jpg	2025-06-30 18:37:48.425	2025-06-30 18:37:48.425	TRANSLATED
284	10	Sonic the Hedgehog 2 - Dylan Kabaka	2022	8.2	After settling in Green Hills, Sonic is eager to prove that he has what it takes to be a true hero. His test comes when Dr. Robotnik returns with a new partner, Knuckles, in search of a mystical emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.	poster-a886337f-9b20-4883-b207-b52aa32bea7f.jpg	2025-06-30 18:45:23.264	2025-06-30 18:45:23.264	TRANSLATED
285	10	Sonic the Hedgehog 3 - Kapo	2024	7.8	Sonic, Knuckles and Tails reunite to battle Shadow, a mysterious new enemy with powers unlike anything they've faced before. With their abilities outmatched in every way, they seek out an unlikely alliance to stop Shadow and protect the planet.	poster-ae0bea62-9758-4d59-ab91-9a83bc818aad.jpg	2025-06-30 18:52:41.672	2025-06-30 18:52:41.672	TRANSLATED
286	6	Outer banks season 1 - Rocky	2020	8.9	Outer Banks season 1 follows a group of teenagers, the Pogues, on a treasure hunt for the legendary Royal Merchant gold, connected to the disappearance of John B's father. The Pogues, led by John B, face off against the wealthy "Kooks" while navigating romance, societal divides, and dangerous secrets. Ultimately, they find the gold, but it's stolen by Ward Cameron, Sarah's father, who also frames John B for murder. 	poster-b003f3ff-b15a-45fe-9241-57ca454c22f4.jpg	2025-07-01 20:55:11.371	2025-07-01 20:55:11.371	TRANSLATED
287	6	Outer banks season 2 - Rocky	2023	9.1	Outer Banks season 2 continues the adventure of the Pogues as they navigate life as fugitives after John B is framed for murder. They find themselves in the Bahamas, pursued by the Camerons and battling new enemies while searching for the gold. Meanwhile, back on the Outer Banks, the rest of the group works to clear John B's name. The season culminates in a near-death experience for Sarah and a shocking revelation about Pope's lineage and a valuable artifact. 	poster-9c25f74b-e03e-48cf-a667-4d4a3d96c740.jpg	2025-07-01 20:57:48.318	2025-07-01 20:57:48.318	TRANSLATED
289	6	Outer Banks - Season 04 - Rocky	2024	9.5	Outer Banks season 4 sees the Pogues return to their treasure-hunting ways after a brief attempt at a normal life, drawn back in by Wes Genrette's offer to find Blackbeard's treasure. They establish a new haven called "Poguelandia 2.0" and a charter business, but financial troubles and a dangerous new enemy force them back into the game. The season explores themes of identity, sacrifice, and the consequences of their actions, with a focus on the mystery surrounding Blackbeard's Blue Crown. 	poster-213a774f-a45f-4446-8446-8ec88a3bf2d1.jpg	2025-07-01 21:03:41.798	2025-07-01 21:03:41.798	TRANSLATED
290	7	Heropanti 2 - Da Great	2022	8.4	RJ enters the glamourous life of Inaaya and Laila, a notorious cyber-criminal. Action and trouble multiply tenfold when Inaaya believes RJ is her former lover.	poster-e0e8665f-3c0e-4681-92d5-5b43ac0439cb.jpg	2025-07-01 21:29:28.152	2025-07-01 21:29:28.152	TRANSLATED
291	1	The Night Agent Season 01 - Junior Giti	2023	7.9	"The Night Agent" season 1 is a 10-episode action thriller following FBI agent Peter Sutherland. He's tasked with monitoring a rarely used emergency phone line for undercover agents, which leads him to protect Rose Larkin after she witnesses her aunt and uncle's murder. Their investigation uncovers a conspiracy involving high-ranking White House officials and a plot to harm the president. 	poster-a28e3015-951e-43b7-a2ae-7f2ab8a34f5d.jpg	2025-07-02 15:13:23.481	2025-07-02 15:13:23.481	TRANSLATED
292	1	 The Night Agent Season 02 - Junior Giti	2025	7.8	"The Night Agent" Season 2 continues the story of Peter Sutherland, now a full-fledged Night Agent, as he navigates a dangerous new mission involving a conspiracy that reaches into the highest levels of government. The season picks up nine months after the events of season one, with Peter in the middle of his first Night Action assignment, which quickly goes awry. He finds himself caught in a web of deceit and betrayal, with danger lurking both inside and outside the organization. 	poster-0dba61a6-ca3b-4dd1-a8df-d121aa5ffce5.jpg	2025-07-02 15:20:46.06	2025-07-02 15:20:46.06	TRANSLATED
295	1	John Wick 1 - Rocky	2014	9.1	Legendary assassin John Wick (Keanu Reeves) retired from his violent career after marrying the love of his life. Her sudden death leaves John in deep mourning. When sadistic mobster Iosef Tarasov (Alfie Allen) and his thugs steal John's prized car and kill the puppy that was a last gift from his wife, John unleashes the remorseless killing machine within and seeks vengeance. Meanwhile, Iosef's father (Michael Nyqvist) -- John's former colleague -- puts a huge bounty on John's head.	poster-877fc04b-51c3-434c-ade6-47b4a8e427c8.jpg	2025-07-04 09:21:34.683	2025-07-04 09:21:34.683	TRANSLATED
296	1	John Wick 2 - Rocky	2017	9.1	Retired super-assassin John Wick's plans to resume a quiet civilian life are cut short when Italian gangster Santino D'Antonio shows up on his doorstep with a gold marker, compelling him to repay past favours. Ordered by Winston, the kingpin of secret assassin society The Continental, to respect the organisation's ancient code, Wick reluctantly accepts the assignment to travel to Rome to take out D'Antonio's sister, the ruthless capo atop the Italian Camorra crime syndicate.	poster-42b3bd78-0204-488d-a954-d3000907b2f1.jpg	2025-07-04 09:23:46.167	2025-07-04 09:23:46.167	TRANSLATED
297	1	 John Wick 3 - Rocky	2019	9.3	After gunning down a member of the High Table -- the shadowy international assassin's guild -- legendary hit man John Wick finds himself stripped of the organization's protective services. Now stuck with a $14 million bounty on his head, Wick must fight his way through the streets of New York as he becomes the target of the world's most ruthless killers.	poster-afd4f617-b609-48af-9b87-efc316ff54a8.jpg	2025-07-04 09:26:24.392	2025-07-04 09:26:24.392	TRANSLATED
298	1	 John Wick 4 -Rocky	2023	9.4	With the price on his head ever increasing, legendary hit man John Wick takes his fight against the High Table global as he seeks out the most powerful players in the underworld, from New York to Paris to Japan to Berlin.	poster-25c09fe0-5247-4c5e-afe3-d148e9dfadf6.jpg	2025-07-04 09:28:58.685	2025-07-04 09:28:58.685	TRANSLATED
299	1	Ballerina - ROCKY	2025	9.3	Trained in the assassin traditions of the Ruska Roma, Eve Macarro takes on an army of killers as she seeks revenge against those responsible for the death of her father.	poster-4ce2ebec-89a0-4dec-931b-3e31f5a0e54b.jpg	2025-07-04 09:31:26.71	2025-07-04 09:31:26.71	TRANSLATED
300	1	To Live Through Death - Gaheza	2024	8.3	"To Live Through Death" is a 2024 action film about a man named Chen who confronts a human trafficking organization to save his kidnapped daughter. He reveals a hidden past and teams up with a local policeman named Can to fight the criminal group. The film features martial arts actors Andy On and Fan Siu-wong, and is directed by Ren Gaoliang. It is described as a classic-style action film with engaging plot and strong fight choreography. 	poster-636904b6-07cb-4fdb-be3b-cdf2b09bd69a.jpg	2025-07-06 08:58:16.47	2025-07-06 08:58:16.47	TRANSLATED
301	1	Twilight of the Warriors - Sankara	2024	7.5	The notorious Kowloon Walled City serves as a fortified, lawless safe haven for gangs and refugees alike. But when a skilled underground fighter runs afoul of the most feared Triad boss in Hong Kong, a bounty is placed on his head.	poster-fe47434b-1c77-4a82-92cc-f07e3226977a.jpg	2025-07-06 09:01:13.566	2025-07-06 09:01:13.566	TRANSLATED
302	1	The Maze Runner 1 - PK	2014	7.4	Thomas (Dylan O'Brien), a teenager, arrives in a glade at the center of a giant labyrinth. Like the other youths dumped there before him, he has no memory of his previous life. Thomas quickly becomes part of the group and soon after demonstrates a unique perspective that scores him a promotion to Runner status -- those who patrol the always-changing maze to find an escape route. Together with Teresa (Kaya Scodelario), the only female, Thomas tries to convince his cohorts that he knows a way out.	poster-1cad87c4-e58e-4298-8450-11946f5c231c.jpg	2025-07-06 09:04:40.043	2025-07-06 09:04:40.043	TRANSLATED
303	1	Maze Runner 2: The Scorch Trials - PK	2015	8.1	Transported to a remote fortified outpost, Thomas and his fellow teenage Gladers find themselves in trouble after uncovering a diabolical plot from the mysterious and powerful organization WCKD. With help from a new ally, the Gladers stage a daring escape into the Scorch, a desolate landscape filled with dangerous obstacles and crawling with the virus-infected Cranks. The Gladers only hope may be to find the Right Hand, a group of resistance fighters who can help them battle WCKD.	poster-ed4a930f-a57c-45c1-990d-50e86565ce96.jpg	2025-07-06 09:07:42.113	2025-07-06 09:07:42.113	TRANSLATED
304	1	Pirates of the Caribbean 1 - PK	2003	8.7	Capt. Jack Sparrow (Johnny Depp) arrives at Port Royal in the Caribbean without a ship or crew. His timing is inopportune, however, because later that evening the town is besieged by a pirate ship. The pirates kidnap the governor's daughter, Elizabeth (Keira Knightley), who's in possession of a valuable coin that is linked to a curse that has transformed the pirates into the undead. A gallant blacksmith (Orlando Bloom) in love with Elizabeth allies with Sparrow in pursuit of the pirates.	poster-655f73ac-1874-4a04-aaf0-3521aa34d283.jpg	2025-07-06 09:27:33.776	2025-07-06 09:27:33.776	TRANSLATED
305	1	Pirates of the Caribbean 2 - PK	2006	8.1	When ghostly pirate Davy Jones (Bill Nighy) comes to collect a blood debt, Capt. Jack Sparrow (Johnny Depp) must find a way to avoid his fate lest his soul be damned for all time. Nevertheless, the wily ghost manages to interrupt the wedding plans of Jack's friends Will Turner (Orlando Bloom) and Elizabeth Swann (Keira Knightley).	poster-2e270574-c28a-4ff9-a5cb-49500c4a1458.jpg	2025-07-06 09:31:14.106	2025-07-06 09:31:14.106	TRANSLATED
306	1	Pirates of the Caribbean 3 - PK	2007	8.8	Will Turner (Orlando Bloom) and Elizabeth Swann (Keira Knightley) join forces with Capt. Barbossa (Geoffrey Rush) to free Jack Sparrow (Johnny Depp) from Davy Jones' locker. Meanwhile, the crew of the Flying Dutchman ghost ship wreaks havoc on the Seven Seas. The friends must navigate dangerous waters to confront Chinese pirate Sao Feng (Chow Yun-Fat) and, ultimately, they must choose sides in a battle wherein the pirate life hangs in the balance.	poster-2406c2ad-813d-48ca-93af-dbceb440e4b3.jpg	2025-07-06 09:33:49.899	2025-07-06 09:33:49.899	TRANSLATED
348	1	Freaky Tales	2025	6.2	An NBA star, a corrupt cop, a female rap duo, teenage punks, neo-Nazis and a debt collector embark on a collision course in 1987 Oakland, Calif.	https://res.cloudinary.com/daryajfms/image/upload/v1753961517/movie-posters/poster-3e447cd2-b65c-495d-816c-a61951b3e7fb.jpg	2025-07-31 11:31:58.208	2025-07-31 11:31:58.208	ORIGINAL
307	1	Pirates of the Caribbean 4 - Master P	2011	7.5	The checkered past of Capt. Jack Sparrow (Johnny Depp) catches up to him when he encounters Angelica (Pen├⌐lope Cruz), a beautiful pirate that Jack once loved then left. Angelica forces him to accompany her to the Queen Anne's Revenge, the ship of the notorious Blackbeard (Ian McShane). Accompanied by a zombie crew, the trio sets sail to find the legendary Fountain of Youth. However, Jack's rival, Barbossa (Geoffrey Rush), also seeks the fountain, as does a ship from Spain.	poster-8e2479ba-5ca9-4ac8-8558-13111b3028f5.jpg	2025-07-06 09:38:31.645	2025-07-06 09:38:31.645	TRANSLATED
308	1	Pirates of the Caribbean 5 - PK	2017	9.2	Thrust into an all-new adventure, a down-on-his-luck Capt. Jack Sparrow feels the winds of ill-fortune blowing even more strongly when deadly ghost sailors led by his old nemesis, the evil Capt. Salazar, escape from the Devil's Triangle. Jack's only hope of survival lies in seeking out the legendary Trident of Poseidon, but to find it, he must forge an uneasy alliance with a brilliant and beautiful astronomer and a headstrong young man in the British navy.	poster-cc3aa435-bbcc-4a8f-8f70-18a32c45f2d5.jpg	2025-07-06 09:40:36.069	2025-07-06 09:40:36.069	TRANSLATED
309	1	Maze Runner 3 - PK	2018	8.2	A group of friends immune to a virus that has had a destructive effect on the human population, embark on a journey to rescue a boy being tortured by a criminal organisation.	poster-e4a75f13-a352-4447-b301-22329188d1c6.jpg	2025-07-06 16:14:10.402	2025-07-06 16:14:10.402	TRANSLATED
311	1	The Old Guard 2 - Be The Great	2025	6.3	Andy leads immortal warriors against a powerful enemy threatening their group. They grapple with the resurfacing of a long-lost immortal, complicating their mission to safeguard humanity.	poster-545fe676-d687-48b3-ab63-082cee17d238.jpg	2025-07-06 16:17:06.68	2025-07-06 16:17:06.68	TRANSLATED
312	1	Land of Bad - ROCKY	2024	7	When a Delta Force team is ambushed in enemy territory, a rookie officer refuses to abandon them. Their only hope lies with an Air Force drone pilot as the eyes in the sky during a brutal 48-hour battle for survival.	poster-6bd15140-db2f-4936-b771-eb4516a30285.jpg	2025-07-06 16:20:35.04	2025-07-06 16:20:35.04	TRANSLATED
313	1	The Stranger in My Home - Mungeli	2025	7.2	Ali meets a mysterious man who claims to be the father of her teenage daughter, Katie. What begins as an unsettling encounter soon spirals into a nightmare of long-buried secrets, lies and obsession.	poster-368c8e7d-e77b-4a22-bff3-8936a23b4ba4.jpg	2025-07-06 16:29:06.722	2025-07-06 16:29:06.722	TRANSLATED
314	1	Heads of State - Rocky	2025	8.1	U.S. President Will Derringer and British Prime Minister Sam Clarke have a not-so-friendly and very public rivalry. However, when Air Force One gets shot down over enemy territory, they find themselves on the run and working together to thwart a global conspiracy that threatens the entire free world.	poster-affad962-bb5b-490e-ac13-df96d8b7c6f9.jpg	2025-07-09 09:40:28.252	2025-07-09 09:40:28.252	TRANSLATED
315	1	 Karate Kid: Legends - B da great	2025	7.9	After moving to New York City with his mother, kung fu prodigy Li Fong struggles to let go of the past as he tries to fit in with his new classmates. When a new friend needs his help, Li enters a karate competition -- but his skills alone aren't enough. With help from Mr. Han and Daniel LaRusso, he soon learns to merge two styles into one for the ultimate martial arts showdown.	poster-dc3885c6-5098-4c13-b658-4dfec30a3ad3.jpg	2025-07-09 14:18:48.415	2025-07-09 14:18:48.415	TRANSLATED
316	4	Cinderella Game S01 - B Da Great	2024	8.5	Cinderella Game" is a 2024 South Korean television series (kdrama) about a woman who discovers she was adopted into a wealthy family and seeks revenge on her enemy who caused her to lose her family and life, according to the IMDb and Wikipedia. The series stars Na Young-hee, Han Groo, Choi Sang, Ji Soo-won, Kim Hye-ok, Choi Jong-hwan, Park Ri-won, and Kwon Do-hyung. The show is also referred to as "Cinderella Game (Korean: ∞ïáδì░δáÉδ¥╝ Ω▓î∞₧ä)". The series premiered on December 2, 2024, with 101 episodes, and is set to conclude on April 25, 2025. 	poster-41b4c5bb-b706-4171-bae0-1b12b8b641e7.jpg	2025-07-10 16:31:47.293	2025-07-10 16:31:47.293	TRANSLATED
317	1	The Old Guard 2 - Rocky	2025	8.4	The Old Guard 2 brings the franchise down to a richer, more mature level of immortality, loyalty and sacrifice. The film flings viewers into another dimension of the old magic and new menace, and provides depth of dramatic narrative as well as action at its highest. A balance between heavy fight scenes and character moments are perfectly giving out in the story, as this group of outsiders deals with the re-emergence of Quynh, an immortal they had lost so many years ago, as well as the death of Booker who had died in order to help them survive. The friendship betrayal and the moral dilemma of eternal life also thread the whole story and make it appear deeper than most action stories.	poster-6c709b73-5823-4b2d-af54-1d6d1946761d.jpg	2025-07-11 15:32:58.424	2025-07-11 15:32:58.424	TRANSLATED
318	2	Work It - Dylan Kabaka	2020	7.5	The movie, Buried in Barstow, is a hard-boiled, rough film, which deals with the redemption, motherhood, coming to terms with the past. It begins by captivating its viewers into a world where things are not what they seem and in most cases, it requires extreme decisions, which are sometimes ruthless. The adventure of Hazel King, a woman tormented by the past, to a woman determined to protect her child touched me quite deeply. This author has managed to make her tough and vulnerable and this makes her a complex and likable main character because I could not stop reading because of her emotional depth especially as she plot an evil world of violence and secrets.	poster-30983186-ec2d-4bd7-b8c4-5116544c611d.jpg	2025-07-11 15:35:45.327	2025-07-11 15:35:45.327	TRANSLATED
319	6	Buried in Barstow - Sankara Da Premier	2022	7.9	A single mother and former hit woman's dark past keeps coming back to haunt her, despite her desire for a quiet life.	poster-aedb3fd6-f47b-4b79-bca2-8483001598d2.jpg	2025-07-11 15:38:35.322	2025-07-11 15:38:35.322	TRANSLATED
320	7	Chhaava 	2025	8.1	Although Chhaava is an emotional and a visually powerful piece of story-telling, there are times when she relegates intricate political forces to pure simplicity which makes certain battles sound simpler than they probably were during historical times. However, the gradual rhythm of the movie, emotional dialogues, and lyrical music enhance the emotional appeal, and one can feel the story even months after watching the movie. Finally, it is an emotional celebration of sheer determination and self-sacrifice that makes one proud and astonished at the sheer determination of a superhero in a tough situation.	poster-f81eae4d-46f3-4934-a3f7-8a87ef44b283.jpg	2025-07-14 21:20:25.909	2025-07-14 21:20:25.909	TRANSLATED
321	4	Red Shoes S01-Savimbi	2014	7.3	Red Shoes S01 is an intense Korean drama with a thick plot shedding light upon the elements of love, betrayal, revenge, and emotional wounds. The crux of the show is the traumatizing effect of abandonment and the quest of justice as experienced by rich, nuanced women. The fact that Hee-Kyung abandons her family to follow her first love represents a catalyst that impacts significantly on her daughter, Jem-ma, who lives in resentment having lost her father after the latter dies mysteriously. The story perfectly juggles the close family drama with the darker motives of vengeance so that every episode has an emotional intensity to it.	poster-3f57ecdf-f0af-4867-8e3d-58ee82241d4f.jpg	2025-07-14 21:27:29.799	2025-07-14 21:27:29.799	TRANSLATED
349	6	The Accountant 2	2025	6.2	Forensic accountant Christian Wolff teams up with his estranged but highly lethal brother to track down mysterious assassins.	https://res.cloudinary.com/daryajfms/image/upload/v1753961675/movie-posters/poster-304ad332-a625-465f-93b0-801401229ef1.jpg	2025-07-31 11:34:36.316	2025-07-31 11:34:36.316	ORIGINAL
322	1	Lucy - Sankara Da Premier	2014	8.3	Lucy is a daring and thrilling action science concepts with philosophical quests that takes the audience to an extreme path of change. At its most basic level it argues with the idea of the potential of humans, as we get to explore what could occur should we determine just how far we could get our minds to go. The very persistence of its characters blazes through the film, and the superb visual effects result in an adrenaline rush of a film, backed up by deeper topics of empowerment, control, and evolution. The cinematography and direction is excellent, and Scarlett Johansson does a fine job as Lucy, as the audience watches her story go through depths of insecurity to kill or be killed.	poster-7db620fd-eb7b-43ff-b5f7-5aa6305d3f2d.jpg	2025-07-14 21:50:59.536	2025-07-14 21:50:59.536	TRANSLATED
323	9	Snow White - Gaheza	2025	7.1	The movie Snow White brings a new and touching vision of the fairy tale written long ago with magical images and a moving story. Since the very beginning, it plunges the audience into the world filled with the contrast of darkness and hope, highlighting the issues of compassion, strength, and inner power. The movie manages to keep its darker side balanced out with the scenes of subversion and solidarity, so we understand that despite the most drastic of times, there can be good even in the most desperate of cases.	poster-ba8ceea3-42f9-4137-827a-cd5165bc533c.jpg	2025-07-16 14:42:29.439	2025-07-16 14:42:29.439	TRANSLATED
324	1	Chinese Zodiac - Junior Giti	2013	8.2	Chinese Zodiac is an action-packed adventure movie that delves on the amazing combination of martial arts, comedy, and Jackies dare-devil stunts. Focusing on the story of the famous bronze Chinese zodiac heads stolen in the Old Summer Palace, the movie is a world-wide voyage adventure full of threat, laughs, and heritage. Played by Chan, the Asian Hawk character is charismatic and resourceful without trouble blending action and heartfelt moments. The narrative has found the perfect balance between the exciting action scenes, such as the escape and the fight scenes, and some comedic moments and musings, particularly the aspects of the cultural background and greed.	poster-c8329388-74e7-4f35-8569-4809e3ceae24.jpg	2025-07-16 14:46:23.1	2025-07-16 14:46:23.1	TRANSLATED
325	6	Most Dangerous Game - Rocky	2020	7.8	Most Dangerous Game is an engaging survival thriller that draws the audience into the action-packed game of life and death, discussing the moral, desperation and human strength issues. The novel revolves around a man called Dodge Tynes, who is diagnosed with a terminal condition and accepts to be part of a deadly hunt so as to have a secured future financially of himself and his family. The movie has a non-stop motion with little to no dialogue, with action scenes that are bloody and very realistic and an aura of grittiness that empowers you to feel what Dodge is going through in his quest to survive. The screenplay is an even see-saw between commendable suspense and seeing the characters, which makes the voyage of Dodge a personal yet emotionally touching experience.	poster-ed81e692-4595-4f06-8f0c-4a0636988bfa.jpg	2025-07-16 14:49:06.623	2025-07-16 14:49:06.623	TRANSLATED
327	1	The Infallibles - Dylan Kabaka.	2024	8	*The Infallibles* is an explosive and unexpected crime-comedy which is masterfully and cleverly balanced between comedic elements, tensions, and social commentary which is placed on the lively background of Paris. Focusing on the unseemly alliance of Alia, fiery and impulsive, with Hugo, meticulous and reserved, the film addresses the issue of trust, cultural collision and the might of teamwork. Their relations with each other are complex, flowing between conflicts and friendship, and make an audience be absorbed in an interesting but controversial story. The fast flow of the movie and its caustic jokes make the story exciting whereas the underlying social message brings another dimension to the humorous plot.	poster-d4e3e1ac-5eb3-4466-a230-3062bd053c1f.jpg	2025-07-19 09:15:33.667	2025-07-19 09:15:33.667	TRANSLATED
326	3	V Wars - Rocky	2019	7.3	The first season of the *V-Wars* is a rather gloomy, atmospheric, show that combines elements of supernatural horror, as well as modern environmental issues related to climate change. Its rough style and physical narrating is something that will make the audience feel uneasy throughout its duration, as they experience the disarray and instability of society falling apart due to the extraordinary events. It is based on some real-world fears rooted in the primer, an ice-melt that brings a deadly virus, which brings levels of urgency and relevance and make the series anything but typical in a vampire series.	poster-3dfe95dd-9b1c-4a47-9a8c-9eb940e0bacf.jpg	2025-07-19 09:00:55.842	2025-07-19 09:00:55.842	TRANSLATED
328	1	In the Lost Lands - Gaheza	2025	8.1	    Last Updated: 3 months ago\n\nUnder the direction of George McKay ΓÇ£In the Lost LandsΓÇ¥ creates an enchanting fantasy world where mystical dangers and intense wants exist among its elements. The story centers on Gray Alys the sorceress who receives her mission from the temperamental queen Milla Jovovich plays. The adventure path gets filled with multiple complicated personalities including the rough hero of Boyce played by Dave Bautista. Through its examination of powerlust and deep desire and sacrifices the film makes viewers think about obtaining happiness at what cost.	poster-402a6e05-43e1-4d1b-87e9-b32637293877.jpg	2025-07-19 09:32:05.084	2025-07-19 09:32:05.084	TRANSLATED
329	1	Max Payne - Master P	2008	6.9	The atmosphere of crime on the dark streets of New York City with hidden secrets and dangerous shadows is an appropriate description of the movie, ΓÇ£Max PayneΓÇ¥ in respect of crime, the atmosphere and the thriller. It is a dark and somber film with overtones of emotive action and noir-style imagery that creates a gloomy feeling of despair and the grayness of morality. The themes of grief and spirituality, drug addiction, and revenge in the movie are what makes it resonate with viewers, getting into the character exploration of the psychology of loss and the thin boundaries between good and evil.	poster-deb9471a-e910-473c-b05c-d5c6b2fa88fa.jpg	2025-07-20 18:11:34.917	2025-07-20 18:11:34.917	TRANSLATED
330	4	Tokunbo - Master P	2024	7.4	T├▓kunb├▓ is a dramatic, tense crime thriller in Nigeria that dwells on morality, family, and the risky decisions of people when the pressure is on their shoulders. The movie revolves around the character played by Gideon Okeke, named T Okunbo, an ex-car smuggler who is buried in his own regrets of the past and is living in order to give a better future to his family. This story intelligently alternates between dynamic scenes and more deeper thoughts about family and self-martyrdom, and makes it an interesting tale of survival in the midst of destruction. Repenting from a life of crime is a strong theme that points out at the inner conflict of being a man who lived back in the past and is waiting on his future redemption.	poster-62c39946-1826-4be8-87cd-b6f2552c83b4.jpg	2025-07-20 18:15:35.095	2025-07-20 18:15:35.095	TRANSLATED
331	6	Tufang - Master P	2023	7.6	The film so titled is shrewd combination of action, suspense, and social messaging called until now and possible to have an equally powerful cast and story narration as in the film Tufang. The story take us through the events in the mind of Veera who thoughtlessly goes to a reputable gun house to shoplift a gun only to find Arjan who is the heir of the name involved with her. Their first conflict becomes a mixed relationship because Arjan falls in love with Veera, but she provokes his actions and provokes a twist that keeps the audience interested. The name of the film is based on the Persian word to a long-barreled gun, and this adds a deeper meaning to the story, since it represents the strength of arms used to fight a just cause.	poster-5e4cf356-be7a-42ca-926f-2e9bbdf3995b.jpg	2025-07-20 18:18:25.83	2025-07-20 18:18:25.83	TRANSLATED
332	1	Impossible - Fallout:  GAHEZA	2018	8.9	ΓÇ£Mission; ΓÇ£Mission Impossible 6. Impossible ΓÇô FalloutΓÇ¥ is an film directed by Christopher McQuarrie, the sixth installment of the series. It follows the gripping story of Ethan Hunt (played by Tom Cruise) and his team, from the International Monster Management (IMF) as they face off against enemies who have stolen a supply of plutonium. The mission takes turns. Ethan must act quickly to prevent a catastrophic event.	poster-ccb2017b-85c2-4210-886d-cb3a0ade08ee.jpg	2025-07-20 18:20:47.63	2025-07-20 18:20:47.63	TRANSLATED
333	1	Mission Impossible 7: Dead - Rocky	2023	9.1	Mission: Impossible Dead reckoning is a powerful action thriller that lives up to the reputation of the franchise parts with their new age action and edge of the seat narrations. Tom Cruise as unwaveringly determined Ethan hunt goes on a globe-ranging endeavor of retrieving a harmful new weapon that poses a hazard to the prosperity of humankind in general. The movie flawlessly incorporates thrilling action scenes with urgency and leaves the audience on its tip of the hands, as it sees jaw-dropping stunts and amazing visuals within various places. It accentuates a very subtle play between security and havoc, as unfrail is the peace in a world that is hovering between a crisis and a disaster.	poster-8245119d-78ee-4eb6-be12-994472fb4b9a.jpg	2025-07-20 18:23:01.511	2025-07-20 18:23:01.511	TRANSLATED
334	3	The Divine Fury	2019	8.1	Yong-hoo blames God for letting his parents die after a serious accident. He is forced to reevaluate his faith after he and Father Ahn are thrust in the middle of an unholy war.	poster-2d30a0b5-b063-475d-8b7b-fcf75b09bede.jpg	2025-07-20 18:29:13.795	2025-07-20 18:29:13.795	TRANSLATED
335	3	The Owners	2020	6	A group of teenagers decides to rob an empty house that belongs to an elderly couple. They, however, find themselves facing their worst fears when the couple returns and intimidates them.	poster-2c64fe11-ee7d-4e3d-b48e-4c207db22f00.jpg	2025-07-20 18:36:27.912	2025-07-20 18:36:27.912	TRANSLATED
336	6	The Commando	2022	8.5	James Baker, a drug enforcement officer, returns home after a mission goes horribly wrong. But he soon discovers that he must save his family from a criminal who has invaded his home.	poster-290e44af-c540-4b5c-873b-6744b6c45988.jpg	2025-07-20 18:40:26.913	2025-07-20 18:40:26.913	TRANSLATED
337	1	Rugal - Junior Giti	2020	9.1	A police officer loses everything he holds dear when he attempts to bring down a nationwide criminal organization.	poster-ac07724a-aa10-487d-8570-c1504b32520f.jpg	2025-07-20 18:44:28.485	2025-07-20 18:44:28.485	TRANSLATED
338	3	Night Has Come S01 - Rocky	2023	8.7	The Season 1 of Night Has Come presents us with an exhilarating plot of high school death game, in which students are thrown into a lethal mafia-like game. The setting takes place in what appears to be an ordinary retreat center with the series swiftly seeding the air with paranoia, suspicion and mental paranoia. When night comes, the students are given threatening messages informing them that survival can only come with betraying friends and telling who among them is the ΓÇ£mafia.ΓÇ¥ The claustrophobic atmosphere is perfectly augmented in the show, highlighting that fear and mistrust can make even regular teenagers desperate, cunning survivors. With a thrilling and fast rhythm, and the dramatics increasingly becoming stakes, the viewer is kept on his toes, wondering about the motives and morals of every character presente	poster-348e738d-9abf-47b9-94d2-b7d811d73796.jpg	2025-07-24 11:19:19.613	2025-07-24 11:19:19.613	TRANSLATED
339	6	Moon Night - Gaheza	2022	7.2	Moon Knight is a Disney+ series set within the Marvel Cinematic Universe (MCU), focusing on the character of Marc Spector, a former mercenary who becomes the human avatar of the Egyptian moon god Khonshu. The series explores Marc's struggle with dissociative identity disorder, as he shares his body with the gift-shop employee Steven Grant, and their interactions with Egyptian gods and cults.	https://res.cloudinary.com/daryajfms/image/upload/v1753875819/movie-posters/poster-742928ce-d9d3-411a-875e-8ad8dcc5a090.jpg	2025-07-30 11:43:39.785	2025-07-30 11:43:39.785	TRANSLATED
342	3	Saint Catherine	2024	6	An orphaned girl is rescued from a satanic ritual and taken to Saint Catherine Institute for homeless youth. There she will learn new skills while facing demons that stalk her.	https://res.cloudinary.com/daryajfms/image/upload/v1753959497/movie-posters/poster-17f0a514-66ec-473b-98df-e03b75803cbf.jpg	2025-07-31 10:58:18.272	2025-07-31 10:58:18.272	ORIGINAL
343	3	S.T.A.L.K.E.R. Shadow of the Zone	2024	8.6	S.T.A.L.K.E.R.: Shadow of the Zone is a 2024 live-action sci-fi horror fan film based on the popular S.T.A.L.K.E.R. video game series, following a seasoned Stalker guiding mercenaries and a scientist into the Chernobyl Exclusion Zone to investigate a mysterious paranormal radio signal. The film, which was successfully funded through Kickstarter, explores the dangers and mysteries of "The Zone" and its anomalies, and the effects of a powerful signal on those exposed to it. 	https://res.cloudinary.com/daryajfms/image/upload/v1753959900/movie-posters/poster-811e3ec3-3050-46b8-bf85-a5511bed57a6.jpg	2025-07-31 11:05:00.593	2025-07-31 11:05:00.593	ORIGINAL
344	3	Ghosts of Red Ridge	2024	7.1	After stopping a robbery, a sheriff jails a stranger linked to outlaws. As he hunts the gang, ghosts of murdered townspeople appear, leaving him to wonder if they're warning him or seeking revenge.	https://res.cloudinary.com/daryajfms/image/upload/v1753960402/movie-posters/poster-e914bb9a-7c6c-4322-a4a7-e2125c821eb4.jpg	2025-07-31 11:13:23.363	2025-07-31 11:13:23.363	ORIGINAL
340	1	Stand Your Ground (2025) 	2025	7.1	Former Special Forces operative, Jack Johnson, uses the Stand Your Ground law to seek vengeance for his wifeΓÇÖs murder, igniting a brutal war against a local crime lordΓÇÖs family and ending in an explosive showdown.	https://res.cloudinary.com/daryajfms/image/upload/v1753893529/movie-posters/poster-7135f7a4-3978-41df-91d4-ec4b46661594.jpg	2025-07-30 16:38:49.818	2025-07-30 16:38:49.818	ORIGINAL
345	4	Bono: Stories of Surrender	2025	7.1	Bono pulls back the curtain on his life, the family, friends and faith that have sustained him. He also reveals personal stories about his journey as a son, father, husband, activist and rock star.	https://res.cloudinary.com/daryajfms/image/upload/v1753960762/movie-posters/poster-8c71bbd9-c27f-4541-9c63-2ba03452b35b.jpg	2025-07-31 11:19:22.78	2025-07-31 11:19:22.78	ORIGINAL
341	1	Gunslingers	2025	6.3	In a town named redemption, reformed gunslinger Keller and mad genius Ben are guided by spiritual leader Jericho towards vindication. While confronting their violent histories, their newfound peace is challenged by violence and revenge.	https://res.cloudinary.com/daryajfms/image/upload/v1753908856/movie-posters/poster-3d6be130-0a8b-4395-b29f-5fce1632ec89.jpg	2025-07-30 20:54:15.752	2025-07-30 20:54:15.752	ORIGINAL
346	3	Abduct	2025	8.6	"Abduct" primarily refers to kidnapping, which is the unlawful seizure and confinement of a person against their will, often for ransom or other illegal purposes. It can also refer to abductive reasoning, a type of logical inference used to form explanations for observed phenomena, particularly in situations with incomplete information. Additionally, "abduction" can be used in the context of a 2011 film starring Taylor Lautner or a board game where players "abduct" ducks. 	https://res.cloudinary.com/daryajfms/image/upload/v1753961014/movie-posters/poster-09f11889-c5c5-4554-88ed-2d822e916742.jpg	2025-07-31 11:23:34.693	2025-07-31 11:23:34.693	ORIGINAL
350	6	STRAW	2025	6.9	Straw is primarily known as an agricultural byproduct of grain harvesting, but it also refers to a new Tyler Perry film released on Netflix and the material used in drinking straws. Agricultural straw has diverse uses, including as animal bedding and feed, a building material (straw bale construction), a source for biofuels and energy, and even as a material for biorefineries and adsorbents. Meanwhile, Tyler Perry's "Straw" is a drama film starring Taraji P. Henson that explores themes of mental health and societal pressures, and "straws" in the context of drinking refers to a tube for consuming beverages, with a recent shift towards alternative materials like paper and reusable options due to environmental concerns.	https://res.cloudinary.com/daryajfms/image/upload/v1753961862/movie-posters/poster-a194751a-2d3b-40c3-ae3d-912d07b275c1.jpg	2025-07-31 11:37:43.377	2025-07-31 11:37:43.377	ORIGINAL
351	6	Maharaja 	2025	8.4	A barber seeks vengeance after his home is burglarized, cryptically telling police his "lakshmi" has been taken, leaving them uncertain if it's a person or object. His quest to recover the elusive "lakshmi" unfolds.	https://res.cloudinary.com/daryajfms/image/upload/v1753962119/movie-posters/poster-3571c79b-ce60-4a3b-b29e-755636acb252.jpg	2025-07-31 11:42:00.02	2025-07-31 11:42:00.02	ORIGINAL
352	1	Predator: Killer of Killers	2025	7.5	A Viking raider, a ninja in feudal Japan, and a World War II pilot encounter a fierce intergalactic hunter.	https://res.cloudinary.com/daryajfms/image/upload/v1753962331/movie-posters/poster-1fd5a17b-b69f-4772-b5e1-319ab1139e08.jpg	2025-07-31 11:45:31.621	2025-07-31 11:45:31.621	ORIGINAL
353	3	The Ugly Stepsister	2025	7	Elvira dreams of the weak-kneed virgin, Prince Julian, and is willing to go to great lengths to conform to the kingdom's ideals of beauty. A surprising and raw twist on the fairy tale `Cinderella', seen from her stepsister's point of view.	https://res.cloudinary.com/daryajfms/image/upload/v1753962470/movie-posters/poster-8006166c-a27f-45ef-82ea-52d7b3680f64.jpg	2025-07-31 11:47:51.111	2025-07-31 11:47:51.111	ORIGINAL
354	3	The Severed Sun	2025	4.9	\nFear and paranoia spread in an isolated religious community when a mysterious beast with shimmering, white eyes embarks on a bloody rampage.	https://res.cloudinary.com/daryajfms/image/upload/v1753962623/movie-posters/poster-db8d50a5-68a7-4f89-81dd-eadb0e114117.jpg	2025-07-31 11:50:24.26	2025-07-31 11:50:24.26	ORIGINAL
355	1	K.O.	2025	5.8	A former fighter must find the missing son of an opponent he accidentally killed years ago, taking on a brutally violent crime gang in Marseille.	https://res.cloudinary.com/daryajfms/image/upload/v1753962765/movie-posters/poster-82ba301c-5b08-40ea-9873-e01cead55da5.jpg	2025-07-31 11:52:46.103	2025-07-31 11:52:46.103	ORIGINAL
356	3	Beaten to Death	2023	4.9	Stranded in the middle of nowhere after surviving a brutal attack, a man must battle deranged country psychos and the harsh landscape to make it out alive.	https://res.cloudinary.com/daryajfms/image/upload/v1753962897/movie-posters/poster-01d9ee11-5367-4229-b7f3-6e618f800ba2.jpg	2025-07-31 11:54:57.691	2025-07-31 11:54:57.691	ORIGINAL
357	10	Peter Rabbit 2: The Runaway -  Gaheza	2021	6.2	Peter Rabbit runs away from his human family when he learns they are going to portray him in a bad light in their book. Soon, he crosses paths with an older rabbit who ropes him into a heist.	https://res.cloudinary.com/daryajfms/image/upload/v1754032312/movie-posters/poster-fe600753-9b96-44f1-9a7c-4e622b973c82.jpg	2025-08-01 07:11:53.277	2025-08-01 07:11:53.277	TRANSLATED
358	1	Dragons Forever	1988	7.1	A lawyer is hired by a chemical company to defend it in court. The situation complicates when the lawyer finds out that his client is running a drug empire in the disguise of the chemical company.	https://res.cloudinary.com/daryajfms/image/upload/v1754032879/movie-posters/poster-d5613221-91f7-4039-9806-8817dff1ad2e.jpg	2025-08-01 07:21:19.86	2025-08-01 07:21:19.86	TRANSLATED
360	3	The originals S2 - DYLAN	2018	8.2	Season two of "The Originals" focuses on the Mikaelson family navigating a new power dynamic in New Orleans, with werewolves controlling the city and threats from their past resurfacing. Klaus and Hayley grapple with new challenges as they try to protect their daughter Hope, while Elijah, isolated from his family, allies with Marcel to regain control of the city. The season also introduces the return of Klaus and Elijah's parents, Esther and Mikael, as well as Dahlia, Esther's sister, who poses a significant threat to Hope	https://res.cloudinary.com/daryajfms/image/upload/v1754034370/movie-posters/poster-81098e4a-c9d1-41d2-8505-35dac7f5cfa5.jpg	2025-08-01 07:46:10.86	2025-08-01 07:46:10.86	TRANSLATED
361	3	Legion - Sankara Da Premier.	2010	7.4	Legion is a very bold and powerful combination of apocalyptic horror and spiritual drama all made in the hallway of a dusty roadside diner that soon turns out to be a battleground in the survival of humankind. The grungy atmosphere and raw story within the film grabs you instantly and makes you understand how hopelessly humans fight against demonic forms that appear when freedom and faith in people are lost by God. The stakes and tension in the narrative are also through the roof, as is the raw energy, because of which the tale gets charged and I was hooked to seeing some kind of a solution within the mess.	https://res.cloudinary.com/daryajfms/image/upload/v1754035402/movie-posters/poster-0b1952d2-8cfb-4cbf-9d1a-0f1bf2d85eeb.jpg	2025-08-01 08:03:23.183	2025-08-01 08:03:23.183	TRANSLATED
362	1	Vantage Point - Sankara Da Premier.	2008	8.5	Vantage point is an action adventurous thriller with a lot of ambitions and velocity that addresses the mayhem and the complexity of an assassination scheme against the American President on a public appearance in Salamanca, Spain. The multidimensional, even puzzle-like structure of the film, which is recounting the same key events through the eyes of different people in the law enforcement system and then through the eyes of a security officer, then through the eyes of the audience and even members of the terrorist cell, made it impossible to take my eyes off the screen the whole time. Such usage of narrative device works perfectly to emphasize how every smallest detail can alter our perception of what happened to the drastic degree and the story can be considered not just catchy but pretty thought-provoking as well.	https://res.cloudinary.com/daryajfms/image/upload/v1754035663/movie-posters/poster-fc1310d0-753c-496b-a387-bf1eeff19cf3.jpg	2025-08-01 08:07:43.713	2025-08-01 08:07:43.713	TRANSLATED
359	3	The Conjuring 3: The Devil Made Me Do It - Sankara	2021	5.6	Paranormal investigators Ed and Lorraine Warren take on one of the most sensational cases of their careers after a cop stumbles upon a dazed and bloodied young man walking down the road. Accused of murder, the suspect claims demonic possession as his defense, forcing the Warrens into a supernatural inquiry unlike anything they've ever seen before.	https://res.cloudinary.com/daryajfms/image/upload/v1754033318/movie-posters/poster-296f6be9-1277-4c5e-a2d6-25f3e2dd3038.jpg	2025-08-01 07:28:38.956	2025-08-01 07:28:38.956	TRANSLATED
363	6	Brick - Sankara Da Premier.	2025	7.5	Brick is a fascinating movie that uses skillful combination of psychological drama, sci-fi mystery, and a thriller to deliver an incredibly tense, mind-blowing picture. I was most impressed by the way in which the theme of confinement, human resilience and innateness to escape are examined in the story due to the unexpected emergence of some mysterious brick wall encircling an apartment building. The surreal, yet simple concept of the film, attracts the audience into the tense, but gradually, get more unsettling state due to the desperation expression of the characters.	https://res.cloudinary.com/daryajfms/image/upload/v1754035961/movie-posters/poster-b8c5c937-a49a-4b76-9676-9e0ed04182ea.jpg	2025-08-01 08:12:42.443	2025-08-01 08:12:42.443	TRANSLATED
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.notification (id, title, message, is_read, url, created_at, updated_at) FROM stdin;
7	The Squid Game 3	Reba fileme Igezweho Nonaha	f	https://hobbyvb.com/play/279/movie	2025-06-28 18:42:39.423	2025-06-28 18:42:39.423
\.


--
-- Data for Name: replies; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.replies (id, "commentId", "userName", content, "replyLike", "createdAt") FROM stdin;
2	5	hobbyVb	Download iri gukunda	2	2025-06-20 15:43:48.405
4	16	hobbyVb	Aitraaz ya 2004?	1	2025-06-28 14:48:03.425
5	19	hobbyVb	mfite seasons 9 gusa	0	2025-06-29 22:37:59.698
6	27	hobbyVb	How?	0	2025-07-06 08:32:25.212
7	28	hobbyvb	Download irakundaΓ£ö∩╕Å	1	2025-07-08 23:11:37.623
8	30	hobbyVb	eeeeeeeeee\nnonese birakwiye gushiraho iyi movie? ya +18	0	2025-07-11 16:43:10.567
9	41	HobbyVb 	igice cyakabiri cyirahari reba Ahanditse  Select Part arabona next part	0	2025-07-24 11:13:40.341
1	4	hobbyVb	biraza gutunga, Iam very Sorry!	4	2025-06-18 13:45:46.735
3	11	hobbyVb	iraboneka gusa Nta download iboneka, niba ushakako tuyishiraho ukayirebera online Kora reply turahita tuyishiraho!	1	2025-06-23 11:21:52.764
10	47	hobbyVb	Ntago iraboneka	1	2025-07-30 11:00:17.154
11	47	hobbyVb	season 2 irahari	0	2025-08-01 08:15:57.598
12	48	hobbyvb	Thanks	0	2025-08-02 06:02:23.36
\.


--
-- Data for Name: replylikes; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.replylikes (id, "replyId", ip) FROM stdin;
1	1	197.157.145.61
2	2	197.157.187.194
3	2	51.158.112.253
4	4	102.22.141.129
5	1	41.186.138.229
6	7	197.157.187.70
7	1	102.22.140.231
8	1	102.22.140.231
9	3	197.157.187.210
10	10	102.22.171.230
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.sources (id, "movieId", name, domain, type, part, "baseUrl", "downloadLink", "isIframe", "createdAt") FROM stdin;
2	1	o	https://dhcplay.com/e/	END	1	s1okspv6u4hd	\N	f	2025-06-28 22:58:06.295
4	3	O	https://dhcplay.com/e/	END	1	lbixbtzixg16	\N	f	2025-06-28 22:58:06.295
5	3	o	https://dhcplay.com/e/	END	2	gre4s42r652j	\N	f	2025-06-28 22:58:06.295
6	3	O	https://dhcplay.com/e/	END	3	xc107sjuplvr	\N	f	2025-06-28 22:58:06.295
8	4	o	https://dhcplay.com/e/	END	1	q1jf8wy0znwm	\N	f	2025-06-28 22:58:06.295
9	5	o	https://dhcplay.com/e/	END	1	jklrcsl1pygi	\N	f	2025-06-28 22:58:06.295
10	5	o	https://iplayerhls.com/e/	END	2	x8l0uk3cro6r	\N	f	2025-06-28 22:58:06.295
14	9	o	https://dhcplay.com/e/	SEASON	1	w6l4as7o8v5y	\N	f	2025-06-28 22:58:06.295
15	9	o	https://dhcplay.com/e/	SEASON	2	ye2ktpu1pfqw	\N	f	2025-06-28 22:58:06.295
16	9	o	https://dhcplay.com/e/	SEASON	3	g71e6tpz5sgf	\N	f	2025-06-28 22:58:06.295
17	9	o	https://dhcplay.com/e/	SEASON	4	xqz3dkze05w9	\N	f	2025-06-28 22:58:06.295
18	9	o	https://dhcplay.com/e/	SEASON	5	z1zeggbzikkc	\N	f	2025-06-28 22:58:06.295
19	9	o	https://dhcplay.com/e/	SEASON	6	as5ol914qa1v	\N	f	2025-06-28 22:58:06.295
20	9	o	https://dhcplay.com/e/	SEASON	7	di8r4xuj0q3f	\N	f	2025-06-28 22:58:06.295
21	9	o	https://dhcplay.com/e/	SEASON	8	x1e690632242	\N	f	2025-06-28 22:58:06.295
22	9	o	https://dhcplay.com/e/	SEASON	9	7z30dsog75ke	\N	f	2025-06-28 22:58:06.295
23	9	o	https://dhcplay.com/e/	SEASON	10	9qv1f3j11chh	\N	f	2025-06-28 22:58:06.295
24	9	o	https://dhcplay.com/e/	SEASON	11	orqjqzrpqp0d	\N	f	2025-06-28 22:58:06.295
25	9	o	https://dhcplay.com/e/	SEASON	12	7hfimzzpjzaw	\N	f	2025-06-28 22:58:06.295
26	9	0	https://dhcplay.com/e/	END	13	zi9vykm473g8	\N	f	2025-06-28 22:58:06.295
27	9	0	https://dhcplay.com/e/	SEASON	14	d9uegnb0yrv4	\N	f	2025-06-28 22:58:06.295
28	9	o	https://dhcplay.com/e/	SEASON	15	78cc0wqybbw6	\N	f	2025-06-28 22:58:06.295
29	9	o	https://dhcplay.com/e/	SEASON	16	tv1y7maf74dv	\N	f	2025-06-28 22:58:06.295
30	9	o	https://dhcplay.com/e/	SEASON	17	khse4dr8kmkp	\N	f	2025-06-28 22:58:06.295
31	9	o	https://dhcplay.com/e/	SEASON	18	l7e6j28uea9a	\N	f	2025-06-28 22:58:06.295
32	9	o	https://dhcplay.com/e/	SEASON	19	nv4fn476h753	\N	f	2025-06-28 22:58:06.295
33	9	o	https://dhcplay.com/e/	SEASON	20	08b783q5tcx6	\N	f	2025-06-28 22:58:06.295
34	9	o	https://dhcplay.com/e/	SEASON	21	yoranf1vyywh	\N	f	2025-06-28 22:58:06.295
35	9	o	https://dhcplay.com/e/	SEASON	22	u281j0miboe0	\N	f	2025-06-28 22:58:06.295
36	9	o	https://dhcplay.com/e/	SEASON	23	a0i9xnp94jo7	\N	f	2025-06-28 22:58:06.295
37	9	o	https://dhcplay.com/e/	SEASON	24	tuio1441nkx2	\N	f	2025-06-28 22:58:06.295
38	10	o	https://dhcplay.com/e/	SEASON	1	gedgs1bismbc	\N	f	2025-06-28 22:58:06.295
39	10	o	https://dhcplay.com/e/	SEASON	2	is96wfv70gjb	\N	f	2025-06-28 22:58:06.295
40	10	o	https://dhcplay.com/e/	SEASON	3	th2sxldki4up	\N	f	2025-06-28 22:58:06.295
41	10	o	https://dhcplay.com/e/	SEASON	4	mvw0nzeostsf	\N	f	2025-06-28 22:58:06.295
42	10	o	https://dhcplay.com/e/	SEASON	5	k87fxofb3lbw	\N	f	2025-06-28 22:58:06.295
43	10	o	https://dhcplay.com/e/	SEASON	6	fwrjzebcf5z7	\N	f	2025-06-28 22:58:06.295
44	10	o	https://dhcplay.com/e/	SEASON	7	gmby0gmfsinu	\N	f	2025-06-28 22:58:06.295
45	10	o	https://dhcplay.com/e/	SEASON	8	ibxo93oitvvf	\N	f	2025-06-28 22:58:06.295
46	10	o	https://dhcplay.com/e/	SEASON	9	vggp90lk1oqs	\N	f	2025-06-28 22:58:06.295
47	10	o	https://dhcplay.com/e/	SEASON	10	myxnjc6jodgy	\N	f	2025-06-28 22:58:06.295
48	11	o	https://dhcplay.com/e/	SEASON	1	siqetxz8bgvb	\N	f	2025-06-28 22:58:06.295
49	11	o	https://dhcplay.com/e/	SEASON	2	5n1yqyhwqvml	\N	f	2025-06-28 22:58:06.295
50	11	o	https://dhcplay.com/e/	SEASON	3	k1ryz0dn1it2	\N	f	2025-06-28 22:58:06.295
51	11	o	https://dhcplay.com/e/	SEASON	4	cicwxxfapha2	\N	f	2025-06-28 22:58:06.295
52	11	o	https://dhcplay.com/e/	SEASON	5	ywd0o6bxszty	\N	f	2025-06-28 22:58:06.295
53	11	o	https://dhcplay.com/e/	SEASON	7	l725x42stggx	\N	f	2025-06-28 22:58:06.295
54	11	o	https://dhcplay.com/e/	SEASON	8	8bajni4gn4d8	\N	f	2025-06-28 22:58:06.295
55	12	o	https://dhcplay.com/e/	END	1	cknrm0nmu9xu	\N	f	2025-06-28 22:58:06.295
56	14	o	https://dhcplay.com/e/	END	1	ee9em0bg32t0	\N	f	2025-06-28 22:58:06.295
57	14	o	https://dhcplay.com/e/	END	2	fjwm98jqojyg	\N	f	2025-06-28 22:58:06.295
58	15	o	https://dhcplay.com/e/	END	1	ipjg97sjjhjl	\N	f	2025-06-28 22:58:06.295
59	15	o	https://dhcplay.com/e/	END	2	6vp28vvu3hhx	\N	f	2025-06-28 22:58:06.295
60	16	o	https://dhcplay.com/e/	END	1	mngedb0mqjet	\N	f	2025-06-28 22:58:06.295
61	16	o	https://dhcplay.com/e/	END	2	d5pdy27tnb6m	\N	f	2025-06-28 22:58:06.295
62	17	o	https://dhcplay.com/e/	END	2	eydk6apu68qq	\N	f	2025-06-28 22:58:06.295
63	17	o	https://dhcplay.com/e/	END	1	9dyqtfsar61m	\N	f	2025-06-28 22:58:06.295
64	18	o	https://dhcplay.com/e/	END	1	mf8t5tx0aqu9	\N	f	2025-06-28 22:58:06.295
65	19	o	https://dhcplay.com/e/	END	1	30t1ti1ajn91	\N	f	2025-06-28 22:58:06.295
66	20	o	https://dhcplay.com/e/	END	1	sczceyhlz894	\N	f	2025-06-28 22:58:06.295
67	20	o	https://dhcplay.com/e/	END	2	6m5066qhafe8	\N	f	2025-06-28 22:58:06.295
68	21	o	https://dhcplay.com/e/	END	1	qve9ndlfil6p	\N	f	2025-06-28 22:58:06.295
69	21	o	https://dhcplay.com/e/	END	2	qvl5fhdzo1sy	\N	f	2025-06-28 22:58:06.295
70	22	o	https://dhcplay.com/e/	END	1	ek2k1ve9qaa5	\N	f	2025-06-28 22:58:06.295
71	22	o	https://dhcplay.com/e/	END	2	tbjmfjur8jgt	\N	f	2025-06-28 22:58:06.295
72	23	o	https://dhcplay.com/e/	END	1	i1ztm8rykeoe	\N	f	2025-06-28 22:58:06.295
73	23	o	https://dhcplay.com/e/	END	2	rklhk7i84cbk	\N	f	2025-06-28 22:58:06.295
74	23	o	https://dhcplay.com/e/	END	2	rklhk7i84cbk	\N	f	2025-06-28 22:58:06.295
75	23	o	https://dhcplay.com/e/	END	3	r5lywtv5jd5u	\N	f	2025-06-28 22:58:06.295
76	24	o	https://dhcplay.com/e/	END	1	eck7pdr9d3ow	\N	f	2025-06-28 22:58:06.295
77	24	o	https://dhcplay.com/e/	END	2	umbvpnpntdfy	\N	f	2025-06-28 22:58:06.295
78	25	o	https://dhcplay.com/e/	END	1	0hhbdx7t5jlb	\N	f	2025-06-28 22:58:06.295
79	26	o	https://dhcplay.com/e/	END	1	1rvylut71h9i	\N	f	2025-06-28 22:58:06.295
80	27	o	https://dhcplay.com/e/	END	1	rsrkyhlq6u6v	\N	f	2025-06-28 22:58:06.295
81	27	o	https://dhcplay.com/e/	END	2	mjqtf7m8i10o	\N	f	2025-06-28 22:58:06.295
82	28	o	https://dhcplay.com/e/	END	1	csz1xety5xyh	\N	f	2025-06-28 22:58:06.295
83	28	o	https://dhcplay.com/e/	END	2	fmn595siziif	\N	f	2025-06-28 22:58:06.295
84	27	o	https://dhcplay.com/e/	END	3	yy7jkaa6r0zo	\N	f	2025-06-28 22:58:06.295
13	6	o	https://hailindihg.com/e/	END	3	xs7u2oynf4a7	https://www.mediafire.com/file/vlx04na96k6ejet/Three+Stoog+C.mp4/file	t	2025-06-28 22:58:06.295
85	29	o	https://dhcplay.com/e/	END	1	2q42dwzefki2	\N	f	2025-06-28 22:58:06.295
86	29	o	https://dhcplay.com/e/	END	2	oafnqzq82es1	\N	f	2025-06-28 22:58:06.295
87	30	o	https://dhcplay.com/e/	END	1	iatc9zdr1nvz	\N	f	2025-06-28 22:58:06.295
88	30	o	https://dhcplay.com/e/	END	2	nv5ypr7xhfsm	\N	f	2025-06-28 22:58:06.295
89	32	o	https://dhcplay.com/e/	END	1	22m3rdzkw3q8	\N	f	2025-06-28 22:58:06.295
90	33	o	https://dhcplay.com/e/	END	1	n7kegdjx1bmz	\N	f	2025-06-28 22:58:06.295
91	33	o	https://dhcplay.com/e/	END	2	70qufjahuolr	\N	f	2025-06-28 22:58:06.295
92	34	o	https://dhcplay.com/e/	END	1	2ldvquxpij05	\N	f	2025-06-28 22:58:06.295
93	34	o	https://dhcplay.com/e/	END	2	3f513q4ex98b	\N	f	2025-06-28 22:58:06.295
94	35	o	https://dhcplay.com/e/	END	1	ij3ozqtrb800	\N	f	2025-06-28 22:58:06.295
95	36	o	https://dhcplay.com/e/	END	1	yzsn8rrrq2bk	\N	f	2025-06-28 22:58:06.295
96	38	o	https://dhcplay.com/e/	END	1	i64n3hbq9sc8	\N	f	2025-06-28 22:58:06.295
97	39	o	https://dhcplay.com/e/	END	1	rctpyyj38xpl	\N	f	2025-06-28 22:58:06.295
98	39	o	https://dhcplay.com/e/	END	2	9wylbe7864pd	\N	f	2025-06-28 22:58:06.295
99	39	o	https://dhcplay.com/e/	END	3	qjc20lmx3z2j	\N	f	2025-06-28 22:58:06.295
100	40	o	https://dhcplay.com/e/	END	1	ktyb0uvyu28t	\N	f	2025-06-28 22:58:06.295
101	40	o	https://dhcplay.com/e/	END	2	y41wc2c7lza2	\N	f	2025-06-28 22:58:06.295
102	41	o	https://dhcplay.com/e/	END	1	gncxnnr2m3re	\N	f	2025-06-28 22:58:06.295
103	42	o	https://dhcplay.com/e/	END	1	foqe37fj5ekv	\N	f	2025-06-28 22:58:06.295
104	42	o	https://dhcplay.com/e/	END	2	yd7pcihw7v1x	\N	f	2025-06-28 22:58:06.295
105	42	o	https://dhcplay.com/e/	END	3	j39usr3iscw4	\N	f	2025-06-28 22:58:06.295
106	42	o	https://dhcplay.com/e/	END	4	38h4k68z1xsz	\N	f	2025-06-28 22:58:06.295
107	42	o	https://dhcplay.com/e/	END	5	l05exc9eeipz	\N	f	2025-06-28 22:58:06.295
108	43	o	https://dhcplay.com/e/	END	1	s6ftnc3tfjj1	\N	f	2025-06-28 22:58:06.295
109	44	o	https://dhcplay.com/e/	END	1	4z9zngpbppu3	\N	f	2025-06-28 22:58:06.295
110	45	o	https://dhcplay.com/e/	END	1	82s03coszqgp	\N	f	2025-06-28 22:58:06.295
111	46	o	https://dhcplay.com/e/	END	1	3q1tau0qty99	\N	f	2025-06-28 22:58:06.295
112	47	o	https://dhcplay.com/e/	END	1	ngwf44kqopjj	\N	f	2025-06-28 22:58:06.295
113	48	o	https://dhcplay.com/e/	END	1	niu4qj9hgeh4	\N	f	2025-06-28 22:58:06.295
114	49	o	https://dhcplay.com/e/	END	1	wxnzcz8io0pe	\N	f	2025-06-28 22:58:06.295
115	50	o	https://dhcplay.com/e/	END	1	gcbueelbbuyo	\N	f	2025-06-28 22:58:06.295
116	51	o	https://dhcplay.com/e/	END	1	gcbueelbbuyo	\N	f	2025-06-28 22:58:06.295
117	52	o	https://dhcplay.com/e/	END	1	4o6268yfi6fk	\N	f	2025-06-28 22:58:06.295
118	52	o	https://dhcplay.com/e/	END	2	iumt0yehrzor	\N	f	2025-06-28 22:58:06.295
119	53	o	https://dhcplay.com/e/	END	1	f4kncnoiptxe	\N	f	2025-06-28 22:58:06.295
120	54	o	https://dhcplay.com/e/	END	1	clg1dgvz2rkb	\N	f	2025-06-28 22:58:06.295
121	55	o	https://dhcplay.com/e/	END	1	gnd4w9u1yrpw	\N	f	2025-06-28 22:58:06.295
122	55	o	https://dhcplay.com/e/	END	2	c0gwiiuqrk3i	\N	f	2025-06-28 22:58:06.295
123	56	o	https://dhcplay.com/e/	END	1	cufhe437nboc	\N	f	2025-06-28 22:58:06.295
124	56	o	https://dhcplay.com/e/	END	2	v3n80cervvim	\N	f	2025-06-28 22:58:06.295
125	57	o	https://dhcplay.com/e/	END	1	sf4kgaihjme9	\N	f	2025-06-28 22:58:06.295
127	59	o	https://dhcplay.com/e/	END	1	l4ilibwotia7	\N	f	2025-06-28 22:58:06.295
128	59	o	https://dhcplay.com/e/	END	2	gl2q4vzmrcl6	\N	f	2025-06-28 22:58:06.295
129	60	o	https://dhcplay.com/e/	END	1	ywlufv67aurq	\N	f	2025-06-28 22:58:06.295
130	61	o	https://dhcplay.com/e/	END	1	6u5mpmehoe49	\N	f	2025-06-28 22:58:06.295
131	62	o	https://dhcplay.com/e/	END	1	rrkvav31lklk	\N	f	2025-06-28 22:58:06.295
132	63	o	https://dhcplay.com/e/	END	1	hp0hsf6z9ii0	\N	f	2025-06-28 22:58:06.295
133	64	o	https://dhcplay.com/e/	END	1	ue2swkzfwm8s	\N	f	2025-06-28 22:58:06.295
134	64	o	https://dhcplay.com/e/	END	2	f188uxiqfh2t	\N	f	2025-06-28 22:58:06.295
135	65	o	https://dhcplay.com/e/	END	1	9oz9vsch01q9	\N	f	2025-06-28 22:58:06.295
136	66	o	https://dhcplay.com/e/	END	1	0ngmu3lofxr7	\N	f	2025-06-28 22:58:06.295
137	67	o	https://dhcplay.com/e/	END	1	rb63zds0yw4w	\N	f	2025-06-28 22:58:06.295
138	68	o	https://dhcplay.com/e/	END	1	13yxwm2vv5i3	\N	f	2025-06-28 22:58:06.295
139	69	o	https://dhcplay.com/e/	END	1	fk4u6p3hjgzc	\N	f	2025-06-28 22:58:06.295
140	70	o	https://dhcplay.com/e/	END	1	kk445824hpc0	\N	f	2025-06-28 22:58:06.295
141	71	o	https://dhcplay.com/e/	END	1	71ahoeajblo8	\N	f	2025-06-28 22:58:06.295
142	72	o	https://dhcplay.com/e/	END	1	vh68pu646m9y	\N	f	2025-06-28 22:58:06.295
143	72	o	https://dhcplay.com/e/	END	2	zc26sxdkd850	\N	f	2025-06-28 22:58:06.295
144	73	o	https://dhcplay.com/e/	END	1	o2r72aqwl0c1	\N	f	2025-06-28 22:58:06.295
145	74	o	https://dhcplay.com/e/	END	1	oucjb9ddwqi0	\N	f	2025-06-28 22:58:06.295
146	75	o	https://dhcplay.com/e/	END	1	vfeol9paaxx5	\N	f	2025-06-28 22:58:06.295
147	76	o	https://dhcplay.com/e/	END	1	2jmecp8e5qqv	\N	f	2025-06-28 22:58:06.295
148	76	o	https://dhcplay.com/e/	END	2	8a4vxit455n9	\N	f	2025-06-28 22:58:06.295
149	77	o	https://dhcplay.com/e/	END	1	6l5spam87yap	\N	f	2025-06-28 22:58:06.295
150	78	o	https://dhcplay.com/e/	END	1	nqedpcu5r2b1	\N	f	2025-06-28 22:58:06.295
151	79	o	https://dhcplay.com/e/	END	1	2cuej8jiwuku	\N	f	2025-06-28 22:58:06.295
152	80	o	https://dhcplay.com/e/	END	1	vfkutcywzdg9	\N	f	2025-06-28 22:58:06.295
153	81	o	https://dhcplay.com/e/	END	1	1hlwhdr45nwo	\N	f	2025-06-28 22:58:06.295
154	82	o	https://dhcplay.com/e/	END	1	b36tijw31jcs	\N	f	2025-06-28 22:58:06.295
155	83	o	https://dhcplay.com/e/	END	1	b36tijw31jcs	\N	f	2025-06-28 22:58:06.295
156	83	o	https://dhcplay.com/e/	END	2	y4u0kb29wksv	\N	f	2025-06-28 22:58:06.295
157	84	o	https://dhcplay.com/e/	END	1	k80rhd97g2wn	\N	f	2025-06-28 22:58:06.295
158	84	o	https://dhcplay.com/e/	END	2	kmdxnvpzdim2	\N	f	2025-06-28 22:58:06.295
159	85	o	https://dhcplay.com/e/	END	1	wb8nryqq62fq	\N	f	2025-06-28 22:58:06.295
160	86	o	https://dhcplay.com/e/	END	1	e5deilf83582	\N	f	2025-06-28 22:58:06.295
161	87	o	https://dhcplay.com/e/	END	1	l8tbvbacyde6	\N	f	2025-06-28 22:58:06.295
162	88	o	https://dhcplay.com/e/	END	1	3ksxydrizlh5	\N	f	2025-06-28 22:58:06.295
163	88	o	https://dhcplay.com/e/	END	2	drf2rv1nka9z	\N	f	2025-06-28 22:58:06.295
164	89	o	https://dhcplay.com/e/	END	1	tpdf9ckl11s7	\N	f	2025-06-28 22:58:06.295
165	90	o	https://dhcplay.com/e/	END	1	lzmsna6uzaz1	\N	f	2025-06-28 22:58:06.295
166	91	o	https://dhcplay.com/e/	END	1	gjzbec703fhe	\N	f	2025-06-28 22:58:06.295
167	92	o	https://dhcplay.com/e/	END	1	gy0po76ix4w2	\N	f	2025-06-28 22:58:06.295
168	93	o	https://dhcplay.com/e/	END	1	vzvrj3piqiqo	\N	f	2025-06-28 22:58:06.295
169	94	o	https://dhcplay.com/e/	END	1	payovdex5ign	\N	f	2025-06-28 22:58:06.295
170	95	o	https://dhcplay.com/e/	END	1	t6yeyutk4bx4	\N	f	2025-06-28 22:58:06.295
171	96	o	https://dhcplay.com/e/	END	1	https://ghbrisk.com/95dek6imcttd	\N	f	2025-06-28 22:58:06.295
172	97	o	https://dhcplay.com/e/	END	1	ldowqzblve3c	\N	f	2025-06-28 22:58:06.295
173	99	o	https://dhcplay.com/e/	END	1	98pfs5ci9e9n	\N	f	2025-06-28 22:58:06.295
174	100	o	https://dhcplay.com/e/	END	1	fyw1j1mmhkvw	\N	f	2025-06-28 22:58:06.295
175	101	o	https://dhcplay.com/e/	END	1	r646xwqbcw96	\N	f	2025-06-28 22:58:06.295
176	102	o	https://dhcplay.com/e/	END	1	921xtq3udppw	\N	f	2025-06-28 22:58:06.295
177	103	o	https://dhcplay.com/e/	END	1	ka4io2gx2ksr	\N	f	2025-06-28 22:58:06.295
178	104	o	https://dhcplay.com/e/	END	1	cdtowy11pww7	\N	f	2025-06-28 22:58:06.295
179	105	o	https://dhcplay.com/e/	END	1	iqhhk6futk1w	\N	f	2025-06-28 22:58:06.295
180	106	o	https://dhcplay.com/e/	END	1	ngomndaoo3h8	\N	f	2025-06-28 22:58:06.295
181	107	o	https://dhcplay.com/e/	END	1	gzkr6xksn4ue	\N	f	2025-06-28 22:58:06.295
182	108	o	https://dhcplay.com/e/	END	1	ap7kybqbasjn	\N	f	2025-06-28 22:58:06.295
183	109	o	https://dhcplay.com/e/	END	1	5odue9pixptk	\N	f	2025-06-28 22:58:06.295
184	110	o	https://dhcplay.com/e/	END	1	auj7vtwb8c59	\N	f	2025-06-28 22:58:06.295
185	110	o	https://dhcplay.com/e/	END	2	jltg3gal3aj0	\N	f	2025-06-28 22:58:06.295
186	110	o	https://dhcplay.com/e/	END	3	oaagdnaaxdzr	\N	f	2025-06-28 22:58:06.295
187	111	o	https://dhcplay.com/e/	END	1	mq06q0nu6lgy	\N	f	2025-06-28 22:58:06.295
188	111	o	https://dhcplay.com/e/	END	2	yuz6udd933qo	\N	f	2025-06-28 22:58:06.295
189	112	o	https://dhcplay.com/e/	END	1	gcjcbfrc16hr	\N	f	2025-06-28 22:58:06.295
190	114	o	https://dhcplay.com/e/	END	1	60476c6c4r78	\N	f	2025-06-28 22:58:06.295
191	115	o	https://dhcplay.com/e/	END	1	2taanqiaex29	\N	f	2025-06-28 22:58:06.295
192	116	o	https://dhcplay.com/e/	END	1	frlk8nxbme36	\N	f	2025-06-28 22:58:06.295
193	117	o	https://dhcplay.com/e/	END	1	hf4iefqgua4b	\N	f	2025-06-28 22:58:06.295
194	117	o	https://dhcplay.com/e/	END	2	ksq800e8x1q4	\N	f	2025-06-28 22:58:06.295
195	118	o	https://dhcplay.com/e/	END	1	xng0ywmg4h6k	\N	f	2025-06-28 22:58:06.295
196	119	o	https://dhcplay.com/e/	END	2	mb1ql71v0oci	\N	f	2025-06-28 22:58:06.295
197	120	o	https://dhcplay.com/e/	END	1	kagpz90gebos	\N	f	2025-06-28 22:58:06.295
198	120	o	https://dhcplay.com/e/	END	2	5k6xrqggw6fk	\N	f	2025-06-28 22:58:06.295
199	121	o	https://dhcplay.com/e/	END	1	uz1wushmj3t6	\N	f	2025-06-28 22:58:06.295
200	122	o	https://dhcplay.com/e/	END	1	2lqp1sr55c5e	\N	f	2025-06-28 22:58:06.295
201	122	o	https://dhcplay.com/e/	END	2	qzcprtmk1dds	\N	f	2025-06-28 22:58:06.295
202	123	o	https://dhcplay.com/e/	END	1	gqhpvrr2diaf	\N	f	2025-06-28 22:58:06.295
203	123	o	https://dhcplay.com/e/	END	2	gfy8zyol42jt	\N	f	2025-06-28 22:58:06.295
204	124	o	https://dhcplay.com/e/	END	1	66hngh64970d	\N	f	2025-06-28 22:58:06.295
205	125	o	https://drive.google.com/	END	1	file/d/1zPu4YQTbrrAWN2l50tnMozQWVyHXRzmc/preview	\N	f	2025-06-28 22:58:06.295
206	126	o	https://drive.google.com/	END	1	file/d/1lLKlWOgGKDKfiX5sfWz3Qfl5wWnO1SuH/preview	\N	f	2025-06-28 22:58:06.295
207	127	o	https://drive.google.com/	END	1	file/d/1QNB3LPDBR47MYZGunE6Put0P5AOEL_kG/preview	\N	f	2025-06-28 22:58:06.295
208	128	o	https://drive.google.com/	END	1	file/d/1dH721CzQuL4M9XYKGvRNkUf6nvnmFay0/preview	\N	f	2025-06-28 22:58:06.295
209	129	o	https://drive.google.com/	END	1	file/d/1iMuSlNvqZvtLF_CJwVRMgTINPE2yMxdk/preview	\N	f	2025-06-28 22:58:06.295
210	130	o	https://drive.google.com/	END	1	file/d/1xfHJoLjabqIcoTwE7YxNGzvXxDtm89fn/preview	\N	f	2025-06-28 22:58:06.295
211	130	o	https://drive.google.com/	END	2	file/d/1KVYEY8HtFUL1BWHeICIWQd4_6X5uTOFh/preview	\N	f	2025-06-28 22:58:06.295
212	131	o	https://drive.google.com/	END	1	file/d/19zrirQpqHog8D8lvivjuUcCGDfYSdXgc/preview	\N	f	2025-06-28 22:58:06.295
213	132	o	https://drive.google.com/	END	1	file/d/1f8gZZRP04zrdwWtf8M4BYEPgv7bb9wNh/preview	\N	f	2025-06-28 22:58:06.295
214	134	o	https://drive.google.com/	END	1	file/d/19D_NvdKlYhbWWwW1DsgZFTb_Jpaw-_pi/preview	\N	f	2025-06-28 22:58:06.295
216	136	o	https://media.cm/	END	1	folud3jy1xin	\N	f	2025-06-28 22:58:06.295
217	136	o	https://media.cm/	END	2	u/7R1J	\N	f	2025-06-28 22:58:06.295
218	137	o	https://drive.google.com/	END	1	file/d/1kTA3eqT0FxVRkGF15_SS9-NpRnu5GECz/preview	\N	f	2025-06-28 22:58:06.295
219	138	o	https://dhcplay.com/	END	1	js0c7kzwfyrr	\N	f	2025-06-28 22:58:06.295
220	139	o	https://dhcplay.com/e/	END	1	22raxi49f1fh	\N	f	2025-06-28 22:58:06.295
221	140	o	https://dhcplay.com/e/	END	1	q366s0zgf0gj	\N	f	2025-06-28 22:58:06.295
222	137	o	https://drive.google.com/	END	2	file/d/1UjvTarxecAm33CKnguaETs4naX0xQCNi/preview	\N	f	2025-06-28 22:58:06.295
223	141	o	https://drive.google.com/	END	1	file/d/1PUNKCg_FnICpQ1jD5K_h5s45-PD2T0C_/preview	\N	f	2025-06-28 22:58:06.295
224	142	o	https://drive.google.com/	END	1	file/d/1UutD0SSB-tLJNBeO_doDgwuFnD4arLM3/preview	\N	f	2025-06-28 22:58:06.295
225	143	o	https://drive.google.com/	END	1	file/d/1xCNCQiYt93M6yBdbgoIVDKfwAACmRr-J/preview	\N	f	2025-06-28 22:58:06.295
226	143	o	https://drive.google.com/	END	2	file/d/1Kib7GtwKnsgdCOUDdyAlqrMEVu78fx4S/preview	\N	f	2025-06-28 22:58:06.295
227	144	o	https://dhcplay.com/e/	END	1	3i7m6kul063f	\N	f	2025-06-28 22:58:06.295
228	145	o	https://dhcplay.com/e/	END	1	uqnutm6s8lnq	\N	f	2025-06-28 22:58:06.295
229	146	o	https://dhcplay.com/e/	END	1	5i1i70gzfr29	\N	f	2025-06-28 22:58:06.295
230	147	o	https://dhcplay.com/e/	END	1	cs2x6hma7wc0	\N	f	2025-06-28 22:58:06.295
231	147	o	https://dhcplay.com/e/	END	2	x77oxee4vf0p	\N	f	2025-06-28 22:58:06.295
232	148	o	https://dhcplay.com/e/	END	1	midkpf7xqmxq	\N	f	2025-06-28 22:58:06.295
233	148	o	https://dhcplay.com/e/	END	2	midkpf7xqmxq	\N	f	2025-06-28 22:58:06.295
234	149	o	https://dhcplay.com/e/	END	1	6xugg6etmkcq	\N	f	2025-06-28 22:58:06.295
235	149	o	https://dhcplay.com/e/	END	2	8ymbyph10435	\N	f	2025-06-28 22:58:06.295
236	150	o	https://dhcplay.com/e/	SEASON	1	30f4jl5og2hr	\N	f	2025-06-28 22:58:06.295
237	150	o	https://dhcplay.com/e/	SEASON	2	30f4jl5og2hr	\N	f	2025-06-28 22:58:06.295
238	150	o	https://dhcplay.com/e/	SEASON	3	ovze3pxigqa4	\N	f	2025-06-28 22:58:06.295
239	150	o	https://dhcplay.com/e/	SEASON	4	bnb5cwgyktm9	\N	f	2025-06-28 22:58:06.295
240	150	o	https://dhcplay.com/e/	SEASON	5	1rt3c8jlng4a	\N	f	2025-06-28 22:58:06.295
241	150	o	https://dhcplay.com/e/	SEASON	6	oigfpa1gq29t	\N	f	2025-06-28 22:58:06.295
242	150	o	https://dhcplay.com/e/	SEASON	7	x8sp58fzm3zo	\N	f	2025-06-28 22:58:06.295
243	150	o	https://dhcplay.com/e/	SEASON	8	w6tg8q2xlt26	\N	f	2025-06-28 22:58:06.295
244	150	o	https://dhcplay.com/e/	SEASON	9	5qahhn20mezs	\N	f	2025-06-28 22:58:06.295
245	150	o	https://dhcplay.com/e/	SEASON	10	xo4u6wa53393	\N	f	2025-06-28 22:58:06.295
246	150	o	https://dhcplay.com/e/	SEASON	11	pto14yi4jron	\N	f	2025-06-28 22:58:06.295
247	150	o	https://dhcplay.com/e/	SEASON	12	r4bjufn9z0sy	\N	f	2025-06-28 22:58:06.295
248	150	o	https://dhcplay.com/e/	SEASON	13	9xt8eq2bp5kb	\N	f	2025-06-28 22:58:06.295
249	150	o	https://dhcplay.com/e/	SEASON	14	yypfeccxmabg	\N	f	2025-06-28 22:58:06.295
250	151	o	https://dhcplay.com/e/	SEASON	1	oehvszr2i30d	\N	f	2025-06-28 22:58:06.295
251	151	o	https://dhcplay.com/e/	SEASON	2	xf4kjca1pytc	\N	f	2025-06-28 22:58:06.295
252	151	o	https://dhcplay.com/e/	SEASON	3	w462wntl217s	\N	f	2025-06-28 22:58:06.295
253	151	o	https://dhcplay.com/e/	SEASON	4	knkbycwna03j	\N	f	2025-06-28 22:58:06.295
254	151	o	https://dhcplay.com/e/	SEASON	5	wmes48ftz9lx	\N	f	2025-06-28 22:58:06.295
255	151	o	https://dhcplay.com/e/	SEASON	6	1rmb2xyvv8nv	\N	f	2025-06-28 22:58:06.295
256	151	o	https://dhcplay.com/e/	SEASON	7	g3h9ye5d02dd	\N	f	2025-06-28 22:58:06.295
257	151	o	https://dhcplay.com/e/	SEASON	8	5fw48hm9xjql	\N	f	2025-06-28 22:58:06.295
258	151	o	https://dhcplay.com/e/	SEASON	9	imxl9crp02bu	\N	f	2025-06-28 22:58:06.295
259	151	o	https://dhcplay.com/e/	SEASON	10	2camrn0puygr	\N	f	2025-06-28 22:58:06.295
261	153	o	https://dhcplay.com/e/	END	1	9p90gxkwp28n	\N	f	2025-06-28 22:58:06.295
262	154	o	https://dhcplay.com/e/	SEASON	1	erv4qvbfy7zm	\N	f	2025-06-28 22:58:06.295
263	154	o	https://dhcplay.com/e/	SEASON	2	8wtxnwmxnjxr	\N	f	2025-06-28 22:58:06.295
264	154	o	https://dhcplay.com/e/	SEASON	3	7fgwtwb0a281	\N	f	2025-06-28 22:58:06.295
265	154	o	https://dhcplay.com/e/	SEASON	4	562ziueig5f8	\N	f	2025-06-28 22:58:06.295
266	155	o	https://dhcplay.com/e/	SEASON	1	pzd8cqzir8ei	\N	f	2025-06-28 22:58:06.295
267	155	o	https://dhcplay.com/e/	SEASON	2	52dt9bl31b7n	\N	f	2025-06-28 22:58:06.295
268	155	o	https://dhcplay.com/e/	SEASON	3	6ug9kpdi595q	\N	f	2025-06-28 22:58:06.295
269	155	o	https://dhcplay.com/e/	SEASON	4	nnyprr8w7cqj	\N	f	2025-06-28 22:58:06.295
270	155	o	https://dhcplay.com/e/	SEASON	5	cxpw330y2ud6	\N	f	2025-06-28 22:58:06.295
271	155	o	https://dhcplay.com/e/	SEASON	6	womzdgvbdygr	\N	f	2025-06-28 22:58:06.295
272	155	o	https://dhcplay.com/e/	SEASON	7	hdy35j4vm5xj	\N	f	2025-06-28 22:58:06.295
273	155	o	https://dhcplay.com/e/	SEASON	8	db7tfmnbqh7b	\N	f	2025-06-28 22:58:06.295
274	155	o	https://dhcplay.com/e/	SEASON	9	na8hvelxk0um	\N	f	2025-06-28 22:58:06.295
275	155	o	https://dhcplay.com/e/	SEASON	10	dnws2el5l06k	\N	f	2025-06-28 22:58:06.295
276	155	o	https://dhcplay.com/e/	SEASON	11	yic8f9gl98c8	\N	f	2025-06-28 22:58:06.295
277	155	o	https://dhcplay.com/e/	SEASON	12	cfcunze8krm9	\N	f	2025-06-28 22:58:06.295
278	155	o	https://dhcplay.com/e/	SEASON	13	mfakujgbfqq1	\N	f	2025-06-28 22:58:06.295
279	155	o	https://dhcplay.com/e/	SEASON	14	zgp2xevssygd	\N	f	2025-06-28 22:58:06.295
280	155	o	https://dhcplay.com/e/	SEASON	15	u9hztw0jn6jp	\N	f	2025-06-28 22:58:06.295
281	155	o	https://dhcplay.com/e/	SEASON	16	84qp4oywef1g	\N	f	2025-06-28 22:58:06.295
282	155	o	https://dhcplay.com/e/	SEASON	17	7xhn27rfj61o	\N	f	2025-06-28 22:58:06.295
283	156	o	https://drive.google.com/	END	1	file/d/1m0SLhvQOV4rOjlAOOmlDApKfin-5dwod/preview	\N	f	2025-06-28 22:58:06.295
284	158	o	https://drive.google.com/	END	1	file/d/1DZ4uc6WMnNKzxzAe33ANN_pzrgNJdC6A/preview	\N	f	2025-06-28 22:58:06.295
285	159	0	https://drive.google.com/	END	1	file/d/1emxhbXFoE4F4GaoXDq1FmyqVqQKOq-bB/preview	\N	f	2025-06-28 22:58:06.295
286	160	o	https://drive.google.com/	END	1	file/d/1qqq2iCuxw3YA6RRQUFAe-Wu7fWl6Uvvb/preview	\N	f	2025-06-28 22:58:06.295
287	161	o	https://drive.google.com/	END	1	file/d/1CocJKScnQPx2iDdhVnoG-l_-zZqupyyU/preview	\N	f	2025-06-28 22:58:06.295
288	162	o	https://drive.google.com/	END	1	file/d/1Jiep4ePqhIysfh6mUf9OSOgLupF7jidi/preview	\N	f	2025-06-28 22:58:06.295
289	163	o	https://dhcplay.com/e/	END	1	nb1v8uum7n3o	\N	f	2025-06-28 22:58:06.295
290	164	o	https://dhcplay.com/e/	END	1	qm91s81s49qv	\N	f	2025-06-28 22:58:06.295
291	165	o	https://dhcplay.com/e/	END	1	91v6omit5ia1	\N	f	2025-06-28 22:58:06.295
292	165	o	https://dhcplay.com/e/	END	2	4fdr929ju61g	\N	f	2025-06-28 22:58:06.295
293	166	o	https://dhcplay.com/e/	END	1	giuztuiuvncw	\N	f	2025-06-28 22:58:06.295
294	168	o	https://dhcplay.com/e/	END	1	eos9zvd2fu0k	\N	f	2025-06-28 22:58:06.295
295	168	o	https://dhcplay.com/e/	END	2	8t2h09iuinfc	\N	f	2025-06-28 22:58:06.295
296	169	o	https://drive.google.com/	END	1	file/d/1XOfDmk0w2hzEHByeXGXTAkcryFNJqkCI/preview	\N	f	2025-06-28 22:58:06.295
297	170	o	https://dhcplay.com/e/	END	1	02ejz7uxq1s8	\N	f	2025-06-28 22:58:06.295
298	170	o	https://dhcplay.com/e/	END	2	djb6i3a5uc66	\N	f	2025-06-28 22:58:06.295
299	171	o	https://dhcplay.com/e/	END	1	eqbfsbymagww	\N	f	2025-06-28 22:58:06.295
300	171	o	https://dhcplay.com/e/	END	2	pitucuvfymz1	\N	f	2025-06-28 22:58:06.295
301	172	o	https://dhcplay.com/e/	END	1	qd9oss03f452	\N	f	2025-06-28 22:58:06.295
302	173	o	https://dhcplay.com/e/	END	1	4j6tlj56g6k7	\N	f	2025-06-28 22:58:06.295
303	174	o	https://dhcplay.com/e/	END	1	l0hlz09xfpzf	\N	f	2025-06-28 22:58:06.295
304	175	o	https://dhcplay.com/e/	END	1	7cc5f2o653jo	\N	f	2025-06-28 22:58:06.295
305	176	o	https://dhcplay.com/e/	END	1	w6uzuyp9e0w0	\N	f	2025-06-28 22:58:06.295
306	177	o	https://dhcplay.com/e/	END	1	dbgrqlhasqqv	\N	f	2025-06-28 22:58:06.295
307	179	o	https://dhcplay.com/e/	END	1	1iuwslcqrxwv	\N	f	2025-06-28 22:58:06.295
308	180	o	https://dhcplay.com/e/	END	1	rdvgvdy7x943	\N	f	2025-06-28 22:58:06.295
309	180	o	https://dhcplay.com/e/	END	2	y68fda2695q1	\N	f	2025-06-28 22:58:06.295
310	181	o	https://dhcplay.com/e/	SEASON	1	3yve9qp6l46u	\N	f	2025-06-28 22:58:06.295
311	181	o	https://dhcplay.com/e/	SEASON	2	pdf1ek4gm1b9	\N	f	2025-06-28 22:58:06.295
312	181	o	https://dhcplay.com/e/	SEASON	3	cq1noo6il0mq	\N	f	2025-06-28 22:58:06.295
313	181	o	https://dhcplay.com/e/	SEASON	4	q1bkqbw2vqyc	\N	f	2025-06-28 22:58:06.295
314	181	o	https://dhcplay.com/e/	SEASON	5	c3h0whykqci6	\N	f	2025-06-28 22:58:06.295
315	181	o	https://dhcplay.com/e/	SEASON	6	t0g5yhx1m8dp	\N	f	2025-06-28 22:58:06.295
316	181	o	https://dhcplay.com/e/	SEASON	7	uf5pzfs3znab	\N	f	2025-06-28 22:58:06.295
317	181	o	https://dhcplay.com/e/	SEASON	8	z7bb42a6u3ff	\N	f	2025-06-28 22:58:06.295
318	181	o	https://dhcplay.com/e/	SEASON	9	owyrtjvy25xs	\N	f	2025-06-28 22:58:06.295
319	181	o	https://dhcplay.com/e/	SEASON	10	ivbaawmgsc23	\N	f	2025-06-28 22:58:06.295
320	182	o	https://dhcplay.com/e/	SEASON	1	t624mj7urisk	\N	f	2025-06-28 22:58:06.295
321	182	o	https://dhcplay.com/e/	SEASON	2	e12w0jwvnh2j	\N	f	2025-06-28 22:58:06.295
322	182	o	https://dhcplay.com/e/	SEASON	3	nqybdv6guyqr	\N	f	2025-06-28 22:58:06.295
323	182	o	https://dhcplay.com/e/	SEASON	4	mqqg1oroskrs	\N	f	2025-06-28 22:58:06.295
324	182	o	https://dhcplay.com/e/	SEASON	5	ycccmjhy6dfd	\N	f	2025-06-28 22:58:06.295
325	182	o	https://dhcplay.com/e/	SEASON	6	umgb06nhhbwf	\N	f	2025-06-28 22:58:06.295
326	182	o	https://dhcplay.com/e/	SEASON	7	qcekbuinuk88	\N	f	2025-06-28 22:58:06.295
327	182	o	https://dhcplay.com/e/	SEASON	8	75xvxoi3y0qw	\N	f	2025-06-28 22:58:06.295
328	182	o	https://dhcplay.com/e/	SEASON	9	8yspohl4fg6e	\N	f	2025-06-28 22:58:06.295
329	182	o	https://dhcplay.com/e/	SEASON	10	qolxny0ivpz1	\N	f	2025-06-28 22:58:06.295
330	183	o	https://dhcplay.com/e/	END	1	mymd288birdw	\N	f	2025-06-28 22:58:06.295
331	183	o	https://dhcplay.com/e/	END	2	qgidxtjuab1b	\N	f	2025-06-28 22:58:06.295
332	184	o	https://dhcplay.com/e/	END	1	u6u7b243f4iy	\N	f	2025-06-28 22:58:06.295
333	184	o	https://dhcplay.com/e/	END	2	2r3u46v1vj0c	\N	f	2025-06-28 22:58:06.295
334	185	o	https://dhcplay.com/e/	END	1	sza1y1oih5w8	\N	f	2025-06-28 22:58:06.295
335	186	o	https://anonsharing.com/	SEASON	1	file/fb9ff373fd939023/The_Originals_S01e01.mp4	\N	f	2025-06-28 22:58:06.295
336	186	o	https://anonsharing.com/	SEASON	2	file/6559fccdb7f46630/The_Originals_S01e02.mp4	\N	f	2025-06-28 22:58:06.295
337	186	o	https://anonsharing.com/	SEASON	3	file/8065da88b8665a5d/The_Originals_S01e03.mp4	\N	f	2025-06-28 22:58:06.295
338	186	o	https://anonsharing.com/	SEASON	4	file/34c221b2ecd5653c/The_Originals_S01e04.mp4	\N	f	2025-06-28 22:58:06.295
339	186	o	https://anonsharing.com/	SEASON	5	file/663b16f4768c38bd/The_Originals_S01e05.mp4	\N	f	2025-06-28 22:58:06.295
340	186	o	https://anonsharing.com/	SEASON	6	file/d3ac4bb9c2810e90/The_Originals_S01e06.mp4	\N	f	2025-06-28 22:58:06.295
341	186	o	https://anonsharing.com/	SEASON	7	file/2ce165e278b57857/The_Originals_S01e07.mp4	\N	f	2025-06-28 22:58:06.295
342	186	o	https://anonsharing.com/	SEASON	8	file/3d04496771a574ba/The_Originals_S01e08.mp4	\N	f	2025-06-28 22:58:06.295
343	186	o	https://anonsharing.com/	SEASON	9	file/3a642f052cb8489f/The_Originals_S01e09.mp4	\N	f	2025-06-28 22:58:06.295
344	186	o	https://anonsharing.com/	SEASON	10	file/49cec4f5a6c42eca/The_Originals_S01e10.mp4	\N	f	2025-06-28 22:58:06.295
345	186	o	https://dhcplay.com/e/	SEASON	11	w1drqlw3cbzr	\N	f	2025-06-28 22:58:06.295
346	186	o	https://dhcplay.com/e/	SEASON	12	vr6vdvm8jtve	\N	f	2025-06-28 22:58:06.295
347	187	o	https://dhcplay.com/e/	END	1	2fuvkv6qdp8j	\N	f	2025-06-28 22:58:06.295
348	188	o	https://dhcplay.com/e/	END	1	kyq4vkgix9dh	\N	f	2025-06-28 22:58:06.295
349	189	o	https://dhcplay.com/e/	END	1	4j6udbhzqlnl	\N	f	2025-06-28 22:58:06.295
350	190	o	https://dhcplay.com/e/	END	1	5r0c18uj1khj	\N	f	2025-06-28 22:58:06.295
351	191	o	https://dhcplay.com/e/	END	1	yky9ykdqom99	\N	f	2025-06-28 22:58:06.295
352	191	o	https://dhcplay.com/e/	END	2	gkpiyw43o5dx	\N	f	2025-06-28 22:58:06.295
353	192	o	https://dhcplay.com/e/	END	1	93li6ulx85sn	\N	f	2025-06-28 22:58:06.295
354	192	o	https://dhcplay.com/e/	END	2	couefhkkt8sc	\N	f	2025-06-28 22:58:06.295
355	193	o	https://dhcplay.com/e/	END	1	it1yq9gw7d3k	\N	f	2025-06-28 22:58:06.295
356	193	o	https://dhcplay.com/e/	END	2	lpc7ldi09txy	\N	f	2025-06-28 22:58:06.295
357	194	o	https://anonsharing.com/	END	1	file/ca8baf291a07e273/Amaran_A.mp4	\N	f	2025-06-28 22:58:06.295
358	194	o	https://anonsharing.com/	END	2	file/fb19baaaea1e2b6f/Amaran_B.mp4	\N	f	2025-06-28 22:58:06.295
360	195	o	https://dhcplay.com/e/	END	1	0ed6zmdcq8ud	\N	f	2025-06-28 22:58:06.295
362	195	o	https://dhcplay.com/e/	END	2	42m5pdolm44g	\N	f	2025-06-28 22:58:06.295
363	195	o	https://dhcplay.com/e/	END	3	2in8utcqkpnr	\N	f	2025-06-28 22:58:06.295
364	196	o	https://dhcplay.com/e/	END	1	3ft1jbltxloi	\N	f	2025-06-28 22:58:06.295
365	196	o	https://dhcplay.com/e/	END	2	corvpdn6a2ta	\N	f	2025-06-28 22:58:06.295
366	197	o	https://dhcplay.com/e/	SEASON	1	jzln2w9acazg	\N	f	2025-06-28 22:58:06.295
367	197	o	https://dhcplay.com/e/	SEASON	2	gbtvqwg0kqwf	\N	f	2025-06-28 22:58:06.295
368	197	o	https://dhcplay.com/e/	SEASON	3	vz4gyouus1v1	\N	f	2025-06-28 22:58:06.295
369	197	o	https://dhcplay.com/e/	SEASON	4	kip2cj3jn6hc	\N	f	2025-06-28 22:58:06.295
370	197	o	https://dhcplay.com/e/	SEASON	5	r5h2myjowem6	\N	f	2025-06-28 22:58:06.295
371	197	o	https://dhcplay.com/e/	SEASON	6	nmi68v1jewu6	\N	f	2025-06-28 22:58:06.295
372	197	o	https://dhcplay.com/e/	SEASON	7	joxncha6nfh6	\N	f	2025-06-28 22:58:06.295
373	197	o	https://dhcplay.com/e/	SEASON	8	0glp6rrn3kdi	\N	f	2025-06-28 22:58:06.295
374	197	o	https://dhcplay.com/e/	SEASON	9	r15dc3s02kr1	\N	f	2025-06-28 22:58:06.295
375	197	o	https://dhcplay.com/e/	SEASON	10	rofky5akqpvj	\N	f	2025-06-28 22:58:06.295
376	198	o	https://dhcplay.com/e/	SEASON	1	u3zjkonk183q	\N	f	2025-06-28 22:58:06.295
377	198	o	https://dhcplay.com/e/	SEASON	2	5r52uy6mnfi7	\N	f	2025-06-28 22:58:06.295
378	198	o	https://dhcplay.com/e/	SEASON	3	w5vjitfvdo03	\N	f	2025-06-28 22:58:06.295
379	198	o	https://dhcplay.com/e/	SEASON	5	qfe1fsh0hehs	\N	f	2025-06-28 22:58:06.295
380	198	o	https://dhcplay.com/e/	SEASON	6	1nh6h79228a6	\N	f	2025-06-28 22:58:06.295
381	198	o	https://dhcplay.com/e/	SEASON	8	y27ba3xublsx	\N	f	2025-06-28 22:58:06.295
382	198	o	https://dhcplay.com/e/	SEASON	9	xur4xlpubv8e	\N	f	2025-06-28 22:58:06.295
383	198	o	https://dhcplay.com/e/	SEASON	10	35tvgfzz8a4h	\N	f	2025-06-28 22:58:06.295
384	199	o	https://dhcplay.com/e/	SEASON	1	nhhs2d8heixq	\N	f	2025-06-28 22:58:06.295
385	199	o	https://dhcplay.com/e/	SEASON	2	qb4to8ysvfge	\N	f	2025-06-28 22:58:06.295
386	199	o	https://dhcplay.com/e/	SEASON	3	nkuu7nh0tolw	\N	f	2025-06-28 22:58:06.295
387	199	o	https://dhcplay.com/e/	SEASON	4	oam1vlf1yzqz	\N	f	2025-06-28 22:58:06.295
388	199	o	https://dhcplay.com/e/	SEASON	5	ffbtcnz2c5hx	\N	f	2025-06-28 22:58:06.295
389	199	o	https://dhcplay.com/e/	SEASON	6	a79otecwz1i1	\N	f	2025-06-28 22:58:06.295
390	199	o	https://dhcplay.com/e/	SEASON	7	6pc3anf959st	\N	f	2025-06-28 22:58:06.295
391	199	o	https://dhcplay.com/e/	SEASON	8	l8lxbophnbxp	\N	f	2025-06-28 22:58:06.295
392	199	o	https://dhcplay.com/e/	SEASON	9	8h4fss228u28	\N	f	2025-06-28 22:58:06.295
393	200	o	https://dhcplay.com/e/	END	1	ghcw9matpo6j	\N	f	2025-06-28 22:58:06.295
394	200	o	https://dhcplay.com/e/	END	2	hb7ez5tb8g5r	\N	f	2025-06-28 22:58:06.295
395	200	o	https://dhcplay.com/e/	END	3	5umjbffe07r4	\N	f	2025-06-28 22:58:06.295
396	201	o	https://dhcplay.com/e/	END	1	7sbyz55arysx	\N	f	2025-06-28 22:58:06.295
398	203	s	https://dhcplay.com/e/	END	1	rwzk4uhgvibc	\N	f	2025-06-28 22:58:06.295
399	204	o	https://dhcplay.com/e/	SEASON	1	l74rv53453tu	\N	f	2025-06-28 22:58:06.295
400	204	s	https://dhcplay.com/e/	SEASON	2	9aza3bd4aicg	\N	f	2025-06-28 22:58:06.295
401	204	o	https://dhcplay.com/e/	SEASON	3	a07ctsufs1hm	\N	f	2025-06-28 22:58:06.295
402	204	o	https://dhcplay.com/e/	SEASON	4	zkm9qopie782	\N	f	2025-06-28 22:58:06.295
404	205	o	https://dhcplay.com/e/	SEASON	2	kjgy3ecpjik9	\N	f	2025-06-28 22:58:06.295
405	205	o	https://dhcplay.com/e/	SEASON	3	yhnbm9850wa6	\N	f	2025-06-28 22:58:06.295
406	205	o	https://dhcplay.com/e/	SEASON	4	kac4vigadsjx	\N	f	2025-06-28 22:58:06.295
407	205	o	https://dhcplay.com/e/	SEASON	5	mt8ic5sp5y23	\N	f	2025-06-28 22:58:06.295
408	206	o	https://dhcplay.com/e/	END	1	b7k9dny90puw	\N	f	2025-06-28 22:58:06.295
409	206	o	https://dhcplay.com/e/	END	2	uflv5gqlshmw	\N	f	2025-06-28 22:58:06.295
410	7	o	https://drive.google.com/	END	1	file/d/1jAqZw9SUMZMK24jkDTYwqCKqDIziBdv0/preview	\N	f	2025-06-28 22:58:06.295
411	207	theg	https://anonsharing.com/	END	1	file/26c586d24ac525b5/Duplicate.mp4	\N	f	2025-06-28 22:58:06.295
412	208	theg	https://anonsharing.com/	END	1	file/31a70692c9d032d2/Aquaman_and_the_Lost_Kingdom.mp4	\N	f	2025-06-28 22:58:06.295
413	209	theg	https://anonsharing.com/	END	1	file/dd64672b9860fb56/Colombiana.mp4	\N	f	2025-06-28 22:58:06.295
414	210	o	https://dhcplay.com/e/	END	1	si14edw726nq	\N	f	2025-06-28 22:58:06.295
415	211	o	https://dhcplay.com/e/	SEASON	1	q8sc3o6tcdl9	\N	f	2025-06-28 22:58:06.295
416	211	o	https://dhcplay.com/e/	SEASON	2	lks4rs5gqrsz	\N	f	2025-06-28 22:58:06.295
417	211	o	https://dhcplay.com/e/	SEASON	3	nm6b1l67np48	\N	f	2025-06-28 22:58:06.295
418	211	o	https://dhcplay.com/e/	SEASON	4	m9qobx2sue57	\N	f	2025-06-28 22:58:06.295
419	211	o	https://dhcplay.com/e/	SEASON	5	byednbyvwuep	\N	f	2025-06-28 22:58:06.295
420	212	theg	https://anonsharing.com/	END	1	file/631fde00afe0e919/Fury_12_Hours.mp4	\N	f	2025-06-28 22:58:06.295
421	213	theg	https://anonsharing.com/	END	1	file/c492b65a26f5f1ba/Tin_Soldier.mp4	\N	f	2025-06-28 22:58:06.295
422	214	theg	https://anonsharing.com/	END	1	file/3474e0dd5b8f0fbc/Mayhem.mp4	\N	f	2025-06-28 22:58:06.295
423	215	theg	https://anonsharing.com/	END	1	file/5520b62b54b6e336/Until_Dawn.mp4	\N	f	2025-06-28 22:58:06.295
424	216	theg	https://anonsharing.com/	END	1	file/58990b1d26197415/The_Kid_Who_Would_Be_King.mp4	\N	f	2025-06-28 22:58:06.295
425	218	siniya	https://drive.google.com/	END	1	file/d/1yrHQ90uYmsVOqdd_C7qVqLQ1M0j50lt0/preview	\N	f	2025-06-28 22:58:06.295
426	218	siniya	https://drive.google.com/	END	2	file/d/1vT0zKjgH4RxHkqFb7OBwe_pUBVORH3VM/preview	\N	f	2025-06-28 22:58:06.295
427	218	siniya	https://drive.google.com/	END	3	file/d/1kh7HXCzhGabQV6DVe9VIJbexlwnk-zfp/preview	\N	f	2025-06-28 22:58:06.295
428	218	siniya	https://drive.google.com/	END	4	file/d/1FvE1szMO-P8NoC-PdCed8R-qZNyha0_W/preview	\N	f	2025-06-28 22:58:06.295
429	218	siniya	https://drive.google.com/	END	5	file/d/1KNXHtbPjGxiCpCZLegLoMTMtFlpMsNKL/preview	\N	f	2025-06-28 22:58:06.295
430	219	o	https://anonsharing.com/	END	1	file/46ef51c5b47a2495/Sikandar.mp4	\N	f	2025-06-28 22:58:06.295
432	220	theg	https://anonsharing.com	END	1	/file/ab3da4f467685e18/Fountain_Of_Youth.mp4	\N	f	2025-06-28 22:58:06.295
433	205	o	https://dhcplay.com/e/	SEASON	6	awixfrs15xfc	\N	f	2025-06-28 22:58:06.295
434	205	o	https://dhcplay.com/e/	SEASON	7	tboagcfzb4ef	\N	f	2025-06-28 22:58:06.295
435	205	o	https://dhcplay.com/e/	SEASON	8	wat5otu2gbyx	\N	f	2025-06-28 22:58:06.295
436	205	o	https://dhcplay.com/e/	SEASON	9	oxb408ufrkcv	\N	f	2025-06-28 22:58:06.295
437	205	o	https://dhcplay.com/e/	SEASON	10	17x69ecyqi5q	\N	f	2025-06-28 22:58:06.295
438	205	o	https://dhcplay.com/e/	SEASON	11	aoodr8aklrn5	\N	f	2025-06-28 22:58:06.295
439	221	theg	https://anonsharing.com/	END	1	file/1320cefa7f541bb3/Headhunters.mp4	\N	f	2025-06-28 22:58:06.295
440	222	theg	https://anonsharing.com/	END	7	file/837cb5b63f4abc4e/Rosario.mp4	\N	f	2025-06-28 22:58:06.295
443	224	o	https://drive.google.com/	END	1	file/d/1UsbGRGC-FMoUvlpB78jHnaFLdEZryFfO/preview	\N	f	2025-06-28 22:58:06.295
444	224	o	https://drive.google.com/	END	2	file/d/1A1fbGd-T5ojLrosx_6uDPiVp7hAFrjcE/preview	\N	f	2025-06-28 22:58:06.295
445	225	theg	https://anonsharing.com/	END	1	file/3b6f84736e98ab3c/Pushpa_2.mp4	\N	f	2025-06-28 22:58:06.295
446	226	theg	https://anonsharing.com/	END	1	file/11c0acbbbe5478f4/Vaamana.mp4	\N	f	2025-06-28 22:58:06.295
448	227	theg	https://anonsharing.com/	SEASON	2	file/303f7e68108097c4/Triada_S01e02.mp4	\N	f	2025-06-28 22:58:06.295
449	227	theg	https://anonsharing.com/	SEASON	3	file/dea062505428f7d3/Triada_S01e03.mp4	\N	f	2025-06-28 22:58:06.295
450	227	theg	https://anonsharing.com/	SEASON	4	file/10b5345955947ef7/Triada_S01e04.mp4	\N	f	2025-06-28 22:58:06.295
451	223	theg	https://anonsharing.com/	END	1	file/289d5a7c010e9794/Sinners.mp4	\N	f	2025-06-28 22:58:06.295
452	228	siniya	https://drive.google.com/	END	1	file/d/1B06DdKGomNKT6JC_cd3XYiRDnQO7z1OY/preview	\N	f	2025-06-28 22:58:06.295
453	228	siniya	https://drive.google.com/	END	2	file/d/1-1nGtHUAfTIOxgUu4rXN_6lQ0NxEn8c8/preview	\N	f	2025-06-28 22:58:06.295
454	229	theg	https://anonsharing.com/	END	1	file/0e59764930e7b76d/Love_Per_Square_Foot.mp4	\N	f	2025-06-28 22:58:06.295
455	227	theg	https://anonsharing.com/	SEASON	5	file/371cd68862b43e93/Triada_S01e05.mp4	\N	f	2025-06-28 22:58:06.295
456	230	o	https://anonsharing.com/	SEASON	1	file/03a83d0d01667ed8/The_Cleaning_Lady_S01e01.mp4	\N	f	2025-06-28 22:58:06.295
457	230	o	https://anonsharing.com/	SEASON	2	file/1a40415c0ec66cb7/The_Cleaning_Lady_S01e02.mp4	\N	f	2025-06-28 22:58:06.295
458	230	o	https://anonsharing.com/	SEASON	3	file/8a45e120925da680/The_Cleaning_Lady_S01e03.mp4	\N	f	2025-06-28 22:58:06.295
459	230	o	https://anonsharing.com/	SEASON	4	file/78d6e50ed311beea/The_Cleaning_Lady_S01e04.mp4	\N	f	2025-06-28 22:58:06.295
460	230	o	https://anonsharing.com/	SEASON	5	file/9c90291c5e5fafdd/The_Cleaning_Lady_S01e05.mp4	\N	f	2025-06-28 22:58:06.295
461	230	o	https://anonsharing.com/	SEASON	6	file/80d37e131573119c/The_Cleaning_Lady_S01e06.mp4	\N	f	2025-06-28 22:58:06.295
462	230	o	https://anonsharing.com/	SEASON	7	file/22a9ed8b35f8b128/The_Cleaning_Lady_S01e07.mp4	\N	f	2025-06-28 22:58:06.295
463	230	o	https://anonsharing.com/	SEASON	8	file/e02989757569a953/The_Cleaning_Lady_S01e08.mp4	\N	f	2025-06-28 22:58:06.295
464	230	o	https://anonsharing.com/	SEASON	9	file/c2c7b8504a459853/The_Cleaning_Lady_S01e09.mp4	\N	f	2025-06-28 22:58:06.295
465	230	o	https://anonsharing.com/	SEASON	10	file/107b1279c10f7eb8/The_Cleaning_Lady_S01e10_Finale.mp4	\N	f	2025-06-28 22:58:06.295
466	231	theg	https://anonsharing.com/	SEASON	1	file/e0ff9106d842e3fc/The_Cleaning_Lady_S02e01.mp4	\N	f	2025-06-28 22:58:06.295
467	231	theg	https://anonsharing.com/	SEASON	2	file/86f68d087b6ad2fb/The_Cleaning_Lady_S02e02.mp4	\N	f	2025-06-28 22:58:06.295
468	231	theg	https://anonsharing.com/	SEASON	3	file/465b36b22d4d1f49/The_Cleaning_Lady_S02e03.mp4	\N	f	2025-06-28 22:58:06.295
469	231	theg	https://anonsharing.com/	SEASON	4	file/c8f536e8ced047c6/The_Cleaning_Lady_S02e04.mp4	\N	f	2025-06-28 22:58:06.295
470	231	theg	https://anonsharing.com/	SEASON	5	file/98ce0658cdbaec00/The_Cleaning_Lady_S02e05.mp4	\N	f	2025-06-28 22:58:06.295
471	231	theg	https://anonsharing.com/	SEASON	6	file/57724c20b39ad960/The_Cleaning_Lady_S02e06.mp4	\N	f	2025-06-28 22:58:06.295
472	231	theg	https://anonsharing.com/	SEASON	7	file/c4143652a6023b05/The_Cleaning_Lady_S02e07.mp4	\N	f	2025-06-28 22:58:06.295
473	231	theg	https://anonsharing.com/	SEASON	8	file/96ffbc608ff2356a/The_Cleaning_Lady_S02e08.mp4	\N	f	2025-06-28 22:58:06.295
474	231	theg	https://anonsharing.com/	SEASON	9	file/83991b2f7f393fd9/The_Cleaning_Lady_S02e09.mp4	\N	f	2025-06-28 22:58:06.295
475	231	theg	https://anonsharing.com/	SEASON	10	file/c03835ee34301caa/The_Cleaning_Lady_S02e10.mp4	\N	f	2025-06-28 22:58:06.295
476	231	theg	https://anonsharing.com/	SEASON	11	file/fdcd9839b4a64367/The_Cleaning_Lady_S02e11.mp4	\N	f	2025-06-28 22:58:06.295
477	231	theg	https://anonsharing.com/	SEASON	12	file/bdd0d51cbc16f1fd/The_Cleaning_Lady_S02e12_Finale.mp4	\N	f	2025-06-28 22:58:06.295
478	232	theg	https://anonsharing.com/	SEASON	1	file/0f820a38ad4c1b9d/The_Cleaning_Lady_S03e01.mp4	\N	f	2025-06-28 22:58:06.295
479	232	theg	https://anonsharing.com/	SEASON	2	file/806cde0f13ce6b10/The_Cleaning_Lady_S03e02.mp4	\N	f	2025-06-28 22:58:06.295
480	232	theg	https://anonsharing.com/	SEASON	3	file/8ca550ad8e1ccf5e/The_Cleaning_Lady_S03e03.mp4	\N	f	2025-06-28 22:58:06.295
481	232	theg	https://anonsharing.com/	SEASON	4	file/859abe3f5ff12fc9/The_Cleaning_Lady_S03e04.mp4	\N	f	2025-06-28 22:58:06.295
482	232	theg	https://anonsharing.com/	SEASON	5	file/ea0ae5e482fbaa19/The_Cleaning_Lady_S03e05.mp4	\N	f	2025-06-28 22:58:06.295
483	232	theg	https://anonsharing.com/	SEASON	5	file/a2e300d866f8e8a1/The_Cleaning_Lady_S03e06.mp4	\N	f	2025-06-28 22:58:06.295
484	232	theg	https://anonsharing.com/	SEASON	7	file/2d46f338f716cb62/The_Cleaning_Lady_S03e07.mp4	\N	f	2025-06-28 22:58:06.295
485	232	theg	https://anonsharing.com/	SEASON	8	file/4a497f20b7236532/The_Cleaning_Lady_S03e08.mp4	\N	f	2025-06-28 22:58:06.295
486	232	theg	https://anonsharing.com/	SEASON	9	file/2be1dba1086e3de8/The_Cleaning_Lady_S03e09.mp4	\N	f	2025-06-28 22:58:06.295
487	232	theg	https://anonsharing.com/	SEASON	10	file/b51a190896941fcb/The_Cleaning_Lady_S03e10.mp4	\N	f	2025-06-28 22:58:06.295
488	232	theg	https://anonsharing.com/	SEASON	11	file/0ec1c8386335ab67/The_Cleaning_Lady_S03e11.mp4	\N	f	2025-06-28 22:58:06.295
489	232	theg	https://anonsharing.com/	SEASON	12	file/13d6bfc96e1ed9b0/The_Cleaning_Lady_S03e12_Finale.mp4	\N	f	2025-06-28 22:58:06.295
490	233	theg	https://anonsharing.com/	SEASON	1	file/75a95cf97a7a1ab7/The_Cleaning_Lady_S04e01.mp4	\N	f	2025-06-28 22:58:06.295
491	233	theg	https://anonsharing.com/	SEASON	2	file/b9e485f768ae6aa4/The_Cleaning_Lady_S04e02.mp4	\N	f	2025-06-28 22:58:06.295
492	234	o	https://anonsharing.com/	END	1	file/d9920e8f6506abdd/Jaat.mp4	\N	f	2025-06-28 22:58:06.295
494	186	thg	https://anonsharing.com/f	SEASON	11	ile/eda33f5da576f107/The_Originals_S01e11.mp4	\N	f	2025-06-28 22:58:06.295
495	186	thg	https://anonsharing.com/	SEASON	12	file/5e0cd18f273708b2/The_Originals_S01e12.mp4	\N	f	2025-06-28 22:58:06.295
496	186	thg	https://anonsharing.com/	SEASON	13	file/5f8dadf67bbb43af/The_Originals_S01e13.mp4	\N	f	2025-06-28 22:58:06.295
497	186	thg	https://anonsharing.com/	SEASON	14	file/f6b6b38df6e6f237/The_Originals_S01e14.mp4	\N	f	2025-06-28 22:58:06.295
498	186	thg	https://anonsharing.com/	SEASON	14	file/9233445f56b25ef3/The_Originals_S01e15.mp4	\N	f	2025-06-28 22:58:06.295
499	186	thg	https://anonsharing.com/	SEASON	16	file/315ee055149eb88f/The_Originals_S01e16.mp4	\N	f	2025-06-28 22:58:06.295
500	235	theg	https://anonsharing.com	END	1	/file/3e9301a8a1330066/Straw_A.mp4	\N	f	2025-06-28 22:58:06.295
501	235	theg	https://anonsharing.com	END	2	/file/cd1f3c924962a758/Straw_B.mp4	\N	f	2025-06-28 22:58:06.295
503	237	theg	https://anonsharing.com/	END	1	file/ed63e541bda280ca/Maaveeran.mp4	\N	f	2025-06-28 22:58:06.295
3	240	siniya	https://drive.google.com	END	1	/file/d/13-iy8SEm7yoz6XehkCamMWZQjQtKb2BT/preview		f	2025-06-28 22:58:06.295
504	240	siniya	https://drive.google.com	END	2	/file/d/13rjcipjzl76_LXzG_6LGT4Tk8yOUPHpt/preview		f	2025-06-28 22:58:06.295
505	241	siniya	https://drive.google.com	END	1	/file/d/1AmpjK7fZOgNXE1gWkXHvVUnkapGOJkh5/preview		f	2025-06-28 22:58:06.295
506	241	siniya	https://drive.google.com	END	2	/file/d/1J4buWHrmk6JwhsJumL1Xm2-BsLGNHznG/preview		f	2025-06-28 22:58:06.295
507	241	siniya	https://drive.google.com	END	3	/file/d/18f36Ka8AtHXEgithbs9fGtNd9Arj5bCJ/preview		f	2025-06-28 22:58:06.295
508	242	o	https://dhcplay.com/e/	END	1	4718k3xyl92h	https://www.mediafire.com/file/y8au8ez0gcov8ho/TROUBLE_A.mp4/file	f	2025-06-28 22:58:06.295
509	243	theg	https://anonsharing.com	END	1	/file/0805252bc20f9eab/Naa_Peru_Surya.mp4		f	2025-06-28 22:58:06.295
510	244	theg	https://anonsharing.com	END	1	/file/3c0b793c3b791fa6/Nameless_Heroes.mp4		f	2025-06-28 22:58:06.295
511	245	theg	https://anonsharing.com	END	1	/file/0b018c831459c6a1/Ramabanam.mp4		f	2025-06-28 22:58:06.295
512	246	theg	https://anonsharing.com	SEASON	1	/file/34ffe8a885ee7785/Rings_Of_The_Power_S01e01.mp4		f	2025-06-28 22:58:06.295
513	246	theg	https://anonsharing.com/	SEASON	2	file/7bd047617641ccfb/Rings_Of_The_Power_S01e02.mp4		f	2025-06-28 22:58:06.295
514	246	theg	https://anonsharing.com	SEASON	3	/file/890fbb7a2039ad88/Rings_Of_The_Power_S01e03.mp4		f	2025-06-28 22:58:06.295
515	246	theg	https://anonsharing.com/	SEASON	4	file/51ee3218e8724bf2/Rings_Of_The_Power_S01e04.mp4		f	2025-06-28 22:58:06.295
516	246	theg	https://anonsharing.com	SEASON	5	/file/453d6818842951a2/The_Rings_of_Power_S01e05.mp4		f	2025-06-28 22:58:06.295
517	246	theg	https://anonsharing.com/	SEASON	6	file/7e114e033b0398ba/The_Rings_of_Power_S01e06.mp4		f	2025-06-28 22:58:06.295
518	246	theg	https://anonsharing.com/	SEASON	7	file/8272b2c706237a0f/The_Rings_of_Power_S01e07.mp4		f	2025-06-28 22:58:06.295
519	246	theg	https://anonsharing.com/	SEASON	8	file/fa912749dd376a5e/The_Rings_of_Power_S01e08_A.mp4		f	2025-06-28 22:58:06.295
520	247	o	https://dhcplay.com/e/	END	1	pjr54syn2xse	https://www.mediafire.com/file/wxr46l0unsdtlec/PATHAAN_A.mp4/file	f	2025-06-28 22:58:06.295
521	247	o	https://dhcplay.com/e/	END	2	86m8cllvdce1	https://www.mediafire.com/file/kekdh2h6dhch89f/PATHAAN_B.mp4/file	f	2025-06-28 22:58:06.295
522	248	o	https://dhcplay.com/e/	END	1	dey0jjkf3j48	https://www.mediafire.com/file/bnoxmg4evl8abxz/Triple_Frontier_2020.mp4/file	f	2025-06-28 22:58:06.295
523	242	o	https://dhcplay.com/e/	END	2	g3gdaxfnu78n	https://www.mediafire.com/file/1eoozp2v2gftjhf/TROULE+B.mp4/file	f	2025-06-28 22:58:06.295
524	205	now	https://short.icu	SEASON	12	/7-Mz8Ld-5		t	2025-06-28 22:58:06.295
525	205	now	https://short.icu	SEASON	13	/3BibxyH-V		t	2025-06-28 22:58:06.295
526	205	now	https://short.icu/	SEASON	14	k9svwZ0uj		t	2025-06-28 22:58:06.295
527	205	now	https://short.icu/	SEASON	15	BtN08EeHB		t	2025-06-28 22:58:06.295
528	205	now	https://short.icu/	SEASON	16	XmSvdQsYB		t	2025-06-28 22:58:06.295
529	205	now	https://short.icu/	SEASON	17	BV9oZQZCA		t	2025-06-28 22:58:06.295
530	205	now	https://short.icu/	SEASON	18	YoHwXtbwz		t	2025-06-28 22:58:06.295
531	205	now	https://short.icu/	SEASON	19	J565u6cEp		t	2025-06-28 22:58:06.295
532	205	now	https://short.icu/	SEASON	20	5cjEMMO5LY		t	2025-06-28 22:58:06.295
533	205	now	https://short.icu/	SEASON	21	9VF8ICY-b		t	2025-06-28 22:58:06.295
534	205	now	https://short.icu/	SEASON	22	uNEPb-3mZh		t	2025-06-28 22:58:06.295
535	205	now	https://short.icu/	SEASON	23	BE-fTQ5j-		t	2025-06-28 22:58:06.295
536	205	now	https://short.icu/	SEASON	24	RrkoD1yEG		t	2025-06-28 22:58:06.295
538	249	now	https://repackager.wixmp.com/	SEASON	1	video.wixstatic.com/video/d7f9fb_574785d2e92a4c4595328cbac10c153f/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
539	249	now	https://repackager.wixmp.com/	SEASON	2	video.wixstatic.com/video/d7f9fb_67e5f3404f95464a9d1cfed448376132/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
540	249	now	https://repackager.wixmp.com	SEASON	3	/video.wixstatic.com/video/d7f9fb_98b0d55754474362b12e2646e59f3b31/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
541	249	now	https://repackager.wixmp.com	SEASON	4	/video.wixstatic.com/video/d7f9fb_f9895cc45bb543b09177668b7cdd572f/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
542	249	now	https://repackager.wixmp.com	SEASON	5	/video.wixstatic.com/video/d7f9fb_bb14887e7c6746fd825312ec48cb7140/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
543	249	now	https://repackager.wixmp.com	SEASON	6	/video.wixstatic.com/video/d7f9fb_0c33e71e382a4ceb9797319a9f16b5e9/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
544	249	now	https://repackager.wixmp.com	SEASON	7	/video.wixstatic.com/video/d7f9fb_9022b2e61a79452083a12b768c966cd2/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
545	249	now	https://repackager.wixmp.com	SEASON	8	/video.wixstatic.com/video/d7f9fb_74c47319f28449d3b2f982909c898957/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
546	249	now	https://repackager.wixmp.com	SEASON	9	/video.wixstatic.com/video/d7f9fb_99bfee5c7d784e7f9557e38929b54cfe/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
547	249	now	https://repackager.wixmp.com/video.wixstatic.com	SEASON	10	/video/d7f9fb_901e48806d644119a6e58a7e912cab6b/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
548	249	now	https://repackager.wixmp.com	SEASON	11	/video.wixstatic.com/video/d7f9fb_83e8d5b9555346da951e96bbd5b84856/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
549	249	now	https://repackager.wixmp.com	SEASON	12	/video.wixstatic.com/video/d7f9fb_b6dc002eff674a49b6bcc12ccf06a5ee/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
552	249	now	https://repackager.wixmp.com	SEASON	13	/video.wixstatic.com/video/d7f9fb_8a93eb0483134494b492cdd7b2e132d1/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
553	249	now	https://repackager.wixmp.com	SEASON	14	/video.wixstatic.com/video/d7f9fb_8a1efe4bc30c4beb8b05ab0e2784d657/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
554	249	now	https://repackager.wixmp.com	SEASON	15	/video.wixstatic.com/video/d7f9fb_cccdb394a1c34c1a81c1ac8c872cf7aa/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
555	249	now	https://repackager.wixmp.com	SEASON	16	/video.wixstatic.com/video/d7f9fb_36fa5412e6864f64a39c44959ab2d23e/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
556	250	now	https://repackager.wixmp.com/	SEASON	1	video.wixstatic.com/video/d7f9fb_ec263f9949714918ac45d64be966bb14/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
557	250	now	https://repackager.wixmp.com/video.wixstatic.com	SEASON	2	/video/d7f9fb_d55c87be5d4142f28303f0be8d510774/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
558	250	now	https://repackager.wixmp.com	SEASON	3	/video.wixstatic.com/video/d7f9fb_5ee702e645fd43eca27ce3bbb15c8b69/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
559	250	now	https://repackager.wixmp.com	SEASON	4	/video.wixstatic.com/video/d7f9fb_f403c95dddc344a58b3995cae91840ea/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
560	250	now	https://repackager.wixmp.com	SEASON	5	/video.wixstatic.com/video/d7f9fb_1e192e1808fc4169932fce0b1669914a/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
561	250	now	https://repackager.wixmp.com	SEASON	6	/video.wixstatic.com/video/d7f9fb_0501039413644659ae665119b9de86ae/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
562	250	now	https://repackager.wixmp.com/video.wixstatic.com/	SEASON	7	video/d7f9fb_73a4500cb79143879139b07d3050c2d8/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
563	250	now	https://repackager.wixmp.com	SEASON	8	/video.wixstatic.com/video/d7f9fb_41e75e0bd93843c0a7b5b77f19675950/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
564	250	now	https://repackager.wixmp.com	SEASON	9	/video.wixstatic.com/video/d7f9fb_ad683aeb6d6e49ddbf0e07718eb36c16/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
565	250	now	https://repackager.wixmp.com	SEASON	10	/video.wixstatic.com/video/d7f9fb_38bc94036a27453684e5e8807f24ca38/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
566	250	now	https://repackager.wixmp.com	SEASON	11	/video.wixstatic.com/video/d7f9fb_4397cb7cd6924dde8eab7be04ab66b37/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
567	250	now	https://repackager.wixmp.com	SEASON	12	/video.wixstatic.com/video/d7f9fb_3ae2d62a02444300984967c269dc0cae/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
568	250	now	https://repackager.wixmp.com	SEASON	13	/video.wixstatic.com/video/d7f9fb_3931d8f75740421390c1a7554d825f00/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
571	251	now	https://repackager.wixmp.com	SEASON	1	/video.wixstatic.com/video/d7f9fb_b94bbb40a1234634af8f75c620317a7e/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
572	251	now	https://repackager.wixmp.com	SEASON	2	/video.wixstatic.com/video/d7f9fb_e4fb2976dd0b442491c80c18192eb9c8/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
573	251	now	https://repackager.wixmp.com	SEASON	3	/video.wixstatic.com/video/d7f9fb_446474db2a734155895f48a09d55d348/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
574	251	now	https://repackager.wixmp.com	SEASON	4	/video.wixstatic.com/video/d7f9fb_09cf2a513663400888d1ff0efba3e4e9/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
575	251	now	https://repackager.wixmp.com	SEASON	5	/video.wixstatic.com/video/d7f9fb_78b3744f2cc34fd3a68040fffc3aebaa/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
576	251	now	https://repackager.wixmp.com	SEASON	6	/video.wixstatic.com/video/d7f9fb_ee5666ffa50544f48fd1456e25669541/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
577	251	now	https://repackager.wixmp.com	SEASON	7	/video.wixstatic.com/video/d7f9fb_46953493363a4232a6f48ee4a4eadf2d/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
578	251	now	https://repackager.wixmp.com	SEASON	8	/video.wixstatic.com/video/d7f9fb_31356432242d49859487174d87766b5e/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
579	252	now	https://repackager.wixmp.com	SEASON	1	/video.wixstatic.com/video/d7f9fb_12a72bbee03a4c24b670a6c98b7495d2/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
580	252	now	https://repackager.wixmp.com	SEASON	2	/video.wixstatic.com/video/d7f9fb_2589b795c207430596d9e25fcc583a24/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
581	252	now	https://repackager.wixmp.com/	SEASON	3	video.wixstatic.com/video/d7f9fb_ea9b1d243b774f7e8bcfea39e0614469/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
582	252	now	https://repackager.wixmp.com/	SEASON	4	video.wixstatic.com/video/d7f9fb_85067a21e21749ffb4523de96cee2b40/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
583	252	now	https://repackager.wixmp.com	SEASON	5	/video.wixstatic.com/video/d7f9fb_137ca9015a6447f2accdc1e0282b23c3/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
584	252	now	https://repackager.wixmp.com	SEASON	6	/video.wixstatic.com/video/d7f9fb_c1c0fbae384c47b9aba98ee929fae928/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
585	252	now	https://repackager.wixmp.com/	SEASON	7	video.wixstatic.com/video/d7f9fb_bf3072bd13344e75bfac3019c8c725a7/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
586	252	now	https://repackager.wixmp.com	SEASON	8	/video.wixstatic.com/video/d7f9fb_5266202471314e94ae4c0ef95f59c919/,240p,/mp4/file.mp4.urlset/manifest.mpd		f	2025-06-28 22:58:06.295
587	186	theg	https://rumble.com/embed/v6sdzof/?vq=	SEASON	17	hd1080p8fEdfR6S12	https://www.mediafire.com/file/ptc5826jlzcezrk/The_Originals_S01e17.mp4/file	t	2025-06-28 22:58:06.295
588	186	theg	https://rumble.com	SEASON	18	/embed/v6se1e1/?vq=hd1080pb5oUZaaK3w	https://www.mediafire.com/file/g1fuqfsj502tpz6/The_Originals_S01e18.mp4/file	t	2025-06-28 22:58:06.295
589	186	theg	https://rumble.com	SEASON	19	/embed/v6se1e9/?vq=hd1080psfEXCsBXzu	https://www.mediafire.com/file/9lbub18q3qckubq/The_Originals_S01e19.mp4/file	t	2025-06-28 22:58:06.295
590	186	theg	https://rumble.com	SEASON	20	/embed/v6se1eb/?vq=hd1080pAvNq420TrM	https://www.mediafire.com/file/o7bvjs3bkjod5ko/The_Originals_S01e20.mp4/file	t	2025-06-28 22:58:06.295
591	186	theg	https://rumble.com	SEASON	21	/embed/v6smpyj/?vq=hd1080pqnmD1NYdJs	https://www.mediafire.com/file/dt1erl0cnlxqnv8/The+Originals+S01e21.mp4/file	t	2025-06-28 22:58:06.295
592	186	theg	https://rumble.com	SEASON	22	/embed/v6smqfl/?vq=hd1080pwxzaw22JYw	https://www.mediafire.com/file/e7d9o7acyg5dw60/The+Originals+S01e22+Finale.mp4/file	t	2025-06-28 22:58:06.295
593	253	theg	https://rumble.com	END	1	/embed/v6shg4h/?vq=hd1080pxhzYlZI4nP	https://www.mediafire.com/file/l5u432lpf4wcl54/Attaque_programm%25C3%25A9e.mp4/file	t	2025-06-28 22:58:06.295
594	254	theg	https://rumble.com	END	1	/embed/v6shi9v/?pub=3vjqu1?vq=hd1080phk3wZipngA	https://www.mediafire.com/file/k3h93i53oqwh6oh/Eye_for_an_Eye_2.mp4/file	t	2025-06-28 22:58:06.295
595	255	theg	https://rumble.com	END	1	/embed/v6shh5j/?vq=hd1080pDxZuNRSXNb	https://www.mediafire.com/file/2azwnrpxr5mtf38/King_Arthur_-_Legend_of_the_Sword.mp4/file	t	2025-06-28 22:58:06.295
596	256	theg	https://rumble.com	END	1	/embed/v6sq01f/?vq=hd1080pVeVfd5zOoR	https://www.mediafire.com/file/ibav5wu61ldysf5/Ghost_Rider.mp4/file	t	2025-06-28 22:58:06.295
599	258	o	https://dhcplay.com/e/	END	1	7l2cj83ispnz	https://www.mediafire.com/file/491fpww33lsw58u/UNHINGED_A.mp4/file	f	2025-06-28 22:58:06.295
600	258	o	https://dhcplay.com/e/	END	2	fci6yzenk8nz	https://www.mediafire.com/file/uu5i6et7axoebe9/UNHINGED_B.mp4/file	f	2025-06-28 22:58:06.295
601	259	theg	https://rumble.com	SEASON	1	/embed/v6spv9b/?vq=hd1080p91KkHLMTPw	https://www.mediafire.com/file/8aftguw41xqq4b8/The_100_S01e01.mp4/file	t	2025-06-28 22:58:06.295
602	259	theg	https://rumble.com	SEASON	2	/embed/v6spvb9/?vq=hd1080poG1aWkinfS	https://www.mediafire.com/file/u2eso7o13t101fo/The_100_S01e02.mp4/file	t	2025-06-28 22:58:06.295
603	259	theg	https://rumble.com	SEASON	3	/embed/v6spvnt/?vq=hd1080pzjlwwFSF4L	https://www.mediafire.com/file/2sm4rm1hlbbosjd/The_100_S01e03.mp4/file	t	2025-06-28 22:58:06.295
604	259	theg	https://rumble.com	SEASON	4	/embed/v6spvwj/?vq=hd1080p0vxLqQNX6d	https://www.mediafire.com/file/8z9xqislznn2jy6/The_100_S01e04.mp4/file	t	2025-06-28 22:58:06.295
605	259	theg	https://rumble.com	SEASON	5	/embed/v6spvz5/?vq=hd1080patU2SyShrq	https://www.mediafire.com/file/h82tvy9uflztdju/The_100_S01e05.mp4/file	t	2025-06-28 22:58:06.295
606	259	theg	https://rumble.com	SEASON	6	/embed/v6spwat/?vq=hd1080pZa3hEkpl6Z	https://www.mediafire.com/file/cfq96eas2x1bpjg/The_100_S01e06.mp4/file	t	2025-06-28 22:58:06.295
607	259	theg	https://rumble.com	SEASON	7	/embed/v6spwt9/?vq=hd1080p5UHNHi2ayG	https://www.mediafire.com/file/3d81op7m3glgfl3/The_100_S01e07.mp4/file	t	2025-06-28 22:58:06.295
608	259	theg	https://rumble.com	SEASON	8	/embed/v6spwoz/?vq=hd1080pkxlOoZypDj	https://www.mediafire.com/file/nki4liqnebysht0/The_100_S01e08.mp4/file	t	2025-06-28 22:58:06.295
609	259	theg	https://rumble.com	SEASON	9	/embed/v6spwwj/?vq=hd1080pudZ3tfo9PR	https://www.mediafire.com/file/va3bq366f7hheux/The_100_S01e09.mp4/file	t	2025-06-28 22:58:06.295
610	259	theg	https://rumble.com	SEASON	10	/embed/v6spwzd/?vq=hd1080pZRcMWan658	https://www.mediafire.com/file/nltxgr0qvpw4j7m/The_100_S01e10.mp4/file	t	2025-06-28 22:58:06.295
611	259	theg	https://rumble.com	SEASON	11	/embed/v6spwyz/?vq=hd1080pKhLPwl39ju	https://www.mediafire.com/file/rkfo6oh9sqzg5kw/The_100_S01e11.mp4/file	t	2025-06-28 22:58:06.295
612	259	theg	https://rumble.com	SEASON	12	/embed/v6spx0j/?vq=hd1080p0qVDOJBe5F	https://www.mediafire.com/file/7m7t1afhou6zg1m/The_100_S01e12.mp4/file	t	2025-06-28 22:58:06.295
613	259	theg	https://rumble.com	SEASON	13	/embed/v6spx0z/?vq=hd1080pSkj4DGmYQO	https://www.mediafire.com/file/1446nepcrhmgocm/The_100_S01e13_Finale.mp4/file	t	2025-06-28 22:58:06.295
614	260	theg	https://anonsharing.com	SEASON	1	/file/8e7e3db139457aad/P%C3%A1lpito_S01e01.mp4		f	2025-06-28 22:58:06.295
615	260	theg	https://anonsharing.com	SEASON	2	/file/8942fea8b8f8da99/P%C3%A1lpito_S01e02.mp4		f	2025-06-28 22:58:06.295
616	260	theg	https://anonsharing.com	SEASON	3	/file/835c1793288167a4/P%C3%A1lpito_S01e03.mp4		f	2025-06-28 22:58:06.295
617	260	theg	https://anonsharing.com	SEASON	4	/file/ae1491f29e949d47/P%C3%A1lpito_S01e04.mp4		f	2025-06-28 22:58:06.295
618	260	theg	https://anonsharing.com	SEASON	5	/file/ab35087794c6499b/P%C3%A1lpito_S01e05.mp4		f	2025-06-28 22:58:06.295
619	260	theg	https://anonsharing.com	SEASON	6	/file/7964be0676f54f69/P%C3%A1lpito_S01e06.mp4		f	2025-06-28 22:58:06.295
620	260	theg	https://anonsharing.com	SEASON	7	/file/f30ae94721b6d60a/P%C3%A1lpito_S01e07.mp4		f	2025-06-28 22:58:06.295
621	260	theg	https://anonsharing.com	SEASON	8	/file/e87eeb36375a452b/P%C3%A1lpito_S01e08.mp4		f	2025-06-28 22:58:06.295
622	260	theg	https://anonsharing.com	SEASON	9	/file/acd5cfdd6b337763/P%C3%A1lpito_S01e09.mp4		f	2025-06-28 22:58:06.295
623	260	theg	https://anonsharing.com	SEASON	10	/file/1b72b8848c6c67bc/P%C3%A1lpito_S01e10.mp4		f	2025-06-28 22:58:06.295
624	260	theg	https://anonsharing.com	SEASON	11	/file/e446e2083a9e2338/P%C3%A1lpito_S01e11.mp4		f	2025-06-28 22:58:06.295
625	260	theg	https://anonsharing.com	SEASON	12	/file/d3f2de5f18dc5bac/P%C3%A1lpito_S01e12.mp4		f	2025-06-28 22:58:06.295
626	260	theg	https://anonsharing.com	SEASON	13	/file/6462f2ebc8e35144/P%C3%A1lpito_S01e13.mp4		f	2025-06-28 22:58:06.295
627	260	theg	https://anonsharing.com	SEASON	14	/file/16b88d329742c1c1/P%C3%A1lpito_S01e14_Finale.mp4		f	2025-06-28 22:58:06.295
447	227	theg	https://anonsharing.com/	SEASON	1	file/0d5e10f8257f9cbf/Triada_S01e01.mp4		f	2025-06-28 22:58:06.295
628	227	theg	https://rumble.com	SEASON	6	/embed/v6se1dr/?vq=hd1080pYFkeAKUZxq	https://www.mediafire.com/file/xop0wkbsdgt70z3/Triada_S01e06.mp4/file	t	2025-06-28 22:58:06.295
629	227	theg	https://rumble.com	SEASON	7	/embed/v6se1dz/?vq=hd1080pXAiLygjb3o	https://www.mediafire.com/file/p9jbzbxh44z5mli/Triada_S01e07.mp4/file	t	2025-06-28 22:58:06.295
630	227	theg	https://rumble.com	SEASON	8	/embed/v6se1dx/?vq=hd1080pmZ6ThUhcUc	https://www.mediafire.com/file/ucsrwo8ba1rq8nn/Triada_S01e08_Finale.mp4/file	t	2025-06-28 22:58:06.295
631	261	theg	https://rumble.com	SEASON	1	/embed/v6srlbn/?vq=hd1080pbHhC0i2pEL	https://www.mediafire.com/file/8bulblvdd9qozv9/The_100_S02e01.mp4/file	t	2025-06-28 22:58:06.295
632	261	theg	https://rumble.com	SEASON	2	/embed/v6srlih/?vq=hd1080pmXKkZKs1NA	https://www.mediafire.com/file/df8hyntdiqji92v/The_100_S02e02.mp4/file	t	2025-06-28 22:58:06.295
633	261	theg	https://rumble.com	SEASON	3	/embed/v6srmcb/?vq=hd1080piMVqga83Rk	https://www.mediafire.com/file/lz8hfzvq9271dx1/The_100_S02e03.mp4/file	t	2025-06-28 22:58:06.295
634	261	theg	https://rumble.com	SEASON	4	/embed/v6srmet/?vq=hd1080p9UbnuyrYYp	https://www.mediafire.com/file/9vupeqyuaza778j/The_100_S02e04.mp4/file	t	2025-06-28 22:58:06.295
635	261	theg	https://rumble.com	SEASON	5	/embed/v6srmtv/?vq=hd1080pmSbdg4euCt	https://www.mediafire.com/file/sxa3g35l5jcb3q5/The_100_S02e05.mp4/file	t	2025-06-28 22:58:06.295
636	261	theg	https://rumble.com	SEASON	6	/embed/v6srmwp/?vq=hd1080pqApu9MK0MV	https://www.mediafire.com/file/pltj4a8wnyqgi4y/The_100_S02e06.mp4/file	t	2025-06-28 22:58:06.295
637	261	theg	https://rumble.com	SEASON	7	/embed/v6sro4h/?vq=hd1080pblPc33V1Wl	https://www.mediafire.com/file/ubk81rfxghy7uo5/The_100_S02e07.mp4/file	t	2025-06-28 22:58:06.295
638	261	theg	https://rumble.com	SEASON	8	/embed/v6stje1/?vq=hd1080pHROxyEZX7U	https://www.mediafire.com/file/5yk5sxm9dkwuli3/The_100_S02e08.mp4/file	t	2025-06-28 22:58:06.295
639	261	theg	https://rumble.com	SEASON	9	/embed/v6srp4h/?vq=hd1080pbpgIAvIOR0	https://www.mediafire.com/file/582hct944qc1mda/The_100_S02e09.mp4/file	t	2025-06-28 22:58:06.295
640	261	theg	https://rumble.com	SEASON	10	/embed/v6srpb3/?vq=hd1080pviIJsZChWI	https://www.mediafire.com/file/wskzrbzrw5veouu/The_100_S02e10.mp4/file	t	2025-06-28 22:58:06.295
641	261	theg	https://rumble.com	SEASON	11	/embed/v6srpd7/?vq=hd1080pKSsnG5ykLN	https://www.mediafire.com/file/m1g1n1gk4ow8f8y/The_100_S02e11.mp4/file	t	2025-06-28 22:58:06.295
642	261	theg	https://rumble.com	SEASON	12	/embed/v6srpeh/?vq=hd1080pc2a48jKVFI	https://www.mediafire.com/file/0s53yj0o9xo0otl/The_100_S02e12.mp4/file	t	2025-06-28 22:58:06.295
643	261	theg	https://rumble.com	SEASON	13	/embed/v6srpxv/?vq=hd1080pEMZQRlEkP0	https://www.mediafire.com/file/d619vy8rxjvuhu0/The_100_S02e13.mp4/file	t	2025-06-28 22:58:06.295
644	261	theg	https://rumble.com	SEASON	14	/embed/v6srpxh/?vq=hd1080pb2A6n9oE0R	https://www.mediafire.com/file/u7336df3dsccjad/The_100_S02e14.mp4/file	t	2025-06-28 22:58:06.295
645	261	theg	https://rumble.com	SEASON	15	/embed/v6srpx3/?vq=hd1080pzD5w6iXq1D	https://www.mediafire.com/file/pms8binq4yk3ncy/The_100_S02e15.mp4/file	t	2025-06-28 22:58:06.295
646	261	theg	https://rumble.com	SEASON	16	/embed/v6srpz5/?vq=hd1080pyWwaBu4RNg	https://www.mediafire.com/file/zwx3o86jpzj7jzd/The_100_S02e16_Finale.mp4/file	t	2025-06-28 22:58:06.295
647	262	theg	https://rumble.com	SEASON	1	/embed/v6svfvb/?vq=hd1080p4hHl06987w	https://www.mediafire.com/file/ynwvbwuj4cpsjqp/Bhimaa_A.mp4/file	t	2025-06-28 22:58:06.295
648	262	theg	https://rumble.com	SEASON	2	/embed/v6svfth/?vq=hd1080pyIpMkG5LDm	https://www.mediafire.com/file/2boqfhpb7y8prap/Bhimaa_B.mp4/file	t	2025-06-28 22:58:06.295
649	263	o	https://rumble.com	END	1	/embed/v6svtib/?vq=hd1080pdClspSLlFI	https://www.mediafire.com/file/yfr1ncrsx9rmg4u/13+SINS.mp4/file	t	2025-06-28 22:58:06.295
650	257	theg	https://rumble.com	END	1	/embed/v6sro2t/?vq=hd1080pHM3FE7NCWw	https://www.mediafire.com/file/533kpsg1l0dysmo/Diablo.mp4/file	t	2025-06-28 22:58:06.295
651	264	o	https://gradehgplus.com/e/	END	1	kwefngrfe7mf	https://www.mediafire.com/file/se528sx9p00lafm/The_Guest_2020.mp4/file	t	2025-06-28 22:58:06.295
403	205	o	https://dhcplay.com/e/	SEASON	1	cbhahbsli63k	https://dhcplay.com/f/cbhahbsli63k_n	f	2025-06-28 22:58:06.295
537	205	now	https://short.icu/	SEASON	25	2Hrm2IsA6		t	2025-06-28 22:58:06.295
664	273	cine	https://rumble.com	END	1	/embed/v6t23p7/?pub=4ky6pk	https://www.mediafire.com/file/iqyynqc6skh8pw3/Duplicity.mp4/file	t	2025-06-28 22:58:06.295
665	274	theg	https://rumble.com	END	1	/embed/v6t3ygd/?vq=hd1080pqYLcO2S092	https://www.mediafire.com/file/irs46jvqm8jtll3/The+Protege.mp4/file	t	2025-06-28 22:58:06.295
654	267	theg	https://rumble.com	END	1	/embed/v6szc5v/?vq=hd1080pn0DtqPZ9nf	https://www.mediafire.com/file/63uk2d7wgkbu7ys/Kesari_2_A.mp4/file	t	2025-06-28 22:58:06.295
655	268	theg	https://rumble.com	END	1	/embed/v6szclp/?vq=hd1080peAMcKm8QAn	https://www.mediafire.com/file/12mrjjdot0gwu9q/Deep_Water.mp4/file	t	2025-06-28 22:58:06.295
653	266	the	https://anonsharing.com	END	1	/file/fd08cb942fb1784d/Kesari_A.mp4		f	2025-06-28 22:58:06.295
656	266	theg	https://anonsharing.com	END	2	/file/67d1af6ff99b796d/Kesari_B.mp4		f	2025-06-28 22:58:06.295
657	267	theg	https://rumble.com	END	2	/embed/v6t06n5/?vq=hd1080pK70qxQinVy	https://www.mediafire.com/file/oh4mnppie0y2ujp/Kesari+2+B.mp4/file	t	2025-06-28 22:58:06.295
658	269	theg	https://rumble.com	END	1	/embed/v6t073l/?vq=hd1080pd8NAuihIdS	https://www.mediafire.com/file/ehy0a8xu52a7ml5/Action+Jackson.mp4/file	t	2025-06-28 22:58:06.295
659	270	theg	https://rumble.com/	END	1	embed/v6t1wmt/?vq=hd1080p3RBmsBxyWb	https://www.mediafire.com/file/wker0qxr53hhgpb/Old_Guard_A.mp4/file	t	2025-06-28 22:58:06.295
660	271	theg	https://rumble.com	END	1	/embed/v6t1y6l/?vq=hd1080pd3al423qAO	https://www.mediafire.com/file/g4jvn6kfq6sdov2/Shadow_Force_A.mp4/file	t	2025-06-28 22:58:06.295
661	271	theg	https://rumble.com	END	2	/embed/v6t1ybv/?vq=hd1080pZGw7f9wDDK	https://www.mediafire.com/file/2xxntfv522fv3w4/Shadow_Force_B.mp4/file	t	2025-06-28 22:58:06.295
662	270	theg	https://ok.ru/	END	2	videoembed/9525536098828?nochat=1&autoplay=1	https://www.mediafire.com/file/57f7jsdw77njomm/AgasobanuyeNow.com+OLD+GUARD+B.mp4/file	t	2025-06-28 22:58:06.295
663	272	theg	https://anonsharing.com	END	1	/file/abe9734cc40502cc/Shadow_Master.mp4		f	2025-06-28 22:58:06.295
669	277	o	https://anonsharing.com/	SEASON	1	file/22899df08bb109ca/Squid_Game_S01e01.mp4	https://www.mediafire.com/file/u0s5je1yxwc8fvl/Squid+Game+E01.mp4/file	f	2025-06-28 22:58:06.295
670	277	theg	https://anonsharing.com	SEASON	2	/file/5ad4797b7e3f356f/Squid_Game_S01e02.mp4		f	2025-06-28 22:58:06.295
671	277	theg	https://anonsharing.com	SEASON	3	/file/4baaf6d750b384e6/Squid_Game_S01e03.mp4		f	2025-06-28 22:58:06.295
672	277	theg	https://anonsharing.com	SEASON	4	/file/447da0a8669cc576/Squid_Game_S01e04.mp4		f	2025-06-28 22:58:06.295
673	277	theg	https://anonsharing.com	SEASON	5	/file/713296ed110e697f/Squid_Game_S01e05_A.mp4		f	2025-06-28 22:58:06.295
674	277	theg	https://anonsharing.com	SEASON	5	/file/c51ef56cc7f4694a/Squid_Game_S01e05_B.mp4		f	2025-06-28 22:58:06.295
675	277	theg	https://anonsharing.com	SEASON	6	/file/08a193b9bb66b385/Squid_Game_S01e06.mp4		f	2025-06-28 22:58:06.295
676	277	theg	https://anonsharing.com	SEASON	7	/file/ab4370dd81d80fbe/Squid_Game_S01e07.mp4		f	2025-06-28 22:58:06.295
677	277	theg	https://anonsharing.com	SEASON	8	/file/c8de73e2ab6df5a5/Squid_Game_S01e08.mp4		f	2025-06-28 22:58:06.295
678	277	theg	https://anonsharing.com	SEASON	9	/file/655d6cd3fe49dc99/Squid_Game_S01e09_Finale.mp4		f	2025-06-28 22:58:06.295
679	278	theg	https://anonsharing.com	SEASON	1	/file/34bfd4ae83c22c0b/Squid_Game_S02e01.mp4		f	2025-06-28 22:58:06.295
680	278	theg	https://anonsharing.com	SEASON	2	/file/c9741b3c507c93a9/Squid_Game_S02e02.mp4		f	2025-06-28 22:58:06.295
681	278	theg	https://anonsharing.com	SEASON	3	/file/9eedef2b7bfb8be2/Squid_Game_S02e03.mp4		f	2025-06-28 22:58:06.295
682	278	theg	https://anonsharing.com	SEASON	4	/file/f194eec22a2e3f6b/Squid_Game_S02e04.mp4		f	2025-06-28 22:58:06.295
683	278	theg	https://anonsharing.com	SEASON	5	/file/580bff687d85e443/Squid_Game_S02e05.mp4		f	2025-06-28 22:58:06.295
684	278	theg	https://anonsharing.com	SEASON	6	/file/2f3c7af7a90f979c/Squid_Game_S02e06.mp4		f	2025-06-28 22:58:06.295
685	278	theg	https://anonsharing.com	SEASON	7	/file/d9a3f8f9b3e3352a/Squid_Game_S02e07_Finale.mp4		f	2025-06-28 22:58:06.295
720	285	theg	https://anonsharing.com	END	1	/file/7ce784c8b1aea5bb/Sonic_the_Hedgehog_3.mp4	https://www.mediafire.com/file/6291z52w97qltvt/Sonic_the_Hedgehog_3.mp4/file	f	2025-06-30 18:57:12.027
721	286	theg	https://anonsharing.com	SEASON	1	/file/29d555107d4638e9/Outer_Banks_S01e01.mp4		f	2025-07-01 21:05:31.493
722	286	theg	https://anonsharing.com	SEASON	2	/file/07aedf1d0f52c19b/Outer_Banks_S01e02.mp4		f	2025-07-01 21:06:05.202
687	279	o	https://rumble.com	SEASON	2	/embed/v6tbs67/?vq=hd1080pcCZfM0P1Xx	https://www.mediafire.com/file/yoe0ujtg7fvc9nr/SQUID+GAME+S03E02.mp4/file	t	2025-06-28 22:58:06.295
688	279	o	https://rumble.com	SEASON	3	/embed/v6t9a5t/?vq=hd1080pxKo6j4FWJg	https://www.mediafire.com/file/m1cuo8jssnba49i/SQUID+GAME+S03E03.mp4/file	t	2025-06-28 22:58:06.295
690	279	now	https://rumble.com	SEASON	4	/embed/v6t9a6t/?vq=hd1080pGFt1C3COdI	https://www.mediafire.com/file/meunwcmyqyarzum/SQUID+GAME+S03E04.mp4/file	t	2025-06-28 22:58:06.295
713	279	o	https://rumble.com	SEASON	5	/embed/v6t9lod/?vq=hd1080p6wTKP32WQA	https://www.mediafire.com/file/ff3fladnq77sfqx/Squid_Game_S03E05.mp4/file	t	2025-06-28 23:03:30.184
714	279	theg	https://rumble.com	SEASON	6	/embed/v6t9p65/?vq=hd1080p90SLqgl47q	https://www.mediafire.com/file/hxznk2kthu1ywbm/Squid+Game+S03e06+Finale.mp4/file	t	2025-06-29 00:52:30.687
715	281	theg	https://anonsharing.com	END	1	/file/54a8bfbc7ee90fe5/Shark_Bait.mp4		f	2025-06-30 17:53:34.738
716	282	theg	https://rumble.com	END	1	/embed/v6t79eb/?vq=hd1080pVaYIPn4TK4	https://www.mediafire.com/file/mauwqlp4h8txx8c/Doctor_Strange_2_A.mp4/file	t	2025-06-30 18:14:54.327
691	280	theg	https://anonsharing.com	SEASON	1	/file/84a805f7d8ed0355/Jumong_S01e01.mp4		f	2025-06-28 22:58:06.295
692	280	theg	https://anonsharing.com	SEASON	2	/file/000c7d69d42d4e4f/Jumong_S01e02.mp4		f	2025-06-28 22:58:06.295
693	280	theg	https://anonsharing.com	SEASON	3	/file/7a095cf6b286408e/Jumong_S01e03.mp4		f	2025-06-28 22:58:06.295
694	280	theg	https://anonsharing.com	SEASON	4	/file/005a0ec44b190710/Jumong_S01e04.mp4		f	2025-06-28 22:58:06.295
695	280	theg	https://anonsharing.com	SEASON	5	/file/5358c7a33ec1715f/Jumong_S01e05.mp4		f	2025-06-28 22:58:06.295
696	280	theg	https://anonsharing.com	SEASON	6	/file/5fc925fd0cc3e648/Jumong_S01e06.mp4		f	2025-06-28 22:58:06.295
697	280	theg	https://anonsharing.com	SEASON	7	/file/7ec41e8caec70113/Jumong_S01e07.mp4		f	2025-06-28 22:58:06.295
698	280	theg	https://anonsharing.com	SEASON	8	/file/12d208dc932ad542/Jumong_S01e08.mp4		f	2025-06-28 22:58:06.295
699	280	theg	https://anonsharing.com	SEASON	9	/file/ec2995ac132f3e72/Jumong_S01e09.mp4		f	2025-06-28 22:58:06.295
700	280	theg	https://anonsharing.com	SEASON	10	/file/7966d6010f781a54/Jumong_S01e10.mp4		f	2025-06-28 22:58:06.295
701	280	theg	https://anonsharing.com	SEASON	11	/file/d5d1d5483912748e/Jumong_S01e11.mp4		f	2025-06-28 22:58:06.295
702	280	theg	https://anonsharing.com	SEASON	12	/file/006c678a8316a152/Jumong_S01e12.mp4		f	2025-06-28 22:58:06.295
703	280	theg	https://anonsharing.com	SEASON	13	/file/e7f12a0c02060b7d/Jumong_S01e13.mp4		f	2025-06-28 22:58:06.295
704	280	theg	https://anonsharing.com	SEASON	14	/file/e835aae7ac5a4a3b/Jumong_S01e14.mp4		f	2025-06-28 22:58:06.295
705	280	theg	https://anonsharing.com	SEASON	15	/file/ade34b4637283fa2/Jumong_S01e15.mp4		f	2025-06-28 22:58:06.295
706	280	theg	https://anonsharing.com	SEASON	16	/file/f1af482948aad586/Jumong_S01e16.mp4		f	2025-06-28 22:58:06.295
707	280	theg	https://anonsharing.com	SEASON	17	/file/0960a1b1b90ef7b6/Jumong_S01e17.mp4		f	2025-06-28 22:58:06.295
708	280	theg	https://anonsharing.com	SEASON	18	/file/cc4278bdb84993db/Jumong_S01e18.mp4		f	2025-06-28 22:58:06.295
709	280	theg	https://anonsharing.com	SEASON	19	/file/12bbc62c47da72f8/Jumong_S01e19.mp4		f	2025-06-28 22:58:06.295
710	280	theg	https://anonsharing.com	SEASON	20	/file/933aebc92fb72bb1/Jumong_S01e20.mp4		f	2025-06-28 22:58:06.295
711	275	o	https://anonsharing.com	END	1	/file/b6e67e1b919fbcdd/Rhade_Shyam.mp4		f	2025-06-28 22:58:06.295
723	286	theg	https://anonsharing.com	SEASON	3	/file/b9406092018c01fc/Outer_Banks_S01e03.mp4		f	2025-07-01 21:06:30.349
724	286	theg	https://anonsharing.com	SEASON	4	/file/f401bd804bb0bc90/Outer_Banks_S01e04.mp4		f	2025-07-01 21:06:56.843
725	286	theg	https://anonsharing.com	SEASON	5	/file/f15a81f9ef3f8186/Outer_Banks_S01e05.mp4		f	2025-07-01 21:07:23.77
726	286	theg	https://anonsharing.com	SEASON	6	/file/aed46f68232bd518/Outer_Banks_S01e06.mp4		f	2025-07-01 21:07:56.986
727	286	theg	https://anonsharing.com	SEASON	7	/file/68a49c0b0681dd96/Outer_Banks_S01e07.mp4		f	2025-07-01 21:08:26.211
717	282	theg	https://rumble.com	END	2	/embed/v6t77z7/?vq=hd1080pcsyZ2F6FHL	https://www.mediafire.com/file/luscjavzm6l7pur/Doctor_Strange_2_B.mp4/file	f	2025-06-30 18:15:47.429
718	283	theg	https://rumble.com	END	1	/embed/v6t5r1x/?vq=hd1080ptNrN8gxWzC	https://www.mediafire.com/file/n9j6o6gzgc8v667/Sonic_the_Hedgehog_1.mp4/file	t	2025-06-30 18:42:36.648
719	284	theg	https://anonsharing.com	END	1	/file/311bf534b622264a/Sonic_the_Hedgehog_2.mp4	https://www.mediafire.com/file/9snxeicx9m48oss/Sonic+the+Hedgehog+2.mp4/file	f	2025-06-30 18:48:50.635
728	286	theg	https://anonsharing.com	SEASON	8	/file/a44028218478338f/Outer_Banks_S01e08.mp4		f	2025-07-01 21:08:53.296
729	286	theg	https://anonsharing.com	SEASON	9	/file/561d2cf2135f0bd4/Outer_Banks_S01e09.mp4		f	2025-07-01 21:09:23.953
730	286	theg	https://anonsharing.com	SEASON	10	/file/5f2383f4858c25ee/Outer_Banks_S01e10_Final.mp4		f	2025-07-01 21:09:57.437
731	287	theg	https://anonsharing.com	SEASON	1	/file/86f664ffe1c1c9c9/Outer_Banks_S02e01.mp4		f	2025-07-01 21:10:39.212
732	287	theg	https://anonsharing.com	SEASON	2	/file/60390da7c9e268cc/Outer_Banks_S02e02.mp4		f	2025-07-01 21:11:05.648
733	287	theg	https://anonsharing.com	SEASON	3	/file/4f66a6bfb4632bfb/Outer_Banks_S02e03.mp4		f	2025-07-01 21:11:38.983
734	287	theg	https://anonsharing.com	SEASON	4	/file/d72e519cab874683/Outer_Banks_S02e04.mp4		f	2025-07-01 21:12:08.547
735	287	theg	https://anonsharing.com	SEASON	5	/file/0428b2d0243f6cdf/Outer_Banks_S02e05.mp4		f	2025-07-01 21:12:37.365
736	287	theg	https://anonsharing.com	SEASON	6	/file/d6b85ff8c5d5d072/Outer_Banks_S02e06.mp4		f	2025-07-01 21:13:22.509
737	287	theg	https://anonsharing.com	SEASON	7	/file/98507b3f0f4bd9a4/Outer_Banks_S02e07.mp4		f	2025-07-01 21:13:56.496
738	287	theg	https://anonsharing.com	SEASON	8	/file/689714dc139172d8/Outer_Banks_S02e08.mp4		f	2025-07-01 21:14:24.937
739	287	theg	https://anonsharing.com	SEASON	9	/file/5a1db8fd13bc98ec/Outer_Banks_S02e09.mp4		f	2025-07-01 21:14:55.306
740	287	theg	https://anonsharing.com	SEASON	10	/file/2bd7c041111a11bd/Outer_Banks_S02e10_Final.mp4		f	2025-07-01 21:15:27.524
741	288	theg	https://anonsharing.com	SEASON	1	/file/53335431e1214166/Outer_Banks_S03e01.mp4		f	2025-07-01 21:16:14.052
742	288	theg	https://anonsharing.com	SEASON	2	/file/2ba9c11ac7b855cf/Outer_Banks_S03e02.mp4		f	2025-07-01 21:16:52.771
743	288	theg	https://anonsharing.com	SEASON	3	/file/1a15cd39219fc2c0/Outer_Banks_S03e03.mp4		f	2025-07-01 21:17:17.578
744	288	theg	https://anonsharing.com	SEASON	4	/file/c354c4567e273d69/Outer_Banks_S03e04.mp4		f	2025-07-01 21:17:46.207
745	288	theg	https://anonsharing.com	SEASON	5	/file/7f5d21aff4db426c/Outer_Banks_S03e05.mp4		f	2025-07-01 21:18:13.578
746	288	theg	https://anonsharing.com	SEASON	6	/file/52123f7e07153c61/Outer_Banks_S03e06.mp4		f	2025-07-01 21:18:41.259
747	288	theg	https://anonsharing.com	SEASON	7	/file/09b7dc966a85620d/Outer_Banks_S03e07.mp4		f	2025-07-01 21:19:11.898
748	288	theg	https://anonsharing.com	SEASON	8	/file/dc46702997d388b6/Outer_Banks_S03e08.mp4		f	2025-07-01 21:19:57.11
749	288	theg	https://anonsharing.com	SEASON	9	/file/55d2c21332f07603/Outer_Banks_S03e09.mp4		f	2025-07-01 21:20:34.414
750	288	theg	https://anonsharing.com	SEASON	10	/file/253802cc92370699/Outer_Banks_S03e10_Final.mp4		f	2025-07-01 21:21:01.347
751	289	theg	https://anonsharing.com	SEASON	1	/file/922dd14c1d0d8b45/Outer_Bank_S04e01.mp4		f	2025-07-01 21:21:43.008
752	289	theg	https://anonsharing.com	SEASON	2	/file/494aad8e001fb8fd/Outer_Bank_S04e02.mp4		f	2025-07-01 21:22:13.703
753	289	theg	https://anonsharing.com	SEASON	3	/file/c08035c2971d0944/Outer_Bank_S04e03.mp4		f	2025-07-01 21:22:45.413
754	289	theg	https://anonsharing.com	SEASON	4	/file/a0209d3959394cdf/Outer_Bank_S04e04.mp4		f	2025-07-01 21:23:14.328
755	289	theg	https://anonsharing.com	SEASON	5	/file/e4a361a5c1b82f7f/Outer_Bank_S04e05.mp4		f	2025-07-01 21:23:43.326
756	289	theg	https://anonsharing.com	SEASON	6	/file/cb3f2064a8de1ab9/Outer_Banks_S04e06.mp4		f	2025-07-01 21:24:11.741
757	289	theg	https://anonsharing.com	SEASON	7	/file/7c9f25182568a1d0/Outer_Banks_S04e07.mp4		f	2025-07-01 21:24:35.285
758	289	theg	https://anonsharing.com	SEASON	8	/file/9abf375f22614ceb/Outer_Banks_S04e08.mp4		f	2025-07-01 21:25:06.151
759	289	theg	https://anonsharing.com	SEASON	9	/file/e2c21bcc046fce84/Outer_Banks_S04e09.mp4		f	2025-07-01 21:25:36.843
760	289	theg	https://anonsharing.com	SEASON	10	/file/5e15e70257e19307/Outer_Banks_S04e10_Finale.mp4		f	2025-07-01 21:26:02.606
761	290	theg	https://rumble.com	END	1	/embed/v6tc2v9/?vq=hd1080pl9TfzOWsVk	https://www.mediafire.com/file/nxrx8bqs24mr1mf/Heropanti_2.mp4/file	t	2025-07-01 21:31:41.881
762	291	theg	https://anonsharing.com	SEASON	1	/file/95e8a0cebfe90ed6/Night_Agent_S01e01.mp4		f	2025-07-02 15:14:19.774
763	291	theg	https://anonsharing.com	SEASON	2	/file/4a1b3fbce529449e/Night_Agent_S01e02.mp4		f	2025-07-02 15:14:40.924
764	291	theg	https://anonsharing.com	SEASON	3	/file/1de884fbf68135d8/Night_Agent_S01e03.mp4		f	2025-07-02 15:15:03.547
765	291	theg	https://anonsharing.com	SEASON	4	/file/b17e46ca0a9b2be1/Night_Agent_S01e04.mp4		f	2025-07-02 15:15:37.309
766	291	theg	https://anonsharing.comp4	SEASON	5	/file/4f2afe50b1d47913/Night_Agent_S01e05.m		f	2025-07-02 15:16:02.674
767	291	theg	https://anonsharing.com	SEASON	6	/file/7c544e8977380433/Night_Agent_S01e06.mp4		f	2025-07-02 15:16:27.94
768	291	theg	https://anonsharing.com	SEASON	7	/file/9cf1db1b65eb9e5b/Night_Agent_S01e07.mp4		f	2025-07-02 15:16:58.39
769	291	theg	https://anonsharing.com	SEASON	8	/file/b02a528322dc65e5/Night_Agent_S01e08.mp4		f	2025-07-02 15:17:28.001
770	291	theg	https://anonsharing.com	SEASON	9	/file/8b458af889a81765/Night_Agent_S01e09.mp4		f	2025-07-02 15:17:56.264
771	291	theg	https://anonsharing.com	SEASON	10	/file/8556eeb4a448a866/Night_Agent_S01e10_Final.mp4		f	2025-07-02 15:18:29.171
772	292	theg	https://anonsharing.com	SEASON	1	/file/f86efdb4bfd0e5e4/The_Night_Agent_S02e01.mp4		f	2025-07-02 15:22:36.66
773	292	theg	https://anonsharing.com	SEASON	2	/file/2f13c3b019e69c03/The_Night_Agent_S02e02.mp4		f	2025-07-02 15:23:18.216
774	292	theg	https://anonsharing.com	SEASON	3	/file/bb139d500e5f1726/The_Night_Agent_S02e03.mp4		f	2025-07-02 15:23:45.531
775	292	theg	https://anonsharing.com	SEASON	4	/file/39e8db94a7ba2f3c/The_Night_Agent_S02e04.mp4		f	2025-07-02 15:25:39.714
776	292	now	https://rumble.com	SEASON	5	/embed/v6tbrf9/?vq=hd1080p0RmQpEhF2K	https://www.mediafire.com/file/eyepep3ksh1te8z/The+Night+Agent+S02e05.mp4/file	t	2025-07-02 15:27:00.748
777	295	theg	https://anonsharing.com	END	1	/file/23aa704f43ebd773/John_Wick_1.mp4		f	2025-07-04 09:22:22.229
778	296	theg	https://anonsharing.com	END	2	/file/71e9099b503cb23d/John_Wick_2.mp4		f	2025-07-04 09:24:50.299
779	297	theg	https://anonsharing.com	END	3	/file/bcdad4f8de101d59/John_Wick_3.mp4		f	2025-07-04 09:26:52.282
780	298	theg	https://anonsharing.com	END	4	/file/1951632b965fdf7e/John_Wick_4.mp4		f	2025-07-04 09:29:57.427
781	299	now	https://ok.ru/	END	1	videoembed/9550362184204?nochat=1&autoplay=1	https://www.mediafire.com/file/61m0cj0yz0x5h07/www.agasobanuyenow.com_-_BALLERINA.mp4/file	t	2025-07-04 09:35:02.241
782	280	theg	https://anonsharing.com	SEASON	21	/file/c78dbba25e1ed81b/Jumong_S01e21.mp4		f	2025-07-04 20:26:30.687
783	280	theg	https://anonsharing.com	SEASON	22	/file/30d0b19ecd70d0ab/Jumong_S01e22.mp4		f	2025-07-04 20:27:00.495
784	280	theg	https://anonsharing.com	SEASON	23	/file/1edb6919c74dfa3f/Jumong_S01e23.mp4		f	2025-07-04 20:27:33.148
785	280	theg	https://anonsharing.com	SEASON	24	/file/5b8e1d9bc91f7d1d/Jumong_S01e24.mp4		f	2025-07-04 20:28:03.996
786	280	theg	https://anonsharing.com	SEASON	25	/file/76be34f268b22ca4/Jumong_S01e25.mp4		f	2025-07-04 20:28:34.814
788	280	theg	https://anonsharing.com	SEASON	26	/file/056a409fbccbffde/Jumong_S01e26.mp4		f	2025-07-04 20:29:43.267
789	280	theg	https://anonsharing.com	SEASON	27	/file/a1d40245201e95b4/Jumong_S01e27.mp4		f	2025-07-04 20:30:07.267
790	280	theg	https://anonsharing.com	SEASON	28	/file/ad78a826e892aeba/Jumong_S01e28.mp4		f	2025-07-04 20:30:36.832
791	280	theg	https://anonsharing.com	SEASON	29	/file/9d42355147392f63/Jumong_S01e29.mp4		f	2025-07-04 20:31:05.223
792	280	theg	https://anonsharing.com	SEASON	30	/file/12fa26fba768b107/Jumong_S01e30.mp4		f	2025-07-04 20:31:38.851
793	280	theg	https://anonsharing.com	SEASON	31	/file/d2c9adb28d773498/Jumong_S01e31.mp4		f	2025-07-04 20:32:46.948
794	280	theg	https://anonsharing.com	SEASON	32	/file/db51081b23219f96/Jumong_S01e32.mp4		f	2025-07-04 20:33:15.478
795	280	theg	https://anonsharing.com	SEASON	33	/file/e96f2ab2f67c341e/Jumong_S01e33.mp4		f	2025-07-04 20:33:53.354
796	280	theg	https://anonsharing.com	SEASON	34	/file/9b922455e11c3d97/Jumong_S01e34.mp4		f	2025-07-04 20:34:19.091
797	280	theg	https://anonsharing.com	SEASON	35	/file/dcdf44b2ad3999d7/Jumong_S01e35.mp4		f	2025-07-04 20:34:52.105
798	280	theg	https://anonsharing.com	SEASON	36	/file/d1220f15ceaa43db/Jumong_S01e36.mp4		f	2025-07-04 20:35:18.99
799	280	theg	https://anonsharing.com	SEASON	37	/file/6031c4c6b348e422/Jumong_S01e37.mp4		f	2025-07-04 20:35:47.616
800	280	theg	https://anonsharing.com	SEASON	38	/file/e2e0255c46708667/Jumong_S01e38.mp4		f	2025-07-04 20:36:59.441
801	280	theg	https://anonsharing.com	SEASON	39	/file/136644d4f1955357/Jumong_S01e39.mp4		f	2025-07-04 20:37:25.372
802	280	theg	https://anonsharing.com	SEASON	40	/file/fce05abe574c09af/Jumong_S01e40.mp4		f	2025-07-04 20:38:02.508
803	300	theg	https://anonsharing.com	END	1	/file/e980f192d5dad249/To_Live_Through_Death.mp4		f	2025-07-06 08:59:19.976
804	301	theg	https://anonsharing.com	END	1	/file/55695192499c0461/Twilight_of_the_Warriors_-_Walled_In.mp4		f	2025-07-06 09:02:13.388
805	302	theg	https://rumble.com	END	1	/embed/v6t5qzb/?vq=hd1080pjgFu3Uqwrv	https://www.mediafire.com/file/sc9s2ndh1grytdu/The_Maze_Runner_1.mp4/file	t	2025-07-06 09:06:05.115
806	303	theg	https://rumble.com	END	1	/embed/v6te97t/?vq=hd1080plK9mNNHWb1		t	2025-07-06 09:26:04.288
807	304	theg	https://anonsharing.com	END	1	/file/92adea2852422c07/Pirates_of_the_Caribbean_-_The_Curse_of_the_Black_Pearl.mp4		f	2025-07-06 09:28:44.207
808	305	theg	https://anonsharing.com	END	1	/file/1e031f1c3503687b/Pirates_Of_The_Caribbean-_Dead_Mans_Chest.mp4		f	2025-07-06 09:31:53.086
809	306	theg	https://anonsharing.com	END	1	/file/b43e8baecbe45a3a/Pirates_of_the_Caribbean_-_At_Worlds_End.mp4		f	2025-07-06 09:34:29.599
810	307	theg	https://anonsharing.com	END	1	/file/1bf83f6fc94af5d5/Pirates_of_the_Caribbean_-_On_Stranger_Tides.mp4		f	2025-07-06 09:39:07.359
811	308	theg	https://anonsharing.com	END	1	/file/ed37708302ddd78f/Pirates_of_the_Caribbean_-_Dead_Men_Tell_No_Tales.mp4		f	2025-07-06 09:41:30.373
812	309	theg	https://rumble.com	END	1	/embed/v6th341/?vq=hd1080pxMpyDuyjl6	https://www.mediafire.com/file/fjqzcnhpp5fj24s/The+Maze+Runner+3.mp4/file	t	2025-07-06 16:15:18.584
814	312	0	https://gradehgplus.com/e/	END	1	4kruxewesmy6	https://www.mediafire.com/file/y0fjebnqxhgalsk/LAND_OF_BAD_A.mp4/file	t	2025-07-06 16:21:38.33
813	311	o	https://gradehgplus.com/e/	END	1	mz6cw6zjnbu4	https://www.mediafire.com/file/ou55kiuvntiim7x/THE+OLD+GUARD+2.mp4/file	t	2025-07-06 16:18:17.454
815	312	o	https://gradehgplus.com/e/	END	2	cwuc9lxbpqnc	https://www.mediafire.com/file/cvtkortw1d0v3y5/LAND_OF_BAD_B.mp4/file	t	2025-07-06 16:23:53.434
816	313	o	https://drive.google.com	END	1	/file/d/1UwfeAiHnzUwuMP73ZUqlf1ZJEm0FrzGl/preview		f	2025-07-06 16:29:46.84
817	313	o	https://drive.google.com	END	2	/file/d/1OmUDsQWN39d8aEpjf4b_BrTiADxAaeRR/preview		f	2025-07-06 16:33:26.776
126	58	o	https://dhcplay.com/e/	END	1	xv0nxtqrnc40	https://www.mediafire.com/file/4osorn7oepb16sy/Sick.mp4/file	f	2025-06-28 22:58:06.295
820	315	theg	https://rumble.com	END	1	/embed/v6tqs44/?vq=hd1080pd5hb8T3aMr	https://www.mediafire.com/file/gwi81epu5waciql/Karate_Kid_Legends.mp4/file	t	2025-07-09 14:20:56.97
821	314	theg	https://rumble.com	END	1	/embed/v6tqlmg/?vq=hd1080po5wLjqf7NP	https://www.mediafire.com/file/fyh6g7i17qcfzg9/Heads+Of+State.mp4/file	t	2025-07-09 17:53:40.099
822	280	theg	https://anonsharing.com	SEASON	41	/file/64dffcb2dca745e3/Jumong_S01e41.mp4		f	2025-07-10 10:51:22.752
823	280	theg	https://anonsharing.com	SEASON	42	/file/99c3638288ee16dc/Jumong_S01e42.mp4		f	2025-07-10 10:52:17.02
824	280	theg	https://anonsharing.commp4	SEASON	43	/file/c06b1ffccba4f0ca/Jumong_S01e43.		f	2025-07-10 10:53:31.791
825	280	theg	https://anonsharing.com	SEASON	44	/file/e25190d2607d0eec/Jumong_S01e44.mp4		f	2025-07-10 10:54:02.016
826	280	theg	https://anonsharing.com	SEASON	45	/file/152df0dfce3aacc4/Jumong_S01e45.mp4		f	2025-07-10 10:54:33.131
827	280	theg	https://anonsharing.com	SEASON	46	/file/1ddd5f03297e7698/Jumong_S01e46.mp4		f	2025-07-10 10:54:59.329
828	280	theg	https://anonsharing.com	SEASON	47	/file/8b43f9ac1d9fff0e/Jumong_S01e47.mp4		f	2025-07-10 10:55:26.606
829	280	theg	https://anonsharing.com	SEASON	48	/file/1487d8be88d61964/Jumong_S01e48.mp4		f	2025-07-10 10:55:52.616
830	280	theg	https://anonsharing.com	SEASON	49	/file/0090c8800807f09d/Jumong_S01e49.mp4		f	2025-07-10 10:56:33.515
831	280	theg	https://anonsharing.com	SEASON	50	/file/a8cc7a9701c82e67/Jumong_S01e50.mp4		f	2025-07-10 10:57:09.221
832	280	theg	https://anonsharing.com	SEASON	51	/file/1a374d27612d4175/Jumong_S01e51.mp4		f	2025-07-10 10:57:47.099
833	280	theg	https://anonsharing.com	SEASON	52	/file/60c47c2f3aaa7802/Jumong_S01e52.mp4		f	2025-07-10 10:58:40.98
834	280	theg	https://anonsharing.com	SEASON	53	/file/c49f064dbfb7e2fd/Jumong_S01e53.mp4		f	2025-07-10 10:59:09.986
835	280	theg	https://anonsharing.com	SEASON	54	/file/f798317b6009dee5/Jumong_S01e54.mp4		f	2025-07-10 10:59:36.062
836	280	theg	https://anonsharing.com	SEASON	55	/file/ad486d5fc6e7ed5f/Jumong_S01e55.mp4		f	2025-07-10 10:59:55.095
837	280	theg	https://anonsharing.com	SEASON	56	/file/b1a6af5f199a00f3/Jumong_S01e56.mp4		f	2025-07-10 11:00:24.002
841	280	theg	https://anonsharing.com	SEASON	57	/file/db0c3977304cfd4d/Jumong_S01e57.mp4		f	2025-07-10 11:04:00.319
840	280	theg	https://anonsharing.com	SEASON	58	/file/5dec3ed78f7e2b78/Jumong_S01e58.mp4		f	2025-07-10 11:02:09.148
843	280	theg	https://anonsharing.com/	SEASON	59	file/5ea6cb27cc30e8c8/Jumong_S01e59.mp4		f	2025-07-10 11:07:11.85
844	280	theg	https://anonsharing.com	SEASON	60	/file/95d41bfd692f8a6d/Jumong_S01e60.mp4		f	2025-07-10 11:07:46.436
845	280	theg	https://anonsharing.com	SEASON	61	/file/4fdab1e822efa734/Jumong_s01e61.mp4		f	2025-07-10 11:37:19.239
846	280	theg	https://anonsharing.com	SEASON	62	/file/33667d007886615e/Jumong_s01e62.mp4		f	2025-07-10 11:37:50.471
847	280	theg	https://anonsharing.com	SEASON	63	/file/29374447d817c39f/Jumong_S01e63.mp4		f	2025-07-10 11:38:13.877
849	280	theg	https://anonsharing.com	SEASON	64	/file/a73708f1edb5516b/Jumong_S01e64.mp4		f	2025-07-10 11:39:33.751
850	280	theg	https://anonsharing.com	SEASON	65	/file/3e0b8b9b6bfaba6d/Jumong_S01e65.mp4		f	2025-07-10 11:40:00.942
851	280	theg	https://anonsharing.com	SEASON	66	/file/382ddf2fe8510050/Jumong_S01e66.mp4		f	2025-07-10 11:40:23.834
852	280	theg	https://anonsharing.com	SEASON	67	/file/7d4c24336fbec1d4/Jumong_S01e67.mp4		f	2025-07-10 11:40:46.987
853	280	theg	https://anonsharing.com	SEASON	68	/file/da2b19b7603ce660/Jumong_S01e68.mp4		f	2025-07-10 11:41:27.28
854	280	theg	https://anonsharing.com	SEASON	69	/file/dff7a96a0095094c/Jumong_S01e69.mp4		f	2025-07-10 11:42:04.075
855	280	theg	https://anonsharing.com	SEASON	70	/file/c1bcd9fdb16090e0/Jumong_s01e70.mp4		f	2025-07-10 11:42:27.776
856	280	theg	https://anonsharing.com	SEASON	71	/file/b0262b67bef5f9f6/Jumong_s01e71.mp4		f	2025-07-10 11:42:59.68
857	280	theg	https://anonsharing.com	SEASON	72	/file/35995384176301e4/Jumong_s01e72.mp4		f	2025-07-10 11:43:25.71
858	280	theg	https://anonsharing.com	SEASON	73	/file/cbc901a4695a5133/Jumong_s01e73.mp4		f	2025-07-10 11:44:21.058
859	280	theg	https://anonsharing.com	SEASON	74	/file/c849e0ada1b8732e/Jumong_s01e74.mp4		f	2025-07-10 11:44:47.949
860	280	theg	https://anonsharing.com	SEASON	75	/file/19a389f655dfe712/Jumong_s01e75.mp4		f	2025-07-10 11:45:22.211
861	280	theg	https://anonsharing.com	SEASON	76	/file/ad3ea01bb58c1ea6/Jumong_s01e76.mp4		f	2025-07-10 11:45:46.402
862	280	theg	https://anonsharing.com	SEASON	77	/file/947e34a5201f3eb1/Jumong_s01e77.mp4		f	2025-07-10 11:46:18.139
863	280	theg	https://anonsharing.com	SEASON	78	/file/aa3c48bada110465/Jumong_s01e78.mp4		f	2025-07-10 11:46:42.305
864	280	theg	https://anonsharing.com	SEASON	79	/file/b4475d712e407300/Jumong_s01e79.mp4		f	2025-07-10 11:47:14.843
865	280	theg	https://anonsharing.com	SEASON	80	/file/4f67bd24dd284ebb/Jumong_s01e80.mp4		f	2025-07-10 11:47:37.038
866	280	theg	https://anonsharing.com	SEASON	81	/file/cdc75ca2152bcb71/Jumong_s01e81_Finale.mp4		f	2025-07-10 11:48:19.768
867	316	theg	https://anonsharing.com	SEASON	1	/file/1c81036e48feb180/Cinderella_Game_S01e01.mp4		f	2025-07-10 16:32:34.84
868	316	theg	https://anonsharing.com	SEASON	2	/file/b7e725412db77dd7/Cinderella_Game_S01e02.mp4		f	2025-07-10 16:33:11.052
869	316	theg	https://anonsharing.com	SEASON	3	/file/5c051bb937bd2d37/Cinderella_Game_S01e03.mp4		f	2025-07-10 16:33:29.586
870	316	theg	https://anonsharing.com	SEASON	4	/file/7d6a1fd46f70782a/Cinderella_Game_S01e04.mp4		f	2025-07-10 16:33:48.108
871	316	theg	https://anonsharing.com	SEASON	5	/file/de96e4cc0c428d60/Cinderella_Game_S01e05.mp4		f	2025-07-10 16:34:07.915
872	316	theg	https://anonsharing.com	SEASON	6	/file/e5d4c7d90cab88ca/Cinderella_Game_S01e06.mp4		f	2025-07-10 16:34:30.38
873	316	theg	https://anonsharing.com	SEASON	7	/file/262881f4e64b2211/Cinderella_Game_S01e07.mp4		f	2025-07-10 16:34:56.218
874	316	theg	https://anonsharing.com	SEASON	8	/file/1ede2b47aa812737/Cinderella_Game_S01e08.mp4		f	2025-07-10 16:35:16.173
875	316	theg	https://anonsharing.com	SEASON	9	/file/29e689c606aac9ef/Cinderella_Game_S01e09.mp4		f	2025-07-10 16:35:45.032
876	316	theg	https://anonsharing.com	SEASON	10	/file/60a83cdaea7046f2/Cinderella_Game_S01e10.mp4		f	2025-07-10 16:36:20.684
877	316	theg	https://anonsharing.com	SEASON	11	/file/aafc4cee39153149/Cinderella_Game_S01e11.mp4		f	2025-07-10 16:36:41.369
878	316	theg	https://anonsharing.com	SEASON	12	/file/75e830065e5b0da7/Cinderella_Game_S01e12.mp4		f	2025-07-10 16:37:45.422
879	316	theg	https://anonsharing.com	SEASON	13	/file/9ed46d5b0f48e2a1/Cinderella_Game_S01e13.mp4		f	2025-07-10 16:38:08.63
880	316	theg	https://anonsharing.com	SEASON	14	/file/fd12a3fcccb89924/Cinderella_Game_S01e14.mp4		f	2025-07-10 16:38:29.457
881	316	theg	https://anonsharing.com	SEASON	15	/file/41a984bc2042d80f/Cinderella_Game_S01e15.mp4		f	2025-07-10 16:38:50.981
882	316	theg	https://anonsharing.com	SEASON	16	/file/146ae1f92bed9dc8/Cinderella_Game_S01e16.mp4		f	2025-07-10 16:39:18.773
883	316	theg	https://anonsharing.com	SEASON	17	/file/a49cf601f4e0783c/Cinderella_Game_S01e17.mp4		f	2025-07-10 16:39:51.478
884	316	theg	https://anonsharing.com	SEASON	18	/file/ad44c5e9d8f58c7f/Cinderella_Game_S01e18.mp4		f	2025-07-10 16:40:11.747
885	316	theg	https://anonsharing.com	SEASON	19	/file/c3b5e6252b682eee/Cinderella_Game_S01e19.mp4		f	2025-07-10 16:40:37.717
886	316	theg	https://anonsharing.com	SEASON	20	/file/f57077ee36c338e8/Cinderella_Game_S01e20.mp4		f	2025-07-10 16:41:10.699
887	317	theg	https://rumble.com	END	1	/embed/v6tsa7k/?vq=hd1080pW3z3i4tdzy	https://www.mediafire.com/file/k6f1f80dlmz0mpy/The_Old_Guard_2.mp4/file	t	2025-07-11 15:34:12.844
888	318	theg	https://rumble.com	END	1	/embed/v6tniy7/?vq=hd1080p6jnuKUlK4F	https://www.mediafire.com/file/v54jtm3fs302an5/Work_It.mp4/file	t	2025-07-11 15:37:18.029
889	319	theg	https://rumble.com	END	1	/embed/v6ttz7u/?vq=hd1080pdu7Q9YUnsJ	https://www.mediafire.com/file/dxk96gzmh5fjv9a/Buried+In+Barstow.mp4/file	t	2025-07-11 15:39:59.491
11	6	o	https://hailindihg.com/e/	END	1	q7pgs2wut0kf	https://www.mediafire.com/file/zuvpouywsm7o8v8/Three+Stooges.mp4/file	t	2025-06-28 22:58:06.295
12	6	o	https://hailindihg.com/e/	END	2	bsamk02iolav	https://www.mediafire.com/file/jk8v6ywbrf6ydbb/KARATE+KID+LEGENDS+B.mp4/file	t	2025-06-28 22:58:06.295
890	320	theg	https://rumble.com	END	1	/embed/v6tvr6u/?vq=hd1080paGUs1A4eUm	https://www.mediafire.com/file/tdvdmzcha6jslgn/Chhaava+A.mp4/file	t	2025-07-14 21:24:38.94
891	320	theg	https://rumble.com	END	2	/embed/v6tvr8i/?vq=hd1080pS2qafQK76Q	https://www.mediafire.com/file/h333hcz2rklada5/Chhaava+B.mp4/file	t	2025-07-14 21:25:40.531
892	321	theg	http://anonsharing.com	SEASON	1	/file/720759ab0f03c674/Red_Shoes_S01e1.mp4		f	2025-07-14 21:32:55.399
893	321	theg	https://anonsharing.com	SEASON	2	/file/0dfa7b92e2d5fb96/Red_Shoes_S01e02.mp4		f	2025-07-14 21:33:29.933
894	321	theg	https://anonsharing.com	SEASON	3	/file/53142444cd18d963/Red_Shoes_S01e03.mp4		f	2025-07-14 21:33:52.857
895	321	theg	https://anonsharing.com	SEASON	4	/file/b312ae058515ff32/Red_Shoes_S01e04.mp4		f	2025-07-14 21:34:18.214
896	321	theg	https://anonsharing.com	SEASON	5	/file/a38149806828111b/Red_Shoes_S01e05.mp4		f	2025-07-14 21:34:48.452
897	321	theg	https://anonsharing.com	SEASON	6	/file/dd6ff8206784efff/Red_Shoes_S01e06.mp4		f	2025-07-14 21:35:14.317
898	321	theg	https://anonsharing.com	END	7	/file/6645283a59432eec/Red_Shoes_S01e07.mp4		f	2025-07-14 21:35:45.315
899	321	theg	https://anonsharing.com	SEASON	8	/file/1e59ed05fcce04af/Red_Shoes_S01e08.mp4		f	2025-07-14 21:36:12.163
900	321	theg	https://anonsharing.com	SEASON	9	/file/5cc1b0b2529c7bfb/Red_Shoes_S01e09.mp4		f	2025-07-14 21:36:51.782
901	321	theg	https://anonsharing.com	SEASON	10	/file/720759ab0f03c674/Red_Shoes_S01e10.mp4		f	2025-07-14 21:37:39.583
902	321	theg	https://anonsharing.com	SEASON	11	/file/959e0cbadeed6ceb/Red_Shoes_S01e11.mp4		f	2025-07-14 21:38:13.844
903	321	theg	https://anonsharing.com	SEASON	12	/file/32313a29c333468b/Red_Shoes_S01e12.mp4		f	2025-07-14 21:38:39.024
904	321	theg	https://anonsharing.com	SEASON	13	/file/c629c679ad01c9db/Red_Shoes_S01e13.mp4		f	2025-07-14 21:39:10.513
905	321	theg	https://anonsharing.com	SEASON	14	/file/faf4104d807ff20d/Red_Shoes_S01e14.mp4		f	2025-07-14 21:39:45.062
906	321	theg	https://anonsharing.com	SEASON	15	/file/b14ceb9c1a575fcf/Red_Shoes_S01e15.mp4		f	2025-07-14 21:40:18.229
907	321	theg	https://anonsharing.com	SEASON	16	/file/39a349f145308e81/Red_Shoes_S01e16.mp4		f	2025-07-14 21:43:55.771
908	321	theg	https://anonsharing.com	SEASON	18	/file/770c9b6bdaea58a8/Red_Shoes_S01e17.mp4		f	2025-07-14 21:44:18.719
909	321	theg	https://anonsharing.com	SEASON	19	/file/357359a89d5340c7/Red_Shoes_S01e19.mp4		f	2025-07-14 21:44:44.77
910	321	theg	https://anonsharing.com	SEASON	20	/file/f66fa151bae0fd99/Red_Shoes_S01e20.mp4		f	2025-07-14 21:45:18
911	322	theg	https://rumble.com	END	1	/embed/v6tylfa/?vq=hd1080p9IeHct9dBH	https://www.mediafire.com/file/n3vwwn9i6h310ij/Lucy.mp4/file	t	2025-07-14 21:52:12.619
913	324	theg	https://anonsharing.com	END	1	/file/2be22786551a6f5c/Chinese_Zodiac.mp4		f	2025-07-16 14:47:18.923
914	325	theg	https://rumble.com	END	1	/embed/v6u1zei/?vq=hd1080pHJqUmSbJH3	https://www.mediafire.com/file/ar1oj0x0njxz8zt/Most+Dangerous+Game+A.mp4/file	t	2025-07-16 14:50:14.967
912	323	theg	https://rumble.com	END	1	/embed/v6u0vgq/?vq=hd1080p4slKl6ppbH	https://www.mediafire.com/file/c9nbhoivmbygo8o/Snowhite.mp4/file	t	2025-07-16 14:44:22.257
915	326	theg	https://rumble.com	SEASON	1	/embed/v6u43yo/?vq=hd1080pZy2zDuVgZS	https://www.mediafire.com/file/za60ek0auzpgyyd/V+Wars+S01e01.mp4/file	t	2025-07-19 09:02:02.324
916	326	theg	https://rumble.com	SEASON	2	/embed/v6u41su/?vq=hd1080p2Q4ZYuT4kl	https://www.mediafire.com/file/0x558qaotfldy0v/V+Wars+S01e02.mp4/file	t	2025-07-19 09:03:01.392
917	326	theg	https://rumble.com	SEASON	3	/embed/v6u41y8/?vq=hd1080pYv8dcVo3AQ	https://www.mediafire.com/file/tofvj6033q2m946/V+Wars+S01e03.mp4/file	t	2025-07-19 09:03:48.227
918	326	theg	https://rumble.com	SEASON	4	/embed/v6u4346/?vq=hd1080p4YUtAM2hcJ	https://www.mediafire.com/file/pom8b1h06xe1r8h/V+Wars+S01e04.mp4/file	t	2025-07-19 09:04:30.351
919	326	theg	https://rumble.com	SEASON	5	/embed/v6u43re/?vq=hd1080pyWFI2haxuw	https://www.mediafire.com/file/9a2jxdqwkplriht/V+Wars+S01e05.mp4/file	t	2025-07-19 09:05:18.398
920	326	theg	https://rumble.com	SEASON	6	/embed/v6u5fso/?vq=hd1080pNDyj4G7RDn	https://www.mediafire.com/file/ft0msc9b4nnssps/V+Wars+S01e06.mp4/file	t	2025-07-19 09:06:30.869
921	326	theg	https://rumble.com	SEASON	7	/embed/v6u5des/?vq=hd1080pHm7O67bhgh	https://www.mediafire.com/file/end9jbn0jv6wqox/V+Wars+S01e07.mp4/file	t	2025-07-19 09:07:39.184
922	326	theg	https://rumble.com	SEASON	8	/embed/v6u5dem/?vq=hd1080pfs4qMxcGBJ	https://www.mediafire.com/file/4kib6abmwusl982/V+Wars+S01e08.mp4/file	t	2025-07-19 09:11:06.602
923	326	theg	https://rumble.com	SEASON	9	/embed/v6u5jd2/?vq=hd1080pR4EtPfkKBX	https://www.mediafire.com/file/zmpnbo9hma8r8pb/V+Wars+S01e09.mp4/file	t	2025-07-19 09:11:59.123
924	326	theg	https://rumble.com	SEASON	10	/embed/v6u5ffw/?vq=hd1080pnPe5ke558u	https://www.mediafire.com/file/zmshelma9rbpwt8/V+Wars+S01e10+Finale.mp4/file	t	2025-07-19 09:13:02.568
925	327	theg	https://rumble.com	SEASON	1	/embed/v6u60m8/?vq=hd1080pyQnHAia2N1	https://www.mediafire.com/file/v9mw0fnrelcf5dq/The_Infallibles.mp4/file	t	2025-07-19 09:16:54.254
926	328	theg	https://anonsharing.com	END	1	/file/51366a60f58923b5/In_the_Lost_Lands.mp4		f	2025-07-19 09:33:16.362
686	279	o	https://rumble.com	SEASON	1	/embed/v6tbs5p/?vq=hd1080pdniPKz3Khv	https://www.mediafire.com/file/518r6mf9vfr82r6/SQUID+GAME+S03E01.mp4/file	t	2025-06-28 22:58:06.295
927	329	theg	https://rumble.com	END	1	/embed/v6u7u24/?vq=hd1080p8dVEFRPP0E	https://www.mediafire.com/file/6t9f1nhwvckytn7/Max_Payne.mp4/file	t	2025-07-20 18:13:20.499
928	330	theg	https://rumble.com	END	1	/embed/v6u7u48/?vq=hd1080pwz60x7aa4b	https://www.mediafire.com/file/m72ms2g11mz4uqs/Tokunbo.mp4/file	t	2025-07-20 18:16:12.312
929	331	theg	https://anonsharing.com	END	1	/file/14f60614cc39d017/Tufang.mp4	https://www.mediafire.com/file/y4rjl7loxptl8ij/Tufang.mp4/file	f	2025-07-20 18:19:20.86
930	332	theg	https://anonsharing.com	END	1	/file/893a4d3654187338/Mission_Impossible_Fallout_A.mp4		f	2025-07-20 18:21:28.009
931	332	theg	https://anonsharing.com	END	2	/file/829c08df51a0135f/Mission_Impossible_Fallout_B.mp4		f	2025-07-20 18:21:49.912
932	333	theg	https://anonsharing.com	END	1	/file/44919d7e2fdaa4bf/Mission-_Impossible_7.mp4		f	2025-07-20 18:23:40.874
933	334	seva	https://drive.google.com	END	1	/file/d/13GSRNWFRxn07ReuFF7BzxG2Z0WswevHP/preview		f	2025-07-20 18:30:18.189
934	334	theg	https://drive.google.com	END	2	/file/d/104PLAkRmHYtB6dTEah5awfL-mCyNjCmZ/preview		f	2025-07-20 18:30:44.732
935	334	seva	https://drive.google.com	END	3	/file/d/1OXQA-cSLCS3cgKW97k3DHoFTeB7yxwt6/preview		f	2025-07-20 18:31:17.009
936	335	seva	https://drive.google.com	SEASON	1	/file/d/1cIDWqqp04Y40vF3NT3R5Q6IoZUQe9_Rt/preview		f	2025-07-20 18:37:51.982
937	336	seva	https://drive.google.com	END	1	/file/d/1g7Z2UZJPiJ0mGO9Xqlb5Kgs9-TUfl0Ex/preview		f	2025-07-20 18:41:05.895
938	337	seva	https://drive.google.com	SEASON	1	/file/d/1w9NER9hzVUR7W0BVjM4trTBqpo-6-PSN/preview		f	2025-07-20 18:46:07.412
939	337	seva	https://drive.google.com	SEASON	2	/file/d/1hWyk3kOlDGnBUDJUsG2ObtfNOb3Pp7Lq/preview		f	2025-07-20 18:46:51.723
940	337	seva	https://drive.google.com	SEASON	3	/file/d/1zaRSuiTQvWhAbnp6lTg9I-qo2buCSOtQ/preview		f	2025-07-20 18:47:35.631
941	337	seva	https://drive.google.com	SEASON	4	/file/d/1bf9ciRRRVxXFYtMvFltEArNrD2Zn-QS5/preview		f	2025-07-20 18:48:37.699
942	337	seva	https://drive.google.com	SEASON	5	/file/d/1ORundbqX3Fsc7UjmQrBCbae9Lbx6XrPn/preview		f	2025-07-20 18:49:13.137
943	337	seva	https://drive.google.com	SEASON	6	/file/d/1KMOEyrTzquN2FQr7hunCSlWGCc7jtjOC/preview		f	2025-07-20 18:49:54.31
944	337	seva	https://drive.google.com	SEASON	7	/file/d/1Tkf4wtE-kXo4GoISEJ5KTpXVV-TREYWo/preview		f	2025-07-20 18:50:29.634
945	337	seva	https://drive.google.com	SEASON	8	/file/d/1C136BxNH3q7Gky-qKYPNK3GzWP-Ni_4g/preview		f	2025-07-20 18:53:27.699
946	337	seva	https://drive.google.com	SEASON	9	/file/d/1pNSk5YCgn9hgINr-yQNvnOp66OT7znAd/preview		f	2025-07-20 18:55:29.912
947	337	seva	https://drive.google.com	SEASON	10	/file/d/1sL9hDAtJNTplWvldHiYqFZJXEitDeE2A/preview		f	2025-07-20 18:56:35.783
948	337	seva	https://drive.google.com	SEASON	11	/file/d/1p3TE04WJHwygt4JEHOpW8A00qj-pbTtm/preview		f	2025-07-20 18:57:30.63
949	337	seva	https://drive.google.com	SEASON	12	/file/d/1p3TE04WJHwygt4JEHOpW8A00qj-pbTtm/preview		f	2025-07-20 18:58:43.376
950	337	seva	https://drive.google.com	SEASON	13	/file/d/16CjY2Ir8a7WErZ8JCP4usA_-XIfwmY1U/preview		f	2025-07-20 18:59:08.79
951	337	seva	https://drive.google.com	SEASON	14	/file/d/10K98bAIPucRqVubW9oTsvyqeinWFOOvN/preview		f	2025-07-20 18:59:37.775
952	337	seva	https://drive.google.com	SEASON	15	/file/d/1akS01ILI4rvanTgR4BVlevAFnrBz7-Je/preview		f	2025-07-20 19:00:13.634
953	337	seva	https://drive.google.com	SEASON	16	/file/d/1WpuMmfOQGkBtBhMYPu-46xq42cUfFkYs/preview		f	2025-07-20 19:00:41.725
954	337	seva	https://drive.google.com	SEASON	17	/file/d/16XFnSvCrEE61luv3aQCSQqOXFl-hPHp5/preview		f	2025-07-20 19:02:19.613
955	337	seva	https://drive.google.com	SEASON	18	/file/d/1ufXn5Q6uiGOewdXl0nrXI6cWEFwuO9Jo/preview		f	2025-07-20 19:03:19.442
956	337	seva	https://drive.google.com	SEASON	19	/file/d/1IAkrv9uZoKtNXOry9uMJef3JKYjLbuaO/preview		f	2025-07-20 19:08:26.167
957	337	seva	https://drive.google.com	SEASON	20	/file/d/1EejCTdTRA1efaQVG19gybh-WjQjKRFLr/preview		f	2025-07-20 19:09:58.46
958	337	seva	https://drive.google.com	SEASON	21	/file/d/1EejCTdTRA1efaQVG19gybh-WjQjKRFLr/preview		f	2025-07-20 19:30:45.752
959	337	seva	https://drive.google.com	SEASON	22	/file/d/19ShwvjeLMRJST11U2TkSgTEvyjBJle8Z/preview		f	2025-07-20 19:33:24.403
960	337	seva	https://drive.google.com	SEASON	23	/file/d/156E_vv0t94p5sIAAyhOWQ5fuGjCLOBy1/preview		f	2025-07-20 19:36:45.025
961	337	seva	https://drive.google.com	SEASON	24	/file/d/14rBXCfj-xALzLI9bOI1_wSPnrOgAzpaN/preview		f	2025-07-20 19:37:23.661
962	337	seva	https://drive.google.com	SEASON	25	/file/d/1QFbqhRGr7jbHhr-E_WecHrilmjMUeJ2O/preview		f	2025-07-20 19:38:09.584
963	337	seva	https://drive.google.com	SEASON	26	/file/d/1g8Jsv5vrLJjj8LVZqGf52rQCNhq2jTSV/preview		f	2025-07-20 19:39:02.782
964	325	theg	https://rumble.com	END	2	/embed/v6ubmei/?vq=hd1080pecWaAPAI5s	https://www.mediafire.com/file/09iuyl3m9twufe8/Most_Dangerous_Game_B.mp4/file	t	2025-07-22 11:57:42.739
965	338	theg	https://rumble.com	SEASON	1	/embed/v6uf5vc/?vq=hd1080pgF0ZbDpaO5	https://www.mediafire.com/file/1ikqgznaey9t9d2/Night+Has+Come+S01e01.mp4/file	t	2025-07-24 11:23:21.895
966	338	theg	https://rumble.com	SEASON	2	/embed/v6uf73e/?vq=hd1080pop2kxfO8Tq	https://www.mediafire.com/file/hy1j51rlws56f8p/Night+Has+Come+S01e02.mp4/file	t	2025-07-24 11:25:32.93
967	338	theg	https://rumble.com	SEASON	3	/embed/v6ugtkg/?vq=hd1080pnlXS3meZUN	https://www.mediafire.com/file/mw5n7zxxsta8fma/Night+Has+Come+S01e03.mp4/file	t	2025-07-25 10:28:44.043
968	338	theg	https://rumble.com	SEASON	4	/embed/v6ugtmk/?vq=hd1080pSLga4cF377	https://www.mediafire.com/file/uzp2ljmng5ayau4/Night_Has_Come_S01e04.mp4/file	t	2025-07-25 10:29:40.352
969	338	theg	https://rumble.com	SEASON	5	/embed/v6ugtnc/?vq=hd1080p456OeREmWM	https://www.mediafire.com/file/sa8dsp7iieg3cxz/Night_Has_Come_S01e05.mp4/file	t	2025-07-25 10:30:52.621
970	339	now	https://short.icu	SEASON	1	/LOJ6jbUxr	https://agasobanuyenow.com/download/S01%20-%20EP01%20-%20Moon%20Knight.mp4	t	2025-07-30 15:34:37.329
971	340	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt30826955		t	2025-07-30 16:40:16.51
972	341	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt24850708		t	2025-07-30 20:57:51.685
973	342	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt33319706		t	2025-07-31 10:59:27.709
974	343	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt31248599		t	2025-07-31 11:05:58.445
975	344	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt31040456		t	2025-07-31 11:13:56.842
976	345	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt35931046		t	2025-07-31 11:20:11.925
977	346	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt36437047		t	2025-07-31 11:24:58.355
978	348	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt21942598		t	2025-07-31 11:32:33.9
979	349	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt7068946		t	2025-07-31 11:35:40.236
980	350	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt32550101		t	2025-07-31 11:40:19.893
981	351	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt26548265		t	2025-07-31 11:43:46.521
982	352	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt36463894		t	2025-07-31 11:46:19.383
983	353	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt29344903		t	2025-07-31 11:48:48.111
984	354	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt14357812		t	2025-07-31 11:51:17.644
985	355	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt36240772		t	2025-07-31 11:53:25.711
986	356	gu	https://vidsrc.net	END	1	/embed/movie?imdb=tt13852690		t	2025-07-31 11:56:03.83
987	357	theg	https://anonsharing.com	END	1	/file/d343814bdb209314/Peter_Rabbit_2.mp4		f	2025-08-01 07:13:19.793
988	358	theg	https://anonsharing.com	END	1	/file/92ad2186d80f9449/Dragons_Forever_(1988).mp4		f	2025-08-01 07:24:08.42
989	359	theg	https://rumble.com	END	1	/embed/v6ulciy/?vq=hd1080pYLgtzzNyob	https://www.mediafire.com/file/4nuepuiypfv4t8m/The_Conjuring_3.mp4/file	t	2025-08-01 07:29:41.304
990	360	o	https://hglink.to	SEASON	1	/e/60ui86plc7v3	https://www.mediafire.com/file/d6kwz3rfp56lydy/THE_ORIGINAL_S02_EP1.mp4/file	t	2025-08-01 07:48:02.829
992	360	o	https://hglink.to	SEASON	2	/e/gyqo3zkua8gj	https://www.mediafire.com/file/5st9jrilcjprr5c/THE_ORIGINAL_S02_EP2.mp4/file	t	2025-08-01 07:53:07.594
991	360	the	https://hglink.to	SEASON	3	/e/qog9t3gc3rip	https://www.mediafire.com/file/rws6cosd0cgcckj/THE_ORIGINAL_S02_EP3.mp4/file	t	2025-08-01 07:51:26.337
993	360	o	https://hglink.to	SEASON	4	/e/ewj7faaag76d	https://www.mediafire.com/file/4b9uayw6zqob718/THE_ORIGINAL_S02_EP4.mp4/file	t	2025-08-01 07:54:37.154
994	360	o	https://hglink.to	SEASON	5	/e/ptow7zuume05	https://www.mediafire.com/file/jm3koozg7vlrt7d/THE_ORIGINAL_S02_EP5.mp4/file	t	2025-08-01 07:55:57.485
995	360	o	https://hglink.to	SEASON	6	/e/0k7h16wis3qj	https://www.mediafire.com/file/apeqvqzrksljan6/THE_ORIGINAL_S02_EP6.mp4/file	t	2025-08-01 07:59:11.787
996	360	o	https://hglink.to	SEASON	7	/e/touve96mvydd	https://www.mediafire.com/file/v3yc6ib2upmuprs/THE_ORIGINAL_S02_EP7.mp4/file	t	2025-08-01 08:00:51.14
997	361	theg	https://rumble.com	END	1	/embed/v6un5o4/?vq=hd1080pbvxdm3QvOc	https://www.mediafire.com/file/6hp4ce1qficob7z/Legion.mp4/file	t	2025-08-01 08:05:47.696
998	362	theg	https://rumble.com	END	1	/embed/v6un5rw/?vq=hd1080ptOyQ4vxI0r	https://www.mediafire.com/file/nl6v37f034fbzrl/Vantage_Point.mp4/file	t	2025-08-01 08:09:28.86
999	363	theg	https://rumble.com	END	1	/embed/v6uov2s/?vq=hd1080peEreHpnmbS	https://www.mediafire.com/file/9lisutftyl03b6e/Brick.mp4/file	t	2025-08-01 08:52:01.875
1000	338	o	https://hglink.to	SEASON	6	/e/3vm5y05fbkn5	https://www.mediafire.com/file/54e8ub2nvedz0ic/NIGHT_HAS_COME_EP06.mp4/file	t	2025-08-02 10:06:32.886
1001	338	o	https://hglink.to	SEASON	7	/e/dv92qr90egds	https://www.mediafire.com/file/hl8mjqlacpdg7xb/NIGHT_HAS_COME_E07.mp4/file	t	2025-08-02 10:07:21.48
1002	338	o	https://hglink.to	SEASON	8	/e/eznxkrbiywl8	https://www.mediafire.com/file/shd0197m51atqip/NIGHT_HAS_COME_EP_08_.mp4/file	t	2025-08-02 10:08:11.873
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.subscription (id, endpoint, p256dh_key, auth_key, browser_id, created_at, updated_at) FROM stdin;
1	https://fcm.googleapis.com/fcm/send/eHAOIdQZCJY:APA91bFkOwU7l56YTPy2g_w1qVKUPpPb3quHnPszJadu9NkwR1r_khwDARbyuVcIu9z9-A2puUmQ9gWIhAdIL90r8sUlWfjnbKVZN1oWCpJ-hDs3vtOmgrpo8ARbLWoknaE24-wtsedX	BPmdpRy7CVJMcO-YOpePr09pYVFVYQn5jQZ7l5DQqZGaUzWIK0UiThNMAH8pBbtrVAhIOoHMh8-6qAXCZJ2p3H0	ZfvOCbvxWtEZQvfuumg98w	4aa0c817-9316-4350-b067-f765f9ea284d	2025-06-16 15:50:17.151	2025-06-16 15:50:17.151
2	https://fcm.googleapis.com/fcm/send/cI_o0ROmR1k:APA91bFm_kJEkw7gzov4ush41JFYHklZLLOxEslbbFF6ALl9dANL4FMhYrcmvIWX_s1wnnsqo5xW_R-EzZsO8vorJoEocqK_lWStDhcipinqI6kqWzaMxZTUqxNeG-dCxCUxk-QYUHag	BC-oGXZskkjmv1U3ntVY3Uw7aSByCXZLp5O6JqRy9aRgnlKpOiM4UeWi_S4qiePD84cP2iK_HhzZV4hcqdXyFEk	3WbNYt4s5QJXk__8skoKJg	df2ed2af-7646-4a9e-a8bc-5024623cf4fd	2025-06-17 09:15:07.828	2025-06-17 09:15:07.828
3	https://fcm.googleapis.com/fcm/send/cubxSv1WhYs:APA91bHCaEbPb8ME2dy7AC53hqZmy4bQ0RaoRicnthJjrbGW2qT3ZCnC1_UVdkFyblcqF1MoFrteT9xheg1I9vfGKxbLPZbVgDXE2jv0g0fAgklJqtAf-gzR4IOqOXcwjSSvIsS-rKIA	BO4oT7T9Lcj6FHCjxmCr7xvhvUtCPcIL-ERdrlbZs9hfDP7wHjjjbfjOnVR95lYuPZ-SZuajxGxG_pi-BMmVCQc	q51EQltaEJLhgATTFSZ_qw	bed66abc-f64a-4ccc-a394-6eee717557c3	2025-06-17 12:56:01.825	2025-06-17 12:56:01.825
4	https://fcm.googleapis.com/fcm/send/f7rYUPt8h6c:APA91bFFPLOlw_3mupEIlAajRJoY6NNYmo-cMUq2SCOW6rKf0XW1-mCPf3oMIqf8-i-TKkBBSQdWtB8xY4T_ecJ4X43bsHDG5f2Ig3nwKzG0fmg5DnV18Lb-14Z4Cz6NFT0ot6xEmees	BKNd8HdBINW_lJPKsS_WrbD12E4N8Yeq-lbGE9eK4qkeFjgCruTeJick9MFHwEDj--pe02mUk1Gd-Dxy-36B9jU	R-MlEaoUPgELemIPa5xumw	8e47773c-6fc9-4bdf-850d-98869ffc5e00	2025-06-17 17:40:05.924	2025-06-17 17:40:05.924
5	https://fcm.googleapis.com/fcm/send/fAjbGnY-dQ4:APA91bGQepCu3v3CR8qf6NY7YA039WKyPcnpv3A-t6WN98sjzQ0Ay1kYN8BPm8h2Nrd_sdqrYii2YxusfV3Q5qVSvOqv6kNeLLFyGK2SS55SwuTF36bM9J-IGaoSUNbrh_CbfGl6s1zf	BA_c-OXYuT_Lxks17sPNMwbF8Kd5_JZaRD1qLFeGBelm-VO-CKSL0VmHTGofUuoVJ-oPDNuA7hGkMxYdNZMH2BI	1gnbI6OpoOe7QS3J8V3BxA	db140fe4-ad67-4630-ad32-8ea8e8ab676c	2025-06-17 20:02:47.617	2025-06-17 20:02:47.617
6	https://fcm.googleapis.com/fcm/send/dR_sVBrdtOE:APA91bFB_-OGTLJLAtdvjrr5APcH5MR2HSeWOMk2WknfKSEspm7QZW7aTiO1Ue9FMKGBryZdIfWr4FVHRH7MHmcjtU73E1Vzk3pW-WgV3hynOduxGWUlofH00MGBCYQhSJb8PkoFJUXu	BBEuvSyLb_TCxtuFWHvObSSAdn6qzAQ6rWTv6oygye1pGXghv45g1gfX_A5DHam3Dj_azrD39JIBr_wFK23ub_0	soUAu9YbjYyztYlsDTXBpA	e466f8d2-f500-45f4-a3c8-8597824c667e	2025-06-18 13:17:50.868	2025-06-18 13:17:50.868
7	https://fcm.googleapis.com/fcm/send/faULISgYccI:APA91bEnVDXyh0vcl40kGIWsMzIalWKisHvecrn0eNKUFSPWyj8lub7i7YzbI60eai_QAMo7BLHED_7aXawJ8KjhKhXZhp1P3TZeT4Pah33ar_J10dB7gfPBm69YCui_Kak6krx98rvw	BN_2KYfjMqkvm2GRpRoEoV8a6gwRR6GPLKR4WJfQsa3t1ANJE-iN0Y2mVSqoyYPuEJjlpPUqnHKBMpWgvhLvg_c	Ihld0KvFQ8XVLd3djhnk-w	01a72f94-ab5b-4fe2-8991-da70b13eb7bf	2025-06-18 22:23:24.779	2025-06-18 22:23:24.779
8	https://jmt17.google.com/fcm/send/eKgQFunOVrI:APA91bGfaeQPF-m2WgVtIq1yQw1cHEBVktjn-usWUZy9D1hdZ9mh0amNXHzEmVE5JG_SmzqM7uti-yeJfJFuYF1B9a8VkZekUkBdBAGcB_KnySqwGCDc7iOw9Pj5PN-yXyRe0e2-oQW6	BOzMgmQGeO-NY19RWx6ec0igsDtwo7THmglJyeGo6N5DefF-tHxv9AerHJoxrwKroRQQSaEd0ul7gZZO7jGSpfE	-YFjfgODFiYH9VdS9I2iTw	69d247f8-8842-475f-9268-5e1bba6153b9	2025-06-19 05:20:03.761	2025-06-19 05:20:03.761
9	https://fcm.googleapis.com/fcm/send/eI3cZPV-Cn4:APA91bFFJQx8S08ZwS_kAgNpmLL6i1egpxGtXJMg0_IwNJBuQgdsfIBwzoJmzusCsfRwivl4fJgTfL7KDq6h1ewzDPeVhdUa2H32aJK3bo1TYHgpEfPP99CggCjpKXPhmzwEmgCHCFcC	BFvj_vXntVccJdYo5vBoteU79g6OGdytBiWBF-NVYYyf0Jj8S3MLJ0XBcV0dErd5s8dk7PPzz5f_sbjMugyc0yg	6iGgRQlsGcb55zdAsPDA6w	a97a30ce-afa6-46d1-a94b-d956e4fdb961	2025-06-19 08:35:37.528	2025-06-19 08:35:37.528
10	https://fcm.googleapis.com/fcm/send/f4HeNX0atzs:APA91bHSsTGroir0MjfmHJhYuef3C7d1Te_wSQmxHI3IsmFTyq2h5zGKrjvrUO1fqCsA-QizuTa3BiryFpYcEFWsSMSMayKI95xCW8W45fntSOxggEfjNcN6gwtVgIQcTiKZp4TYDEze	BDUQp01s7Ju83q-zqmqu3bNFQWH8KVtUZSZQsS1p9hiHEqD_dG5YvA47uAevgAyvBOl8TnS4JoTqEmT6y6Jc1V4	6za25-DDieiHfPCVPc7y8g	6b7d7e74-d806-4397-8176-bba67a931453	2025-06-19 12:50:36.38	2025-06-19 12:50:36.38
11	https://fcm.googleapis.com/fcm/send/f-bGKEo8zj0:APA91bEV6Kqkgrve4vuwQKZZPMIbSBQt7S7Oyc9c-jajEqZwjaoKT8KhN8iPWk1o1JMOlTdyrVLPxtEgXeuGtBxtxZhRZGoxx5Ma18zb8s2YL500l0ptQtP2S6KN7fMI4sbspI6PLLLj	BE-Ozyv4CR-t9QY1pwCsOUWPOSgl8AiiiEZviv7J3mZnpiobyOro00l6FJm3jl-2k-_Nid6i8yNOyWtAjEkFdac	8tSjTqPhNDeOn5rWMAl2uw	d850cde9-76f5-4bd4-961c-96334b02c2e5	2025-06-19 15:37:30.701	2025-06-19 15:37:30.701
12	https://fcm.googleapis.com/fcm/send/cpbeCrlerS0:APA91bHs3DPAQc7lqMkr4k_N04Is9tp7aJndd7KmTXZMfVqMXxKFcCFHQAhV66ZsXDtGFeNIWzrmrTRcf2CULPL8Ekhk0Kb29opY0Bjuc6wGy-UDVYIh1VLiIG3ama2VTbMu4WG8kzEp	BAwoSlVHUf_qks0yUIQV-98S0ijKymTBiEcLf_6y6K98pI5ZduSEMI6eT_v8MnyDZh68NkOvWHHB_1eMW6wKXxM	ca8JpK220T42qj46SYIKdw	bc983e36-9d99-41c5-ac4d-d039d463e40f	2025-06-19 17:51:55.885	2025-06-19 17:51:55.885
13	https://fcm.googleapis.com/fcm/send/dU-Df3mxKNY:APA91bEIC6Q64qMLW93voB7hvg0uSCe8eZzmUr3mEs-PyxP8W83zT5_yoQNOohmsClPeEUr4_hBjV1hizdx955dejplbgRQUMO9QyqBFcWlx7lnp_mh8KQ1BriLuxBBBkoRLuAu_leVt	BGufPiMZUooUGgW8czhEewrJZkk0CONEwlp-a9GiA8wLRkZoAH5BYGKKq50OB9EJXZu9X98jHK54TYWhYXBZ4Z8	FW97jKjNC7dSyxOMI_YESA	3e75c4a5-9206-43c4-b5b3-65f5f1d283ba	2025-06-19 22:51:33.554	2025-06-19 22:51:33.554
14	https://fcm.googleapis.com/fcm/send/cRoy0TCtvzo:APA91bHizcz79RumZk88oSRHfIsAOIVnHBejBNoQmE5yWVm6PuAdahKUhtZUVrG7Jed-T9XO6C09Du_wY4DWrxStqWK5LmYC8T2NBUMUgc2bgayDHrs04aSU2kpwgY55317O0fDudqIi	BCXhNYVk9Ta_5rQNebRo-KVrJDv3MRs4RuCyxy4BbTrwhN33SDvOf23cB3ImXHlTT-NSEQ864bQ6nIYayBgF51o	Bdp285RrEg4kLSbxsWn0Sw	e1368f3b-9ae6-4306-baad-d55aab789f17	2025-06-20 07:40:19.165	2025-06-20 07:40:19.165
\.


--
-- Data for Name: usernotifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.usernotifications (id, "subscriptionId", "notificationId", is_read, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, email, password, "createdAt") FROM stdin;
1	hobbie@gmail.com	$2y$10$rAPcPZn1W6wUwDh3ah0eA.R4m3enG9o17RM3n1yHvbI4XdO.aVsBC	2025-06-12 22:38:56.709
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.categories_id_seq', 4, true);


--
-- Name: commentlike_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.commentlike_id_seq', 30, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.comments_id_seq', 48, true);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1, true);


--
-- Name: inquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.inquiries_id_seq', 1, false);


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.movies_id_seq', 363, true);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.notification_id_seq', 7, true);


--
-- Name: replies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.replies_id_seq', 12, true);


--
-- Name: replylikes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.replylikes_id_seq', 10, true);


--
-- Name: sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.sources_id_seq', 1002, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.subscription_id_seq', 14, true);


--
-- Name: usernotifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.usernotifications_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: commentlike commentlike_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.commentlike
    ADD CONSTRAINT commentlike_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: inquiries inquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT inquiries_pkey PRIMARY KEY (id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: replies replies_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT replies_pkey PRIMARY KEY (id);


--
-- Name: replylikes replylikes_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.replylikes
    ADD CONSTRAINT replylikes_pkey PRIMARY KEY (id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- Name: usernotifications usernotifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.usernotifications
    ADD CONSTRAINT usernotifications_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: Subscription_endpoint_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "Subscription_endpoint_key" ON public.subscription USING btree (endpoint);


--
-- Name: Users_email_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "Users_email_key" ON public.users USING btree (email);


--
-- Name: commentlike_commentId_ip_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "commentlike_commentId_ip_key" ON public.commentlike USING btree ("commentId", ip);


--
-- Name: idx_browser_id; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_browser_id ON public.subscription USING btree (browser_id);


--
-- Name: commentlike CommentLike_commentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.commentlike
    ADD CONSTRAINT "CommentLike_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES public.comments(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: comments Comments_movieId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT "Comments_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES public.movies(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: movies Movies_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT "Movies_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replies Replies_commentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT "Replies_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES public.comments(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replylikes ReplyLikes_replyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.replylikes
    ADD CONSTRAINT "ReplyLikes_replyId_fkey" FOREIGN KEY ("replyId") REFERENCES public.replies(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: sources Sources_movieId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT "Sources_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES public.movies(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: usernotifications UserNotifications_notificationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.usernotifications
    ADD CONSTRAINT "UserNotifications_notificationId_fkey" FOREIGN KEY ("notificationId") REFERENCES public.notification(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: usernotifications UserNotifications_subscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.usernotifications
    ADD CONSTRAINT "UserNotifications_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES public.subscription(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: neondb_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

