/// 
Class interop.bp.SimpleServiceFHIRHandler Extends Ens.BusinessProcessBPL [ DependsOn = interop.bp.SimpleServiceFHIRHandlerContext ]
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='HS.FHIRServer.Interop.Request' response='HS.FHIRServer.Interop.Response' contextsuperclass='interop.bp.SimpleServiceFHIRHandlerContext' height='2000' width='2000' >
<sequence xend='200' yend='550' >
<call name='Send request' target='FHIRServer Operation Simple Service' async='0' timeout='10' xpos='200' ypos='250' >
<request type='HS.FHIRServer.Interop.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='HS.FHIRServer.Interop.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<code name='HandleResponse' xpos='200' ypos='350' >
<![CDATA[ do context.HandleResponse(request, response)]]>
</code>
<call name='DummyLog' target='DummyLogOperation' async='1' xpos='200' ypos='450' >
<request type='interop.msg.DummyLog' >
<assign property="callrequest" value="context.DummyLogMsg" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
