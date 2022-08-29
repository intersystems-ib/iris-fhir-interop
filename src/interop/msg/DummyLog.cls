Class interop.msg.DummyLog Extends Ens.Request
{

Property Username As %String;

Property ClientAddr As %String;

Property Items As list Of %String;

Storage Default
{
<Data name="DummyLogDefaultData">
<Subscript>"DummyLog"</Subscript>
<Value name="1">
<Value>Username</Value>
</Value>
<Value name="2">
<Value>ClientAddr</Value>
</Value>
<Value name="3">
<Value>Items</Value>
</Value>
</Data>
<DefaultData>DummyLogDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
