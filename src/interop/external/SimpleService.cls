/// 
/// Simple service that simulates a FHIR response
Class interop.external.SimpleService Extends %CSP.REST
{

Parameter HandleCorsRequest As %Integer = 1;

XData UrlMap
{
<Routes>
<Route Url="/ServiceRequest" Method="GET" Call="GetServiceRequest"/>
</Routes>
}

ClassMethod GetServiceRequest() As %Status
{
    // hardcoded data
    set data = 
    {
        "resourceType": "Bundle",
        "id": "5af30eee-278f-11ed-89df-0242c0a83002",
        "type": "searchset",
        "timestamp": "2022-08-29T11:23:58Z",
        "total": 2,
        "link": [
            {
                "relation": "self",
                "url": "https://webserver/iris/csp/healthshare/fhirrepo/fhir/r4/ServiceRequest"
            }
        ],
        "entry": [
            {
                "fullUrl": "https://webserver/iris/csp/healthshare/fhirrepo/fhir/r4/ServiceRequest/5174",
                "resource": {
                    "resourceType": "ServiceRequest",
                    "id": "5174",
                    "text": {
                        "status": "generated",
                        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative with Details</b></p><p><b>id</b>: benchpress</p><p><b>status</b>: active</p><p><b>intent</b>: plan</p><p><b>code</b>: Bench Press (regime/therapy)  <span>(Details : {SNOMED CT code '229115003' = 'Bench press', given as 'Bench Press (regime/therapy) '})</span></p><p><b>subject</b>: <a>Patient/example</a></p><p><b>occurrence</b>: Count 20 times, Do 3 per 1 weeks</p><p><b>patientInstruction</b>: Start with 30kg 10-15 repetitions for three sets and increase in increments of 5kg when you feel ready</p></div>"
                    },
                    "status": "active",
                    "intent": "plan",
                    "code": {
                        "coding": [
                            {
                                "system": "http://snomed.info/sct",
                                "code": "229115003",
                                "display": "Bench Press (regime/therapy) "
                            }
                        ]
                    },
                    "subject": {
                        "reference": "Patient/example"
                    },
                    "occurrenceTiming": {
                        "repeat": {
                            "count": 20,
                            "countMax": 30,
                            "frequency": 3,
                            "period": 1,
                            "periodUnit": "wk"
                        }
                    },
                    "patientInstruction": "Start with 30kg 10-15 repetitions for three sets and increase in increments of 5kg when you feel ready",
                    "meta": {
                        "lastUpdated": "2022-08-29T11:22:16Z",
                        "versionId": "1"
                    }
                },
                "search": {
                    "mode": "match"
                }
            },
            {
                "fullUrl": "https://webserver/iris/csp/healthshare/fhirrepo/fhir/r4/ServiceRequest/5175",
                "resource": {
                    "resourceType": "ServiceRequest",
                    "id": "5175",
                    "text": {
                        "status": "generated",
                        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative with Details</b></p><p><b>id</b>: education</p><p><b>status</b>: completed</p><p><b>intent</b>: order</p><p><b>category</b>: Education <span>(Details : {SNOMED CT code '311401005' = 'Patient education', given as 'Patient education (procedure)'})</span></p><p><b>code</b>: Health education - breast examination <span>(Details : {SNOMED CT code '48023004' = 'Breast self-examination technique education', given as 'Breast self-examination technique education (procedure)'})</span></p><p><b>subject</b>: Jane Doe</p><p><b>occurrence</b>: 16/08/2014</p><p><b>authoredOn</b>: 16/08/2016</p><p><b>requester</b>: Angela Care, MD</p><p><b>performer</b>: Pamela Educator, RN</p><p><b>reasonCode</b>: early detection of breast mass <span>(Details )</span></p></div>"
                    },
                    "status": "completed",
                    "intent": "order",
                    "category": [
                        {
                            "coding": [
                                {
                                    "system": "http://snomed.info/sct",
                                    "code": "311401005",
                                    "display": "Patient education (procedure)"
                                }
                            ],
                            "text": "Education"
                        }
                    ],
                    "code": {
                        "coding": [
                            {
                                "system": "http://snomed.info/sct",
                                "code": "48023004",
                                "display": "Breast self-examination technique education (procedure)"
                            }
                        ],
                        "text": "Health education - breast examination"
                    },
                    "subject": {
                        "display": "Jane Doe"
                    },
                    "occurrenceDateTime": "2014-08-16",
                    "authoredOn": "2016-08-16",
                    "requester": {
                        "display": "Angela Care, MD"
                    },
                    "performer": [
                        {
                            "display": "Pamela Educator, RN"
                        }
                    ],
                    "reasonCode": [
                        {
                            "text": "early detection of breast mass"
                        }
                    ],
                    "meta": {
                        "lastUpdated": "2022-08-29T11:23:19Z",
                        "versionId": "1"
                    }
                },
                "search": {
                    "mode": "match"
                }
            }
        ]
    }

    // write response
    set %response.ContentType = "application/json+fhir"
    set %response.Status = "200"
    write data.%ToJSON()

    quit $$$OK
}

}
