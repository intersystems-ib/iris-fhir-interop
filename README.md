Example of using InterSystems IRIS or HealthShare Health Connect interoperability features for FHIR (no FHIR repository capabilities used in this case).

# Setup
Build image
```
docker-compose build
```

Run container
```
docker-compose up -d
```

Log-in into [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp) using `superuser` / `SYS`.

# Scenario: FHIR client

Scenario where you need to build or manipulate some FHIR request and send it to an external FHIR server.

## Create foundation namespace
Open terminal:
```
docker exec -it iris bash
iris session iris
```

Create `FHIRINTEROP` foundation namespace:
```
zn "HSLIB"
do ##class(HS.HC.Util.Installer).InstallFoundation("FHIRINTEROP")
```

## Load source code
```
zn "FHIRINTEROP"
do $SYSTEM.OBJ.LoadDir("/app/src/", "ck", .errorlog, 1)
```

## Config external FHIR server
In `FHIRINTEROP` namespace, go to Health > Service Registry and create a new service:
* Name: `external-fhirserver`
* Service Type: `HTTP`
* SSL Configuration: `ssl`
* Host: external FHIR server host (e.g. `api.logicahealth.org`)
* URL: external FHIR server URL (e.g. `/externalfhirrepoiris/open`)

## Test interoperability production
Have a look at the [interop.Production](http://localhost:52773/csp/healthshare/fhirinterop/EnsPortal.ProductionConfig.zen?PRODUCTION=interop.Production) production:
* `interop.bs.FHIRFileService` - Business Service that reads a file and creates a `HS.FHIRServer.Interop.Request` message.
* `interop.bp.FileToFHIRService` - Business Process that prepare `HS.FHIRServer.Interop.Request` from service before sending to external FHIR server.
* `HS.FHIRServer.Interop.HTTPOperation` - built-in Business Operation that sends a FHIR request to an external FHIR server.

Run some tests:
* Start the production
* Copy `data/patient.json` into `data/fhir-input` to process a sample file in your production.

# Scenario: FHIR server

Scenario in which you need to receive FHIR requests and send them to an external server.

For example, in case you need to forward a FHIR request to an external server you can use simple FHIR Interoperability Adapter in InterSystems IRIS or HealthShare Health Connect.
You can find more information in [FHIR Interoperability Adapter](https://docs.intersystems.com/healthconnect20221/csp/docbook/DocBook.UI.Page.cls?KEY=HXFHIR_fhir_adapter).

## Install adapter
You need to install the FHIR interoperability adapter before using it in a namespace.
During the adapter installation it will create:
* A web application for your FHIR server endpoint.
* An `InteropService` and `InteropOperation` in your production.

Install the adapter:

```
zn "FHIRINTEROP"
set status = ##class(HS.FHIRServer.Installer).InteropAdapterConfig("/myendpoint/r4")
```

Update your production as needed

## Config InteropService
Change `InteropService` Target Config Name so it will send messages to already configured `HS.FHIRServer.Interop.HTTPOperation` which sends messages to external FHIR server.

Test your service using [iris-fhir-interop.postman_collection.json](./iris-fhir-interop.postman_collection.json) Postman collection