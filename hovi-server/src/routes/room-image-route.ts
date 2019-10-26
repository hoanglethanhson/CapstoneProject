import roomImageFunction from '../functions/room-image-function';

export default [
  {
    path: '/roomImage/',
    method: 'get',
    handler: roomImageFunction.getRoomImages,
  },
  {
    path: '/roomImage/:roomImageId',
    method: 'get',
    handler: roomImageFunction.getRoomImage,
  },
  {
    path: '/room-group/upload',
    method: 'post',
    authentication: true,
    uploadOptions: {
      type: 'photos',
      fileSize: 10 * 1024 * 1024,
      isMultiple: true,
      maxQuantity: 8,
    },
    handler: roomImageFunction.uploadImage,
  },
  {
    path: '/roomImage',
    method: 'post',
    authentication: true,
    handler: roomImageFunction.createRoomImage,
  },
  {
    path: '/roomImage/:roomImageId',
    method: 'put',
    authentication: true,
    handler: roomImageFunction.updateRoomImage,
  },
  {
    path: '/roomImage/:roomImageId',
    method: 'delete',
    authentication: true,
    handler: roomImageFunction.deleteRoomImage,
  },
];
