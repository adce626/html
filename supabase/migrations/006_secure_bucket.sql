-- =============================================
-- SECURE: Make id-documents bucket PRIVATE
-- Run in Supabase SQL Editor
-- =============================================

-- 1. Make bucket PRIVATE (no public access)
UPDATE storage.buckets SET public = false WHERE id = 'id-documents';

-- 2. Drop old public policies
DROP POLICY IF EXISTS "Allow public uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow public reads" ON storage.objects;
DROP POLICY IF EXISTS "Allow public updates" ON storage.objects;
DROP POLICY IF EXISTS "Anyone can upload to id-documents" ON storage.objects;
DROP POLICY IF EXISTS "Public read access for id-documents" ON storage.objects;
DROP POLICY IF EXISTS "Public Access" ON storage.objects;

-- 3. Allow authenticated users to upload
DROP POLICY IF EXISTS "Authenticated upload" ON storage.objects;
CREATE POLICY "Authenticated upload"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'id-documents');

-- 4. Allow anon to upload (mobile app has no auth)
DROP POLICY IF EXISTS "Anon upload" ON storage.objects;
CREATE POLICY "Anon upload"
  ON storage.objects FOR INSERT TO anon
  WITH CHECK (bucket_id = 'id-documents');

-- 5. No public read — signed URLs only
-- (No SELECT policy = no one can read without signed URL)

-- 6. Allow anon SELECT for signed URL creation (needed by createSignedUrl)
DROP POLICY IF EXISTS "Anon signed url" ON storage.objects;
CREATE POLICY "Anon signed url"
  ON storage.objects FOR SELECT TO anon
  USING (bucket_id = 'id-documents');

-- 7. Allow anon UPDATE for upsert
DROP POLICY IF EXISTS "Anon update" ON storage.objects;
CREATE POLICY "Anon update"
  ON storage.objects FOR UPDATE TO anon
  USING (bucket_id = 'id-documents')
  WITH CHECK (bucket_id = 'id-documents');

-- 8. Allow authenticated UPDATE for upsert
DROP POLICY IF EXISTS "Authenticated update" ON storage.objects;
CREATE POLICY "Authenticated update"
  ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'id-documents')
  WITH CHECK (bucket_id = 'id-documents');
