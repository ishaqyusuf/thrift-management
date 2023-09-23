/*
  Warnings:

  - You are about to drop the column `email` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `users` table. All the data in the column will be lost.
  - Added the required column `uniqueId` to the `Users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `users` DROP COLUMN `email`,
    DROP COLUMN `password`,
    ADD COLUMN `phoneNo` VARCHAR(191) NULL,
    ADD COLUMN `uniqueId` VARCHAR(191) NOT NULL;

-- CreateTable
CREATE TABLE `ThriftCycle` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `createdAt` TIMESTAMP(0) NULL,
    `updatedAt` TIMESTAMP(0) NULL,

    UNIQUE INDEX `ThriftCycle_id_key`(`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MonthWallets` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `thriftCycleId` INTEGER NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `total` DOUBLE NULL,
    `createdAt` TIMESTAMP(0) NULL,
    `updatedAt` TIMESTAMP(0) NULL,

    UNIQUE INDEX `MonthWallets_id_key`(`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Participants` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `thriftCycleId` INTEGER NOT NULL,
    `amount` DOUBLE NOT NULL,
    `createdAt` TIMESTAMP(0) NULL,
    `updatedAt` TIMESTAMP(0) NULL,

    UNIQUE INDEX `Participants_id_key`(`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `thriftCycleId` INTEGER NOT NULL,
    `monthWalletId` INTEGER NOT NULL,
    `paid` DOUBLE NOT NULL,
    `payable` DOUBLE NOT NULL,
    `createdAt` TIMESTAMP(0) NULL,
    `updatedAt` TIMESTAMP(0) NULL,

    UNIQUE INDEX `Payments_id_key`(`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payrolls` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `position` INTEGER NOT NULL,
    `payableAmount` DOUBLE NULL,
    `paid` DOUBLE NULL,
    `pendingAmount` DOUBLE NULL,
    `thriftCycleId` INTEGER NULL,
    `createdAt` TIMESTAMP(0) NULL,
    `updatedAt` TIMESTAMP(0) NULL,
    `paidAt` TIMESTAMP(0) NULL,

    UNIQUE INDEX `Payrolls_id_key`(`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `MonthWallets` ADD CONSTRAINT `MonthWallets_thriftCycleId_fkey` FOREIGN KEY (`thriftCycleId`) REFERENCES `ThriftCycle`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Participants` ADD CONSTRAINT `Participants_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Participants` ADD CONSTRAINT `Participants_thriftCycleId_fkey` FOREIGN KEY (`thriftCycleId`) REFERENCES `ThriftCycle`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payments` ADD CONSTRAINT `Payments_monthWalletId_fkey` FOREIGN KEY (`monthWalletId`) REFERENCES `MonthWallets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payments` ADD CONSTRAINT `Payments_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payrolls` ADD CONSTRAINT `Payrolls_thriftCycleId_fkey` FOREIGN KEY (`thriftCycleId`) REFERENCES `ThriftCycle`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payrolls` ADD CONSTRAINT `Payrolls_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
