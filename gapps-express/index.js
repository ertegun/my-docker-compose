const express = require("express");
const path = require("path");
const fs = require("fs");

const app = express();
const port = 6499;
require("dotenv").config();
var Datastore = require("nedb"),
  db = new Datastore();
const cheerio = require("cheerio");
// Klasör yolunu belirleyin
const klasorYolu = path.join(__dirname, process.env.SOURCE_PATH);
console.log(klasorYolu);

app.get("/", (req, res) => {
  console.log("request root");
  fs.readdir(klasorYolu, (err, dosyalar) => {
    console.log("request file list");

    if (err) {
      console.error(err);
      return res.status(500).send("software klasörü okunamadı.");
    }

    dosyalar.forEach((value, index) => {
      const fullPath = path.join(klasorYolu, value);
      fs.stat(fullPath, (err, stats) => {
        if (err) {
          console.error("Hata:", err);
          return;
        }
        let fileOrDir = "";
        db.ensureIndex({ fieldName: "file", unique: true }, function (err) {});
        if (stats.isFile()) {
          fileOrDir = "file";
        } else if (stats.isDirectory()) {
          fileOrDir = "publish.htm";
        }
        if (value != "software") {
          db.insert([{ file: value, fileOrDir: fileOrDir }], function (err, newDocs) {});
        }
      });
    });
    res.redirect("/software");
  });
});

app.get("/software", (req, res) => {
  db.find({})
    .sort({ file: 1 })
    .exec(function (err, docs) {
      if (docs.length == 0) {
        console.log("veri sıfırlanmış.");
        res.redirect("/");
      } else {
        res.send(`
        <ul>
          ${docs.map((e) => `<li><h4><a href="/software/${e.file}/${e.fileOrDir}" target="_blank">${e.file}</h4></li></a>`).join("")}
        </ul>
      `);
      }
    });
});

app.get("/software/:dosyaAdi/file", (req, res) => {
  const dosyaAdi = req.params.dosyaAdi;
  const dosyaYolu = path.join(klasorYolu, dosyaAdi);
  console.log(`${dosyaAdi} indirildi.`);
  res.download(dosyaYolu, dosyaAdi, (err) => {
    if (err) {
      console.error(err);
      return res.status(500).send("Dosya indirme hatası.");
    }
  });
});

app.get("/software/:klasor_adi/publish.htm", (req, res) => {
  const klasor_adi = req.params.klasor_adi;
  console.log(klasor_adi);
  res.sendFile(path.join(__dirname, "software", klasor_adi + "/publish.htm"));
});

app.get("/software/:klasor_adi/:exe_adi.exe", (req, res) => {
  const klasor_adi = req.params.klasor_adi;
  const exe_adi = req.params.exe_adi + ".exe";
  const dosyaYolu = path.join(klasorYolu, klasor_adi + "/" + exe_adi);

  let htmlPath = `${__dirname}/software/${klasor_adi}/publish.htm`;
  fs.readFile(htmlPath, "utf8", (err, data) => {
    if (err) {
      console.error("Dosya okuma hatası:", err);
      return;
    }

    const $ = cheerio.load(data);
    const table = $("table");
    const thirdRowTds = table.find("tr:nth-child(4) td");
    const cellTexts = thirdRowTds
      .map((index, element) => {
        return $(element).text();
      })
      .get();

    res.download(dosyaYolu, klasor_adi + "-" + cellTexts[3] + ".exe", (err) => {
      if (err) {
        console.error(err);
        return res.status(500).send("Dosya indirme hatası.");
      }
      console.log(`${klasor_adi} indirildi.`);
    });
  });
});

app.use("/software", express.static(path.join(__dirname, "software")));

app.listen(port, () => {
  console.log(`Uygulama http://localhost:${port} adresinde çalışıyor.`);
});
