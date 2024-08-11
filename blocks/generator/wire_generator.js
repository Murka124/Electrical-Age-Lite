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
 * @param { string[] } textures texture names from textures/
 */
const generateStates = (textures) => {
  const generated = []; // Array<Array<string | number[]>>

  const _sides = structuredClone(Object.entries(sides));

  // генерируем каждый вариант состояния блока
  for (let i = 0; i < Math.pow(2, 6); i++) {
    const currentState = []; // Array<boolean>
    for (let j = 0; j < 6; j++) {
      currentState[Number(j)] = (i & (1 << j)) > 0;
    }
    // Ебанина выше генерирует массив из 6 булевых переменных

    const state = currentState
      .map(
        (bool, index) =>
          bool && [_sides[index][0], [..._sides[index][1], ...textures]]
      )
      .filter((v) => !!v);
    state.push(["center", [...sides.center, ...textures]]); // До кучи в конец кидаем центр, потому что везде сука должен быть центр.
    // Эта штука преобразует булевый массив в массив из сторон

    generated.push(state);
    // И мы потом просто выкидываем стейт в выходной массив
  }
  return generated;
};

/**
 * @param {string} blockname
 * @param {[string, number[]][][]} generated from generateStates()
 */
const writeModels = function (modid, blockname, generated) {
  const blockPath = `../${blockname}`;

  if (!fs.existsSync(blockPath)) fs.mkdirSync(blockPath, { recursive: true });

  generated.forEach(async (data) => {
    const block = new wireTemplate(modid + ":" + blockname);
    block["model-primitives"].aabbs = data.map((v) => v[1]);

    const sideData = data.filter((v) => v[0]).map((v) => v[0]);
    const name =
      blockname + (sideData ? "_" + sideData.join("_") : "") + ".json";

    block["model-primitives"].aabbs.push([...sides.center, blockname]);

    fs.writeFileSync(`../${name}`, JSON.stringify(block, null, 2));
  });
};

const wireTemplate = class {
  /** @param {string} picking blockId */
  constructor(picking) {
    this["light-passing"] = true;
    this.model = "custom";
    this["model-primitives"] = {
      aabbs: []
    };

    this.hidden = true;
    this["picking-item"] = picking;

    this["script-name"] = "wire_logic";
  }
};

module.exports = {
  sides,
  generateStates,
  writeModels,
  wireTemplate
};
