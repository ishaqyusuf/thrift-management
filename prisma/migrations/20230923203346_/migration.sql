/*
  Warnings:

  - Made the column `thriftCycleId` on table `payrolls` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `payrolls` DROP FOREIGN KEY `Payrolls_thriftCycleId_fkey`;

-- AlterTable
ALTER TABLE `payments` ADD COLUMN `status` VARCHAR(191) NULL,
    MODIFY `paid` DOUBLE NULL,
    MODIFY `payable` DOUBLE NULL;

-- AlterTable
ALTER TABLE `payrolls` ADD COLUMN `payDay` DATETIME(3) NULL,
    ADD COLUMN `status` VARCHAR(191) NULL,
    MODIFY `thriftCycleId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Payrolls` ADD CONSTRAINT `Payrolls_thriftCycleId_fkey` FOREIGN KEY (`thriftCycleId`) REFERENCES `ThriftCycle`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
