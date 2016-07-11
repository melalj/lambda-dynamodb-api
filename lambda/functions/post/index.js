var date = new Date();
date.setDate(date.getDate() + 1);
var ddb = require('dynamodb').ddb({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  region: process.env.AWS_REGION,
  sessionToken: process.env.AWS_SESSION_TOKEN,
  sessionExpires: date,
});
exports.handle = function(event, context) {
    var key = (event.key === undefined ? "NO KEY" : event.key);
    var table = (event.table === undefined ? "NO TABLE" : event.table);
    var dataraw = (event.data === undefined ? "NO DATA" : event.data);
    console.log("Request received:\n", JSON.stringify(event));
    console.log("Context received:\n", JSON.stringify(context));

    var data = Object.assign({
      key: key,
      timestamp: Date.now(),
    }, dataraw);

    ddb.putItem(table, data, {}, (err) => {
      if (err) return context.fail({ success: false, error: err.message });
      return context.succeed({ success: true });
    });
};
