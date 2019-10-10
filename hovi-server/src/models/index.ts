import {createConnection, Connection} from 'typeorm';
import config from '../../config';
import {User} from './user';
import {RoomType} from "./building_type";
import {Service} from "./service";
import {Amenities} from "./amenities";
import {Building} from "./building";
import {RoomGroup} from "./room_group";
import {Room} from "./room";
import {RoomImage} from "./room_image";
import {BuildingService} from "./building_service";

export class DatabaseManager {
    static connection: Connection;

    static async init() {
        if (DatabaseManager.connection) return;
        DatabaseManager.connection = await createConnection({
            name: 'default',
            type: 'mysql',
            host: config.MYSQL_HOST,
            port: config.MYSQL_PORT,
            username: config.MYSQL_USER,
            password: config.MYSQL_PASSWORD,
            database: config.MYSQL_DATABASE,
            entities: [
                User,
                RoomType,
                Service,
                Amenities,
                Building,
                RoomGroup,
                Room,
                RoomImage,
                BuildingService
            ],
            maxQueryExecutionTime: 1000
        });
    }

    static async clearData() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(User).execute();
    }

    static async close() {
        if (!DatabaseManager.connection) return;
        await DatabaseManager.connection.close();
        DatabaseManager.connection = null;
    }
}
