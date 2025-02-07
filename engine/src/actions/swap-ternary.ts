import { type SourceFile } from "ts-morph";
import { isConditionalExpression } from "../types/ast";
import { processStdin } from "../utils/std";

export function swapConditionalBranches(sourceFile: SourceFile): void {
  sourceFile.forEachDescendant((node) => {
    if (isConditionalExpression(node)) {
      const whenTrue = node.getWhenTrue().getText();
      const whenFalse = node.getWhenFalse().getText();

      node.getWhenTrue().replaceWithText(whenFalse);
      node.getWhenFalse().replaceWithText(whenTrue);
    }
  });
}

if (require.main === module) {
  processStdin(swapConditionalBranches);
}
