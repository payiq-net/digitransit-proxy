const os = require("os");

const getLocalIPv4Addr = () =>
  Object.values(os.networkInterfaces()).reduce(
    (ip, i) =>
      i.reduce(
        (ip, a) => ip || (!a.internal && a.family === "IPv4" && a.address),
        ip
      ),
    null
  );

console.log(getLocalIPv4Addr());
