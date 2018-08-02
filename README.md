## First run

```
docker-compose up
docker-compose down
```

## Try to crash database

```
./stack_deploy.sh
docker service logs stackName_web -f
docker service logs stackName_postgres -f
```

run again and again

```
./stack_deploy.sh
```

remove stack

```
./stack_remove.sh
```
