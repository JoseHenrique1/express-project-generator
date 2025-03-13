#!/bin/bash

# Verifica se um nome de módulo foi passado como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <nome_do_modulo>"
  exit 1
fi

# Define o diretório base dos módulos
MODULES_DIR="./src/modules"
MODULE_NAME="$1"
MODULE_CAPITALIZED="$(tr '[:lower:]' '[:upper:]' <<< ${MODULE_NAME:0:1})${MODULE_NAME:1}"
MODULE_PATH="$MODULES_DIR/$MODULE_NAME"
INDEX_FILE="$MODULES_DIR/index.ts"

# Cria a estrutura de diretórios
mkdir -p "$MODULE_PATH"

# Cria e preenche o arquivo controller
cat <<EOL > "$MODULE_PATH/$MODULE_NAME.controller.ts"
import { RequestHandler } from "express";
import { service$MODULE_CAPITALIZED } from "./$MODULE_NAME.service.ts";

const get${MODULE_CAPITALIZED}s: RequestHandler = (req, res) => {
  res.status(200).json([]);
  return;
};

const get${MODULE_CAPITALIZED}: RequestHandler = (req, res) => {
  res.status(200).json({});
  return;
};

const post${MODULE_CAPITALIZED}: RequestHandler = (req, res) => {
  res.status(201).json({});
  return;
};

const put${MODULE_CAPITALIZED}: RequestHandler = (req, res) => {
  res.status(200).json({});
  return;
};

const delete${MODULE_CAPITALIZED}: RequestHandler = (req, res) => {
  res.status(200).json({});
  return;
};

export const controller$MODULE_CAPITALIZED = {
  get${MODULE_CAPITALIZED}s,
  get${MODULE_CAPITALIZED},
  post${MODULE_CAPITALIZED},
  put${MODULE_CAPITALIZED},
  delete${MODULE_CAPITALIZED},
};
EOL

cat <<EOL > "$MODULE_PATH/$MODULE_NAME.route.ts"
import { Router } from "express";
import { controller$MODULE_CAPITALIZED } from "./$MODULE_NAME.controller.ts";

export const router$MODULE_CAPITALIZED = Router();

router$MODULE_CAPITALIZED.get("/", controller$MODULE_CAPITALIZED.get${MODULE_CAPITALIZED}s);
router$MODULE_CAPITALIZED.get("/:id", controller$MODULE_CAPITALIZED.get${MODULE_CAPITALIZED});
router$MODULE_CAPITALIZED.post("/", controller$MODULE_CAPITALIZED.post${MODULE_CAPITALIZED});
router$MODULE_CAPITALIZED.put("/:id", controller$MODULE_CAPITALIZED.put${MODULE_CAPITALIZED});
router$MODULE_CAPITALIZED.delete("/:id", controller$MODULE_CAPITALIZED.delete${MODULE_CAPITALIZED});
EOL

cat <<EOL > "$MODULE_PATH/$MODULE_NAME.service.ts"
const get${MODULE_CAPITALIZED}s = () => {
  return [];
};

const get${MODULE_CAPITALIZED} = (id: string) => {
  return {};
};

const post${MODULE_CAPITALIZED} = () => {
  return {};
};

const put${MODULE_CAPITALIZED} = (id: string, data: {}) => {
  return {};
};

const delete${MODULE_CAPITALIZED} = (id: string) => {
  return {};
};

export const service$MODULE_CAPITALIZED = {
  get${MODULE_CAPITALIZED}s,
  get${MODULE_CAPITALIZED},
  post${MODULE_CAPITALIZED},
  put${MODULE_CAPITALIZED},
  delete${MODULE_CAPITALIZED},
};
EOL

touch "$MODULE_PATH/$MODULE_NAME.types.ts"

if ! grep -q "router$MODULE_CAPITALIZED" "$INDEX_FILE"; then
  echo "import { router$MODULE_CAPITALIZED } from \"./$MODULE_NAME/$MODULE_NAME.route.ts\";" >> "$INDEX_FILE"
  echo "router.use(\"/$MODULE_NAME\", router$MODULE_CAPITALIZED);" >> "$INDEX_FILE"
fi

echo "Módulo '$MODULE_NAME' criado em '$MODULE_PATH' com sucesso e adicionado ao roteador principal!"