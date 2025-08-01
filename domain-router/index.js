const express = require("express");
const app = express();
const path = require("path");
const fs = require("fs");

app.get("/", (req, res) => {
  const domain = req.headers.host;
  console.log(req.headers.host);
  switch (domain) {
    case "gruparge.com":
      return res.redirect(301, "https://www.gruparge.com");
      break;
    default:
      break;
  }

  res.send("Hoş geldiniz!");
});

app.get("/get.php", (req, res) => {
  const { pack } = req.query;
  if (!pack) {
    return res.status(400).send("Eksik parametre!");
  }
  // Dosya yolu
  const filePath = path.join(__dirname, "meta.gruparge.com", "pack", `${pack}.pack`);
  // Dosya var mı kontrol et
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
      return res.status(404).send("Dosya bulunamadı!");
    }
    res.download(filePath, `${pack}.pack`);
  });
});

app.get("/:p1/:p2", (req, res) => {
  const { p1, p2 } = req.params;
  let address = `https://www.gruparge.com/${p1}/${p2}/`;
  res.redirect(301, address);
});

app.get("/:p3", (req, res) => {
  const { p3 } = req.params;
  let address = `https://www.gruparge.com/${p3}`;
  res.redirect(301, address);
});

app.listen(80, () => {
  console.log("Uygulama http://localhost:80 adresinde çalışıyor!");
});
