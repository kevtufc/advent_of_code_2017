const fs = require('fs')

let max_value = 0

function getInstructions(file, callback) {
  fs.readFile(file, 'utf8', (err,data) => {
    if(err) throw err;
    let lines = data.split("\n");
    callback(lines);
  });
}

function createRegisters(instructions, callback) {
  var regs = new Map();
  for(let ins of instructions) {
    let reg = ins.split(" ",1)[0];
    regs.set(reg, 0);
  };
  callback(regs);
}

function compare(a, cmp, b){
  switch(cmp){
    case "==": return a == b;
    case "!=": return a != b;
    case "<=": return a <= b;
    case ">=": return a >= b;
    case ">" : return a >  b;
    case "<" : return a <  b;
  }
};

function processInstructions(instructions, regs, callback) {
  for(let ins of instructions) {
    let [reg, dir, x, _if, reg2, cmp, v] = ins.split(" ");
    let reg2_value = regs.get(reg2);
    [x, v] = [parseInt(x, 10), parseInt(v, 10)];
    if(compare(reg2_value, cmp, v)){
      let m = dir == 'inc' ? 1 : -1
      let new_value = regs.get(reg) + (x * m);
      regs.set(reg, new_value);
      if(new_value > max_value) {
        max_value = new_value;
      }
    }
  }
  callback(regs);
}

getInstructions('input.txt', (ins) => { 
  createRegisters(ins, (regs) => {
    processInstructions(ins, regs, (regs) => {
      console.log(regs);
      console.log("Part One: " + Math.max(...Array.from(regs.values())));
      console.log("Part Two: " + max_value)
    });  
  }); 
});