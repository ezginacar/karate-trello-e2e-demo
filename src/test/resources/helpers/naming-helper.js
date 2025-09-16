function() {
  var uuid = java.util.UUID.randomUUID().toString().split("-")[0];
  var now = new java.text.SimpleDateFormat("yyyyMMdd-HHmmss").format(new java.util.Date());

  return {
    getStandartNaming: function(prefix) { return prefix + "-" + uuid + "-" + now;},

  }
}
