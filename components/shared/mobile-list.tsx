"use client";

import { cn } from "@/lib/utils";
import Link from "next/link";
import React from "react";

interface Props<T> {
  data: T[];
  primary?(data: T);
  secondary?(data: T);
  slotRight?(data: T);
  slotLeft?(data: T);
  text?(data: T);
  Item?(data: T);
  link?(data: T);
}
export default function MobileList<T>({
  data,
  primary,
  secondary,
  slotRight,
  slotLeft,
  text,
  Item,
  link,
}: Props<T>) {
  return (
    <ul className="">
      {data?.map((l, i) => {
        const _link = link ? link(l) : null;
        const Node = _link ? Link : React.createElement;
        const nodeProps: any = {};
        if (_link) nodeProps.href = _link;
        const pr = primary && primary(l);
        const sec = secondary && secondary(l);
        const txt = text && text(l);
        return (
          <li className="" key={i}>
            <Node
              {...nodeProps}
              className={cn("flex space-x-2 text-sm border-b py-2")}
            >
              <div id="mainData" className="flex flex-col space-y-2">
                {pr && <p className="font-semibold">{pr}</p>}
                {sec && <p className="text-muted-foreground">{sec}</p>}
                {txt && <p className="">{txt}</p>}
              </div>
            </Node>
          </li>
        );
      })}
    </ul>
  );
}
