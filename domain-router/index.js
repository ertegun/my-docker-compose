const express = require("express");
const app = express();
const geoip = require("geoip-lite");
const path = require("path");
const fs = require("fs");
const e = require("express");

function getClientIp(req) {
  // x-forwarded-for başlığı ters proxy'ler (nginx, load balancer) için kullanılır
  const ipAddress = req.headers["x-forwarded-for"] || req.socket.remoteAddress;
  // Eğer birden fazla IP varsa, sadece ilkini alırız
  return ipAddress.split(",")[0].trim();
}

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

app.get("/country-detection/:p1", (req, res) => {
  const { p1 } = req.params;
  const ip = getClientIp(req);
  console.log(`User IP Address: ${ip}`);
  const geo = geoip.lookup(ip);
  let address;
  if (geo) {
    console.log(`${geo.country} , ${geo.city} , ${geo.region}`);
    if (geo.country === "IN") {
      address = `https://drive.google.com/file/d/1Fr7CgVfq4xFfTw9LioBIjlkW0YZwD25g/view?usp=sharing`;
    } else {
      address = `https://www.gruparge.com/en-us/${p1}`;
    }
  } else {
    console.log(`Geo bilgisi bulunamadı!`);
    address = `https://www.gruparge.com/en-us/${p1}`;
  }
  res.redirect(301, address);
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
