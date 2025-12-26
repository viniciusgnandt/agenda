import express from "express";

const app = express();
const PORT = 3000;

app.use(express.json());

app.get("/health", (req, res) => {
  res.json({
    status: "ok",
    service: "agenda-backend",
    time: new Date().toISOString()
  });
});

app.get("/hello", (req, res) => {
  res.send("Backend da agenda está funcionando 🚀");
});

app.listen(PORT, () => {
  console.log(`Backend rodando na porta ${PORT}`);
});
