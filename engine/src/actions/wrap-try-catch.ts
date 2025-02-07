import { SourceFile } from "ts-morph";
import { processStdin } from "../utils/std";

export function wrapLinesWithTryCatch(sourceFile: SourceFile): void {
  const statements = sourceFile.getStatements();
  const statementsText = statements.map((stmt) => stmt.getText());

  statements.forEach((stmt) => stmt.remove());

  sourceFile.addStatements((writer) => {
    writer.write("try {").newLine();
    statementsText.forEach((stmt) => {
      writer.write(stmt).newLine();
    });
    writer.write("} catch (error) {").newLine();
    writer.write("    console.log(error);").newLine();
    writer.write("}");
  });
}

if (require.main === module) {
  processStdin(wrapLinesWithTryCatch);
}
