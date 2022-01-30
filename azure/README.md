# Some Azure notes

## Azure Container Registry
- managed container registry
1. Create one from WebUI
2. ```$ docker login <example>.azurecr.io```. The credentials are in Access Keys tab on the left.
3. ```docker tag <your image name> <example>.azurecr.io/<your image name>```
4. ```docker push <your new tagged iamge name>```

## Azure container Instance
1. Run container directly via images stored in various repo instance dockerhub, azure CR, and others

## Azure App Service
- define a set of compute resources, and azure handles rest

### WEBUI
1. Create service plan first.
2. Create Web app, can select code or docker.
3. After creation, in Deployment Center tab select your source, git ...

### CLI
1. ```az login```
2. Go inside your git project folder, ```az webapp --sku F1 --name test-app```  A default resource group / app service plan is created, you can change via command line.
3. ```az webapp up```
4. ```az group webapp log tail```
5. Always on, keeps the app up.

### Scaling notes
1. Set in App Service plan > Settings > scale UP/Out
2. Scale in -> All conditions must be met, for Scale Out -> At least one Condition must be met
3. Keep margin between min and max high.

## Cosmos DB
1. Setup via WEBUI is pretty simple.
2. ```az cosmosdb create --name "asdads" --resource-group "asdasd"```