const ZKLib = require("node-zklib");
const test = async () => {
  let zkInstance = new ZKLib("192.168.1.9", 4370, 10000, 4000);
  try {
    // Create socket to machine
    await zkInstance.createSocket();
    // Get general info like logCapacity, user counts, logs count
    // It's really useful to check the status of device
    console.log(await zkInstance.getInfo());
  } catch (e) {
    console.log(e);
    if (e.code === "EADDRINUSE") {
    }
  }

  // Get users in machine
  const users = await zkInstance.getUsers();
  console.log(users.data);

  // Get all logs in the machine
  // Currently, there is no filter to take data, it just takes all !!
  //   const logs = await zkInstance.getAttendances();
  //   console.log(logs);

  //   const attendances = await zkInstance.getAttendances((percent, total) => {
  //     // this callbacks take params is the percent of data downloaded and total data need to download
  //   });

  // YOu can also read realtime log by getRealTimelogs function

  // console.log('check users', users)

  //   zkInstance.getRealTimeLogs((data) => {
  //     // do something when some checkin
  //     console.log(data);
  //   });

  // delete the data in machine
  // You should do this when there are too many data in the machine, this issue can slow down machine
  //   zkInstance.clearAttendanceLog();

  // Get the device time
  //   const getTime = await zkInstance.getTime();
  //   console.log(getTime.toString());

  //   const response = await zkInstance.executeCmd("CMD_OPTIONS.DOOR_OPEN", [1]);
  //   console.log(response);
  // Disconnect the machine ( don't do this when you need realtime update :)))
  await zkInstance.disconnect();
};

test();
