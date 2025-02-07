import { Project, SourceFile } from "ts-morph";
import prettier from "prettier";

function readStdin(): Promise<string> {
  return new Promise((resolve, reject) => {
    let data = "";
    process.stdin.setEncoding("utf8");
    process.stdin.on("data", (chunk) => (data += chunk));
    process.stdin.on("end", () => resolve(data));
    process.stdin.on("error", reject);
  });
}

function addIndent(input: string, text: string) {
  const indent = input.match(/^\s*/)?.[0] || "";
  return text
    .split("\n")
    .map((line) => (line ? indent + line : ""))
    .join("\n");
}

function addFormatting(text: string) {
  return prettier.format(text, { parser: "typescript" });
}

export async function processStdin(
  transform: (sourceFile: SourceFile) => Promise<void> | void,
) {
  const input = await readStdin();
  const project = new Project({ useInMemoryFileSystem: true });

  const sourceFile = project.createSourceFile("temp.ts", input);

  await transform(sourceFile);
  let text = sourceFile.getFullText();

  text = await addFormatting(text);
  text = addIndent(input, text);

  process.stdout.write(text);
}
