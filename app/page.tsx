import dayjs from "dayjs";
import { users } from "./data/users";

export default function Home() {
  const ls = users.sort((a, b) => a.position - b.position);

  return (
    <div className="px-4 flex flex-col justify-center h-screen">
      <p className="text-xl font-bold">Ad-Dinaar Thrift </p>
      <span></span>
      {ls.map((user) => (
        <p key={user.name}>
          {user.position}. {user.name}
        </p>
      ))}
    </div>
  );
}
