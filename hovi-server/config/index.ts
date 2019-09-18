export default {
    APP_NAME: process.env.APP_NAME,
    API_PATH: process.env.API_PATH,
    ENV: process.env.NODE_ENV,
    PORT: parseInt(process.env.PORT, 10),
    HOST: process.env.HOST,
    MYSQL_DATABASE: process.env.MYSQL_DATABASE,
    MYSQL_USER: process.env.MYSQL_USER,
    MYSQL_PASSWORD: process.env.MYSQL_PASSWORD,
    MYSQL_HOST: process.env.MYSQL_HOST,
    MYSQL_PORT: parseInt(process.env.MYSQL_PORT, 10)
};
