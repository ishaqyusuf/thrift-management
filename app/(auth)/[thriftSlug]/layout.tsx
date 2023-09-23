"use client";
import { useSession } from "next-auth/react";
import { redirect } from "next/navigation";

export default function AuthLayout({ children }: any) {
  return (
    <div className="flex flex-col">
      <div className="h-12 border-b"></div>
      {children}
    </div>
  );
}
