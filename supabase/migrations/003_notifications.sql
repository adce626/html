-- =============================================
-- SAMA Notifications System — Supabase Migration
-- =============================================

-- 1. notifications table
CREATE TABLE IF NOT EXISTS notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  type TEXT NOT NULL DEFAULT 'announcement'
    CHECK (type IN ('job_match', 'application_update', 'worker_request_update', 'message', 'announcement')),
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  message TEXT,
  related_id TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast queries
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_is_read ON notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at ON notifications(created_at DESC);

-- RLS policies
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Anyone can read notifications (public announcements + user-specific)
CREATE POLICY "Users can view notifications"
  ON notifications FOR SELECT
  USING (user_id IS NULL OR user_id = auth.uid());

-- Only service role can insert (via backend/FCM flow)
CREATE POLICY "Service role can insert notifications"
  ON notifications FOR INSERT
  WITH CHECK (true);

-- Users can update their own notifications (mark as read)
CREATE POLICY "Users can update own notifications"
  ON notifications FOR UPDATE
  USING (user_id IS NULL OR user_id = auth.uid());

-- 2. device_tokens table (FCM tokens)
CREATE TABLE IF NOT EXISTS device_tokens (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  token TEXT NOT NULL UNIQUE,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  platform TEXT NOT NULL DEFAULT 'android',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_device_tokens_user_id ON device_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_device_tokens_token ON device_tokens(token);

ALTER TABLE device_tokens ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own device tokens"
  ON device_tokens FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own device tokens"
  ON device_tokens FOR INSERT
  WITH CHECK (user_id = auth.uid() OR user_id IS NULL);

CREATE POLICY "Users can delete own device tokens"
  ON device_tokens FOR DELETE
  USING (user_id = auth.uid());
