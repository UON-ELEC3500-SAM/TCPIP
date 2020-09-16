//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package tcpip.simulations;

//
// author: Thomas Reschka
//

import inet.common.misc.ThruputMeteringChannel;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth10M;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth1G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;

network cwindow
{
    parameters:
        int numClients = default(2);
        @display("bgb=802,525");

    submodules:
         client[numClients]: StandardHost {
            parameters:
               // @display("p=231.702,187.266");
//            gates:
//                pppg[1];
        }



        server: StandardHost {
            parameters:
                @display("p=603,188;i=device/server");
            gates:
                pppg[1];
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=100,100;is=s");
        }
        router: Router {
            @display("p=415,188");
            gates:
                pppg[];
        }

    connections:
     for i=0..numClients-1 {
          router.pppg++ <--> ThruputMeteringChannel {  delay = 100ms; datarate = 10Mbps; } <--> client[i].pppg++;
       }
//     client_0.pppg[0] <--> ThruputMeteringChannel {  delay = 100ms; datarate = 10Mbps; } <--> router.pppg[0];
//     client_1.pppg[0] <--> ThruputMeteringChannel {  delay = 100ms; datarate = 10Mbps; } <--> router.pppg[1];
//     client_2.pppg[0] <--> ThruputMeteringChannel {  delay = 100ms; datarate = 10Mbps; } <--> router.pppg[2];

       router.pppg++ <--> ThruputMeteringChannel {  delay = 100ms; datarate = 10Mbps; } <--> server.pppg[0];
}
