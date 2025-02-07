import { Project, SourceFile } from "ts-morph";

function readStdin(): Promise<string> {
  return new Promise((resolve, reject) => {
    let data = "";
    process.stdin.setEncoding("utf8");
    process.stdin.on("data", (chunk) => (data += chunk));
    process.stdin.on("end", () => resolve(data));
    process.stdin.on("error", reject);
  });
}

export async function processStdin(
  transform: (sourceFile: SourceFile) => Promise<void> | void,
) {
  const input = await readStdin();
  const project = new Project({ useInMemoryFileSystem: true });
  const sourceFile = project.createSourceFile("temp.ts", input);

  await transform(sourceFile);
  process.stdout.write(sourceFile.getFullText());
}
