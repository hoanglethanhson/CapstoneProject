import roomImageFunction from '../functions/room-image-function';

export default [
  {
    path: '/roomImage/',
    method: 'get',
    authentication: false,
    handler: roomImageFunction.getRoomImages,
  },
  {
    path: '/roomImage/:roomImageId',
    method: 'get',
    authentication: false,
    handler: roomImageFunction.getRoomImage,
  },
  {
    path: '/room-group/upload',
    method: 'post',
    authentication: false,
    uploadOptions: {
      type: 'file',
      fileSize: 10 * 1024 * 1024,
      isMultiple: true,
      maxQuantity: 8,
    },
    handler: roomImageFunction.uploadImage,
  },
  {
    path: '/roomImage',
    method: 'post',
    authentication: false,
    handler: roomImageFunction.createRoomImage,
  },
  {
    path: '/roomImage/:roomImageId',
    method: 'put',
    authentication: false,
    handler: roomImageFunction.updateRoomImage,
  },
  {
    path: '/roomImage/:roomImageId',
    method: 'delete',
    authentication: false,
    handler: roomImageFunction.deleteRoomImage,
  },
];
