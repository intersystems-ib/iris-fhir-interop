Class interop.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="interop.Production" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="interop.bs.FHIRFileService" Category="" ClassName="interop.bs.FHIRFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/app/data/fhir-input</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.json</Setting>
    <Setting Target="Host" Name="TargetConfigNames">interop.bp.FileToFHIRServer</Setting>
  </Item>
  <Item Name="FHIRServer Operation" Category="" ClassName="HS.FHIRServer.Interop.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ServiceName">external-fhirserver-basic</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
  <Item Name="FHIRServer Operation OAuth" Category="" ClassName="HS.FHIRServer.Interop.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ServiceName">external-fhirserver-oauth</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
  <Item Name="FHIRServer Operation Simple Service" Category="" ClassName="HS.FHIRServer.Interop.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ServiceName">external-simple-service</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
  <Item Name="HS.Util.Trace.Operations" Category="" ClassName="HS.Util.Trace.Operations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="interop.bp.FileToFHIRServer" Category="" ClassName="interop.bp.FileToFHIRServer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="InteropOperation" Category="" ClassName="HS.FHIRServer.Interop.DummyOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="InteropService" Category="" ClassName="HS.FHIRServer.Interop.Service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">FHIRServer Operation OAuth</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
  <Item Name="interop.bp.SimpleServiceFHIRHandler" Category="" ClassName="interop.bp.SimpleServiceFHIRHandler" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DummyLogOperation" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
