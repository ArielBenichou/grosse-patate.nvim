import { type ConditionalExpression } from "ts-morph";

export function isConditionalExpression(
  node: any,
): node is ConditionalExpression {
  return node.getKindName() === "ConditionalExpression";
}
