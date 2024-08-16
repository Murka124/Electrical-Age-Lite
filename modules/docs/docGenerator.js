const fs = require("fs");

const docs = fs.readdirSync("./").filter((f) => f.endsWith(".txt"));

const argumentReturnTable = {
  number: ["int", "number", "x", "y", "z"],
  boolean: ["bool"],
  string: ["string", "str"],
  table: [
    "vec3",
    "таблицастрок",
    "table",
    "tableornil",
    "array<int>",
    "tableилиnil",
    "vector",
    "vec2",
    "vec4",
    "matrix",
    "quat",
    "mat4"
  ]
};

const argumentReturnTableEntries = Object.entries(argumentReturnTable);
const getKey = (val) => {
  const key = argumentReturnTableEntries.find(([_k, v]) =>
    v.includes(val)
  )?.[0];
  if (!key) console.log("Ахтунг!", val);
  else console.log("Норма");

  return key ?? "any";
};

if (!fs.existsSync("./generated")) fs.mkdirSync("./generated");

docs.forEach((doc) => {
  const file = fs.readFileSync(doc).toString();
  const lines = file.split(/\n|\r/).filter((f) => !!f);

  const functions = parseLines(lines);

  functions.forEach((data) => {
    data.comments = data.comments.map((v) => "-" + v);
    parseArguments(data);
    parseReturn(data);
    data.function = `function ${data.function} return ${data.function} end`;
  });

  //console.log(functions);

  fs.writeFileSync(
    "./generated/" + doc + ".lua",
    functions.map((v) => v.comments.join("\n") + "\n" + v.function).join("\n\n")
  );
});

const packid = require("../../package.json").id;
fs.writeFileSync(
  "./mainTypesGenerated.lua",
  docs.map((v) => `require "${packid}:docs/generated/${v}.lua"`).join("\n")
);

console.log("Generated successfully!");

// UTILS

/**
 * @param {string[]} lines
 * @returns {{function:string,comments:string[]}[]} Functions
 */
function parseLines(lines) {
  const functions = [];

  let commentLines = [];
  let functionLines = [];
  lines.forEach((l, i, arr) => {
    if (l.startsWith("--")) {
      commentLines.push(l);
      return;
    } else if (
      (!arr[i + 1]?.startsWith("--") && arr[i + 1]) ||
      l.startsWith("}")
    ) {
      functionLines.push(l);
      return;
    }

    functions.push({
      function: functionLines.length ? functionLines.join("\n") : l,
      comments: commentLines
    });
    commentLines = [];
    functionLines = [];
  });

  return functions;
}

/**
 *
 * @param {string} str
 * @param {string} first
 * @param {string} second
 * @returns {{start: number, end: number}[]} Index of pair.
 */
function findPairIndex(str, first = "{", second = "}") {
  const pairIndex = [];
  for (let i = 0; i < str.length; i++) {
    if (str[i] === first) {
      let pairCount = 1;
      for (let j = i + 1; j < str.length; j++) {
        if (str[j] === first) {
          pairCount++;
        } else if (str[j] === second) {
          pairCount--;
          if (pairCount === 0) {
            pairIndex.push({ start: i, end: j });
            break;
          }
        }
      }
    }
  }
  return pairIndex;
}

/**
 * @param {{function: string, comments: string[]}} data
 */
function parseArguments(data) {
  const func = data.function;
  let args = func.split(/\s/).join("").split(/\(|\)/)[1];
  args.replace(/\{[A-Za-z0-9\s]+\}/g, "table");
  while (args?.includes("{")) {
    const pair = findPairIndex(args).shift();
    args =
      args.substring(0, pair.start) + "table" + args.substring(pair.end + 1);
  }

  if (!args) return;

  args = args
    .split(",")
    .map((arg) => arg.split(":"))
    .map((arg) => (arg[1] ? arg : [arg[0], arg[0]]));

  data.function =
    data.function.substring(0, data.function.indexOf("(") + 1) +
    args.map((v) => v[0]).join(",") +
    data.function.substring(data.function.indexOf(")"));
  console.log(data.function, args);
  data.comments.push(...args.map((v) => `---@param ${v[0]} ${getKey(v[1])}`));
}

/**
 * @param {{function: string, comments: string[]}} data
 */
function parseReturn(data) {
  const func = data.function;
  const splitval = func.split("->");

  data.function = splitval[0].replace(/\s/g, "");
  let retval = splitval[1];

  if (!retval) return;

  while (retval?.startsWith(" ")) retval = retval.substring(1);

  if (retval?.includes("{")) retval = "table";

  console.log(retval);
  if (retval.includes(",")) {
    retval =
      "{" +
      retval
        .split(/\s/)
        .join("")
        .split(",")
        .map((v, i) => `[${i + 1}]:` + (getKey(v) ?? "any"))
        .join(",") +
      "}";
  } else retval = getKey(retval.replace(/\s/g, ""));

  data.comments.push("---@return " + retval);
}
