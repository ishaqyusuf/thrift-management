"use client";
import { useSession } from "next-auth/react";
import { redirect } from "next/navigation";

export default function AuthLayout({ children }: any) {
  return <>{children}</>;
}
