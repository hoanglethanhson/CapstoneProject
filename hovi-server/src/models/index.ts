import {createConnection, Connection, getManager} from 'typeorm';
import config from '../../config';
import {User} from './user';
import {RoomType} from "./building-type";
import {Service} from "./service";
import {Amenities} from "./amenities";
import {Building} from "./building";
import {RoomGroup} from "./room-group";
import {Room} from "./room";
import {RoomImage} from "./room-image";
import {BuildingService} from "./building-service";
import {RoomAmenities} from "./room-amenities";
import {Transaction} from "./transaction";
import {Feedback} from "./feedback";
import {TenantReview} from "./tenant-review";
import {BankTransferHistory} from "./bank-transfer-history";


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
                BuildingService,
                RoomAmenities,
                Transaction,
                Feedback,
                TenantReview,
                BankTransferHistory
            ],
            maxQueryExecutionTime: 1000
        });
    }


    static async prepareDelete() {
        await getManager().query('SET foreign_key_checks = 0;');
    }


    static async clearDataUserTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(User).execute();
    }

    static async clearDataRoomTypeTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(RoomType).execute();
    }

    static async clearDataBuildingTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(Building).execute();
    }

    static async clearDataRoomGroupTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(RoomGroup).execute();
    }

    static async clearDataRoomTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(Room).execute();
    }

    static async clearDataTransactionTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(Transaction).execute();
        //await getManager().query('SET foreign_key_checks = 0;delete from transaction');
    }

    static async close() {
        if (!DatabaseManager.connection) return;
        await DatabaseManager.connection.close();
        DatabaseManager.connection = null;
    }

    static async clearDataAmenitiesTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(Amenities).execute();
    }

    static async clearDataServiceTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(Service).execute();
    }

    static async clearDataRoomAmenitiesTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(RoomAmenities).execute();
    }

    static async clearDataBuildingServiceTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(BuildingService).execute();
    }

    static async clearDataBankTransferHistoryTest() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        this.prepareDelete();
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(BankTransferHistory).execute();
    }
}
