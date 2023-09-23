"use client";

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
