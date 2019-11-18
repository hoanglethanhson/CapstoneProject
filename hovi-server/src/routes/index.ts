import AuthRoutes from './auth-route';
import UserRoutes from './user-route';
import BuildingTypeRoutes from './building-type-route';
import ServiceRoutes from './service-route';
import AmenitiesRoutes from './amenities-route';
import BuildingRoutes from './building-route';
import RoomGroupRoutes from './room-group-route';
import RoomRoutes from './room-route';
import RoomImageRoutes from './room-image-route';
import BuildingServiceRoutes from './building-service-route';
import RoomAmenitiesRoutes from './room-amenities-route';
import TransactionRoutes from './transaction-route';
import FeedBackRoutes from './feedback-route';
import TenantReviewRoutes from "./tenant-review-route";
import BankTransferHistoryRoutes from "./bank-transfer-history-route";
import ESRoute from "./es-route"
import ReportedRoomRoutes from "./reported-room-route"

export default [
  ...AuthRoutes,
  ...UserRoutes,
  ...BuildingTypeRoutes,
  ...ServiceRoutes,
  ...AmenitiesRoutes,
  ...BuildingRoutes,
  ...RoomGroupRoutes,
  ...RoomRoutes,
  ...RoomImageRoutes,
  ...BuildingServiceRoutes,
  ...RoomAmenitiesRoutes,
  ...TransactionRoutes,
  ...FeedBackRoutes,
  ...TenantReviewRoutes,
  ...BankTransferHistoryRoutes,
  ...ReportedRoomRoutes,
  ...ESRoute
];
