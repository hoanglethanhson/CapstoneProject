import UserRoutes from './user-route';
import RoomTypeRoutes from './roomType-route'
import ServiceRoutes from './service-route'
import AmenitiesRoutes from './amenities-route'
export default [...UserRoutes, ...RoomTypeRoutes, ...ServiceRoutes, ...AmenitiesRoutes];
