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
import {ReportedRoom} from "./reported-room";
import {AdminBankAccount} from "./admin-bank-account";
import {SystemInformation} from "./system-information";
import {SavedRoom} from "./saved-room";


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
                BankTransferHistory,
                ReportedRoom,
                AdminBankAccount,
                SystemInformation,
                SavedRoom
            ],
            maxQueryExecutionTime: 1000
        });
    }

    static async clearData() {
        if (!DatabaseManager.connection) return;
        const connection = DatabaseManager.connection;
        const deleteQuery = connection.createQueryBuilder().delete();
        await deleteQuery.from(BuildingService).execute();
        await deleteQuery.from(RoomAmenities).execute();

        await deleteQuery.from(Service).execute();
        await deleteQuery.from(Amenities).execute();

        await deleteQuery.from(RoomImage).execute();
        await deleteQuery.from(Transaction).execute();
        await deleteQuery.from(Feedback).execute();
        await deleteQuery.from(TenantReview).execute();
        await deleteQuery.from(BankTransferHistory).execute();

        await deleteQuery.from(Room).execute();
        await deleteQuery.from(RoomGroup).execute();
        await deleteQuery.from(Building).execute();
        await deleteQuery.from(RoomType).execute();

        await deleteQuery.from(User).execute();
    }

    static async insertData() {
        if (!DatabaseManager.connection) {
            return;
        }
        let user = new User();
        user.id = 1;
        user = await User.repo.save(user);

        let buildingType = new RoomType();
        buildingType.id = 1;
        buildingType = await RoomType.repo.save(buildingType);

        let building = new Building();
        building.id = 1;
        building.typeId = 1;
        building = await Building.repo.save(building);

        let roomGroup = new RoomGroup();
        roomGroup.id = 1;
        roomGroup.buildingId = building.id;
        roomGroup = await RoomGroup.repo.save(roomGroup);

        let room = new Room();
        room.roomId = 1;
        room.roomGroupId = roomGroup.id;
        room = await Room.repo.save(room);

        let transaction = new Transaction();
        transaction.transactionId = 1;
        transaction.userId = user.id;
        transaction.roomId = room.roomId;

        let amenities = new Amenities();
        amenities.id = 1;
        amenities = await Amenities.repo.save(amenities);

        let service = new Service();
        service.id = 1;
        service = await Service.repo.save(service);
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
