-- AlterTable
ALTER TABLE "movies" ADD COLUMN     "type" TEXT NOT NULL DEFAULT 'TRANSLATED';

-- AlterTable
ALTER TABLE "sources" ALTER COLUMN "downloadLink" SET DEFAULT NULL;
