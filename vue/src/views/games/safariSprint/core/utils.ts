import {Lines} from "@/views/games/safariSprint/types/line";

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
