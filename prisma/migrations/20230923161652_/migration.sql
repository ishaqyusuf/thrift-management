/*
  Warnings:

  - A unique constraint covering the columns `[title]` on the table `ThriftCycle` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[slug]` on the table `ThriftCycle` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `endDate` to the `ThriftCycle` table without a default value. This is not possible if the table is not empty.
  - Added the required column `startDate` to the `ThriftCycle` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `thriftcycle` ADD COLUMN `endDate` DATETIME(3) NOT NULL,
    ADD COLUMN `slug` VARCHAR(191) NULL,
    ADD COLUMN `startDate` DATETIME(3) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `ThriftCycle_title_key` ON `ThriftCycle`(`title`);

-- CreateIndex
CREATE UNIQUE INDEX `ThriftCycle_slug_key` ON `ThriftCycle`(`slug`);
