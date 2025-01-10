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

app.get("/:p1/:p2", (req, res) => {
  const { p1, p2 } = req.params;
  let address = `https://www.gruparge.com/${p1}/${p2}/`;

  // switch (p2) {
  //   case "rkrs":
  //     switch (p1) {
  //       case "en":
  //         address = "https://www.gruparge.com/wp-content/uploads/2024/04/power-factor-controller-RKRS-user-manuel.pdf";
  //         break;
  //       default: //tr
  //         address = "https://www.gruparge.com/wp-content/uploads/2023/05/reaktif-kontrol-rolesi-rkrs-kullanma-kilavuzu.pdf";
  //         break;
  //     }
  //     break;
  //   case "rkr":
  //     switch (p1) {
  //       case "en":
  //         address = "https://www.gruparge.com/wp-content/uploads/2023/01/reagent-control-relay-rkr-user-manual.pdf";
  //         break;
  //       default: //tr
  //         address = "https://www.gruparge.com/wp-content/uploads/2023/01/rkr-serisi-reaktif-guc-kontrol-rolesi-kullanim-kilavuzu.pdf";
  //         break;
  //     }
  //     break;
  //   default:
  //     address = address;
  //     break;
  // }
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
