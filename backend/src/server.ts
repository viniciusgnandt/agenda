import express from "express";

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get("/hello", (req, res) => {
  res.send("Backend da agenda está funcionando 2.0 🚀");
});