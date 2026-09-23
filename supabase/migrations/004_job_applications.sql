-- =============================================
-- SAMA Job Applications Table
-- Run this in Supabase SQL Editor
-- =============================================

CREATE TABLE IF NOT EXISTS job_applications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  job_id UUID NOT NULL,
  job_title TEXT NOT NULL,
  full_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  id_image_url TEXT,
  id_image_back_url TEXT,
  status TEXT DEFAULT 'جديد',
  source TEXT DEFAULT 'mobile',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_job_applications_job_id ON job_applications(job_id);
CREATE INDEX IF NOT EXISTS idx_job_applications_status ON job_applications(status);
CREATE INDEX IF NOT EXISTS idx_job_applications_created_at ON job_applications(created_at DESC);

-- RLS
ALTER TABLE job_applications ENABLE ROW LEVEL SECURITY;

-- Anyone can insert (mobile app submissions)
CREATE POLICY "Anyone can submit applications"
  ON job_applications FOR INSERT
  WITH CHECK (true);

-- Service role can read all
CREATE POLICY "Service role can read all"
  ON job_applications FOR SELECT
  USING (true);

-- Storage bucket for ID images (same as web app)
INSERT INTO storage.buckets (id, name, public)
VALUES ('id-documents', 'id-documents', true)
ON CONFLICT (id) DO NOTHING;

-- Allow public read access to id-documents bucket
CREATE POLICY "Public read access for id-documents"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'id-documents');

-- Allow anonymous upload to id-documents bucket
CREATE POLICY "Anyone can upload to id-documents"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'id-documents');
