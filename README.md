# docker-jenkins

Sets up a container with jenkins(Ubuntu 14.04/Oracle Java 7) installed listening on port 8080.

## Usage

To build the container, run the following:

    #docker build -t="larkin/jenkins" .

To run the container, run the following:

    #docker run -d -p 8080:8080 --name jenkins -i -t larkin/jenkins

    #docker ps
    CONTAINER ID        IMAGE                   COMMAND                CREATED             STATUS              PORTS                    NAMES
    747485faf0d8        larkin/jenkins:latest   "java -jar /opt/jenk   32 seconds ago      Up 31 seconds       0.0.0.0:8080->8080/tcp   jenkins

Your jenkins instance is available here [http://localhost:8080](http://localhost:8080)

## Author

  * Pavel Larkin (<laxkin@gmail.com>)

## LICENSE

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
