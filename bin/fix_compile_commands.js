#!/usr/bin/env node
const fs = require('fs')
const file = process.argv[2] || `${process.cwd()}/compile_commands.json`
const data = require(file)

// FIXME: effeciency
const REPLACES = [
  {
    find: /((?:[^ ]+\\ )+[^ ]+)/g,
    replace: [{ re: /\\ /g, target: ' '  }, { re: /^/, target: '"' }, { re: /$/, target: '"' }]
  }
]

function replaceProp (item, propName) {
  // const before = item[propName]
  // let didReplaced = false
  for (const { find, replace } of REPLACES) {
    const matches = item[propName].match(find)
    if (!matches) {
      continue
    }
    didReplaced = true
    for (const mm of matches) {
      const mmm = replace.reduce((res, it) => res.replace(it.re, it.target), mm)
      // FIXME: effeciency robust
      item[propName] = item[propName].replace(mm, mmm)
    }
  }
  // if (didReplaced) {
  //   console.log('before: ', before)
  //   console.log('after: ', item[propName])
  // }
}

for (const item of data) {
  replaceProp(item, 'file');
  replaceProp(item, 'command');
}

fs.writeFileSync(file, JSON.stringify(data))
