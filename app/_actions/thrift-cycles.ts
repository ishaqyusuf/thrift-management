"use server";

import { prisma } from "@/db";

export async function _getThriftCycles() {
  return await prisma.thriftCycle.findMany({
    orderBy: {
      id: "desc",
    },
  });
}
