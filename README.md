# Hovi backend

## Setup server
- Install nodejs8.0.0 or above.
- Install Docker ([Docker for window](https://docs.docker.com/docker-for-windows/), [Docker for ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/))
- Run `docker-compose up --build -d` to build & start all images docker
- Turn off **hovi-backend_server** image to start in development environment:
    - Step 1: Run `docker ps` to list all images running, find image-name* need to stop.
    - Step 2: Run `docker stop image-name:`  to stop **hovi-backend_server** image.
    - Step 3: On folder `hovi-backend/hovi-server` to run `npm start` or `yarn start` to start development.
> Note: Should not stop *mysql* or *mysql_test* image, it is used during server development.

## Scripts
- `npm start`: Run server app with local environment (Use for development).
- `npm run start:docker`: Run server app with docker environment (Use to development in docker).
- `npm build`: Build server app into *dist* folder.
- `npm test`: Build & run tests server app.
- `npm test:watch`: Run tests in watch mode

## Branch naming
- Check out new branch from branch `develop`.
- Branch convention:
    - master: production release
    - develop: development
    - feature/task_key_words_YYYYMMDD_thuongnn
    - fixbug/task_key_words_YYYYMMDD_thuongnn

### Error HTTP Response (400, 401, 403, 404, 500)
```json
{
  "status": 400,
  "message": "An error message"
}
```

## Code structure convention

### Model
```ts
@Entity(Model.tableName)
export class Model extends BaseEntity {
  static readonly tableName = '';
  static readonly schema = {
    id: 'id',
    col1: 'col_1',
  };

  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    name: Model.schema.col1,
  })
  col1: string;

  static get repo(): ModelRepository {
    return getCustomRepository(ModelRepository);
  }
}

@EntityRepository(Model)
export class ModelRepository extends Repository<Model> {
}
```

### Repository
- Use these prefixes for functions in service: (sort functions in that order)
    * `exists`: check if a row exists by some condition
    * `is_`: check if a condition is true
    * `append_`: append some value to each item in a list
    * `list_`: query a list of items from database
    * `get_one`: query something from database by some condition
    * `get_`: get custom data
    * `create`: add one record to database. only one argument which is a dictionary.
    * `create_`: add custom record to database. arguments will be list of keyword arguments.
    * `update`: update record in database
    * `delete`: delete a record in database
    * other custom functions...
- Use keyword arguments when it enhances clarity and readability of code. [References](https://stackoverflow.com/questions/7041752/any-reason-not-to-always-use-keyword-arguments)

### Function & Routes
- Create function in `src/functions` with rule names is `modelName-function.ts`.
- Create route in `src/routes` with rule names is `modelName-route.ts`.

#### Function
```ts
import {typeError} from '../utils/httpErrors'; // Example typeError: HTTP400Error, HTTP401Error,...
import {modelName} from "../models/modelName";

export default class ClassName {
    static functionName: Handler = async (req: Request, res: Response, next: NextFunction) => {
        // to do process
        res.status(200).send(result); // success
        next(new typeError(message)); // failed
    };
}
```

#### Route
```ts
import className from "../functions/className-function";

export default [
    {
        path: "/",                       //name path
        method: "get",                   //method type: get, post, put, delete
        authentication: true,            //true if the function must authenticate the user
        handler: className.functionName  //handler function
    }
];
```
> Note: Function must mapping the route, and import route created into `src/routes/index.ts`

## Testing
- All test file create on `__tests__` folder.
- Should writing test before to coding function.

## Software should be used
- [Kitematic](https://kitematic.com/): UI to management(view, start, stop, restart,...) docker images.
- [Navicat Premium](https://downmienphi.com/windows/download-navicat-premium.688.html): Database development tool (use crack if you are not economically :D)
- [WebStorm](https://www.jetbrains.com/webstorm/): The smartest JavaScript IDE. Use [GitHub Student Developer](https://education.github.com/pack) Pack to get key fee.

# Reference
- [Production ready Node.js REST API Setup using TypeScript, PostgreSQL and Redis](https://itnext.io/production-ready-node-js-rest-apis-setup-using-typescript-postgresql-and-redis-a9525871407)
- [Error handling and validating incoming data](https://wanago.io/2018/12/17/typescript-express-error-handling-validation/)
- [Express Document](https://expressjs.com/en/api.html#express)
- [TypeORM Document](https://typeorm.io/)
