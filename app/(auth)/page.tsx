import MobileList from "@/components/shared/mobile-list";
import { _getThriftCycles } from "../_actions/thrift-cycles";
import { ThriftCycle } from "@prisma/client";
import ThriftListShell from "@/components/shell/thrift-list-shell";

export default async function Home() {
  const cycles = await _getThriftCycles();
  return (
    <div className="px-4 flex flex-col justify-center h-screen">
      <p className="text-xl font-bold">Ad-Dinaar Thrift</p>
      <ThriftListShell data={cycles} />
    </div>
  );
}
