const wire_generator = require("./wire_generator");

const modid = require("../../package.json").id;
//const modid = "electrical_age_lite"

const generators = [];
const generate = () => generators.forEach((v) => v.build());

class Generator {
  constructor(blockname, textures) {
    this.blockname = blockname;
    this.textures = textures;

    generators.push(this);
  }

  build() {
    const states = wire_generator.generateStates(this.textures);
    wire_generator.writeModels(modid, this.blockname, states, this.textures);
    console.log(this.blockname, "wires generated");
  }
}

new Generator("wire_tin", ["wire_tin"]);
new Generator("wire_copper", ["wire_copper"]);

generate();
