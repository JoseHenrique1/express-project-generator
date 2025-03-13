# 🚀 Express Project Generator  

Scripts Bash para automatizar a criação de projetos e módulos no **Express** com **TypeScript** e **Prisma**.  

### 📌 Requisitos  
- **Node.js** instalado  
- **npm** ou **yarn** instalado  
- **chmod** configurado para executar os scripts  


## 🛠️ Instalação e Uso  

### 1️⃣ **Criando um novo projeto Express**  

O primeiro script (`create-project.sh`) gera a estrutura básica de um projeto **Express + TypeScript** e instala todas as dependências necessárias.  

#### 🔹 **Passo 1: Dar permissão ao script**  
Antes de rodar o script, conceda permissão de execução:  

```bash
chmod +x ./create-project.sh
```

#### 🔹 **Passo 2: Criar o projeto**  
Para criar um novo projeto, rode o comando:  

```bash
./create-project.sh nome-do-projeto
```

Isso criará a seguinte estrutura de diretórios e arquivos:  
- `src/` (código-fonte)  
  - `index.ts` (arquivo principal do servidor)  
  - `modules/` (módulos da aplicação)  
  - `database/` (configuração do Prisma)  
  - `@types/` (tipos personalizados)  
- `package.json` (configuração do projeto)  
- `prisma/` (configuração do banco de dados SQLite)  
- `.gitignore` (arquivos ignorados pelo Git)  


### 2️⃣ **Criando um novo módulo**  

O segundo script (`create-module.sh`) permite adicionar módulos automaticamente, seguindo a arquitetura **Controller - Service - Route**.  

#### 🔹 **Passo 1: Dar permissão ao script**  
Antes de rodar o script, conceda permissão de execução:  

```bash
chmod +x ./create-module.sh
```

#### 🔹 **Passo 2: Criar um módulo**  
Para adicionar um novo módulo, execute:  

```bash
./create-module.sh nome-do-modulo
```

Isso criará a seguinte estrutura dentro de `src/modules/`:  
- `nome-do-modulo/`  
  - `nome-do-modulo.controller.ts` (controlador)  
  - `nome-do-modulo.service.ts` (serviço)  
  - `nome-do-modulo.route.ts` (rotas)  
  - `nome-do-modulo.types.ts` (tipos personalizados)  

Além disso, o módulo será automaticamente importado e registrado no roteador principal (`src/modules/index.ts`).  



## 📜 Licença  
Este projeto está sob a licença **MIT**. Sinta-se à vontade para usar e modificar! 🚀  

Se tiver sugestões ou melhorias, contribua com um **pull request**. 😉