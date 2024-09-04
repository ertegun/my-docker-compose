const net = require("net");

const client = new net.Socket();
const HOST = "192.168.1.123"; // ZKTeco cihazının IP adresi
const PORT = 4370; // ZKTeco cihazının TCP/IP port numarası

client.connect(PORT, HOST, function () {
  console.log("ZKTeco cihazına bağlanıldı.");
  const command = Buffer.from("5050000000160000000100000000000000", "hex"); // kart okuma komutu
  client.write(command);
});

client.on("data", function (data) {
  console.log("Alınan veri: ", data);
});

client.on("close", function () {
  console.log("Bağlantı kapatıldı.");
});
