#!/usr/bin/env node
const { Project } = require("ts-morph");

// Read input from stdin
let input = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
  // Create an in-memory project and source file
  const project = new Project({ useInMemoryFileSystem: true });
  const sourceFile = project.createSourceFile("temp.ts", input);
  
  // Traverse the AST to find conditional (ternary) expressions
  sourceFile.forEachDescendant(node => {
    if (node.getKindName() === "ConditionalExpression") {
      const condition = node.getCondition().getText();
      const whenTrue = node.getWhenTrue().getText();
      const whenFalse = node.getWhenFalse().getText();
      
      // Swap the branches: set whenTrue to whenFalse and vice versa
      node.getWhenTrue().replaceWithText(whenFalse);
      node.getWhenFalse().replaceWithText(whenTrue);
    }
  });
  
  // Output the refactored code
  process.stdout.write(sourceFile.getFullText());
});
