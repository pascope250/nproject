/*
  Warnings:

  - A unique constraint covering the columns `[commentId,ip]` on the table `commentlike` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `commentlike` ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- CreateIndex
CREATE UNIQUE INDEX `commentlike_commentId_ip_key` ON `commentlike`(`commentId`, `ip`);
