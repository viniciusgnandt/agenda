import { Request, Response } from "express";
import { services } from "../data/services.mock";

export function listServices(req: Request, res: Response) {
  return res.json(services);
}