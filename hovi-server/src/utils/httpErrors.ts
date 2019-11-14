import HttpException from './HttpException';

export class HTTP400Error extends HttpException {
  constructor(message: any | string = 'Bad Request') {
    super(400, message);
  }
}

export class HTTP409Error extends HttpException {
  constructor(message: any | string = 'Already exists') {
    super(409, message);
  }
}

export class HTTP401Error extends HttpException {
  constructor(message: any | string = 'Unauthorized') {
    super(401, message);
  }
}

export class HTTP403Error extends HttpException {
  constructor(message: any | string = 'Forbidden') {
    super(403, message);
  }
}

export class HTTP404Error extends HttpException {
  constructor(message: any | string = 'Not found') {
    super(404, message);
  }
}
