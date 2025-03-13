#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 <nome_do_projeto>"
  exit 1
fi

# Diretórios e arquivos do projeto
PROJECT_DIR="./src"
MODULES_DIR="$PROJECT_DIR/modules"
DB_DIR="$PROJECT_DIR/database"
TYPES_DIR="$PROJECT_DIR/@types"


mkdir -p "$PROJECT_DIR"
mkdir -p "$MODULES_DIR"
mkdir -p "$DB_DIR"
mkdir -p "$TYPES_DIR"


touch "$PROJECT_DIR/index.ts"
touch "$DB_DIR/prisma.ts"
touch "$TYPES_DIR/express.d.ts"
touch "$MODULES_DIR/index.ts"


cat > package.json <<EOL
{
  "name": "$1",
  "version": "1.0.0",
  "description": "",
  "license": "ISC",
  "author": "José Henrique",
  "type": "module",
  "main": "index.js",
  "scripts": {
    "dev": "npx tsx watch src/index.ts",
    "build": "npx tsc"
  }
}
EOL

cat > "$PROJECT_DIR/index.ts" <<EOL
import express from "express";
import "express-async-errors";
import { router } from "./modules/index.ts";

const app = express();

app.use(express.json());

app.use("/", router);

app.listen(3333, () => console.log("Server is running on port 3333"));
EOL

cat > "$MODULES_DIR/index.ts" <<EOL
import { Router } from "express";

export const router = Router();
EOL

DEPENDENCIES=(
  "cors"
  "express"
  "express-async-errors"
)

DEV_DEPENDENCIES=(
  "@biomejs/biome"
  "@types/express"
  "@types/node"
  "tsx"
  "typescript"
  "prisma"
)

for package in "${DEPENDENCIES[@]}"; do
  echo "Instalando $package ..."
  npm install "$package"
done

for package in "${DEV_DEPENDENCIES[@]}"; do
  echo "Instalando $package para desenvolvimento..."
  npm install "$package" -D
  echo ""
done

echo "Iniciando configuração do typescript..."
npx tsc --init --target es2022 --module nodenext --moduleResolution nodenext --lib es2022 --rootDir src --outDir dist --resolveJsonModule true --strict true --allowImportingTsExtensions true --noEmit true

echo "Iniciando configuração do prisma com sqlite..."
npx prisma init --datasource-provider sqlite

npx @biomejs/biome init

cat > .gitignore <<EOL
/node_modules
.env
/prisma/dev.db
/prisma/dev-journal.db
create_module.sh
create_project.sh
EOL

echo "Estrutura do projeto criada com sucesso!"
echo "Dependências instaladas com sucesso!"
