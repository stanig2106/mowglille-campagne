import {Lines} from "@/views/games/safariSprint/types/line";
import {MaybeRefOrGetter, toValue} from "vue";

export function randomArrayElement<T>(array: readonly T[] | T[]): T {
  return array[Math.floor(Math.random() * array.length)];
}

export function controlledRandomArrayElement<T>(arrays: { array: readonly T[] | T[], odd: number }[]): T {
  const total = arrays.reduce((acc, {odd}) => acc + odd, 0);
  const random = Math.random() * total;
  let current = 0;
  for (const {array, odd} of arrays) {
    current += odd;
    if (random < current)
      return randomArrayElement(array);
  }
  throw new Error("This should not happen");
}

export function lineToS(line: Lines): string {
  return line.content.map(block => block.consoleString).join("") + "/" + line.type;
}

export function dateToS(date: MaybeRefOrGetter<Date>, type: "Full" | "Date" | "Hours" = "Full"): string {
  const d = toValue(date);
  if (type === "Full")
    return `${dateToS(d, "Date")}, ${dateToS(d, "Hours")}`
  if (type === "Date")
    return d.toLocaleDateString("fr").slice(0, -5)
  if (type === "Hours")
    return d.toLocaleTimeString("fr").slice(0, -3)
  throw new Error("Invalid type");
}
