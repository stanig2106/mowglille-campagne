import {Lines, LineType, lineType} from "../types/line"
import {Block} from "../types/block"
import {cars, grasses, kayaks, logs, police, rails, roads, rocks, trains, trucks, waters} from "@/views/games/safariSprint/core/blocks";
import {controlledRandomArrayElement, randomArrayElement} from "@/views/games/safariSprint/core/utils";
import {CONSTANTES} from "@/views/games/safariSprint/core/constante";

function getRandomContent<T extends LineType>(type: T, previousBlocks: Block<T>[]): Block<T>[] {
  switch (type) {
    case LineType.Grass:
      return [...previousBlocks, randomArrayElement([...grasses, ...rocks])];
    case LineType.Water:
      return [...previousBlocks, randomArrayElement([...waters, ...logs, ...kayaks])]
    case LineType.Road:
      return [...previousBlocks, controlledRandomArrayElement([
        {array: roads, odd: 1},
        {array: cars, odd: 0.28},
        {array: trucks, odd: 0.2},
        {array: police, odd: 0.02},
      ])]
    case LineType.Train:
      // already a train at the end of the line
      if (trains.some(t => previousBlocks[previousBlocks.length - 1] === t))
        return [...previousBlocks, randomArrayElement(rails)]
      return [...previousBlocks, randomArrayElement([...rails, ...trains])]
    default:
      throw new Error(`Unknown line type: ${type}`);
  }
}

export default function generate(previousLine: Lines | null): Lines {
  const type = controlledRandomArrayElement([
    {array: [LineType.Grass], odd: 5},
    {array: [LineType.Water], odd: 3},
    {array: [LineType.Road], odd: 4},
    {array: [LineType.Train], odd: 3},
  ]);
  let content: Block<LineType>[] = []
  for (let i = 0; i < CONSTANTES.width; i++)
    content = getRandomContent(type, content)
  return {type, content};
}
