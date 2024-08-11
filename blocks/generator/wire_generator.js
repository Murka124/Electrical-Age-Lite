const fs = require("fs");

const sides = {
  left: [0, 0.45, 0.45, 0.45, 0.1, 0.1],
  right: [0.55, 0.45, 0.45, 0.45, 0.1, 0.1],
  bottom: [0.45, 0, 0.45, 0.1, 0.45, 0.1],
  top: [0.45, 0.55, 0.45, 0.1, 0.45, 0.1],
  back: [0.45, 0.45, 0, 0.1, 0.1, 0.45],
  front: [0.45, 0.45, 0.55, 0.1, 0.1, 0.45],
  center: [0.42, 0.42, 0.42, 0.16, 0.16, 0.16]
};

/**
 * @param { string[] } texture texture name from textures/
 */
const generateStates = (textures) => {
  const generated = []; // Array<Array<string | number[]>>

  const _sides = structuredClone(Object.entries(sides));
  _sides.map((v) => v[1].push(...textures));

  // генерируем каждый вариант состояния блока
  for (let i = 0; i < Math.pow(2, 6); i++) {
    const currentState = []; // Array<boolean>
    for (let j = 0; j < 6; j++) {
      currentState[Number(j)] = (i & (1 << j)) > 0;
    }

    const state = currentState
      .map((bool, index) => bool && _sides[index])
      .filter((v) => !!v);

    generated.push(state);
  }
  return generated;
};

let blocknamesuka

/**
 *
 * @param {string} blockname
 * @param {string[] | undefined} data states
 */
const getBlockName = (blockname, data) =>
  blockname + (data ? "_" + data.join("_") : "") + ".json";

/**
 * @param {string} blockname
 * @param {[string, number[]][][]} generated from generateStates()
 */
const writeModels = function (modid, blockname, generated, textures) {
  const masterBlock = new wireTemplate();

  const center = structuredClone(sides.center);
  center.push(...textures);
  masterBlock["model-primitives"].aabbs = [center];

  const blockPath = `../${blockname}`;

  if (!fs.existsSync(blockPath)) fs.mkdirSync(blockPath, { recursive: true });
  fs.writeFileSync(
    `../${blockname}.json`,
    JSON.stringify(masterBlock, null, 2)
  );

  generated
    .filter((v) => v.length)
    .forEach(async (data) => {
      const block = new wireTemplate();
      block["model-primitives"].aabbs = data.map((v) => v[1]);

      const name = getBlockName(
        blockname,
        data.filter((v) => v[0]).map((v) => v[0])
      );
      block["picking-item"] = "electrical_age_lite:"+blockname;
      block["script-name"] = "wire_logic";
      // let block_material
      // if (blockname == "tin_wire") block_material = "tin"
      // if (blockname == "copper_wire") block_material = "copper"
      if (name == blockname) {
        name+="_center"
      } else {
        block["model-primitives"].aabbs.push([0.42, 0.42, 0.42, 0.16, 0.16, 0.16, blockname])
      }
      //console.log(blockPath)

      fs.writeFileSync(`../${name}`, JSON.stringify(block, null, 2));
    });
};

const wireTemplate = class {
  constructor() {
    this["light-passing"] = true;
    this.model = "custom";
    this["model-primitives"] = {
      aabbs: [
        [0.42, 0.42, 0.42, 0.16, 0.16, 0.16] // center
      ]
    };
    this.hidden = true;
    //this["picking-item"] = "electrical_age_lite:";
  }
};

module.exports = {
  sides,
  generateStates,
  getBlockName,
  writeModels,
  wireTemplate
};
