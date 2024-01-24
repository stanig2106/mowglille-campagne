import {LineType} from "./line";

export type Block<T extends LineType> = {
  consoleString: string;
}

// trees, rocks and bushes
export type GrassBlock = Block<LineType.Grass>
export type RockBlock = Block<LineType.Grass>

// log and kayak (the middle of the kayak is an obstacle)
export type WaterBlock = Block<LineType.Water>
export type LogBlock = Block<LineType.Water>
export type KayakBlock = Block<LineType.Water>

// Jeep's, tourist safari buses and ambulances
export type RoadBlock = Block<LineType.Road>
export type CarBlock = Block<LineType.Road>
export type TruckBlock = Block<LineType.Road>
export type PoliceBlock = Block<LineType.Road>

// herd of elephants
export type RailBlock = Block<LineType.Train>
export type TrainBlock = Block<LineType.Train>
