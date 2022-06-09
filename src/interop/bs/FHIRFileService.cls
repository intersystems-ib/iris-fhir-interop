Class interop.bs.FHIRFileService Extends Ens.BusinessService
{

/// Where to send messages
Property TargetConfigNames As %String(MAXLEN = 1000);

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Parameter SETTINGS = "GenerateSuperSessionID:Additional,AlertGracePeriod:Alerting,TargetConfigNames:Basic:selector?multiSelect=1&context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId}";

/// Override this method to process incoming data. Do not call SendRequestSync/Async() from outside this method (e.g. in a SOAP Service or a CSP page).
Method OnProcessInput(pInput As %Stream.GlobalCharacter, pOutput As %RegisteredObject, ByRef pHint As %String) As %Status
{
	set ret = $$$OK
    try {
        set resource = {}.%FromJSON(pInput)

        set interopRequest = ##class(HS.FHIRServer.Interop.Request).%New()
        
        set apiRequest = ##class(HS.FHIRServer.API.Data.Request).%New()
        set apiRequest.RequestMethod = "POST"
        set apiRequest.RequestFormatCode = "JSON" 
        set apiRequest.ResponseFormatCode = "JSON"
        set apiRequest.RequestPath = "/"_resource.resourceType
	    set apiRequest.QueryString = "" 

        set resourceJsonStream = ##class(%Stream.GlobalCharacter).%New()
        do resource.%ToJSON(resourceJsonStream)

        set quickStream = ##class(HS.SDA3.QuickStream).%New()
        set quickStreamId = quickStream.%Id()
        do quickStream.CopyFrom(resourceJsonStream)
        do quickStream.Rewind()
		
        set interopRequest.QuickStreamId = quickStreamId
        set interopRequest.Request = apiRequest
        
        // send message to targets
        for i=1:1:$l(..TargetConfigNames, ",") { 
			set tTarget=$zstrip($p(..TargetConfigNames,",",i),"<>W")
			$$$ThrowOnError(..SendRequestSync(tTarget, interopRequest, .response))
        }

        // clear HS.SDA3.QuickStream (^CacheTemp.HS.Stream)
        do quickStream.Clear(1)

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

/// Return an array of connections for drawing lines on the config diagram
ClassMethod OnGetConnections(Output pArray As %String, pItem As Ens.Config.Item)
{
	do ##super(.pArray,pItem)
	if pItem.GetModifiedSetting("TargetConfigNames",.tValue) {
		for i=1:1:$L(tValue,",") { 
			set tOne=$zstrip($p(tValue,",",i),"<>W")
			continue:""=tOne
			set pArray(tOne)="" 
		}
	}
}

}
