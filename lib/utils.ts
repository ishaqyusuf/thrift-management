import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"
 
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
export function undot(items) {
  if (Array.isArray(items)) {
    return items;
  }

  let collection = {};

  Object.keys(items).forEach((key) => {
    if (key.indexOf('.') !== -1) {
      const obj = collection;

      key.split('.').reduce((acc, current, index, array) => {
        if (!acc[current]) {
          acc[current] = {};
        }

        if ((index === array.length - 1)) {
          acc[current] = items[key];
        }

        return acc[current];
      }, obj);

      collection = { ...collection, ...obj };
    } else {
      collection[key] = items[key];
    }
  });

  return collection
};
export function generateRandomString(length) {
  const charset =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let randomString = "";

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * charset.length);
    randomString += charset.charAt(randomIndex);
  }

  return randomString;
}