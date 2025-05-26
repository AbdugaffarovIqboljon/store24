const fs = require('fs');
const path = require('path');

function buildTreeString(dirPath, indent = '') {
  let treeString = '';
  const items = fs.readdirSync(dirPath, { withFileTypes: true });

  items.forEach((item, index) => {
    const isLast = index === items.length - 1;
    const prefix = isLast ? '└── ' : '├── ';
    const itemPath = path.join(dirPath, item.name);

    treeString += indent + prefix + item.name + '\n';

    if (item.isDirectory()) {
      const newIndent = indent + (isLast ? '    ' : '│   ');
      treeString += buildTreeString(itemPath, newIndent);
    }
  });

  return treeString;
}

// Foydalanuvchi kiritgan path
const inputPath = process.argv[2]; // Misol: node tree-to-file.js ./test

if (!inputPath) {
  console.error('❗️ Iltimos, path kiriting. Misol: node tree-to-file.js ./test');
  process.exit(1);
}

const fullPath = path.resolve(inputPath);
const rootName = path.basename(fullPath);
let finalTree = rootName + '\n';
finalTree += buildTreeString(fullPath);

// Natijani faylga yozamiz
fs.writeFileSync('tree.txt', finalTree);

console.log('✅ tree.txt faylga yozildi!');