# Dispatch configuration proposal

## Related material

 - <http://qpid.apache.org/releases/qpid-dispatch-trunk/qdrouterd.conf.5.html>
 - <https://svn.apache.org/repos/asf/qpid/dispatch/trunk/etc/qdrouterd.conf>

## Proposed changes

 - Use "key" for named config blocks; use "${type}_id" for references
   from without
 - Use a standard list syntax throughout
 - Describe comment syntax

 - Collapse container and router to simply router
 - Collapse containerName and routerId to "id", inside router
 - id has no default, and it's required
 - Default workerThreads to 4, remove from shipped config
 - Remove sslProfile from shipped config
 - Consider adding builtins for _closes, _multicast, etc.  Use a safer
   prefix for these? `_qd_`?
 - Use requireSasl=no instead of allowNoSasl=yes
 - Default addr to all interfaces
 - Default port to 5672
 - Default mode (was routerMode) to standalone
 - Eliminate waypoints
 - Eliminate password
 - Instead of requirePeerAuth, requireClientAuth=no in listener and
   requireServerAuth=yes in connector (and requirePeerAuth has
   incorrect help text)
 - Use updateInterval instead of raInterval
 - Remove remoteLsMaxAge

## Minimal example

        router {
            id: router1
        }

        # If no listener is supplied, a default listener (key: default) is
        # created with no ssl profile, bound to all local interfaces

## Basic example (incomplete)

        router {
            id: router1
        }

        listener {
            addr: 127.0.0.1
            port: amqp
        }
        
        connector {
            # XXX incomplete!
        }

## Annotated example (incomplete)

        router {
            id: router1               # Renamed from routerId; no default and required
            mode: standalone          # Default to standalone
            workerThreads: 99         # Default to 4
            debugDump: /some/path
            # Tunables
            helloInterval: 1
            helloMaxAge: 3
            updateInterval: 30        # Renamed from raInterval
            updateIntervalFlux: 4     # Is this important to have as a tuneable?
            # Remove: containerName, remoteLsMaxAge, mobileAddrMaxAge
        }

        listener {
            addr: 127.0.0.1           # Change default to 127.0.0.1?
            port: amqp
            role: normal              # normal, interRouter, onDemand
            requireClientAuth: false  # 
            certDb: /some/cert.db
            certFile: /some/cert.pem
            keyFile: /some/cert.pem
            # ^^ Should one of cert/keyFile default to the value of the other?
            passwordFile: /some/password.file
            # Remove: password
        }

