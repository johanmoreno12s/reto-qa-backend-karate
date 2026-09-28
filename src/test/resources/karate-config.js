function fn() {
  var config = {};
  config.baseUrl = karate.properties['baseUrl'] || 'https://serverest.dev';
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 20000);
  karate.configure('headers', {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  });

  config.userData = function () {
    var suffix = java.util.UUID.randomUUID().toString();
    return {
      nome: 'QA Karate ' + suffix,
      email: 'qa.karate.' + suffix + '@example.com',
      password: 'Qa@123456',
      administrador: 'false'
    };
  };

  return config;
}