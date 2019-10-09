import UserRoutes from './user-route';
import BuildingTypeRoutes from './building_type-route'
import ServiceRoutes from './service-route'
import AmenitiesRoutes from './amenities-route'
import BuildingRoutes from './building-route'
import RoomGroupRoutes from './room_group-route'
export default [...UserRoutes, ...BuildingTypeRoutes, ...ServiceRoutes, ...AmenitiesRoutes, ...BuildingRoutes, ...RoomGroupRoutes];
