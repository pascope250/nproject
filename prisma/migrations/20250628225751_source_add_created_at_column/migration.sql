-- AlterTable
ALTER TABLE "sources" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "downloadLink" SET DEFAULT NULL;
