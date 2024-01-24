import {Block} from "./block";

export enum LineType {
  Grass = "grass",
  Water = "water",
  Road = "road",
  Train = "train",
}

export const lineType = [
  LineType.Grass,
  LineType.Water,
  LineType.Road,
  LineType.Train
] as const;

type Line<T extends LineType> = {
  type: T;
  content: Block<T>[];
}

export type GrassLine = Line<LineType.Grass>
export type WaterLine = Line<LineType.Water>
export type RoadLine = Line<LineType.Road>
export type TrainLine = Line<LineType.Train>

export type Lines = GrassLine | WaterLine | RoadLine | TrainLine;
