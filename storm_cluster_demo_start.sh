docker run -d --restart always --name some-zookeeper zookeeper:3.4

docker run -d --restart always --name some-nimbus --link some-zookeeper:zookeeper storm:1.0.3 storm nimbus
docker run -d --restart always --name supervisor1 --link some-zookeeper:zookeeper --link scripts_rabbit1_1:rabbit --link some-nimbus:nimbus storm:1.0.3 storm supervisor

docker run -d --restart always --name supervisor2 --link some-zookeeper:zookeeper --link scripts_rabbit1_1:rabbit --link some-nimbus:nimbus storm:1.0.3 storm supervisor

docker run -d --restart always --name rabbit --hostname rabbit1 -p 5672:5672 -p 15672:15672 rabbit:alpine
docker run -d --restart always --name rabbit_dashboard --hostname rabbit2 -p 5673:5672 -p 15673:15672 rabbit:alpine

docker run -d --restart always --name memc -p 11211:11211 memcached:alpine


docker run -d --restart always --name redis -p 6379:6379 redis:alpine
sleep 4
docker run --link some-nimbus:nimbus --rm -v /Users/ovidiudanielbarba/IdeaProjects/CINI_SmartLightingSystem/target/CINI_SmartLightingSystem-1.0-jar-with-dependencies.jar:/CINI_SmartLightingSystem-1.0-jar-with-dependencies.jar storm:1.0.3 storm jar /CINI_SmartLightingSystem-1.0-jar-with-dependencies.jar org.uniroma2.sdcc.Topologies

sleep 4

docker run -d -p 8000:8080 --restart always --name ui --link some-nimbus:nimbus storm:1.0.3 storm ui
