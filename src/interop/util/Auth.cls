Class interop.util.Auth
{

/// do ##class(interop.util.Auth).CreateOAuth2Server()
ClassMethod CreateOAuth2Server() As %Status
{
    set ns = $namespace
    set $namespace = "%SYS"

    set server = ##class(OAuth2.Server.Configuration).%New()
    set server.Description = "AuthServer"

    set endpoint = ##class(OAuth2.Endpoint).%New()
    set endpoint.UseSSL = 1
    set endpoint.Host = "webserver"
    set endpoint.Prefix = "iris"
    set server.IssuerEndpoint = endpoint
    
    // supported grant types
    set server.SupportedGrantTypes = "ACJ"

    // use JWT tokens
    set server.GenerateTokenClass = "%OAuth2.Server.JWT"

    // support some specific scopes we can define
    set scopes = ##class(%ArrayOfDataTypes).%New()
    do scopes.SetAt("My own scope", "my/scope")
    set server.SupportedScopes = scopes

    // allow unsupported scopes (for testing different SMART on FHIR scopes)
    set server.AllowUnsupportedScope = 1

    // customize auth server as needed
    set server.AuthenticateClass = "%OAuth2.Server.Authenticate"
    set server.ValidateUserClass = "%OAuth2.Server.Validate"
    set server.CustomizationNamespace = "%SYS"
    set server.CustomizationRoles = "%DB_IRISSYS,%Manager,%DB_%DEFAULT"

    set server.SSLConfiguration = "ssl"

    write server.Save()

    set $namespace = ns
}

/// required for /.well-known/smart-configuration
ClassMethod CreateOAuth2IssuerServiceRegistry()
{
    set ns = $namespace
    set $namespace = "FHIRREPO"

    // create Service Registry (HTTP) to include FHIR repo endpoint
    set service=##class(HS.Registry.Service.HTTP).%New()
    set service.Name="OAuth2.Issuer"
    set service.Host="webserver"
    set service.URL="/iris/oauth2"
    set service.Type="HTTP"
    set service.SSLConfig="ssl"

    $$$ThrowOnError(service.%Save())

    set $namespace = ns
}

}
