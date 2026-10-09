-- CareerPilot AI — 002 table privileges (non-destructive, re-runnable).
-- Run this in the Supabase Dashboard → SQL Editor → New query → Paste → Run,
-- the same way 001 was applied. No data is deleted. No RLS policy is changed.
--
-- WHY THIS EXISTS: 001 created the tables and RLS policies but issued no
-- table-level GRANTs. Tables created by raw SQL are owned by postgres with
-- privileges granted to no other role, so every PostgREST request made as
-- the anon/authenticated roles fails with 42501 "permission denied for
-- table ..." before RLS is even evaluated. Symptoms: history, profile, and
-- preference reads/writes all fail for real logged-in users.
--
-- RLS REMAINS THE SECURITY BOUNDARY: these GRANTs only let the roles reach
-- the policy check. Every policy still enforces user_id = auth.uid()
-- (or id = auth.uid() for profiles), so users can only touch their own rows.

GRANT USAGE ON SCHEMA public TO anon, authenticated;

GRANT SELECT, INSERT, UPDATE, DELETE ON public.profiles TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.analyses TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.resume_improvements TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.interview_sessions TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.interview_messages TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.user_preferences TO anon, authenticated;
