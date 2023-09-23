"use server";

import collect from "collect.js";
import { users as userLs } from "../data/users";
import { generateRandomString, undot } from "@/lib/utils";
import { IUser } from "../types/users";
import { prisma } from "@/db";
import { Prisma, Users } from "@prisma/client";
import dayjs from "dayjs";

export async function initialize() {
  const userList: (IUser & {
    amount;
    position;
    Timestamp;
  })[] = userLs.map((user) => undot(user)) as any;

  const startMonth = dayjs()
    .set("months", 5)
    .startOf("month");
  const endMonth = dayjs()
    .set("months", 11)
    .endOf("month");
  let addMonth = 0;
  let _months: string[] = [];
  while (true) {
    const nm = startMonth.add(addMonth, "months");
    const diff = endMonth.diff(nm, "month");
    if (diff >= 0) {
      addMonth++;
      _months.push(nm.format("MMM YYYY"));
    }
    if (diff == 0) break;
  }
  const cycle = await prisma.thriftCycle.create({
    data: {
      title: "JUL-DEC 2023",
      slug: "jul-dec-2023",
      createdAt: new Date(),
      updatedAt: new Date(),
      startDate: startMonth.toISOString(),
      endDate: endMonth.toISOString(),
      MonthWallet: {
        createMany: {
          data: _months.map((title) => ({
            title,
            createdAt: new Date(),
            updatedAt: new Date(),
          })),
        },
      },
    },
    include: {
      MonthWallet: true,
    },
  });
  const users: (Users & { amount })[] = [];
  await Promise.all(
    userList.map(async (ls) => {
      let { amount, position, Timestamp, ...userData } = ls;
      amount = Number(amount.replace(",", ""));
      const user = await prisma.users.create({
        data: {
          ...userData,
          uniqueId: generateRandomString(6).toUpperCase(),
          createdAt: new Date(),
          updatedAt: new Date(),
          Participants: {
            create: {
              amount,
              Cycle: {
                connect: {
                  id: cycle.id,
                },
              },
            },
          },
          Payrolls: {
            create: {
              position: position,
              ThriftCycle: {
                connect: {
                  id: cycle.id,
                },
              },
            },
          },
        },
      });
      users.push({ ...user, amount });
    })
  );
  await Promise.all(
    cycle.MonthWallet.map(async (mw) => {
      await prisma.monthWallets.update({
        where: {
          id: mw.id,
        },
        data: {
          Payments: {
            createMany: {
              data: users.map((user) => ({
                payable: user.amount,
                thriftCycleId: cycle.id,
                userId: user.id,
                createdAt: new Date(),
                updatedAt: new Date(),
              })),
            },
          },
        },
      });
    })
  );
}
