import express from "express";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;

app.use(express.json());


app.get("/health", (req, res) => {
  res.json({
    status: "ok",
    service: "agenda-backend",
    time: new Date().toISOString()
  });
});

app.get("/hello", (req, res) => {
  res.send("Backend da agenda está funcionando 4.0 🚀");
});

app.get("/vinicius", (req, res) => {
  res.send("Vinicius é o melhor dev!");
});

const server = app.listen(PORT, () => {
  console.log(`✅ Backend rodando na porta ${PORT}`);
});

// Tratamento de erros
process.on("uncaughtException", (error) => {
  console.error("❌ Erro não tratado:", error);
  process.exit(1);
});

process.on("unhandledRejection", (reason) => {
  console.error("❌ Promise rejeitada:", reason);
  process.exit(1);
});

// Graceful shutdown
process.on("SIGTERM", () => {
  console.log("🛑 SIGTERM recebido, encerrando servidor...");
  server.close(() => {
    console.log("✅ Servidor encerrado");
    process.exit(0);
  });
});