import imageCompression from 'browser-image-compression';
import { supabase } from '@/integrations/supabase/client';

const COMPRESSION_OPTIONS = {
  maxSizeMB: 0.1, // 100 KB
  maxWidthOrHeight: 1200,
  useWebWorker: true,
  fileType: 'image/jpeg' as const,
  initialQuality: 0.7,
};

/**
 * Compress an image file to ~100KB
 */
export async function compressImage(file: File): Promise<File> {
  // If file is already small enough, skip compression
  if (file.size <= 100 * 1024) {
    return file;
  }

  const compressedFile = await imageCompression(file, COMPRESSION_OPTIONS);
  return compressedFile;
}

/**
 * Upload a photo to Supabase Storage
 */
export async function uploadWorkoutPhoto(
  file: File,
  userId: string,
  workoutId: string
): Promise<string> {
  // Compress the image first
  const compressedFile = await compressImage(file);

  // Generate unique filename
  const timestamp = Date.now();
  const extension = 'jpg';
  const path = `${userId}/${workoutId}/${timestamp}.${extension}`;

  // Upload to Supabase Storage
  const { data, error } = await supabase.storage
    .from('workout-photos')
    .upload(path, compressedFile, {
      contentType: 'image/jpeg',
      upsert: false,
    });

  if (error) {
    throw new Error(`Failed to upload photo: ${error.message}`);
  }

  // Get the public URL
  const { data: urlData } = supabase.storage
    .from('workout-photos')
    .getPublicUrl(path);

  return urlData.publicUrl;
}

/**
 * Delete a photo from Supabase Storage
 */
export async function deleteWorkoutPhoto(photoUrl: string): Promise<void> {
  // Extract the path from the URL
  const url = new URL(photoUrl);
  const pathParts = url.pathname.split('/workout-photos/');

  if (pathParts.length < 2) {
    throw new Error('Invalid photo URL');
  }

  const path = pathParts[1];

  const { error } = await supabase.storage
    .from('workout-photos')
    .remove([path]);

  if (error) {
    throw new Error(`Failed to delete photo: ${error.message}`);
  }
}

/**
 * Validate that a file is an acceptable image
 */
export function validateImageFile(file: File): { valid: boolean; error?: string } {
  const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'];

  if (!validTypes.includes(file.type)) {
    return {
      valid: false,
      error: 'Неподдерживаемый формат. Используйте JPG, PNG или WebP.'
    };
  }

  // Max 20MB before compression
  const maxSize = 20 * 1024 * 1024;
  if (file.size > maxSize) {
    return {
      valid: false,
      error: 'Файл слишком большой. Максимум 20 MB.'
    };
  }

  return { valid: true };
}
