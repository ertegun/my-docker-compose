const express = require("express");
const app = express();

app.get("/", (req, res) => {
  const domain = req.headers.host;
  console.log(req.headers);
  if (domain === "gruparge.com") {
    return res.redirect(301, "https://www.gruparge.com");
  }
  res.send("Hoş geldiniz!");
});

app.listen(80, () => {
  console.log("Uygulama http://localhost:80 adresinde çalışıyor!");
});
