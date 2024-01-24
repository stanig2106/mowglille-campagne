import {
  CarBlock,
  GrassBlock,
  KayakBlock,
  LogBlock, PoliceBlock,
  RailBlock,
  RoadBlock,
  RockBlock,
  TrainBlock,
  TruckBlock,
  WaterBlock
} from "@/views/games/safariSprint/types/block";

// Grasses
export const grassBlock: GrassBlock = {
  consoleString: "_"
}
export const grasses = [grassBlock] as const

export const rockBlock: RockBlock = {
  consoleString: "🪨"
}
export const treeBlock: RockBlock = {
  consoleString: "🌳"
}
export const bushBlock: RockBlock = {
  consoleString: "🌿"
}
export const rocks = [rockBlock, treeBlock, bushBlock] as const


// Road
export const roadBlock: RoadBlock = {
  consoleString: "_"
}
export const roads = [roadBlock] as const

export const jeepBlock: CarBlock = {
  consoleString: "🚙"
}
export const touristSafariBusBlock: TruckBlock = {
  consoleString: "🚌"
}
export const ambulanceBlock: PoliceBlock = {
  consoleString: "🚑"
}
export const cars = [jeepBlock] as const
export const trucks = [touristSafariBusBlock] as const
export const police = [ambulanceBlock] as const


// Water
export const waterBlock: WaterBlock = {
  consoleString: "🌊"
}
export const waters = [waterBlock] as const

export const logBlock: LogBlock = {
  consoleString: "🪵"
}
export const logs = [logBlock] as const

export const kayakBlock: KayakBlock = {
  consoleString: "🛶"
}
export const kayaks = [kayakBlock] as const


// Rail
export const railBlock: RailBlock = {
  consoleString: "_"
}
export const rails = [railBlock] as const

export const elephantsHerdBlock: TrainBlock = {
  consoleString: "🐘"
}
export const trains = [elephantsHerdBlock] as const

export const blocks = [
  ...grasses,
  ...rocks,

  ...roads,
  ...cars,
  ...trucks,
  ...police,

  ...waters,
  ...logs,
  ...kayaks,

  ...rails,
  ...trains
] as const

export type Blocks = typeof blocks[number]




