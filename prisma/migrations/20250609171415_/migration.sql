/*
  Warnings:

  - You are about to drop the column `created_at` on the `movies` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `movies` DROP COLUMN `created_at`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);
