-- =============================================
-- Fix RLS policies for id-documents bucket
-- Run this in Supabase SQL Editor
-- =============================================

-- 1. Make sure bucket is public
UPDATE storage.buckets SET public = true WHERE id = 'id-documents';

-- 2. Drop any conflicting old policies
DROP POLICY IF EXISTS "Anyone can upload to id-documents" ON storage.objects;
DROP POLICY IF EXISTS "Public read access for id-documents" ON storage.objects;
DROP POLICY IF EXISTS "Public Access" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload" ON storage.objects;
DROP POLICY IF EXISTS "Anyone can upload" ON storage.objects;

-- 3. Allow ANYONE to upload (anon + authenticated)
CREATE POLICY "Allow public uploads"
  ON storage.objects FOR INSERT
  TO public
  WITH CHECK (bucket_id = 'id-documents');

-- 4. Allow ANYONE to read/download
CREATE POLICY "Allow public reads"
  ON storage.objects FOR SELECT
  TO public
  USING (bucket_id = 'id-documents');

-- 5. Allow update (for upsert)
CREATE POLICY "Allow public updates"
  ON storage.objects FOR UPDATE
  TO public
  USING (bucket_id = 'id-documents');

-- 6. Allow delete
CREATE POLICY "Allow public deletes"
  ON storage.objects FOR DELETE
  TO public
  USING (bucket_id = 'id-documents');
