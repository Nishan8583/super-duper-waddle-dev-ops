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

### Blob storage
1. Create group ```az group create --name az204-blob-rg --location <myLocation>```
2. ```az storage account create --resource-group az204-blob-rg --name \
<myStorageAcct> --location <myLocation> \ 
--kind BlockBlobStorage --sku Premium_LRS``

### Application Delivery
#### 1. CDN:
A -------------------> CDNs(edge server, edge point, point of presense) ----------------> Source origin
B <-------------------> No need to reach source origin now


1. CDN caching: global (for each endpoint)

### Event Based Solutions
-> An event is the smallest unit of information that describes what happened. Metainformation

#### 1. Event grid
1. Event driven automation
Azure sources -------------> Event Grid ----------------> Handler(Logic apps, functions, storage)

2. Event: Smallest subset of info that defines what happened, no data, only metadata around an event
2. publisher: user/org that sends event to event grid.
3. Event sources: The app/service generating the event. (Ex: Azure storage, container)
4. Topic: This is where we define where to receive the event.
5. Subscriptions: filter events form topics
6. Event handlers: processes the events

7. Create event grid -> Overview, Create event subscription on topic -> endpoiint type 
8. push data:
```powershell
endpoint=$(az eventgrid topic show --name <name> -g <resource_group> --query "endpoint" --output tsu)
key=$(az eventgrid topic show key  --name <name> -g <resource_group> --query "key1" --output tsu)
curl -X POST -H "aeg-sas-key: $key1 -d "$vevent1" $endpoint"
```

#### 2. Event Hub
1. Data streaming and event ingestion
2. Real time or batch processing
3. Store events for archiving (azure sotrage or data lake)
4. Stream events to 3rd parties

5. Namespaces: specific to regiion, hub can accept data only in same region
6. Event hub: created within namespaces, defines msg retention and parition count
7. partitions:
    -> queues for incomming event
    stored in ordered they are received
    will stay as long as partition period
    no way to remove data manually has to expire
    larger number of partitions = higher scalibility
8. event publisher: sends data to event hub
9. Throughput unit: capacity measurement for eventhub
10. consumer group: apps read from eventhub
11. event receiver: speciifc app in consumer gorup

Options:
1. kafka
2. Capture: azure storage

Time window: amount of time 
Size window: size

when time window or size window reached, it is then stored

Creation: 
1. Create namespace
Autoinflate: auto scape up no auto scale down
Overview: +eventhub

Send logs from app:
App > MOnitoring> diagnosting settings> add/Edit> stream to eventhub


#### 3. Notification Hub
> push notification to devices
> manages Push NOtificaiton service (PNS)

### Message Based Solution
 Message is a binary formatm contains xml,json or just raw text data

Message sender/Producer ( apps ) -> (API CALL TO SEND DATA) -> Service Bus namespace -> (API CALL) -> Message Receiver/Consumer (apps or services)

#### 1. Azure Service Bus
1. Queue: single space where messages are sent, one to one relationship between sender and receiver

sender ---------------------(QUEUE)-------------> Receiver
all receiver take data from same queue. allows asynchronous send and receive

2. Topic: One to many relationship between sender and receiver. Each receiver has its own queue and does not affect each other.
    Sender sends data to a topic.

Sender  ---------------------->(TOPIC)
                        |   subscription   | -----------> receiver
                        |   subscription   | -----------> receiver
each receiver pulls from own subscription.

3. Security:
    -> Shared Access Signature
    -> Permission levels: 
        -> Send: send data
        -> Listen: Receive data
        -> Manage: Send + Receive + manage namespace\

4. Tiers: 
    -> basic: only queue
    -> standard: Queues and topics
    -> Premium: Queues and topics + isolated instances + geo disaster recovery

5. Steps
    -> Create Service namespace
    -> in Overview section |    + topic     OR      +queue|
    -> In entities > Queue | Topic (+subscription)
    -> In shared access policy (connection string)


#### 2. Storage queue
-> on top of storage accounts
-> unlikce service bus, no order, no batch sending
-> pros: higher stroage, lower cost, same replication as storage accoaunt for redundancy

1. Access: via portal or url
2. Security: Shared key (On storage account level or queue level), SAS, Azure AD, Firewall based
3. Steps:
    -> In storage account: Queue
    -> URL: https://storage_acct.queue.core.windows.net/queue_name