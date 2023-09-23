"use client";
import { useSession } from "next-auth/react";
import { redirect } from "next/navigation";

export default function AuthLayout({ children }: any) {
  // const { data: session } = useSession({
  //   required: true,
  //   onUnauthenticated() {
  //     redirect("/signin");
  //   },
  // });
  // if (!session?.user) return <></>;
  return <>{children}</>;
}
