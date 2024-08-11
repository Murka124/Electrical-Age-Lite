const wire_generator = require("./wire_generator");

const modid = require("../../package.json").id;
const constants = require("../../modules/constants.json");

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

const wires = Object.keys(constants.wires);
const materials = constants.wire_materials;
wires.forEach((name, index) => {
  new Generator("wire_" + name, ["wire_" + materials[index]]); // name = "copper", then "wire_"+name; material = "copper", then "wire_"+material
});

generate();
