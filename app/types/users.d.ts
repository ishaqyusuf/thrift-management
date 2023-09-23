import { Users } from "@prisma/client";

export interface IUser extends Omit<Users, "meta"> {
  meta: {
    nextOfKin: {
      name;
      occupation;
      phone;
      address;
      officeAddress;
    };
    bankName;
    accountNo;
    bvn;
    referal;
  };
}
