const express = require("express");
const app = express();

app.get("/", (req, res) => {
  const domain = req.headers.host;
  console.log(req.headers.host);
  switch (domain) {
    case "gruparge.com":
    case "localhost": //test
      return res.redirect(301, "https://www.gruparge.com");
      break;
    default:
      break;
  }

  res.send("Hoş geldiniz!");
});

app.get("/:lang/:device_code", (req, res) => {
  const { lang } = req.params;
  const { device_code } = req.params;
  let address = "https://www.gruparge.com";

  switch (device_code) {
    case "rkrs":
      switch (lang) {
        case "en":
          address = "https://www.gruparge.com/wp-content/uploads/2024/04/power-factor-controller-RKRS-user-manuel.pdf";
          break;
        default: //tr
          address = "https://www.gruparge.com/wp-content/uploads/2023/05/reaktif-kontrol-rolesi-rkrs-kullanma-kilavuzu.pdf";
          break;
      }
      break;
    case "rkr":
      switch (lang) {
        case "en":
          address = "https://www.gruparge.com/wp-content/uploads/2023/01/reagent-control-relay-rkr-user-manual.pdf";
          break;
        default: //tr
          address = "https://www.gruparge.com/wp-content/uploads/2023/01/rkr-serisi-reaktif-guc-kontrol-rolesi-kullanim-kilavuzu.pdf";
          break;
      }
      break;
    default:
      address = address;
      break;
  }
  res.redirect(301, address);
});

app.listen(80, () => {
  console.log("Uygulama http://localhost:80 adresinde çalışıyor!");
});
