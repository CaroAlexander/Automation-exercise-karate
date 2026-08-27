function fn() {

    var env = karate.env;
    karate.log('Karate environment:', env);

    if (!env) {
        env = 'qa';
    }

    var config = {
        env: env
    };

    if (env == 'qa') {
        config.baseUrl = 'https://automationexercise.com';
    }

    if (env == 'dev') {
        config.baseUrl = 'https://automationexercise.com';
    }

    config.defaultPassword = 'Password123';

    return config;
}