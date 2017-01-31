--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: adverseevents_tb; Type: TABLE; Schema: public; Owner: fabienplisson
--

CREATE TABLE adverseevents_tb (
    class bigint,
    pain double precision,
    erythema double precision,
    pyrexia double precision,
    rash double precision,
    swelling double precision,
    pruritus double precision,
    oedema double precision,
    headache double precision,
    urticaria double precision,
    hypersensitivity double precision,
    vomiting double precision
);


ALTER TABLE adverseevents_tb OWNER TO fabienplisson;

--
-- Name: adverseeventsdata; Type: TABLE; Schema: public; Owner: fabienplisson
--

CREATE TABLE adverseeventsdata (
    class bigint,
    pain double precision,
    erythema double precision,
    pyrexia double precision,
    rash double precision,
    swelling double precision,
    pruritus double precision,
    oedema double precision,
    headache double precision,
    urticaria double precision,
    hypersensitivity double precision,
    vomiting double precision
);


ALTER TABLE adverseeventsdata OWNER TO fabienplisson;

--
-- Data for Name: adverseevents_tb; Type: TABLE DATA; Schema: public; Owner: fabienplisson
--

COPY adverseevents_tb (class, pain, erythema, pyrexia, rash, swelling, pruritus, oedema, headache, urticaria, hypersensitivity, vomiting) FROM stdin;
1	0.104999999999999996	0.332999999999999963	0.0470000000000000001	0.0220000000000000022	0.392000000000000015	0.0640000000000000013	0.0050000000000000001	0.0139999999999999986	0.0100000000000000002	0.00800000000000000017	0.00600000000000000012
2	0.552999999999999936	0.0200000000000000004	0.114000000000000004	0.0309999999999999998	0.0459999999999999992	0.0260000000000000023	0.0599999999999999978	0.0740000000000000102	0.00600000000000000012	0.0520000000000000046	0.0250000000000000014
3	0	0	0.356000000000000039	0.182999999999999996	0.00300000000000000006	0.0779999999999999999	0.0850000000000000061	0.100999999999999993	0	0.086999999999999994	0.111000000000000001
4	0.123999999999999999	0.537999999999999923	0.0650000000000000022	0.0470000000000000001	0.00100000000000000002	0.0840000000000000052	0.104000000000000009	0.0160000000000000003	0.00800000000000000017	0.00900000000000000105	0.00900000000000000105
5	0.0250000000000000014	0.0570000000000000021	0.0550000000000000003	0.0909999999999999976	0.0139999999999999986	0.123000000000000012	0.0350000000000000033	0.0149999999999999994	0.537000000000000033	0.0370000000000000051	0.0160000000000000003
\.


--
-- Data for Name: adverseeventsdata; Type: TABLE DATA; Schema: public; Owner: fabienplisson
--

COPY adverseeventsdata (class, pain, erythema, pyrexia, rash, swelling, pruritus, oedema, headache, urticaria, hypersensitivity, vomiting) FROM stdin;
1	0.104999999999999996	0.332999999999999963	0.0470000000000000001	0.0220000000000000022	0.392000000000000015	0.0640000000000000013	0.0050000000000000001	0.0139999999999999986	0.0100000000000000002	0.00800000000000000017	0.00600000000000000012
2	0.552999999999999936	0.0200000000000000004	0.114000000000000004	0.0309999999999999998	0.0459999999999999992	0.0260000000000000023	0.0599999999999999978	0.0740000000000000102	0.00600000000000000012	0.0520000000000000046	0.0250000000000000014
3	0	0	0.356000000000000039	0.182999999999999996	0.00300000000000000006	0.0779999999999999999	0.0850000000000000061	0.100999999999999993	0	0.086999999999999994	0.111000000000000001
4	0.123999999999999999	0.537999999999999923	0.0650000000000000022	0.0470000000000000001	0.00100000000000000002	0.0840000000000000052	0.104000000000000009	0.0160000000000000003	0.00800000000000000017	0.00900000000000000105	0.00900000000000000105
5	0.0250000000000000014	0.0570000000000000021	0.0550000000000000003	0.0909999999999999976	0.0139999999999999986	0.123000000000000012	0.0350000000000000033	0.0149999999999999994	0.537000000000000033	0.0370000000000000051	0.0160000000000000003
\.


--
-- Name: ix_adverseevents_tb_class; Type: INDEX; Schema: public; Owner: fabienplisson
--

CREATE INDEX ix_adverseevents_tb_class ON adverseevents_tb USING btree (class);


--
-- Name: ix_adverseeventsdata_class; Type: INDEX; Schema: public; Owner: fabienplisson
--

CREATE INDEX ix_adverseeventsdata_class ON adverseeventsdata USING btree (class);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

