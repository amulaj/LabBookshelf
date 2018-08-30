codeunit 50102 "WebServiceCall"
{
    trigger OnRun();
    var 
        Customer_l: Record Customer;        
        MyWindow: Dialog;          
        MyNext: Integer;      
        MyInputPage: Page MyInputPage;   
    begin                                                 
         clear(MyInputPage);         
         MyInputPage.SetInput('google.com');
         MyInputPage.RunModal;         
        /*
        //Only a test for Input Dialog. Dialog works but not for Input only for Showing some Informations.
        MyNext := 0;  
        MyWindow.OPEN(Text000,MyNext);           
        REPEAT  
            // Do some processing. 
            SLEEP(5000);   
            MyNext := MyNext + 1;  
            MyWindow.UPDATE(); // Update the field in the dialog.  
            SLEEP(5000);             
        UNTIL MyNext = 4;          
        MyWindow.CLOSE()     
        */
        clear(ContentJson);        
        HttpClient.DefaultRequestHeaders().Clear(); 
        if Customer_l.get(10000) then begin          
        PopulateCustomerWithFetchData(Customer_l,FetchDataFromWebService(MyInputPage.GetInput)); 
        message(Customer_l.Name + '; ' 
                + Customer_l."Home Page" + '; ' 
                + Customer_l.Address + '; ' 
                + Customer_l.City + '; ' 
                + Customer_l."Post Code" + '; ' 
                + Customer_l."Country/Region Code"); 
        end;    
    end;

    local procedure FetchDataFromWebservice(DomainName: Text) ResponseJson: JsonObject;           
    begin 
        ContentJson.Add('domain',DomainName); 
        ContentJson.WriteTo(contentText);
        HttpContent.WriteFrom(ContentText);

        HttpClient.DefaultRequestHeaders().Add('Authorization',StrSubstNo('Bearer %1',ApiKey));
        if not HttpClient.Post(Url,HttpContent,HttpResponseMessage) then
            error(ErrorNoConnection); 
        if not HttpResponseMessage.IsSuccessStatusCode() then
            error(ErrorResponse,HttpResponseMessage.HttpStatusCode(),HttpResponseMessage.ReasonPhrase());
        
        HttpResponseMessage.Content().ReadAs(ContentText); 
        ResponseJson.ReadFrom(ContentText);          
    end;

    local procedure PopulateCustomerWithFetchData(var Cust: Record Customer; ContentJson: JsonObject);
    var
        LocationsJson: JsonArray; 
        LocationJson: JsonObject;
        JsonToken: JsonToken;
    begin
        with Cust do begin 
            if ContentJson.get('name',JsonToken) then
                Name := JsonToken.AsValue().AsText();
            if ContentJson.get('website',JsonToken) then 
                "Home Page" := JsonToken.AsValue().AsText(); 
            if ContentJson.SelectToken('$.details.locations',JsonToken) then begin 
                LocationsJson := JsonToken.AsArray(); 
                if LocationsJson.get(0,JsonToken) then begin
                    LocationJson := JsonToken.AsObject(); 
                    if LocationJson.Get('addressLine1',JsonToken) then
                        Address := JsonToken.AsValue().AsText(); 
                    if LocationJson.Get('city',JsonToken) then
                        City := JsonToken.AsValue().AsText(); 
                    if LocationJson.Get('postalCode',JsonToken) then
                        "Post Code" := JsonToken.AsValue().AsText(); 
                    if LocationJson.Get('countryCode',JsonToken) then
                        "Country/Region Code" := JsonToken.AsValue().AsText();                         
                end;

            end;
        end;
    end;
    
    var
        ContentJson: JsonObject; 
        ContentText: Text; 
        HttpContent: HttpContent;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage; 
        Url: Label 'https://api.fullcontact.com/v3/company.enrich', Locked=true; 
        ApiKey: Label 'JPFZHxaEO4VgBlJ3RQtrW3RT0ZaKyzlW', Locked=true; 
        ErrorNoConnection: Label 'Check your internet connection.'; 
        ErrorResponse: Label 'An error occured\Status code: %1\Reason: %2';         
}
