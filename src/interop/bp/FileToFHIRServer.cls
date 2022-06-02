/// 
Class interop.bp.FileToFHIRServer Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='350' >
<call name='Send to FHIR Server' target='FHIRServer Operation' async='0' timeout='10' xpos='200' ypos='250' >
<request type='HS.FHIRServer.Interop.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='HS.FHIRServer.Interop.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
