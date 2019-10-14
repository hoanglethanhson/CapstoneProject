import AuthRoutes from './auth-route';
import UserRoutes from './user-route';
import BuildingTypeRoutes from './building_type-route';
import ServiceRoutes from './service-route';
import AmenitiesRoutes from './amenities-route';
import BuildingRoutes from './building-route';
import RoomGroupRoutes from './room_group-route';
import RoomRoutes from './room-route';
import RoomImageRoutes from './room_image-route';
import BuildingServiceRoutes from './building_service-route';
import RoomAmenitiesRoutes from './room_amenities-route';
import TransactionRoutes from './transaction-route';
import FeedBackRoutes from './feedback-route';

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
];
