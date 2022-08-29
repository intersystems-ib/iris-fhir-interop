Class interop.bp.SimpleServiceFHIRHandlerContext Extends Ens.BP.Context
{

/// DummyLogMsg that contains some fields from FHIR response and will be sent to an operation
Property DummyLogMsg As interop.msg.DummyLog;

/// Handle response extracting some fields and saving a DummyLogMsg
Method HandleResponse(request As HS.FHIRServer.Interop.Request, response As HS.FHIRServer.Interop.Response) As %Status
{
    // extract some data from request
    set ..DummyLogMsg = ##class(interop.msg.DummyLog).%New()
    set ..DummyLogMsg.Username = request.Request.Username
    set ..DummyLogMsg.ClientAddr = request.Request.AdditionalInfo.GetAt("ClientAddr")
    set ..DummyLogMsg.Items = ##class(%ListOfObjects).%New()

    // get FHIR response body
    set stream = ##class(HS.SDA3.QuickStream).%OpenId(response.QuickStreamId)
    
    // parse FHIR reponse body
    set json = {}.%FromJSON(stream)

    if json.resourceType="Bundle" {
        // loop through bundle
        set iter = json.entry.%GetIterator()
        while iter.%GetNext(.key, .object) { 
            set item = "element:"_key_"=/"_object.resource.resourceType_"/"_object.resource.id
            do ..DummyLogMsg.Items.Insert(item)
        }
    }

    quit $$$OK
}

Storage Default
{
<Data name="SimpleServiceFHIRHandlerContextDefaultData">
<Subscript>"SimpleServiceFHIRHandlerContext"</Subscript>
<Value name="1">
<Value>DummyLogMsg</Value>
</Value>
</Data>
<DefaultData>SimpleServiceFHIRHandlerContextDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
